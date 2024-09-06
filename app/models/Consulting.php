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
        $this->consulting_id = $params['consulting_id'] ?? null;
        $this->consulting_name = $params['consulting_name'] ?? null;
        $this->description = $params['description'] ?? null;
        $this->contact_email = $params['contact_email'] ?? null;
        $this->adm_user_id = 1;
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
}

?>