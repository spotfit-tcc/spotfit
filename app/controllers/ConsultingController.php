<?php

namespace App\controllers;

use App\controllers\ApplicationController;
use App\models\Consulting;
use App\models\Category;
use App\forms\consulting\ConsultingForm;

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
        $this->authenticate();

        $consulting_form = new ConsultingForm([]);

        $this->view->consulting_form = $consulting_form;
        $this->view->action = "Nova";
        $this->view->form_action = "/consulting/create";
        $this->view->categories = Category::get_all_categories();

        $this->render('form');
    }

    public function create(){
        $consulting_form = new ConsultingForm($_POST, $_FILES);
        $consulting_form->validate_record();

        if($consulting_form->create_record()){
            header('Location: /consulting?prof=' . $consulting_form->__get('consulting_id'));
        } else {
            echo("<pre>");
            print_r($consulting_form);
            echo("</pre>");

            $this->view->consulting_form = $consulting_form;
            $this->view->action = "Nova";
            $this->view->form_action = "/consulting/create";
            $this->view->categories = Category::get_all_categories();

            $this->render('form');
        }
    }

    private function get_consulting ($search) {
        $consulting = new Consulting([]);
        return $consulting->list_records($search);
    }
}

?>