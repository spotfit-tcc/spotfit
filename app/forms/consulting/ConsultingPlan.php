<?php

namespace App\forms\consulting;

class ConsultingPlan {
	private $consulting_plans_id;
	private $plan;
	private $price;
	private $description;
	private $period;
	private $benefits = [];
    private $errors;

    public function __construct($params){
        $this->consulting_plans_id = $params['consulting_plans_id'] ?? null;
        $this->plan = $params['plan'] ?? null;
        $this->price = $params['price'] ?? null;
        $this->description = $params['description'] ?? null;
        $this->period = $params['period'] ?? null;
        $this->benefits = $params['benefits'] ?? [];
    }

    public function __get($attr){
        return $this->$attr;
    }

    public function get_formated_price(){
        return str_replace('.', ',', strval($this->price));
    }

    public function get_unformated_price(){
        return str_replace(',', '.', str_replace('.', '', strval($this->price)));
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
