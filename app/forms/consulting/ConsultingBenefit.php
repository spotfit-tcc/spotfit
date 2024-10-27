<?php

namespace App\forms\consulting;

class ConsultingBenefit {
	private $consulting_benefit_id ;
	private $benefit;
	private $description;
	private $icon;
	private $idx;
    private $errors = [];

    public function __construct($params, $idx){
        $this->consulting_benefit_id = $params['consulting_benefit_id'] ?? null;
        $this->benefit = $params['benefit'] ?? null;
        $this->description = $params['description'] ?? null;
        $this->icon = $params['icon'] ?? null;
        $this->idx = $idx ?? null;
    }

    public function __get($attr){
        return $this->$attr;
    }

    public function get_errors(){
        if (empty(trim($this->benefit))){
            $this->errors[] = "Preencha todos os campos obrigatórios do benefício " . $this->idx + 1;
        }

        return $this->errors;
    }
}

?>
