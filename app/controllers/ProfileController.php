<?php

namespace App\controllers;

use App\controllers\ApplicationController;
use App\models\User;
use App\models\BaseModel;

class ProfileController extends ApplicationController {
    public function index(){
        // Se necessário, você pode redirecionar ou renderizar uma view padrão aqui
        $this->render('index');

    $userData = User::logged_user(false);

        // Verifica se o usuário está logado
        if ($userData) {
            // Renderiza a view com os dados do usuário
            $this->render('profile', [
                'profile_photo' => $userData['profile_photo'],
                'user_name' => $userData['user_name'],
                'email' => $userData['email'],
                'phone' => $userData['phone'],
            ]);
        } else {
            // Redireciona para a página de login caso o usuário não esteja logado
            $this->redirect('sign_in'); 
        }
    
}
}


?>
