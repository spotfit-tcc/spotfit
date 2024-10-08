<?php

namespace App\controllers;

use App\controllers\ApplicationController;
use App\models\User;

class SignUpController extends ApplicationController{
    public function index(){
        $this->view->user = new User($_POST);
        $this->render('index', 'no_menu');
    }

    public function create(){
        $user = new User($_POST);

        if($user->create_record()){
            header('Location: /sign_in?new_user=1');
        } else {
            $this->view->user = $user;
            $this->render('index', 'no_menu');
        }
    }
}

?>