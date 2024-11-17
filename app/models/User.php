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
	private $professional;
	private $phone;
    private $file_params;
    private $profile_photo;
    const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB

    public function __construct($params){
        $this->user_id = $params['user_id'] ?? null;
        $this->user_name = $params['user_name'] ?? null;
        $this->email = $params['email'] ?? null;
        $this->user_password = $params['user_password'] ?? null;
        $this->cpf_or_cnpj = $params['cpf_or_cnpj'] ?? null;
        $this->professional = $params['professional'] ?? null;
        $this->phone = $params['phone'] ?? null;
        $this->profile_photo = $params['profile_photo'] ?? null;
    }

    public function __get($attr){
        return $this->$attr;
    }

    public function setFileParams($file_params){
        $this->file_params = $file_params;
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

        if(!empty(self::findByAttribute('email', $this->email))){
            $this->errors[] = "Já existe um usuário cadastrado com esse email";
        }

        if(!empty(self::findByAttribute('cpf_or_cnpj', $this->cpf_or_cnpj))){
            $this->errors[] = "Já existe um usuário cadastrado com esse CPF ou CNPJ";
        }

        if($this->has_file_params()){
            if($this->file_params["size"] > self::MAX_FILE_SIZE){
                $this->errors[] = "A imagem de perfil enviada ultrapassa 5 MB";
            }

            if(
                $this->file_params["type"] != "image/jpeg" &&
                $this->file_params["type"] != "image/png"
            ){
                $this->errors[] = "A imagem de perfil deve ser jpeg ou png";
            }
        }

        return empty($this->errors);
    }

    public function create_record(){
        if (!$this->valid_record()) return false;

        if($this->save_profile_image()){
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
                    ':professional' => $this->__get('professional'),
                    ':phone' => $this->phone,
                    ':profile_photo' => $this->profile_photo
                ));

                return true;
            } catch(PDOException $e) {
                $this->errors[] = $e->getMessage();
                return false;
            }
        } else {
            $this->errors[] = "Erro ao fazer upload da imagem. Tente outra";
            return false;
        }
    }

    public function save_profile_image(){
        if(!$this->has_file_params()){
            return true;
        }else {
            $imageFileType = strtolower(pathinfo($this->file_params["name"], PATHINFO_EXTENSION));
            $this->profile_photo = $this->cpf_or_cnpj . uniqid('', true) . '.' . $imageFileType;
    
            return move_uploaded_file($this->file_params["tmp_name"], self::file_upload_dir() . $this->profile_photo);
        }
    }

    private function has_file_params(){
        if(!isset($this->file_params)) return true;

        return !empty($this->file_params["tmp_name"]);
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

    public static function getLoggedUserData() {
        if (session_status() === PHP_SESSION_NONE) session_start();
    
        if (isset($_SESSION['user_id'])) {
            $user_id = $_SESSION['user_id'];
    
            return self::findByAttribute('user_id', $user_id); 
        }
    
        return null; 
    }
    
    
    
    
}

?>