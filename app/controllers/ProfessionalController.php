<?php

namespace App\controllers;

use App\controllers\ApplicationController;

class ProfessionalController extends ApplicationController{
    public function index(){
        $searchingEspecificProfessional = !empty($_GET["prof"]) && is_numeric($_GET["prof"]) && $_GET['prof'] > 0;
        $professionalFound = true;
        if ($searchingEspecificProfessional) {
            $this->render('specificProfessional');
            // return;
        } else {

            $this->render('index');
        }

    }
}

?>