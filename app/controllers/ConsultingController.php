<?php

namespace App\controllers;

use App\controllers\ApplicationController;

class ConsultingController extends ApplicationController{
    protected $authenticate = true;

    public function index(){

        $searchingEspecificProfessional = !empty($_GET["prof"]) && is_numeric($_GET["prof"]) && $_GET['prof'] > 0;

        if ($searchingEspecificProfessional) {
            $this->show();
            return;
        }

        $this->render('index');

    }

    public function show(){
        $this->render('show');
    }

    public function new(){
        $this->view->step = isset($_GET['step']) ? (int)$_GET['step'] : 1;
        $this->render('new');
    }

    public function create(){
        echo "<pre>";
        print_r($_POST);
        echo "</pre>";

        $cur_step = (int)$_POST['form_step'];

        if($cur_step >= 5){
            header("Location: /consulting");
        } else {
            $next_step = $cur_step + 1;
            header("Location: /consulting/new?step=$next_step");
        }
    }
}

?>