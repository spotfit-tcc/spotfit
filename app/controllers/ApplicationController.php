<?php

namespace App\controllers;

//os recursos do miniframework
use Framework\controller\BaseController;
use App\models\BaseModel;


class ApplicationController extends BaseController {
    protected $authenticate = false;

    function __construct(){
        session_start();

        parent::__construct();

        if($this->authenticate){
            $this->authenticate();
        }
    }

    function authenticate(){
        if(!isset($_SESSION['auth']) || !$_SESSION['auth']){
            header('Location: /sign_in');
            return;
        }
    }

	public function sum_numbers($num1, $num2){
        return $num1 + $num2;
    }

    
	public function resource_name(){
		$class_name = str_replace('App\controllers\\', '', get_class($this));

		return lcfirst(str_replace("Controller", '', $class_name));
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

    public static function logged_as_admin(){
        $user = BaseModel::logged_user(false)[0];

        return $user["email"] == __ADMIN_LOGIN__ &&
               password_verify(__ADMIN_PASSWORD__, $user['user_password']);
    }

}

?>
