<?php

namespace App\models;
use App\models\BaseModel;

class Category extends BaseModel {
	private $category_id;
	private $category_name;

    public function __construct($params){
        $this->set_attributes($params);
    }

    public function set_attributes($params){
        $this->category_id = $params['category_id'] ?? null;
        $this->category_name = $params['category_name'] ?? null;
    }

    public static function get_all_categories(){
        $con = self::get_connection();

        try{
            $stmt = $con->query('SELECT * FROM category');

            return $stmt->fetchAll(\PDO::FETCH_ASSOC);
        } catch(PDOException $e) {
            return [];
        }
    }
}

?>