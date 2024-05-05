<?php

namespace App\Controllers;

//os recursos do miniframework
use App\Controllers\ApplicationController;

//os models
use App\Models\Teste;


class TesteController extends ApplicationController {

	public function show() {
		$this->view->test_sum = $this->sum_numbers(1,5);

		$teste = new Teste;
		$this->view->info = $teste->getTestes();

		$this->render('show');
	}

}


?>