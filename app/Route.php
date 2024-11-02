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

		$routes['/consulting/edit'] = array(
			'route' => '/consulting/edit',
			'controller' => 'ConsultingController',
			'action' => 'edit'
		);

		$routes['/consulting/update'] = array(
			'route' => '/consulting/update',
			'controller' => 'ConsultingController',
			'action' => 'update'
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

		$routes['/sign_up'] = array(
			'route' => '/sign_up',
			'controller' => 'SignUpController',
			'action' => 'index'
		);

		$routes['/sign_up/create'] = array(
			'route' => '/sign_up/create',
			'controller' => 'SignUpController',
			'action' => 'create'
		);

		$routes['/sign_in'] = array(
			'route' => '/sign_in',
			'controller' => 'SignInController',
			'action' => 'index'
		);

		$routes['/sign_in/authenticate'] = array(
			'route' => '/sign_in/authenticate',
			'controller' => 'SignInController',
			'action' => 'authenticate'
		);

		$routes['/sign_in/logout'] = array(
			'route' => '/sign_in/logout',
			'controller' => 'SignInController',
			'action' => 'logout'
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
		
		$routes['/planview'] = array(
			'route' => '/planview',
			'controller' => 'PlanViewController',
			'action' => 'index'
		);

		$routes['/planRedirect'] = array(
			'route' => '/planRedirect',
			'controller' => 'PlanViewController',
			'action' => 'redirect'
		);

		$this->setRoutes($routes);
	}

}

?>