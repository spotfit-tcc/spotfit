<?php

namespace App\forms\consulting;

class ConsultingImage {
	private $name;
	private $type;
	private $size;
	private $tmp_name;

    public function __construct($params){
        $this->name = $params['name'] ?? null;
        $this->type = $params['type'] ?? null;
        $this->size = $params['size'] ?? null;
        $this->tmp_name = $params['tmp_name'] ?? null;
    }

    public function path_name(){
    }

    public function valid_record(){
    }
}

?>
