<?php

namespace App\controllers;

use App\controllers\ApplicationController;

class SignInController extends ApplicationController{
    public function index(){
        $this->render('index');
    }
}

?>