<?php

namespace App;

class DbConnection {
	public static function getDb() {
		$user = "root";
		$password = "";
		$host = "localhost";
		$db_name = "spotfit";

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