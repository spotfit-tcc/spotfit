<?php

namespace App\controllers;

use App\controllers\ApplicationController;
use App\models\User;
use App\models\Consulting;

class ProfileController extends ApplicationController {

    protected $authenticate = true;

    public function index()
    {
        if (isset($_SESSION['user_id'])) {
            $user = [
                'user_id' => $_SESSION['user_id'],
                'profile_photo' => $_SESSION['profile_photo'],
                'user_name' => $_SESSION['user_name'],
                'email' => $_SESSION['email'],
                'phone' => $_SESSION['phone'] ?? '',
                'professional' => $_SESSION['professional'] 
            ];
        
            // Instancie o modelo Consulting
            $consultingModel = new Consulting([]);
            $consultingRecords = $user['professional'] == 1 
                ? $consultingModel->list_records_by_user($user['user_id']) 
                : [];
    
            $this->render('index', 'default', [
                'user' => $user,
                'consultings' => $consultingRecords,
                'isProfessional' => $user['professional'] == 1
            ]);
        } else {
            header('Location: /sign_in');
            exit();
        }
    }
    

    // public function schedules()
    // {
    //     $userId = $this->logged_user(true); 

    //     $stmt = $this->db->prepare("
    //         SELECT cs.*, u.user_name, u.phone 
    //         FROM contact_schedules cs
    //         INNER JOIN user u ON cs.user_id = u.user_id
    //         INNER JOIN consulting c ON cs.consulting_id = c.consulting_id
    //         WHERE cs.user_id = ?  -- Aqui estamos filtrando pelo ID do usuário
    //         ORDER BY cs.contact_date
    //     ");
    //     $stmt->execute([$userId]);

    //     $schedules = $stmt->fetchAll();

    //     $this->render('schedules', ['schedules' => $schedules]);
    // }

}
