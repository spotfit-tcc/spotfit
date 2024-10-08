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

    public function get_attributes(){
        $reflection = new \ReflectionClass($this);
        $props = $reflection->getProperties();

        $result = [];
        foreach ($props as $prop) {
            $prop->setAccessible(true);
            $result[$prop->getName()] = $prop->getValue($this);
        }

        return $result;
    }

    public function is_valid(){
        count($this->errors) == 0;
    }

    public static function table_name(){
        $current_class = (new \ReflectionClass(get_called_class()))->getShortName();
        
        return strtolower(preg_replace('/([a-z])([A-Z])/', '$1_$2', $current_class));
    }

    public static function findByAttribute($attr, $value){
        $con = self::get_connection();

        try{
            $stmt = $con->prepare(
                'SELECT * FROM ' . self::table_name() . ' WHERE '.
                $attr . ' = :value'
            );
            $stmt->bindParam(':value', $value); 
            $stmt->execute();

            return $stmt->fetchAll(\PDO::FETCH_ASSOC);
        } catch(PDOException $e) {
            return [];
        }
    }

    public static function file_upload_dir(){
        $dir = dirname(__DIR__, 3) . '/spotfit_uploads/';

        //create directory if it doesn't exists
        if (!is_dir($dir)) {
            if (!mkdir($dir, 0777, true) && !is_dir($dir)) {
                die('Falha ao criar diretório ' . $dir);
            }
        }
        
        return $dir;
    }

}

?>