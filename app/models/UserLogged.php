<?php

namespace App\models;
use App\models\BaseModel;

class UserLogged extends BaseModel {

    protected $db;

    public function __construct() {
        $this->db = self::get_connection(); 
    }

    public function getUserById($user_id) {
        $stmt = $this->db->prepare("SELECT user_id, user_name, email, phone, profile_photo FROM user WHERE user_id = ?");
        $stmt->execute([$user_id]);
    
        // Adicione um var_dump aqui para verificar se a execução foi bem-sucedida
        if ($stmt->errorCode() !== '00000') {
            var_dump($stmt->errorInfo());
        }
    
        $userData = $stmt->fetch(\PDO::FETCH_ASSOC);
        
        var_dump($userData); // Verifique o que está sendo retornado
        return $userData;
    }
    
    
    
}


?>