<?php

namespace Framework\controller;

abstract class BaseController {

	protected $view;

	public function __construct() {
		$this->view = new \stdClass();
	}

	protected function render($view, $layout = "default") {
		$this->view->page = $view;
	
		$baseDir = dirname(__DIR__, 3);
	
		$layoutPath = $baseDir . "/app/views/layouts/" . $layout . ".phtml";
		
		if (file_exists($layoutPath)) {
			require_once $layoutPath;
		} else {
			$this->content();
		}
	}
	

	protected function content() {
		$classAtual = get_class($this);
	
		$classAtual = str_replace('\\', '/', $classAtual);
	
		$classAtual = str_replace('App/controllers/', '', $classAtual);
		$classAtual = lcfirst(str_replace('Controller', '', $classAtual));
	
		$baseDir = dirname(__DIR__, 3);
	
		$pathToView = $baseDir . "/app/views/" . $classAtual . "/" . $this->view->page . ".phtml";

		if (file_exists($pathToView)) {
			require_once $pathToView;
		} else {
			echo 'View file not found: ' . $pathToView . '<br>';
		}
	}
	
}

?>