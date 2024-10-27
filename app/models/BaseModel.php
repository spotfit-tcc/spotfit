<?php

namespace App\models;
use App\DbConnection;

class BaseModel {

	public static function get_connection(){
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

    public static function findByAttribute($attr, $value, $mode = "fetchAll", $restrict_by_user_param = ""){
        $con = self::get_connection();

        try{
            $query = 'SELECT * FROM ' . self::table_name() . ' WHERE '.
                        $attr . ' = :value';

            if(!empty($restrict_by_user_param)){
                $query .= " AND $restrict_by_user_param = " . self::logged_user();
            }

            $stmt = $con->prepare($query);
            $stmt->bindParam(':value', $value); 
            $stmt->execute();

            if($mode == "fetchAll"){
                return $stmt->fetchAll(\PDO::FETCH_ASSOC); #return all results in array
            } else {
                return $stmt->fetch(\PDO::FETCH_ASSOC); #return single result
            }
            
        } catch(PDOException $e) {
            return [];
        }
    }

    public static function file_upload_dir(){
        $dir = dirname(__DIR__, 2) . '/public/image_uploads/';

        //create directory if it doesn't exists
        if (!is_dir($dir)) {
            if (!mkdir($dir, 0777, true) && !is_dir($dir)) {
                die('Falha ao criar diretório ' . $dir);
            }
        }
        
        return $dir;
    }

    public static function logged_user($only_id = true){
        if (session_status() === PHP_SESSION_NONE) session_start();

        if($_SESSION["user_id"] && $only_id){
            return $_SESSION["user_id"];
        } else if($_SESSION["user_id"] && !$only_id){
            return User::findByAttribute('id', $_SESSION["user_id"]);
        } else {
            return null;
        }
    }

}

?>