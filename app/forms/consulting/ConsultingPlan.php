<?php

namespace App\forms\consulting;

class ConsultingPlan {
	private $plan;
	private $price;
	private $description;
	private $period;
	private $benefits = [];
    private $errors;

    public function __construct($params){
        $this->plan = $params['plan'] ?? null;
        $this->price = $params['price'] ?? null;
        $this->description = $params['description'] ?? null;
        $this->period = $params['period'] ?? null;
        $this->benefits = $params['benefits'] ?? [];
    }

    public function __get($attr){
        return $this->$attr;
    }

    public function get_errors(){
        if (
            empty(trim($this->plan)) ||
            empty(trim($this->price)) ||
            empty(trim($this->period))
        ){
            $this->errors[] = "Preencha todos os campos obrigatórios para o plano";
        }

        if(empty($this->benefits)){
            $this->errors[] = "O plano precisa ter pelo menos 1 benefício";
        }

        return $this->errors;
    }
}

?>
