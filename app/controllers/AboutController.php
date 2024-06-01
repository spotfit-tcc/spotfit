<?php

namespace App\controllers;

use App\controllers\ApplicationController;

class AboutController extends ApplicationController{
    public function index(){
        $this->render('index');
    }
}

?>