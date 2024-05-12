<?php

namespace App\controllers;

use App\controllers\ApplicationController;

class ConsultingController extends ApplicationController{
    public function index(){
        $this->render('index');
    }

    public function show(){
        $this->render('show');
    }

    public function new(){
        $this->render('new');
    }
}

?>