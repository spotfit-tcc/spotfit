<?php

namespace App\controllers;

use App\controllers\ApplicationController;

class SignInController extends ApplicationController{
    public function index(){
        $this->render('index', 'no_menu');
    }

    public function authenticate(){
        $_SESSION["auth"] = true;
        header('Location: /');
    }

    public function logout(){
        session_destroy();
        header('Location: /sign_in');
    }
}

?>