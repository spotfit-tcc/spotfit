<?php

namespace App;

use MF\Init\Bootstrap;

class Route extends Bootstrap {

	protected function initRoutes() {

		$routes['teste/show'] = array(
			'route' => '/teste/show',
			'controller' => 'TesteController',
			'action' => 'show'
		);

		$this->setRoutes($routes);
	}

}

?>