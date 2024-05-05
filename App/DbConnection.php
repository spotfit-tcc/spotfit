<?php

namespace App;

class DbConnection {
	private $user = "root";
	private $password = "";
	private $host = "localhost";
	private $db_name = "spotfit";

	public static function getDb() {
		try {
			return new \PDO(
				"mysql:host=$host;dbname=$db_name;",
				$user,
				$password 
			);
		} catch (\PDOException $e) {
			//.. tratar de alguma forma ..//
		}
	}
}

?>