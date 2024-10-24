<?php

namespace App\forms\consulting;

class ConsultingPlan {
	private $plan;
	private $price;
	private $description;
	private $period;
	private $benefits;

    public function __construct($params){
        $this->plan = $params['plan'] ?? null;
        $this->price = $params['price'] ?? null;
        $this->description = $params['description'] ?? null;
        $this->period = $params['period'] ?? null;
        $this->benefits = $params['benefits'] ?? null;
    }

    public function valid_record(){
    }
}

?>
