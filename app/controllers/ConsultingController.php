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

        if (empty($_GET["sort"])) {
            $_GET["sort"] = 2;
        }

        $filters = [
           1 => "mais_curtidas",
           2 => "mais_vistas",
           3 => "mais_novas",
        ];

        $filtro = $filters[$_GET["sort"]];

        $parametros = $this->get_consulting($search, $filtro);
        $this->view->parametros = json_decode(json_encode($parametros), true);

        $this->render('index');

    }

    public function show(){
        $consulting = new ConsultingForm([]);

        $userView = 0;
        if (!empty($_SESSION["user_id"])) {
            $userView = $_SESSION["user_id"];
        }

        $consulting->insert_view(
            $userView,
            $_GET["prof"]
        );

        if (!empty($_POST["like_form"])) {
            $result = $consulting->toggle_user_like($_POST["user_id"], $_POST['consulting_id']);
            $response = [
                'success' => !empty($result),
                'user_has_liked' => $result['liked'],
            ];
    
            header('Content-Type: application/json');
            echo json_encode($response);
            exit;
        }

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

        $dadosConsultoria = $consulting->build_form_from_id($prof);
        $usuarioADM = self::logged_as_admin();

        if ($dadosConsultoria["consulting"]["status"] != "accepted" && !$usuarioADM) {
            header("Location: /consulting");
            return;
        }

        $this->view->consultingData = $dadosConsultoria;

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
            header('Location: /consulting?created_msg=1');
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

        if($consulting_form->update_record()){
            header('Location: /consulting?created_msg=1');
        } else {
            $this->view->consulting_form = $consulting_form;
            $this->view->action = "Editar";
            $this->view->type = "edit";
            $this->view->form_action = "/consulting/update";
            $this->view->categories = Category::get_all_categories();

            $this->render('form');
        }
    }

    private function get_consulting ($search, $filtro = null) {
        $consulting = new Consulting([]);
        return $consulting->list_records($search, $filtro);
    }
}

?>