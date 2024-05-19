<?php

namespace App;

use Framework\initializer\Bootstrap;

class Route extends Bootstrap {

	protected function initRoutes() {

		$routes['/consulting/index'] = array(
			'route' => '/consulting/index',
			'controller' => 'ConsultingController',
			'action' => 'index'
		);

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

		$routes['/landing_page/index'] = array(
			'route' => '/landing_page/index',
			'controller' => 'LandingPageController',
			'action' => 'index'
		);

		$routes['/landing_page'] = array(
			'route' => '/landing_page',
			'controller' => 'LandingPageController',
			'action' => 'index'
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

		$routes['/profile'] = array(
			'route' => '/profile',
			'controller' => 'ProfileController',
			'action' => 'index'
		);

		$this->setRoutes($routes);
	}

}

?>