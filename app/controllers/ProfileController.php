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

            $con = Consulting::get_connection();
            $stmt = $con->prepare(
                "SELECT count(*) FROM consulting_schedules cs
                WHERE cs.consulting_id IN
                (SELECT c.consulting_id FROM consulting c WHERE c.adm_user_id = ?)
                AND cs.read = 0"
            );
            $stmt->execute([$user["user_id"]]);
            $notifications_qnt = $stmt->fetch()[0];
    
            $this->render('index', 'default', [
                'user' => $user,
                'consultings' => $consultingRecords,
                'isProfessional' => $user['professional'] == 1,
                'notifications_qnt' => $notifications_qnt
            ]);
        } else {
            header('Location: /sign_in');
            exit();
        }
    }
    

    public function schedules()
    {
        $userId = User::logged_user(true);
        $con = User::get_connection();

        $stmt = $con->prepare("
            SELECT cs.*, u.user_name, u.phone, u.profile_photo
            FROM consulting_schedules cs
            INNER JOIN user u ON cs.user_id = u.user_id
            INNER JOIN consulting c ON cs.consulting_id = c.consulting_id
            WHERE c.consulting_id IN 
            (SELECT c2.consulting_id FROM consulting c2 WHERE c2.adm_user_id = ?)
            AND cs.dismiss = 0
            ORDER BY cs.contact_date
        ");
        $stmt->execute([$userId]);

        $schedules = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        $this->view->schedules = $schedules;

        $this->render('schedules', "");
    }

}
