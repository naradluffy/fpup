<?php
class View_model extends CI_Model {

	public function __construct()
	{
		$this->load->database();
	}
	
	public function get_itemset($mincon){
		
		$query = $this->db->query("select distinct a.id_menu, b.nama_menu 
					from itemset_detail a, menu b, header c 
					where a.id_menu = b.id_menu 
					and b.id_menu = c.id_menu 
					and (a.frequent/c.frequent)>=".$mincon."");
		
		return $query->result_array();	
		
	}
	
	/*public function get_json(){
		$this->load->helper('url');

			$slug = url_title($this->input->post('title'), 'dash', TRUE);
		
	}*/
	
	public function set_json($mincon){

		$query2 = $this->db->query("select distinct a.no_itemset,a.id_menu,b.nama_menu,a.frequent from itemset_detail a, menu b,header c where a.id_menu = b.id_menu and b.id_menu = c.id_menu and (a.frequent/c.frequent)>".$mincon." order by a.id_menu, a.frequent desc ");

		foreach ($query2->result_array() as $row2){
			$nos[] = array('nama_menu' => $row2['nama_menu'],
								'id_menu' => $row2['id_menu'],
								'no_itemset' => $row2['no_itemset'],
								'frequent' => $row2['frequent']);
		}

		$query3 = $this->db->query("select distinct a.id_menu,b.nama_menu from itemset_detail a, menu b, header c where a.id_menu = b.id_menu and b.id_menu = c.id_menu and (a.frequent/c.frequent)>".$mincon."");

		foreach ($query3->result_array() as $row3){
			$menus[] = array('nama_menu' => $row3['nama_menu'],
								'id_menu' => $row3['id_menu']);
		}
	
		$query4 = $this->db->query("select a.id_menu,a.no_itemset,b.nama_menu, a.item,c.nama_menu as nama_item, a.urutan,a.frequent from itemset_detail a, menu b, menu c, header d where a.id_menu = b.id_menu and a.item = c.id_menu and b.id_menu = d.id_menu and (a.frequent/d.frequent)>".$mincon." order by a.id_menu,a.no_itemset, a.urutan");
		
	
		foreach ($query4->result_array() as $row){
			$datas[] = array('nama_menu' => $row['nama_menu'],
						'no_itemset' => $row['no_itemset'],
						'nama_item' => $row['nama_item'],
						'frequent' => $row['frequent']);
		}
		
		foreach ($menus as $menu){
			$s = array(	'Item' => $menu['nama_menu']);
				$s['Itemset'] = $this->childs1($nos, $menu['nama_menu'],$datas);
				$list[] = $s;
		}
		
		$return = $list;
		
		$json = json_encode($return);
		
		$data = array(
        'json' => $json
		);

		$this->db->insert('hasil_rekomendasi', $data);
		
		return $json;
	}
	
	function childs($datas, $brg, $no){
		$d = "";
		foreach ($datas as $value){
			if (($value["nama_menu"]==$brg) &&($value["no_itemset"]==$no)){
				$d = $d.$value['nama_item'].", ";
				$all = $d.$value['nama_menu'];
			}
			
		}
		if(!empty($all))
			return $all;
		else
			return false;
	}

		function childs1($nos, $v,$datas){
			foreach ($nos as $value){
				if ($value["nama_menu"]==$v){
					$d = array(
						'frequent'	=> $value['frequent']
					);
					$d['Items'] = $this->childs($datas, $v,$value['no_itemset']);
					$all = $d;
				}
				
			}
			if(!empty($all))
				return $all;
			else
				return false;
		}
	
	
	
}