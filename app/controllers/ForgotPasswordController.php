<?php

namespace App\controllers;

use App\controllers\ApplicationController;

class ForgotPasswordController extends ApplicationController{
    public function index(){
        $this->render('index' , 'no_menu');
    }

    public function new(){
        $this->render('new' , 'no_menu');
    }
}

?>