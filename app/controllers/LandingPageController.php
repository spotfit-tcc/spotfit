<?php

namespace App\controllers;
use App\models\Comment;

use App\controllers\ApplicationController;

class LandingPageController extends ApplicationController{
    public function index(){
        $comment_model = new Comment();
        $comentarios = $comment_model->list_records();

        $this->view->comentarios = $comentarios;

        $this->render('index');
    }
}

?>