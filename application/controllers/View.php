<?php
ini_set('max_execution_time', 0); 
ini_set('memory_limit','2048M');

class View extends CI_Controller {

	public function __construct()
        {
                parent::__construct();
            
                $this->load->helper('url_helper');
				$this->load->controller('menu');
				//$this->load->controller('viewresult');
				//$this->load->controller('build');
		}
		
	public function index(){	
		$this->menu->index();
	}
	
	public function menu(){
		$this->menu->index();
		
	}
	
	/*public function view_result(){	
		$this->viewresult->controller('viewresult');
		
	}
	
	public function build(){
					
		$this->build->index();
	}*/
}
		