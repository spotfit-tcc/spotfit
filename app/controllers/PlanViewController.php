<?php

namespace App\controllers;

use App\controllers\ApplicationController;
use \Stripe\Stripe;

class PlanViewController extends ApplicationController {
    
    public function index() {
        $this->render('index');  
    }

    public function checkout() {
        Stripe::setApiKey('sk_test_51Q9Dl6RxE3ZgGCwMgsWTh1jlr9SDkJ9WaUMAwLbUApL69jIuF0VQO6cWX2ht2XmsbtRq5bgzQLhxrw9mVc1ABfIl00EnyXpf6Z'); // Chave secreta

        header('Content-Type: application/json');
        $YOUR_DOMAIN = 'http://localhost:8000/planview';  

        if (!isset($_POST['plan'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Nenhum plano foi selecionado']);
            return;
        }

        $plan = $_POST['plan'];
        $product_name = '';
        $unit_amount = 0;

        if ($plan === 'pro') {
            $product_name = 'Plano Pro';
            $unit_amount = 1500;  // R$15,00 
        } elseif ($plan === 'premium') {
            $product_name = 'Plano Premium';
            $unit_amount = 2500;  // R$25,00 
        } else {
            http_response_code(400);
            echo json_encode(['error' => 'Plano inválido']);
            return;
        }

        try {
            $checkout_session = \Stripe\Checkout\Session::create([
                'payment_method_types' => ['card'],
                'line_items' => [[
                    'price_data' => [
                        'currency' => 'brl',  
                        'product_data' => [
                            'name' => $product_name,  
                        ],
                        'unit_amount' => $unit_amount, 
                    ],
                    'quantity' => 1,
                ]],
                'mode' => 'payment',  
                'success_url' => $YOUR_DOMAIN . '/success?session_id={CHECKOUT_SESSION_ID}',
                'cancel_url' => $YOUR_DOMAIN . '/cancel',
            ]);

            echo json_encode(['id' => $checkout_session->id]);

        } catch (\Exception $e) {
            http_response_code(500);
            echo json_encode(['error' => 'Erro ao criar sessão de checkout: ' . $e->getMessage()]);
        }
    }

    // Novo método para renderizar a página de sucesso
    public function success() {
        // Renderize a página HTML que contém o script para buscar os detalhes da sessão
        $this->render('success');  // Assumindo que você tenha uma view chamada 'success'
    }

    public function cancel() {
        // Renderiza a página de cancelamento
        $this->render('cancel');  // Assumindo que você tenha uma view chamada 'cancel'
    }

    public function getSessionStatus() {
        Stripe::setApiKey('sk_test_51Q9Dl6RxE3ZgGCwMgsWTh1jlr9SDkJ9WaUMAwLbUApL69jIuF0VQO6cWX2ht2XmsbtRq5bgzQLhxrw9mVc1ABfIl00EnyXpf6Z'); // Chave secreta

        header('Content-Type: application/json');
        $input = json_decode(file_get_contents('php://input'), true);
        $sessionId = $input['session_id'];

        if (!$sessionId) {
            echo json_encode(['error' => 'Session ID não encontrado']);
            return;
        }

        try {
            $session = \Stripe\Checkout\Session::retrieve($sessionId);
            echo json_encode([
                'customer_email' => $session->customer_details->email,
                'status' => $session->payment_status
            ]);
        } catch (\Exception $e) {
            http_response_code(500);
            echo json_encode(['error' => 'Erro ao recuperar status da sessão: ' . $e->getMessage()]);
        }
    }
}


