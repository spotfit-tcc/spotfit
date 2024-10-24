<?php

namespace App\forms\consulting;

class ConsultingBenefit {
	private $name;
	private $description;
	private $idx;

    public function __construct($params, $idx){
        $this->name = $params['name'] ?? null;
        $this->description = $params['description'] ?? null;
        $this->idx = $idx ?? null;
    }

    public function valid_record(){
    }
}

?>
