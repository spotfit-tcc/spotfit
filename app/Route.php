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

		$routes['/consulting/create'] = array(
			'route' => '/consulting/create',
			'controller' => 'ConsultingController',
			'action' => 'create'
		);

		$routes['/landing_page'] = array(
			'route' => '/landing_page',
			'controller' => 'LandingPageController',
			'action' => 'index'
		);
		$routes['/'] = array(
			'route' => '/',
			'controller' => 'LandingPageController',
			'action' => 'index'
		);

		$routes['/profile'] = array(
			'route' => '/profile',
			'controller' => 'ProfileController',
			'action' => 'index'
		);

		$routes['/profile/edit'] = array(
			'route' => '/profile/edit',
			'controller' => 'ProfileController',
			'action' => 'edit'
		);


		$routes['/sign_up'] = array(
			'route' => '/sign_up',
			'controller' => 'SignUpController',
			'action' => 'index'
		);

		$routes['/sign_in'] = array(
			'route' => '/sign_in',
			'controller' => 'SignInController',
			'action' => 'index'
		);

		$routes['/faq'] = array(
			'route' => '/faq',
			'controller' => 'FaqController',
			'action' => 'index'
		);

		$routes['/about'] = array(
			'route' => '/about',
			'controller' => 'AboutController',
			'action' => 'index'
		);

		$routes['/forgotPassword'] = array(
			'route' => '/forgotPassword',
			'controller' => 'ForgotPasswordController',
			'action' => 'index'
		);

		$routes['/forgotPassword/new'] = array(
			'route' => '/forgotPassword/new',
			'controller' => 'ForgotPasswordController',
			'action' => 'new'
		);

		$routes['/professional'] = array(
			'route' => '/professional',
			'controller' => 'ProfessionalController',
			'action' => 'index'
		);
		

		$this->setRoutes($routes);
	}

}

?>