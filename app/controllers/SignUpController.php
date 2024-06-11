<?php

namespace App\controllers;

use App\controllers\ApplicationController;

class SignUpController extends ApplicationController{
    public function index(){
        $this->render('index', 'no_menu');
    }
}

?>