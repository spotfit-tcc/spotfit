<?php

namespace App\controllers;

use App\controllers\ApplicationController;

class ProfessionalController extends ApplicationController{
    public function index(){
        $this->render('index');
    }
}

?>