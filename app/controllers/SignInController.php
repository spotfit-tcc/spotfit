<?php

namespace App\controllers;

use App\controllers\ApplicationController;
use App\models\User;

class SignInController extends ApplicationController{
    public function index(){
        $this->render('index', 'no_menu');
    }

    public function authenticate(){
        $user = User::findByEmailAndPassword(
            $_POST['email'],
            $_POST['password']
        );
        if(empty($user)){
            header('Location: /sign_in?logged=0');
        } else {
            $_SESSION["user_id"] = $user['user_id'];
            $_SESSION["user_name"] = $user['user_name'];
            $_SESSION["email"] = $user['email'];
            $_SESSION["profile_photo"] = $user['profile_photo'];
            $_SESSION["phone"] = $user['phone']; 
            $_SESSION['professional'] = $user['professional']; 
            $_SESSION["auth"] = true;
            header('Location: /');
        }
    }

    public function logout(){
        session_destroy();
        header('Location: /landing_page');
    }
}

?>