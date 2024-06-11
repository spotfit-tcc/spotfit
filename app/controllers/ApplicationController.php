<?php

namespace App\controllers;

//os recursos do miniframework
use Framework\controller\BaseController;


class ApplicationController extends BaseController {
    protected $authenticate = false;

    function __construct(){
        session_start();

        parent::__construct();

        if($this->authenticate){
            if(!isset($_SESSION['auth']) || !$_SESSION['auth']){
                header('Location: /sign_in');
                return;
            }
        }
    }

	public function sum_numbers($num1, $num2){
        return $num1 + $num2;
    }

    
	public function resource_name(){
		$class_name = str_replace('App\controllers\\', '', get_class($this));

		return strtolower(str_replace("Controller", '', $class_name));
	}

    public function load_controller_css(){
        $file = "/assets/stylesheets/".$this->resource_name().".css";
        if (file_exists($_SERVER['DOCUMENT_ROOT'].$file)){
            return "<link rel='stylesheet' href='$file'>";
        }
        else {
            return;
        }
    }

    public function load_controller_js(){
        $file = "/assets/javascripts/".$this->resource_name().".js";
        if (file_exists($_SERVER['DOCUMENT_ROOT'].$file)){
            return "<script src='$file' defer></script>";
        }
        else {
            return;
        }
    }

}

?>
