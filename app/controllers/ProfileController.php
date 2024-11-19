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
                AND cs.read = 0 AND cs.dismiss = 0"
            );
            $stmt->execute([$user["user_id"]]);
            $notifications_qnt = $stmt->fetch()[0];
    
            $this->view->user = $user;
            $this->view->isProfessional = $user['professional'] == 1;
            $this->view->notifications_qnt = $notifications_qnt;
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
        $read = $_GET['list_mode'] == "read" ? true : false ;

        $userId = User::logged_user(true);
        $con = User::get_connection();

        $stmt = $con->prepare("
            SELECT cs.*, u.user_name, u.phone, u.profile_photo
            FROM consulting_schedules cs
            INNER JOIN user u ON cs.user_id = u.user_id
            INNER JOIN consulting c ON cs.consulting_id = c.consulting_id
            WHERE c.consulting_id IN 
            (SELECT c2.consulting_id FROM consulting c2 WHERE c2.adm_user_id = :user_id)
            AND cs.dismiss = 0 AND cs.read = :read
            ORDER BY cs.contact_date
        ");
        $stmt->execute([
            ':user_id' => $userId,
            ':read' => $read
        ]);

        $schedules = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        $this->view->schedules = $schedules;
        $this->view->read = $read;

        $this->render('schedules', "");
    }

    public function set_read(){
        $schedule = $_GET["schedule"];

        try{
            $con = User::get_connection();
            $stmt = $con->prepare("
                UPDATE consulting_schedules cs SET
                cs.read = 1 WHERE cs.schedule_id = :schedule_id
                AND cs.consulting_id IN 
                (SELECT c.consulting_id FROM consulting c WHERE c.adm_user_id = :user_id)
            ");
            $stmt->execute([
                ':schedule_id' => $schedule,
                ':user_id' => User::logged_user()
            ]);

            
            $data = array("result" => "true");
        } catch(Exception $e){
            $data = $e;
        }

        $json_data = json_encode($data);
        echo $json_data;
    }

    public function dismiss(){
        $schedule = $_GET["schedule"];

        try{
            $con = User::get_connection();
            $stmt = $con->prepare("
                UPDATE consulting_schedules cs SET
                cs.dismiss = 1 WHERE cs.schedule_id = :schedule_id
                AND cs.consulting_id IN 
                (SELECT c.consulting_id FROM consulting c WHERE c.adm_user_id = :user_id)
            ");
            $stmt->execute([
                ':schedule_id' => $schedule,
                ':user_id' => User::logged_user()
            ]);

            
            $data = array("result" => "true");
        } catch(Exception $e){
            $data = $e;
        }

        $json_data = json_encode($data);
        echo $json_data;
    }
}
