<?php

namespace App\controllers;

use App\controllers\ApplicationController;
use App\models\Consulting;

class PendingConsultingsController extends ApplicationController{
    public function index(){
        $this->authenticate();

        if(!self::logged_as_admin() ){
            header('Location: /consulting');
            return;
        }

        $this->view->pending_consultings = Consulting::list_all_pending_consultings();
        $this->render('index');
    }

    public function change_consulting_status(){
        $this->authenticate();

        if(!self::logged_as_admin() ){
            header('Location: /consulting');
            return;
        }

        $con = Consulting::get_connection();
        $stmt = $con->prepare(
            'UPDATE consulting SET status = :status WHERE consulting_id = :consulting_id'
        );
        $stmt->execute([
            ':status' => $_GET["status"],
            ':consulting_id' => $_GET["consulting_id"]
        ]);

        header('Location: /pending_consultings');
    }
}

?>