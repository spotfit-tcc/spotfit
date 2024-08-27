<?php

namespace App\models;
use App\models\DbConnection;

class BaseModel {
	protected function get_connection(){
        return DbConnection::getDb();
    }
}

?>