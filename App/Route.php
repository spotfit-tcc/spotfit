<?php

namespace App;

use Framework\initializer\Bootstrap;

class Route extends Bootstrap {

	protected function initRoutes() {
		$routes['/consulting'] = array(
			'route' => '/consulting',
			'controller' => 'ConsultingController',
			'action' => 'index'
		);

		$routes['/consulting/show'] = array(
			'route' => '/consulting/show',
			'controller' => 'ConsultingController',
			'action' => 'show'
		);

		$routes['/consulting/new'] = array(
			'route' => '/consulting/new',
			'controller' => 'ConsultingController',
			'action' => 'new'
		);

		$routes['/landing_page'] = array(
			'route' => '/landing_page',
			'controller' => 'LandingPageController',
			'action' => 'index'
		);

		$routes['/profile'] = array(
			'route' => '/profile',
			'controller' => 'ProfileController',
			'action' => 'index'
		);

		$this->setRoutes($routes);
	}

}

?>