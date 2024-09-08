<?php

namespace App\controllers;

use App\controllers\ApplicationController;
use App\models\Consulting;

class ConsultingController extends ApplicationController{
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
        $cur_step = (int)$_POST['form_step'];

        switch($cur_step){
            case 1:
                $this->create_step1();
                break;
            case 5:
                #TODO: redirecionar para página da consultoria com flash message
                header("Location: /consulting");
                return;
        }

        header('Location: /consulting/new?step=' . ($cur_step + 1));
    }

    private function create_step1(){
        $consulting = new Consulting($_POST);

        if(!$consulting->create_record()){
            header('Location: /consulting/new?step=1&&errors=' . $consulting->get_errors());
            exit;
        }
    }
}

?>