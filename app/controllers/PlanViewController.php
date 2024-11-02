<?php

namespace App\controllers;

class PlanViewController extends ApplicationController {
    
    public function index() {
        $this->render('index');  
    }

    public function redirect() {
        session_start();

        if ($_SERVER["REQUEST_METHOD"] === "POST") {
            $plan = $_POST['plan'] ?? '';

            if ($this->isUserLoggedIn()) {
                if ($plan === 'free') {
                    header("Location: https://buy.stripe.com/test_6oE4gM2J84NU28EeUW");
                } 
                elseif ($plan === 'pro') {
                    header("Location: https://buy.stripe.com/test_5kAfZucjIbciaFa288");
                }
                elseif ($plan === 'premium') {
                    header("Location: https://buy.stripe.com/test_cN23cIdnM806cNi001");
                }
                exit();
            } else {
                // Redirecionar para a página de login se não estiver logado
                header("Location: /sign_in");
                exit();
            }
        }
    }

    private function isUserLoggedIn() {
        return isset($_SESSION["user_id"]) && !empty($_SESSION["user_id"]);
    }
}

