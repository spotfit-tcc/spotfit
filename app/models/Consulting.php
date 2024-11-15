<?php

namespace App\models;
use App\models\BaseModel;

class Consulting extends BaseModel {
	private $consulting_id;
	private $consulting_name;
	private $description;
	private $contact_email;
	private $contact_phone;
	private $adm_user_id;

    public function __construct($params){
        $this->set_attributes($params);
    }

    public function set_attributes($params){
        $this->consulting_id = $params['consulting_id'] ?? null;
        $this->consulting_name = $params['consulting_name'] ?? null;
        $this->description = $params['description'] ?? null;
        $this->contact_email = $params['contact_email'] ?? null;
        $this->adm_user_id = $params['adm_user_id'] ?? self::logged_user(true);
        $this->contact_phone = $params['contact_phone'] ?? null;
    }

    public function __get($attr){
        return $this->$attr;
    }

    public function valid_record(){
        if (
            empty(trim($this->consulting_name)) ||
            empty(trim($this->description)) ||
            empty(trim($this->contact_email))
        ){
            $this->errors[] = "Preencha os campos de nome da consultoria, descrição e email de contato";
            return false;
        }
        return true;
    }

    public function create_record(){
        if (!$this->valid_record()) return false;

        $con = self::get_connection();

        try{
            $stmt = $con->prepare(
                'INSERT INTO consulting(consulting_name, description, contact_email, adm_user_id, contact_phone)'.
                'VALUE (:consulting_name, :description, :contact_email, :adm_user_id, :contact_phone)'
            );
            $stmt->execute(array(
                ':consulting_name' => $this->consulting_name,
                ':description' => $this->description,
                ':contact_email' => $this->contact_email,
                ':adm_user_id' => $this->adm_user_id,
                ':contact_phone' => $this->contact_phone,
            ));
            return true;
        } catch(PDOException $e) {
            $this->errors[] = $e->getMessage();
            return false;
        }
    }
    public function list_records($search = null)
    {
        $con = self::get_connection();
    
        try {
            $query = 'SELECT * FROM consulting con
                     INNER JOIN consulting_image ci 
                        ON ci.consulting_id = con.consulting_id
                     INNER JOIN consulting_professional cp 
                        ON cp.consulting_id = con.consulting_id  
                     INNER JOIN consulting_category cc 
                        ON cc.consulting_id = con.consulting_id
                     INNER JOIN category cat
                        ON cat.category_id = cc.category_id';
    
            if ($search) {
                $query .= ' WHERE con.consulting_name LIKE :search';
            }
    
            $stmt = $con->prepare($query);
    
            if ($search) {
                $searchParam = "%{$search}%";
                $stmt->bindParam(':search', $searchParam, \PDO::PARAM_STR);
            }
    
            $stmt->execute();
            $records = $stmt->fetchAll(\PDO::FETCH_ASSOC);
            return $records;
        } catch (PDOException $e) {
            $this->errors[] = $e->getMessage();
            return false;
        }
    }

    public function list_records_by_user($user_id)
    {
        $con = self::get_connection();

        try {
            $query = 'SELECT con.*, ci.image_dir AS image_path
                    FROM consulting con
                    LEFT JOIN consulting_image ci 
                    ON ci.consulting_id = con.consulting_id
                    WHERE con.adm_user_id = :user_id';
            $stmt = $con->prepare($query);
            $stmt->bindParam(':user_id', $user_id, \PDO::PARAM_INT);
            $stmt->execute();
            $records = $stmt->fetchAll(\PDO::FETCH_ASSOC);
            return $records;
        } catch (PDOException $e) {
            $this->errors[] = $e->getMessage();
            return false;
        }
    }

    public static function list_all_pending_consultings()
    {
        $con = self::get_connection();

        try {
            $query = 'SELECT *
                    FROM consulting con
                    WHERE con.status = "pending"';
            $stmt = $con->query($query);
            $records = $stmt->fetchAll(\PDO::FETCH_ASSOC);
            return $records;
        } catch (PDOException $e) {
            $this->errors[] = $e->getMessage();
            return false;
        }
    }


}

?>