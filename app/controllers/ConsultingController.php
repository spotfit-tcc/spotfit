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
        $search = $_GET["search"];

        $parametros = $this->get_consulting($search);

        $this->view->parametros = json_decode(json_encode($parametros), true);

        $this->render('index');

    }

    public function show(){
        $this->render('show');
    }

    public function new(){
        $consulting = new Consulting([]);

        if(isset($_GET["consulting_id"])){
            $params = Consulting::findByAttribute('consulting_id', $_GET["consulting_id"], 'fetch', '');
            if(!empty($params)){
                $consulting->set_attributes($params);
            }
        }

        $this->view->consulting = $consulting;
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

    private function get_consulting ($search) {
        $consulting = new Consulting([]);
        return $consulting->list_records($search);
    }
}

?>