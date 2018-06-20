<?php
class menu_model extends CI_Model {

	public function __construct()
	{
		$this->load->database();
	}
	
	public function get_menu(){
		$query = $this->db->get('menu');
		return $query->result_array();
		//result();
		//row();
		
	}
	
	public function set_menu()
	{
		$data = $this->db->query("SELECT distinct nama_menu FROM transaksi where nama_menu not in (select nama_menu from menu) ORDER BY `id` DESC");
		
		if($data->num_rows())
		{
			$insert = $this->db->query("insert into menu (nama_menu) SELECT distinct nama_menu FROM transaksi where nama_menu not in (select nama_menu from menu) ORDER BY `id` DESC ");
			$count = $data->num_rows();
		} else {
			$count = 0;
		}
		
		return $count;	
	}
	
}