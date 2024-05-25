<?php

namespace App\controllers;

use App\controllers\ApplicationController;

class LandingPageController extends ApplicationController{
    public function index(){
        $this->render('index');
    }
}

?>