<?php

namespace App\models;
use App\models\BaseModel;
use JC\BrDocs\BrDoc;

class User extends BaseModel {
	private $user_id;
	private $user_name;
	private $email;
	private $user_password;
	private $cpf_or_cnpj;
	private $profile_photo;
	private $professional;
	private $phone;

    public function __construct($params){
        $this->user_id = $params['user_id'] ?? null;
        $this->user_name = $params['user_name'] ?? null;
        $this->email = $params['email'] ?? null;
        $this->user_password = $params['user_password'] ?? null;
        $this->cpf_or_cnpj = $params['cpf_or_cnpj'] ?? null;
        $this->profile_photo = $params['profile_photo'] ?? null;
        $this->professional = $params['professional'] ?? null;
        $this->phone = $params['phone'] ?? null;
    }

    public function __get($attr){
        return $this->$attr;
    }

    public function getProfessional(){
        (bool)$this->professional;
    }

    public function valid_record(){
        if (
            empty(trim($this->user_name)) ||
            empty(trim($this->email)) ||
            empty(trim($this->user_password)) ||
            empty(trim($this->cpf_or_cnpj)) ||
            empty(trim($this->professional))
        ){
            $this->errors[] = "Preencha todos os campos obrigatórios";
        }

        if(
            !BrDoc::cpf($this->cpf_or_cnpj)->isValid() &&
            !BrDoc::cnpj($this->cpf_or_cnpj)->isValid()
        ){
            $this->errors[] = "Preencha um CPF ou CNPJ válido";
        }

        return empty($this->errors);
    }

    public function create_record(){
        if (!$this->valid_record()) return false;

        $con = self::get_connection();

        try{
            $stmt = $con->prepare(
                'INSERT INTO user(user_name, email, user_password,'.
                'cpf_or_cnpj, profile_photo, professional, phone) '.
                'VALUE (:user_name, :email, :user_password,'.
                ':cpf_or_cnpj, :profile_photo, :professional, :phone)'
            );
            $stmt->execute(array(
                ':user_name' => $this->user_name,
                ':email' => $this->email,
                ':user_password' => password_hash(
                    $this->user_password, PASSWORD_DEFAULT
                ),
                ':cpf_or_cnpj' => $this->cpf_or_cnpj,
                ':profile_photo' => $this->profile_photo,
                ':professional' => $this->getProfessional(),
                ':phone' => $this->phone
            ));
            return true;
        } catch(PDOException $e) {
            $this->errors[] = $e->getMessage();
            return false;
        }
    }

    public static function findByEmailAndPassword($email, $password){
        $con = self::get_connection();

        try{
            $stmt = $con->prepare(
                'SELECT * FROM user WHERE '.
                'email = :email'
            );
            $stmt->bindParam(':email', $email); 
            $stmt->execute();

            $user = $stmt->fetch(\PDO::FETCH_ASSOC);

            if(password_verify($password, $user['user_password'])){
                return $user;
            } else{
                return [];
            }
        } catch(PDOException $e) {
            return [];
        }
    }
}

?>