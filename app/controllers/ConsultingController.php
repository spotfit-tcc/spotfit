<?php

namespace App\controllers;

use App\controllers\ApplicationController;
use App\models\Consulting;
use App\models\Category;
use App\models\Comment;
use App\forms\consulting\ConsultingForm;

class ConsultingController extends ApplicationController{
    public function index(){

        $searchingEspecificProfessional = !empty($_GET["prof"]) && is_numeric($_GET["prof"]) && $_GET['prof'] > 0;

        if ($searchingEspecificProfessional) {
            $this->show();
            return;
        }

        $search = null;
        if (!empty($_GET["search"])) {
            $search = $_GET["search"];
        }

        $parametros = $this->get_consulting($search);
        $this->view->parametros = json_decode(json_encode($parametros), true);


        $this->render('index');

    }

    public function show(){
        $consulting = new ConsultingForm([]);

        if (!empty($_POST["comment_description"]) && !empty($_POST["comment_rating"])) {
            $comment_model = new Comment();
            $comment_model->create_record([
                'user_id' => $_SESSION["user_id"],
                'consulting_id' => $_GET["prof"],
                'comment_type' => "nao sei",
                'comment_text' => $_POST["comment_description"],
                'rating' => $_POST["comment_rating"],
            ]);

            $_POST["comment_description"] = null;
            $_POST["comment_rating"] = null;

            header("Location: /consulting?prof=$_GET[prof]");
        }

       
        $prof = null;
        if (!empty($_GET["prof"])) {
            $prof = $_GET["prof"];
        }

        $this->view->consultingData = $consulting->build_form_from_id($prof);
        $this->render('show');
    }

    public function new(){
        $this->authenticate();

        $consulting_form = new ConsultingForm([]);

        $this->view->consulting_form = $consulting_form;
        $this->view->action = "Nova";
        $this->view->type = "new";
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
            $this->view->consulting_form = $consulting_form;
            $this->view->action = "Nova";
            $this->view->type = "new";
            $this->view->form_action = "/consulting/create";
            $this->view->categories = Category::get_all_categories();

            $this->render('form');
        }
    }

    public function edit(){
        $this->authenticate();

        $params = ConsultingForm::build_form_from_id($_GET['id']);

        $this->view->consulting_form = new ConsultingForm($params);

        if($this->view->consulting_form->cant_edit()){
            header('Location: /consulting?err=not_found');
            return;
        }

        $this->view->action = "Editar";
        $this->view->type = "edit";
        $this->view->form_action = "/consulting/update";
        $this->view->categories = Category::get_all_categories();

        $this->render('form');
    }

    public function update(){
        $consulting_form = new ConsultingForm($_POST, $_FILES);
        $consulting_form->validate_record();

        // echo("<pre>");
        // print_r($consulting_form);
        // echo("</pre>");

        // echo("<pre>");
        // print_r($_POST);
        // echo("</pre>");

        // echo("<pre>");
        // print_r($_FILES);
        // echo("</pre>");

        if($consulting_form->update_record()){
            header('Location: /consulting?prof=' . $consulting_form->__get('consulting_id'));
        } else {
            $this->view->consulting_form = $consulting_form;
            $this->view->action = "Editar";
            $this->view->type = "edit";
            $this->view->form_action = "/consulting/pdate";
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