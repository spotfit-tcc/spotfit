<?php

namespace Framework\controller;

abstract class BaseController {

    protected $view;

    public function __construct() {
        $this->view = new \stdClass();
    }

    /**
     * @param string $view Nome da view (sem a extensão .phtml).
     * @param string $layout Nome do layout a ser usado (default se não especificado).
     * @param array $data Dados a serem passados para a view.
     */
    protected function render($view, $layout = "default", $data = []) {
        $this->view->data = $data; 

        $this->view->page = $view;

        if(file_exists("../app/views/layouts/".$layout.".phtml")) {
            require_once "../app/views/layouts/".$layout.".phtml";
        } else {
            $this->content();
        }
    }

    protected function content() {
        $classAtual = get_class($this);

        $classAtual = str_replace('App\\controllers\\', '', $classAtual);

        $classAtual = lcfirst(str_replace('Controller', '', $classAtual));

        $viewFile = "../app/views/".$classAtual."/".$this->view->page.".phtml";
        if (file_exists($viewFile)) {
            extract($this->view->data);

            require_once $viewFile;
        } else {
            echo "Erro: A view não foi encontrada!";
        }
    }
}


?>