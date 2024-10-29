<?php

namespace App\controllers;

use App\controllers\ApplicationController;
use App\models\UserLogged;

class ProfileController extends ApplicationController {
    public function index(){
        // Se necessário, você pode redirecionar ou renderizar uma view padrão aqui
        $this->render('index');
    }
    public function account() {
        if (isset($_GET['user_id']) && $_GET['user_id'] == $_SESSION['user_id']) {
            $userLogged = new UserLogged();
            $userData = $userLogged->getUserById($_SESSION['user_id']);
            
            // Verifique se o $userData não está vazio antes de renderizar
            if ($userData) {
                $this->render('profile/index', ['userData' => $userData]);
            } else {
                echo "Usuário não encontrado.";
            }
        } else {
            echo "Acesso negado ou usuário não encontrado.";
        }
    }
    
}


?>
