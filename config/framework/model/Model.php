<?php

namespace Framework\model;

use App\DbConnection;

abstract class Model {

	protected $db;

	public function __construct() {
		$this->db = DbConnection::getDb();
	}
}


?>