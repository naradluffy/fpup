<?php
class Menu extends CI_Controller {
		
		public function __construct()
        {
                parent::__construct();
                $this->load->model('menu_model');
                $this->load->helper('url_helper');
				$this->load->helper('form');
				$this->load->library('form_validation');
        }
		
		public function index()
        {
				$data['count'] = NULL;
                $data['menu'] = $this->menu_model->get_menu();
				
				$this->load->view('templates/header', $data);
				$this->load->view('fpup/menu_view', $data);
				$this->load->view('templates/footer');
        }
		
		public function refresh($count = NULL)
        {		
				$data['count'] = $this->menu_model->set_menu();
				$data['menu'] = $this->menu_model->get_menu();
				
				$this->load->view('templates/header', $data);
				$this->load->view('fpup/menu_view', $data);
				$this->load->view('templates/footer');
        }
}