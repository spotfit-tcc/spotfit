<?php

namespace App\models;
use App\DbConnection;

class BaseModel {
	protected static function get_connection(){
        $con = DbConnection::getDb();
        $con->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);

        return $con;
    }

    protected $errors = [];
    public function get_errors(){
        return implode('<br/>', $this->errors);
    }
}

?>