<?php

namespace App;

class DbConnection {
	public static function getDb() {
		$user = "root";
		$password = "root";
		$host = "localhost";
		$db_name = "spotfit";
		
		// $user = "if0_37279824";
		// $password = "Spot123admin";
		// $host = "sql112.infinityfree.com";
		// $db_name = "if0_37279824_spotfit";



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