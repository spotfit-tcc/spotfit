<?php

namespace Framework\controller;

abstract class BaseController {

	protected $view;

	public function __construct() {
		$this->view = new \stdClass();
	}

	protected function render($view, $layout = "default") {
		$this->view->page = $view;

		if(file_exists("../App/views/layouts/".$layout.".phtml")) {
			require_once "../App/views/layouts/".$layout.".phtml";
		} else {
			$this->content();
		}
	}

	protected function content() {
		$classAtual = get_class($this);

		$classAtual = str_replace('App\\controllers\\', '', $classAtual);

		$classAtual = strtolower(str_replace('Controller', '', $classAtual));

		require_once "../App/views/".$classAtual."/".$this->view->page.".phtml";
	}
}

?>