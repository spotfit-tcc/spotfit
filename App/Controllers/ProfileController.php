<?php

namespace App\controllers;

use App\controllers\ApplicationController;

class ProfileController extends ApplicationController{
    public function index(){
        $this->render('index');
    }
}

?>