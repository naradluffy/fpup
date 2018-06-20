<?php
ini_set('max_execution_time', 0); 
ini_set('memory_limit','2048M');

class Viewresult extends CI_Controller {
	
	public function __construct()
        {
                parent::__construct();
                $this->load->model('view_model');
                $this->load->helper('url_helper');
		}
		
	public function index()
    {
		$this->load->helper('form');
		$this->load->library('form_validation');
		
		$this->form_validation->set_rules('mincon', 'Minimum Confidence', 'integer|required|greater_than[0]|less_than[100]');
	
		if ($this->form_validation->run() === FALSE)
				{
					$data['count'] = NULL;
					
					if (form_error('mincon')){
						$data['count'] = 0;
					}
					
					$this->load->view('templates/header');
					$this->load->view('fpup/view_freq', $data);
					$this->load->view('templates/footer');			
		
				}
				else 
				{
					$mincon = $this->input->post('mincon')/100;
					$data['count'] = 1;
					$data['mincon'] = $mincon;
			
					$this->save_json($mincon);
					
					$data['items'] = $this->view_model->get_itemset($mincon);
					
					$this->load->view('templates/header');
					$this->load->view('fpup/view_freq', $data);
					$this->load->view('templates/footer');
				}		
	}
	
	public function save_json($mincon){
		
		$this->view_model->set_json($mincon);
	
	}
	
	/*public function freq($mincon){
		
		$data['mincon'] = $this->uri->segment(3);
		
		$this->load->view('fpup/view_json', $data);
		
		
	}*/
}
		