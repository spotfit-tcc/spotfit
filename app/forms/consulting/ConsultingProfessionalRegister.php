<?php

namespace App\forms\consulting;

class ConsultingProfessionalRegister {
	private $profession;
	private $register_type;
	private $register;
    private $errors;

    public function __construct($params){
        $this->profession = $params['profession'] ?? null;
        $this->register_type = $params['register_type'] ?? null;
        $this->register = $params['register'] ?? null;
    }

    public function __get($attr){
        return $this->$attr;
    }

    public function get_errors(){
        if (
            empty(trim($this->profession)) ||
            empty(trim($this->register_type)) ||
            empty(trim($this->register))
        ){
            $this->errors[] = "Preencha todas as informações do registro";
        }

        #verificar se registro é válido
    }
}

?>
