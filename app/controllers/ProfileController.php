<?php

namespace App\controllers;

use App\controllers\ApplicationController;
use App\models\User;

class ProfileController extends ApplicationController {

    protected $authenticate = true;

    public function index() {
        if (isset($_SESSION['user_id'])) {
            $user = [
                'user_id' => $_SESSION['user_id'],
                'profile_photo' => $_SESSION['profile_photo'],
                'user_name' => $_SESSION['user_name'],
                'email' => $_SESSION['email'],
                'phone' => $_SESSION['phone'] ?? '' 
            ];

            $this->render('index', 'default', ['user' => $user]);
        } else {
            header('Location: /sign_in');
            exit();
        }
    }
}

?>
