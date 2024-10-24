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

        $consulting = new Consulting([]);

        if(isset($_GET["consulting_id"])){
            $params = Consulting::findByAttribute('consulting_id', $_GET["consulting_id"], 'fetch', '');
            if(!empty($params)){
                $consulting->set_attributes($params);
            }
        }

        $this->view->consulting = $consulting;
        $this->view->categories = Category::get_all_categories();
        $this->render('new');
    }

    public function create(){
        $consulting_form = new ConsultingForm($_POST, $_FILES);

        echo "<pre>";
        print_r($consulting_form);
        echo "</pre>";

        echo "<pre>";
        print_r($_POST);
        echo "</pre>";

        echo "<pre>";
        print_r($_FILES);
        echo "</pre>";
    }

    private function get_consulting ($search) {
        $consulting = new Consulting([]);
        return $consulting->list_records($search);
    }
}

?>