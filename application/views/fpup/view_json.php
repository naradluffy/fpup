<?php

	$query2 = $this->db->query("select distinct a.no_itemset,a.id_barang,b.nama_barang,a.jumlah from itemset_detail a, barang b,header c where a.id_barang = b.id_barang and b.id_barang = c.id_barang and (a.jumlah/c.jumlah)>".$mincon." order by a.id_barang, a.jumlah desc ");

	foreach ($query2->result_array() as $row2){
		$nos[] = array('nama_barang' => $row2['nama_barang'],
							'id_barang' => $row2['id_barang'],
							'no_itemset' => $row2['no_itemset'],
							'jumlah' => $row2['jumlah']);
	}

	$query3 = $this->db->query("select distinct a.id_barang,b.nama_barang from itemset_detail a, barang b, header c where a.id_barang = b.id_barang and b.id_barang = c.id_barang and (a.jumlah/c.jumlah)>".$mincon."");

	foreach ($query3->result_array() as $row3){
		$barangs[] = array('nama_barang' => $row3['nama_barang'],
							'id_barang' => $row3['id_barang']);
	}
	
	$query4 = $this->db->query("select a.id_barang,a.no_itemset,b.nama_barang, a.item,c.nama_barang as nama_item, a.urutan,a.jumlah from itemset_detail a, barang b, barang c, header d where a.id_barang = b.id_barang and a.item = c.id_barang and b.id_barang = d.id_barang and (a.jumlah/d.jumlah)>".$mincon." order by a.id_barang,a.no_itemset, a.urutan");
		
	
		foreach ($query4->result_array() as $row){
			$datas[] = array('nama_barang' => $row['nama_barang'],
						'no_itemset' => $row['no_itemset'],
						'nama_item' => $row['nama_item'],
						'jumlah' => $row['jumlah']);
		}
		
		foreach ($barangs as $barang){
			$s = array(	'Item' => $barang['nama_barang']);
				$s['Itemset'] = childs1($nos, $barang['nama_barang'],$datas);
				$list[] = $s;
		}
		
		$return = $list;
		
echo json_encode($return);

function childs($datas, $brg, $no){
	$d = "";
	foreach ($datas as $value){
		if (($value["nama_barang"]==$brg) &&($value["no_itemset"]==$no)){
			$d = $d.$value['nama_item'].", ";
			$all = $d.$value['nama_barang'];
		}
		
	}
	if(!empty($all))
		return $all;
	else
		return false;
}

function childs1($nos, $v,$datas){
	foreach ($nos as $value){
		if ($value["nama_barang"]==$v){
			$d = array(
				'Jumlah'	=> $value['jumlah']
			);
			$d['Items'] = childs($datas, $v,$value['no_itemset']);
			$all = $d;
		}
		
	}
	if(!empty($all))
		return $all;
	else
		return false;
}
