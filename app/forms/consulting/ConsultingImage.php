<?php

namespace App\forms\consulting;

class ConsultingImage {
	private $name;
	private $type;
	private $size;
	private $tmp_name;
    private $db_saved_name;
    private $consulting_image_id;
    private $errors = [];
    const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB

    public function __construct($params){
        $this->name = $params['name'] ?? null;
        $this->type = $params['type'] ?? null;
        $this->size = $params['size'] ?? null;
        $this->tmp_name = $params['tmp_name'] ?? null;
        $this->db_saved_name = $params['db_saved_name'] ?? null;
        $this->consulting_image_id  = $params['consulting_image_id'] ?? null;
    }

    public function __get($attr){
        return $this->$attr;
    }

    public function save_image($dir){
        $imageFileType = strtolower(pathinfo($this->name, PATHINFO_EXTENSION));
        $this->db_saved_name = uniqid('', true) . '.' . $imageFileType;

        return move_uploaded_file($this->tmp_name, $dir . $this->db_saved_name);
    }

    public function get_errors(){
        if($this->size > self::MAX_FILE_SIZE){
            $this->errors[] = "A imagem $name ultrapassa " . self::MAX_FILE_SIZE . 'MB';
        }

        if(
            $this->type != "image/jpeg" &&
            $this->type != "image/png"
        ){
            $this->errors[] = "A imagem $this->name deve ser jpeg ou png";
        }

        return $this->errors;
    }
}

?>
