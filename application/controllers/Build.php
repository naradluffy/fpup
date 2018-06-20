<?php
ini_set('max_execution_time', 0); 
ini_set('memory_limit','2048M');

class Build extends CI_Controller {
		
		public function __construct()
        {
                parent::__construct();
                $this->load->model('build_model');

		}
		
		public function index()
        {
				$this->load->helper('form');
				$this->load->library('form_validation');
				
				$this->form_validation->set_rules('minsup', 'Minimum Support', 'required|greater_than[0]|less_than[11]');
				$this->form_validation->set_rules('date1', 'Begin Date', 'required|callback_tanggal_check');
				$this->form_validation->set_rules('date2', 'End Date', 'required|callback_tanggal_check');
		
		
				if ($this->form_validation->run() === FALSE)
				{
					$data['count'] = NULL;
					
					if (form_error('minsup') || form_error('date1') || form_error('date2')){
						$data['count'] = 0;
					}
					$data['message'] = NULL;
					$data['tanggal'] = $this->build_model->tanggal_terakhir();
										
					$this->load->view('templates/header');
					$this->load->view('fpup/view_build', $data);
					$this->load->view('templates/footer');			
		
				}
				else 
				{
					$minsup = $this->input->post('minsup');
					$date1 = $this->input->post('date1');
					$date2 = $this->input->post('date2');
				
					$status = $this->build_model->save_transaction($date1, $date2);
					if ($status === TRUE){
						$this->build_model->build_tree($minsup);
						$this->build_model->itemset();
						$data['count'] = $this->build_model->itemset_detail();
						$data['message'] = NULL;
					} else 
					{
						$data['message'] = 'Tidak ada transaksi baru';
						$data['count'] = 0;
					}
					
					$data['tanggal'] = $this->build_model->tanggal_terakhir();
										
					$this->load->view('templates/header');
					$this->load->view('fpup/view_build', $data);
					$this->load->view('templates/footer');
				}
        }
		
		// Method untuk mengecek format tanggal sesuai dengan YYYY-mm-dd.
		public function tanggal_check($str)
        {
				if (preg_match("/^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/", $str))
				{
					return TRUE;					
				}
				else
				{
					$this->form_validation->set_message('tanggal_check', 'The Date format is not valid.');
					return FALSE;
				}
        }
		
}