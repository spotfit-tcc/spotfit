<?php

namespace App\forms\consulting;

class ConsultingProfessionalRegister {
	private $profession;
	private $register_type;
	private $register;

    public function __construct($params){
        $this->profession = $params['profession'] ?? null;
        $this->register_type = $params['register_type'] ?? null;
        $this->register = $params['register'] ?? null;
    }

    public function valid_record(){
    }
}

?>
