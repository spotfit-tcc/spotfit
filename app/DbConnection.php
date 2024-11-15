<?php

namespace App;

class DbConnection {
	public static function getDb() {
		$user = __DB_USER__;
		$password = __DB_PASSWORD__;
		$host = __DB_HOST__;
		$db_name = __DB_NAME__;

		try {
			return new \PDO(
				"mysql:host=$host;dbname=$db_name;",
				$user,
				$password 
			);
		} catch (\PDOException $e) {
			echo("<pre>");
			print_r($e);
			echo("</pre>");
		}
	}
}

?>