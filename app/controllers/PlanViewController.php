<?php

namespace App\controllers;

use App\controllers\ApplicationController;
use \Stripe\Stripe;

class PlanViewController extends ApplicationController {
    
    public function index() {
        $this->render('index');  // Renderiza a view dos planos
    }

    public function checkout() {
        // Configura a chave da API do Stripe
        Stripe::setApiKey('sk_test_51Q9Dl6RxE3ZgGCwMgsWTh1jlr9SDkJ9WaUMAwLbUApL69jIuF0VQO6cWX2ht2XmsbtRq5bgzQLhxrw9mVc1ABfIl00EnyXpf6Z'); // Chave secreta

        header('Content-Type: application/json');

        // Define o domínio para redirecionamento
        $YOUR_DOMAIN = 'http://localhost:8080/planview';  

        // Verifica se o plano foi enviado via POST
        if (!isset($_POST['plan'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Nenhum plano foi selecionado']);
            return;
        }

        // Obtem o plano escolhido
        $plan = $_POST['plan'];
        $product_name = '';
        $unit_amount = 0;

        // Define o plano com base na escolha do usuário
        if ($plan === 'pro') {
            $product_name = 'Plano Pro';
            $unit_amount = 1500;  // R$15,00 (em centavos)
        } elseif ($plan === 'premium') {
            $product_name = 'Plano Premium';
            $unit_amount = 3000;  // R$30,00 (em centavos)
        } else {
            http_response_code(400);
            echo json_encode(['error' => 'Plano inválido']);
            return;
        }

        try {
            // Cria uma nova sessão de checkout no Stripe
            $checkout_session = \Stripe\Checkout\Session::create([
                'payment_method_types' => ['card'],
                'line_items' => [[
                    'price_data' => [
                        'currency' => 'brl',  // Usando BRL para reais
                        'product_data' => [
                            'name' => $product_name,  // Nome do plano selecionado
                        ],
                        'unit_amount' => $unit_amount,  // Valor em centavos
                    ],
                    'quantity' => 1,
                ]],
                'mode' => 'payment',  // Modo de pagamento
                'success_url' => $YOUR_DOMAIN . '/success',  // URL de sucesso
                'cancel_url' => $YOUR_DOMAIN . '/cancel',  // URL de cancelamento
               
            ]);

            // Retorna o ID da sessão de checkout
            echo json_encode(['id' => $checkout_session->id]);
        } catch (\Exception $e) {
            // Em caso de erro, retorna uma mensagem de erro
            http_response_code(500);
            echo json_encode(['error' => 'Erro ao criar sessão de checkout: ' . $e->getMessage()]);
        }
    }

}
