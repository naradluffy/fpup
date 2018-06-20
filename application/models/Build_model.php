<?php
class Build_model extends CI_Model {

	public function __construct()
	{
		$this->load->database();
		$this->load->helper('url');
	}
	
	// tujuan method ini adalah untuk menyeleksi data yang ingin dianalisis dari tabel transaksi. Seleksi data berdasarkan periode waktu yang diinputkan
	// user. kita juga disini membuat no_trans yakni nomor ekstrak_transaksi untuk setiap nomor bill. Type data adalah integer.
	public function save_transaction($date1, $date2)
	{
		//mengecek apakah sudah pernah build sebelumnya atau belum pernah.
		$result = $this->db->query("select max(id_upload) as upload from ekstrak_transaksi");
		$jml = $result->row();
		
		//Jika belum, maka proses ini:
		if($jml->upload === NULL){
			
			//masukkan ke tabel ekstrak_transaksi dari tabel transaksi dengan periode tanggal yang ditentukan user dengan id_upload = 1
			//tabel ekstrak_transaksi digunakan untuk menyimpan data transaksi yang ingin dianalisis dengan periode tanggal yang ditentukan user
			$this->db->query("insert into ekstrak_transaksi (no_bill, id_menu, id_upload, waktu) 
				select a.no_bill, b.id_menu, 1, tanggal
				from transaksi a, menu b where a.nama_menu = b.nama_menu and no_trans in (select no_trans from transaksi 
				group by no_trans having count(no_trans) > 1) and tanggal between '".$date1."' and '".$date2."'
				order by a.no_trans");
			
			//jika query atas tidak menginsert apa-apa, maka jangan lakukan proses selanjutnya
			if ($this->db->affected_rows() == 0){
				return FALSE;
			}
			
			$no_trans = 1;
			
			//ambil no_bill (no_bill) ekstrak_transaksi yang ada diurutkan ascending
			$query = $this->db->query("select distinct no_bill from ekstrak_transaksi order by no_bill");
			$no_bill = $query->result_array();	
			
			// loop no_bill. update no_transnya sama dengan no_bill. 
			// Contoh jika no_bill = 888 maka no_trans = 1
			// jika no_bill = 889 maka no_trans = 2
			foreach($no_bill as $seq)
			{				
				$this->db->query("update ekstrak_transaksi set no_trans = ".$no_trans." where no_bill = ".$seq["no_bill"].""); 
				$no_trans = $no_trans + 1;
			}
			
		}
	
		//Jika sudah ada ekstrak_transaksi maka proses ini:
		else 
		{	
			// tambah sequence build selanjutnya
			$new_seq_upload = $jml->upload + 1;
			
			// insert data dari transaksi yang periodenya telah ditentukan oleh user dengan id_upload = new_seq_upload
			$this->db->query("insert into ekstrak_transaksi (no_bill, id_menu, id_upload) 
				select a.no_bill, b.id_menu, ".$new_seq_upload." 
				from transaksi a, menu b where a.nama_menu = b.nama_menu and no_trans in (select no_trans from transaksi 
				group by no_trans having count(no_trans) > 1) and tanggal between '".$date1."' and '".$date2."' 
				and no_bill not in (select distinct no_bill from ekstrak_transaksi) order by a.no_trans");
			
			// jika tidak berhasil insert apa-apa jangan lanjutkan proses.
			if ($this->db->affected_rows() == 0){
				return FALSE;
			}
			
			// sekarang kita buat no_trans berdasarkan no_trans terakhir dalam tabel ekstrak_transaksi yang sudah ada apa terus nomornya dilanjutkan.
			// contoh: no_bill = 890 maka no_trans = 3 (asalnya 2)
			$query_max_no_trans = $this->db->query("select max(no_trans) as no from ekstrak_transaksi");
			$last_no_trans = $query_max_no_trans->row();

			$new_no_trans = $last_no_trans->no + 1;
					
			$query = $this->db->query("select distinct no_bill from ekstrak_transaksi where id_upload = ".$new_seq_upload." order by no_bill");
			$no_bill = $query->result_array();	
			
			
			foreach($no_bill as $seq)
			{
				$this->db->query("update ekstrak_transaksi set no_trans = ".$new_no_trans." where no_bill = ".$seq["no_bill"]." and id_upload = ".$new_seq_upload.""); 
				$new_no_trans = $new_no_trans + 1;
			}		
		}
		
		return TRUE;

	}

	public function build_tree($minsup)
	{
		// mengecek apakah tree sudah ada datanya atau belum.
		$result = $this->db->query("select count(*) as hitung from tree");
		$jml = $result->row();
		
		// Jika belum ada ekstrak_transaksi di tabel tree maka proses ini:
		if($jml->hitung == 0){
			
			$this->db->truncate('min_sup');
			$this->db->truncate('support');
			$this->db->truncate('header');
			
			// masukkan minimum support yang diinput user ke tabel min_sup dengan id_upload = 1
			$this->db->insert('min_sup', array('id_upload' => 1, 'frequent' => $minsup ));
		
			// cari ekstrak_transaksi-ekstrak_transaksi yang jika itemnya difrequentkan lebih besar dari minimum support. jika sudah didapat maka masukkan
			// ke dalam tabel tree: nama itemnya, id_trans, no_bill, dan id_uploadnya.
			$insert = $this->db->query("INSERT INTO tree (id_menu, nama_menu, id_trans, id_upload, no_bill)
				SELECT a.id_menu, b.nama_menu, a.no_trans , a.id_upload, a.no_bill
				FROM ekstrak_transaksi a, menu b, (SELECT id_menu, count(id_menu) as support from ekstrak_transaksi a group by id_menu) c 
				WHERE a.id_menu = b.id_menu and b.id_menu = c.id_menu AND c.support>=".$minsup." 
				ORDER BY a.no_trans asc, c.support desc, b.id_menu asc");
			
			// masukkan item dan frequent frekuensi setiap item ke dalam tabel support.
			$isi_support = $this->db->query("INSERT INTO support (id_menu, frequent)
				SELECT id_menu, count(id_menu) 
				FROM `ekstrak_transaksi` 
				GROUP BY id_menu 
				ORDER BY count(id_menu) desc, id_menu asc");
			
			// masukkan item dan frequent frekuensinya jika frequentnya lebih besar dari minimum support
			$isi_header = $this->db->query("INSERT INTO header(id_menu, frequent)
				SELECT id_menu, count(id_menu) as jml from ekstrak_transaksi group by id_menu having count(id_menu)>=".$minsup." 
				order by count(id_menu) desc, id_menu asc");	
			
			// masuk ke fp_tree method
			$message = $this->fp_tree();
		}
		// Jika sudah ada ekstrak_transaksi di tabel tree
		else
		{
			
			$this->db->truncate('rescan_item');
			$this->db->truncate('new_support');
			
			// cari frequent nomor ekstrak_transaksi build yang terbaru ada berapa, masukkan ke variable count.
			$result = $this->db->query("select count(no_trans)as jml, id_upload 
				from (select no_trans, count(no_trans) jml, id_upload 
					from ekstrak_transaksi 
					where id_upload = (select max(id_upload) from ekstrak_transaksi) 
					group by no_trans) x");
			$count = $result->row();
			
			// kayaknya ga dipake deh...
			$new_minsup = $minsup * $count->jml;	
			
			// masukkan minimum support yang diinput user
			$this->db->insert('min_sup', array('id_upload' => $count->id_upload, 'frequent' => $minsup ));
			
			// masukkan item dan frequent frekuensi di tabel ekstrak_transaksi yang frequentnya lebih besar dari minimum support. (to be continued)
			$new_support = $this->db->query("INSERT INTO new_support(id_menu, frequent)
				SELECT id_menu, count(id_menu) as jml from ekstrak_transaksi where id_upload = (select max(id_upload) from ekstrak_transaksi) 
					group by id_menu having count(id_menu)>=".$minsup." order by count(id_menu) desc, id_menu asc");
			
			// masuk ke fpup method.
			$message = $this->fpup();
		}		
				
		return $message;
	}
	
	// secara umum, method ini bertugas untuk mengetahui parent, urutan semua item di setiap ekstrak_transaksi.
	public function fp_tree()
	{
		$query = $this->db->query("SELECT distinct id_trans FROM `tree` group by id_trans, id_upload");
		
		if ($query->num_rows() > 0){
			
			foreach ($query->result() as $row)
			{
				$query2 = $this->db->query("SELECT id FROM `tree` WHERE id_trans=".$row->id_trans." order by id_trans,id");
		
				$i = 1;
				
				if ($query2->num_rows() > 0){
					
					foreach ($query2->result() as $row2){
												
						// disini update urutan
						$this->db->where('id', $row2->id);
						$this->db->update('tree', array('urutan' => $i));
						
						$old_urutan = $i - 1;
						
						$this->db->select('id_menu');
						$this->db->where(array('id_trans' => $row->id_trans, 'urutan' => $old_urutan));
						$query3 = $this->db->get('tree');
						
						if ($query3->num_rows() > 0){
							$row3 = $query3->row();
							
							// disini update parent							
							$this->db->where('id', $row2->id);
							$this->db->update('tree', array('parent' => $row3->id_menu));
							
						}
						$i = $i+1;
					}
				}
					
			}
			
		}

		$message = $this->trees();
		
		return $message;
	}
	
	public function trees()
	{
		$this->db->distinct();
		$this->db->select('id_trans, id_upload');
		$query = $this->db->get('tree');

		if ($query->num_rows() > 0){
			
			foreach ($query->result() as $row){
				
				$query2 = $this->db->query("SELECT id, id_menu,urutan,parent 
							FROM `tree` WHERE id_trans=".$row->id_trans." 
							and node is null");
								
				if ($query2->num_rows() > 0){
					
					foreach ($query2->result() as $row2){
						
						$this->db->select_max('node');
						$query3 = $this->db->get('tree');
						$max1 = $query3->row()->node;
						
						$this->db->select_max('node');
						$this->db->where('id_menu', $row2->id_menu);
						$this->db->where('urutan', $row2->urutan);
						$this->db->where('parent', $row2->parent);
						$query4 = $this->db->get('tree');
						$max2 = $query4->row()->node;
						
						$this->db->select_max('node');
						$this->db->where('urutan', $row2->urutan);
						$this->db->where('parent', $row2->parent);
						$query5 = $this->db->get('tree');
						$max3 = $query5->row()->node;
						
						if ($row2->urutan == 1){
							if (is_null($max1)){
							
								$this->db->where('id_trans', $row->id_trans);
								$this->db->where('urutan', $row2->urutan);
								$this->db->update('tree', array('node' => 1));
							}
							else
							{
								if (is_null($max2)){
									
									$new_node = $max1 + 1;
									$this->db->where('id_trans', $row->id_trans);
									$this->db->where('urutan', $row2->urutan);
									$this->db->update('tree', array('node' => $new_node));
									
								}
								else {
									$this->db->limit(1);
									$this->db->select('node');
									$this->db->where('id_menu', $row2->id_menu);
									$this->db->where('parent', $row2->parent);
									$query6 = $this->db->get('tree');
									$node = $query6->row()->node;
										
									$this->db->where('id_trans', $row->id_trans);
									$this->db->where('urutan', $row2->urutan);
									$this->db->update('tree', array('node' => $node));
					
								}
							}
						} else {
							if (is_null($max2) && $max3){
								
								$new_node = $max1 + 1;
								$this->db->where('id_trans', $row->id_trans);
								$this->db->where('urutan', $row2->urutan);
								$this->db->update('tree', array ('node' => $new_node));
							
							} else if (is_null($max2) && is_null($max3)){
								
								$this->db->limit(1);
								$this->db->select('node');
								$this->db->where('id_menu', $row2->parent);
								$this->db->where('id_trans', $row->id_trans);
								$query6 = $this->db->get('tree');
								$node = $query6->row()->node;
								
								$this->db->where('id_trans', $row->id_trans);
								$this->db->where('urutan', $row2->urutan);
								$this->db->update('tree',  array('node' => $node));
							
							} else if ($max2 && $max3){

								$this->db->where('id_trans', $row->id_trans);
								$this->db->where('urutan <=', $row2->urutan);
								$this->db->from('tree');
								$count = $this->db->count_all_results(); 
								
								$query7 = $this->db->query("select x.id_trans, count(x.id_menu) from (
										select b.id_trans, b.id_menu from tree a, tree b 
											where a.id_menu = b.id_menu and a.parent=b.parent 
												and a.urutan = b.urutan and a.id_trans = ".$row->id_trans." 
												and a.urutan <= ".$row2->urutan.") x 
												where x.id_trans != ".$row->id_trans." group by x.id_trans 
												having count(x.id_menu) = ".$count."");
								
								if ($query7->num_rows() > 0){
									
									$row7 = $query7->row();
									
									$this->db->limit(1);
									$this->db->select('node');
									$this->db->where('id_trans', $row7->id_trans);
									$this->db->where('urutan', $row2->urutan);
									$query8 = $this->db->get('tree');
									$row8 = $query8->row();
												
									$this->db->where('id_trans', $row->id_trans);
									$this->db->where('urutan', $row2->urutan);
									$this->db->update('tree', array('node' => $row8->node));
									
								} else {
									$old = $row2->urutan - 1;
									
									$this->db->limit(1);
									$this->db->select('node');
									$this->db->where('id_trans', $row->id_trans);
									$this->db->where('urutan', $old);
									$query9 = $this->db->get('tree');
									$row9 = $query9->row();
									
									$this->db->where('id_trans', $row->id_trans);
									$this->db->where('urutan', $row2->urutan);
									$this->db->update('tree', array('node' => $row9->node));
								}
							} else {
								echo "something is wrong";
							}
						}
					}
				}
			}
		}
		return 'trees is successfully processed';
	}
	
	public function fpup()
	{
	
		//Step 3 FPUP
		$query = $this->db->query("select a.id_menu, (a.frequent+ b.frequent) as new_frequent 
				from header a, new_support b where a.id_menu = b.id_menu");
		
		if ($query->num_rows() > 0){			
			foreach ($query->result() as $row){
				
				$this->db->where('id_menu', $row->id_menu);
				$this->db->update('header', array('frequent' => $row->new_frequent));
			}
		}
		
		//Step 4 FPUP
		$query2 = $this->db->query("select a.id_menu, (a.frequent+x.jml) as new_frequent 
					from support a, (select count(id_menu)as jml, id_menu 
						from ekstrak_transaksi where id_upload = (select max(id_upload) 
							from ekstrak_transaksi) and id_menu in (select a.id_menu 
								from header a where a.id_menu not in (select id_menu 
									from new_support)) group by id_menu) x 
									where a.id_menu = x.id_menu and (a.frequent+x.jml)>=(select sum(frequent) 
										from min_sup)");
		
		if ($query2->num_rows() > 0){			
			foreach ($query2->result() as $row2){
				
				$this->db->where('id_menu', $row2->id_menu);
				$this->db->update('header', array('frequent' => $row2->new_frequent));
				
			}
		}
		
		$query3 = $this->db->query("SELECT b.id_menu, (a.frequent+b.frequent) as new_jml 
						FROM new_support b, support a where b.id_menu not in (select id_menu from header) 
						and a.id_menu = b.id_menu and (a.frequent+b.frequent)>=(select sum(frequent) from min_sup)");
		
		$query4 = $this->db->query("select id_menu from header where frequent < (select sum(frequent) from min_sup)");
		
		if ($query4->num_rows() > 0){			
			foreach ($query4->result() as $row4){
				
				$this->db->where('id_menu', $row4->id_menu);
				$this->db->delete('header');
			
			}
		}
		
		//Step 5 FPUP
		if ($query3->num_rows() > 0){			
			foreach ($query3->result() as $row3){
				$data = array(
						'id_menu' => $row3->id_menu,
						'frequent' => $row3->new_jml
				);
				$this->db->insert('rescan_item',$data);
			
			}
		}
		
		//Step 6 dan 7 FPUP
		$query5 = $this->db->query("SELECT id_menu, frequent from rescan_item order by frequent desc, id_menu asc");
		
		if ($query5->num_rows() > 0){			
			foreach ($query5->result() as $row5){
				
				$this->db->insert('header', array('id_menu' => $row5->id_menu, 'frequent' => $row5->frequent));
			
			}
		}
		
		//Step 8 FPUP
		$this->db->truncate('koresponden');
		$query6 = $this->db->query("INSERT INTO koresponden (id, id_menu, no_trans, no_bill)
					select distinct id_trans, id_menu, no_trans, no_bill from ekstrak_transaksi 
					where no_trans in (select no_trans from ekstrak_transaksi where id_menu in 
					(select id_menu from rescan_item) and id_upload < (select max(id_upload) 
					from ekstrak_transaksi)) and id_menu in (select id_menu from header) 
					and id_upload < (select max(id_upload) from ekstrak_transaksi)");
		
		$query7 = $this->db->query("select count(id_menu),id_menu from tree where id_menu 
					not in (select id_menu from header) group by id_menu");
		
		if ($query7->num_rows() > 0){			
			foreach ($query7->result() as $row7){
				
				$this->db->where('id_menu', $row7->id_menu);
				$this->db->delete('tree');
			}
		}
		
		#Make a Tree
		$query8 = $this->db->query("SELECT a.id, a.id_menu, c.nama_menu, a.no_trans, d.id_upload 
					FROM koresponden a, header b, menu c, ekstrak_transaksi d 
					where a.id_menu = c.id_menu and a.id_menu = b.id_menu and a.id_menu 
					and a.id_menu = d.id_menu and a.id=d.id_trans and a.id_menu not in 
					(select id_menu from tree where id_trans = a.no_trans) order by b.id");
		
		if ($query8->num_rows() > 0){			
			foreach ($query8->result() as $row8){
				
				$this->db->query("INSERT INTO tree (id_trans, id_menu, nama_menu, id_upload, no_bill) 
				select a.no_trans, a.id_menu, b.nama_menu, a.id_upload, a.no_bill
				from ekstrak_transaksi a, menu b where a.id_menu = b.id_menu and a.id_trans=".$row8->id."");
			
			}
		}
		
		//Step 9 FPUP
		$this->db->truncate('koresponden');
		$query9 = $this->db->query("INSERT INTO koresponden (id, id_menu, no_trans, id_upload, no_bill)
					select a.id_trans, a.id_menu, a.no_trans, a.id_upload, a.no_bill
					from ekstrak_transaksi a, header b 
					where a.id_menu = b.id_menu 
					and a.id_menu in (select id_menu from header) 
					and a.id_upload = (select max(id_upload) from ekstrak_transaksi) 
					order by a.id_upload, a.no_trans, b.id");
					
		$query10 = $this->db->query("INSERT INTO tree (id_trans, id_menu, nama_menu, id_upload, no_bill)
					select a.no_trans, a.id_menu, b.nama_menu, a.id_upload, a.no_bill 
					from koresponden a, menu b where a.id_menu = b.id_menu");
		
		//merapikan urutan
		$this->db->update('tree', array('urutan' => NULL,
										'node' => NULL,
										'parent' => NULL));
									
		$message = $this->fp_tree();
		
		return $message;
	}
	
	public function itemset()
	{
		$this->db->truncate('itemset');
		
		$this->db->select('id_menu');
		$this->db->order_by('id DESC');
		$query = $this->db->get('header');

		if ($query->num_rows() > 0){
			foreach ($query->result() as $row){
				
				$this->db->truncate('temp_tree');
				
				$this->db->select_sum('frequent');
				$query2 = $this->db->get('min_sup');
				
				$minsup = $query2->row()->frequent;
				
				$this->db->select('urutan, id_trans');
				$this->db->where('id_menu',$row->id_menu);
				$query3 = $this->db->get('tree');
				
				if ($query3->num_rows() > 0){
					foreach ($query3->result() as $row3){
						
						$this->db->query("insert into temp_tree 
							(id, id_trans, id_menu, nama_menu, parent, node, urutan, id_upload)
							select id, id_trans, id_menu, nama_menu, parent, node, urutan, id_upload 
							from tree where id_trans = ".$row3->id_trans." 
							and urutan < ".$row3->urutan." order by id");
					}
				}
				
				$query4 = $this->db->query("select id_menu, count(id_menu) 
							from temp_tree group by id_menu having count(id_menu) < ".$minsup."");
					
				if ($query4->num_rows() > 0){
					foreach ($query4->result() as $row4){
							
							$this->db->where('id_menu', $row4->id_menu);
							$this->db->delete('temp_tree');
					}
				}
				
				//merapikan urutan
				$this->db->update('temp_tree', array('urutan' => NULL,
												'node' => NULL,
												'parent' => NULL));
				
				$query5 = $this->db->query("SELECT distinct id_trans FROM temp_tree group by id_trans, id_upload");
				
				if ($query5->num_rows() > 0){
					foreach ($query5->result() as $row5){
						
						$query6 = $this->db->query("SELECT id FROM `temp_tree` WHERE id_trans=".$row5->id_trans." order by id_trans,id");
				
						if ($query6->num_rows() > 0){
							
							$i=1;
							
							foreach ($query6->result() as $row6){
								
								$this->db->where('id', $row6->id);								
								$this->db->update('temp_tree', array('urutan' => $i));
								
								$old_urutan = $i - 1;
								
								$result = $this->db->query("select id_menu from temp_tree where id_trans=".$row5->id_trans." and urutan =".$old_urutan." limit 1");
								$row7 = $result->row_array();
								
								$this->db->where('id', $row6->id);								
								$this->db->update('temp_tree', array('parent' => $row7['id_menu']));
								
								$i = $i + 1;
							}
						}						
					}
				}
				
				$this -> temp();
				
				$this->db->query("INSERT INTO itemset (id_menu, item, parent, urutan, node, frequent)
						SELECT ".$row->id_menu.",id_menu, parent, urutan, node, count(id_menu) FROM `temp_tree` 
						group by id_menu, urutan, parent, node order by node, urutan");
				
				$this->db->where('frequent <', 3);
				$this->db->delete('itemset');

			} 
		}
		
		return "itemset telah berhasil dibuat.";
		
	}
	
	public function temp()
	{
		$this->db->distinct();
		$this->db->select('id_trans, id_upload');
		$query = $this->db->get('temp_tree');

		if ($query->num_rows() > 0){
			
			foreach ($query->result() as $row){
				
				$query2 = $this->db->query("SELECT id, id_menu,urutan,parent 
							FROM `temp_tree` WHERE id_trans=".$row->id_trans." 
							and node is null");
								
				if ($query2->num_rows() > 0){
					
					foreach ($query2->result() as $row2){
						
						$this->db->select_max('node');
						$query3 = $this->db->get('temp_tree');
						$max1 = $query3->row()->node;
						
						$this->db->select_max('node');
						$this->db->where('id_menu', $row2->id_menu);
						$this->db->where('urutan', $row2->urutan);
						$this->db->where('parent', $row2->parent);
						$query4 = $this->db->get('temp_tree');
						$max2 = $query4->row()->node;
						
						$this->db->select_max('node');
						$this->db->where('urutan', $row2->urutan);
						$this->db->where('parent', $row2->parent);
						$query5 = $this->db->get('temp_tree');
						$max3 = $query5->row()->node;
						
						if ($row2->urutan == 1){
							if (is_null($max1)){
							
								$this->db->where('id_trans', $row->id_trans);
								$this->db->where('urutan', $row2->urutan);
								$this->db->update('temp_tree', array('node' => 1));
							}
							else
							{
								if (is_null($max2)){
									
									$new_node = $max1 + 1;
									$this->db->where('id_trans', $row->id_trans);
									$this->db->where('urutan', $row2->urutan);
									$this->db->update('temp_tree', array('node' => $new_node));
									
								}
								else {
									$this->db->limit(1);
									$this->db->select('node');
									$this->db->where('id_menu', $row2->id_menu);
									$this->db->where('parent', $row2->parent);
									$query6 = $this->db->get('temp_tree');
									$node = $query6->row()->node;
										
									$this->db->where('id_trans', $row->id_trans);
									$this->db->where('urutan', $row2->urutan);
									$this->db->update('temp_tree', array('node' => $node));
					
								}
							}
						} else {
							if (is_null($max2) && $max3){
								
								$new_node = $max1 + 1;
								$this->db->where('id_trans', $row->id_trans);
								$this->db->where('urutan', $row2->urutan);
								$this->db->update('temp_tree', array ('node' => $new_node));
							
							} else if (is_null($max2) && is_null($max3)){
								
								$this->db->limit(1);
								$this->db->select('node');
								$this->db->where('id_menu', $row2->parent);
								$this->db->where('id_trans', $row->id_trans);
								$query6 = $this->db->get('temp_tree');
								$row6 = $query6->row_array();
								
								$this->db->where('id_trans', $row->id_trans);
								$this->db->where('urutan', $row2->urutan);
								$this->db->update('temp_tree',  array('node' => $row6['node']));
							
							} else if ($max2 && $max3){

								$this->db->where('id_trans', $row->id_trans);
								$this->db->where('urutan <=', $row2->urutan);
								$this->db->from('temp_tree');
								$count = $this->db->count_all_results(); 
								
								$query7 = $this->db->query("select x.id_trans, count(x.id_menu) from (
										select b.id_trans, b.id_menu from temp_tree a, temp_tree b 
											where a.id_menu = b.id_menu and a.parent=b.parent 
												and a.urutan = b.urutan and a.id_trans = ".$row->id_trans." 
												and a.urutan <= ".$row2->urutan.") x 
												where x.id_trans != ".$row->id_trans." group by x.id_trans 
												having count(x.id_menu) = ".$count."");
								
								if ($query7->num_rows() > 0){
									
									$row7 = $query7->row();
									
									$this->db->limit(1);
									$this->db->select('node');
									$this->db->where('id_trans', $row7->id_trans);
									$this->db->where('urutan', $row2->urutan);
									$query8 = $this->db->get('temp_tree');
									$row8 = $query8->row();
												
									$this->db->where('id_trans', $row->id_trans);
									$this->db->where('urutan', $row2->urutan);
									$this->db->update('temp_tree', array('node' => $row8->node));
									
								} else {
									$old = $row2->urutan - 1;
									
									$this->db->limit(1);
									$this->db->select('node');
									$this->db->where('id_trans', $row->id_trans);
									$this->db->where('urutan', $old);
									$query9 = $this->db->get('temp_tree');
									$row9 = $query9->row();
									
									$this->db->where('id_trans', $row->id_trans);
									$this->db->where('urutan', $row2->urutan);
									$this->db->update('temp_tree', array('node' => $row9->node));
								}
							} else {
								echo "something is wrong";
							}
						}
					}
				}
			}
		}
		return 'node temp is successfully processed';
	}
	
	public function itemset_detail()
	{
		$this->db->truncate('itemset_detail');
		$parent = 0;
		
		$query = $this->db->query("select distinct id_menu from itemset");
		if ($query->num_rows() > 0){
			foreach ($query->result() as $row){
				
				$no = 0;
				$query2 = $this->db->query("select id, id_menu, item, parent,urutan, 
						node,frequent from itemset where id_menu=".$row->id_menu."");
				
				if ($query2->num_rows() > 0){
					foreach ($query2->result() as $row2){
						
						$no = $no + 1;
						$parent = $row2->parent;
						
						if ($row2->urutan == 1){
							$data = array (	'no_itemset' => $no,
											'id_menu' => $row2->id_menu,
											'item' => $row2->item,
											'urutan' => $row2->urutan,
											'frequent' => $row2->frequent,
											);
							
							$this->db->insert('itemset_detail', $data);
		
						} else {
							$data = array (	'no_itemset' => $no,
											'id_menu' => $row2->id_menu,
											'item' => $row2->item,
											'urutan' => $row2->urutan,
											'frequent' => $row2->frequent,
											);
							
							$this->db->insert('itemset_detail', $data);
							
							for ($i=$row2->urutan-1; $i>=1; $i--){
								
								$query3 = $this->db->query("select id, id_menu, item, parent,urutan, node,frequent from itemset where id_menu=".$row2->id_menu." 
										and item = ".$parent." and urutan = ".$i."");

								$row3 = $query3->row();
								
								$parent = $row3->parent;
								
								$data = array (	'no_itemset' => $no,
											'id_menu' => $row3->id_menu,
											'item' => $row3->item,
											'urutan' => $i,
											'frequent' => $row3->frequent,
											);
							
								$this->db->insert('itemset_detail', $data);
							
							}
						}
						
					}
				}
			}			
		}
		
		$query4 = $this->db->query("select distinct id_menu, no_itemset from itemset_detail");
		if ($query4->num_rows() > 0){
			foreach ($query4->result() as $row4){
				
				$jmlpermenu = 0;
				$this->db->select('no_trans');
				$this->db->where('id_menu', $row4->id_menu);
				$query5 = $this->db->get('ekstrak_transaksi');
				
				if ($query5->num_rows() > 0){
					foreach ($query5->result() as $row5){
						
						$m = 0;
						$this->db->select('item');
						$this->db->where('id_menu', $row4->id_menu);
						$this->db->where('no_itemset', $row4->no_itemset);
						$query6 = $this->db->get('itemset_detail');
						
						if ($query6->num_rows() > 0){
							foreach ($query6->result() as $row6){
								
								$this->db->where('no_trans', $row5->no_trans);
								$this->db->where('id_menu', $row6->item);
								$query6 = $this->db->get('ekstrak_transaksi');
								
								if ($query6->num_rows() == 1){
									$m = 1;
								} else {
									$m = 0;
									break;
								}
							}
						}
						
						if ($m == 1 ){
							$jmlpermenu = $jmlpermenu+1;
						}
					}
				}
				
				$data = array('frequent' => $jmlpermenu);	
				$this->db->where('id_menu', $row4->id_menu);
				$this->db->where('no_itemset', $row4->no_itemset);
				$this->db->update('itemset_detail', $data);	
						
			}
		}
		return 1;
	}

	public function tanggal_terakhir()
	{
		$this->db->distinct('waktu');
		$this->db->select('waktu');
		$this->db->order_by('waktu DESC');
		$query = $this->db->get('ekstrak_transaksi');
		
		if ($query->num_rows() > 0){
			return 'Tanggal terakhir pembuatan itemset: '.$query->row()->waktu;
		}		
		else {
			return NULL;
		}
	}
}