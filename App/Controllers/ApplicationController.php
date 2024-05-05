<?php

namespace App\Controllers;

//os recursos do miniframework
use MF\Controller\BaseController;


class ApplicationController extends BaseController {

	public function sum_numbers($num1, $num2){
        return $num1 + $num2;
    }

}

?>
