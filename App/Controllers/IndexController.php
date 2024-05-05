<?php

namespace App\Controllers;

//os recursos do miniframework
use App\Controllers\ApplicationController;
use MF\Model\Container;


//os models
use App\Models\Produto;
use App\Models\Info;


class IndexController extends ApplicationController {

	public function index() {
		$this->view->test_sum = $this->sum_numbers(1,5);

		$this->render('index');
	}

	public function sobreNos() {

		$info = Container::getModel('Info');

		$informacoes = $info->getInfo();
		
		@$this->view->dados = $informacoes;

		$this->render('sobreNos');
	}

}


?>