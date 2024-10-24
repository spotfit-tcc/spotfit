<?php

namespace App\forms\consulting;
use App\models\BaseModel;

class ConsultingForm {
	private $consulting_id;
	private $consulting_name;
	private $description;
	private $contact_email;
	private $contact_phone;
	private $adm_user_id;
    private $consulting_images = [];
    private $consulting_benefits = [];
    private $consulting_professionals = [];
    private $consulting_plans = [];

    public function __construct($params, $files_params = []){
        //Consulting
        $this->consulting_id = $params['consulting_id'] ?? null;
        $this->consulting_name = $params['consulting_name'] ?? null;
        $this->description = $params['description'] ?? null;
        $this->contact_email = $params['contact_email'] ?? null;
        $this->adm_user_id = $params['adm_user_id'] ?? null;
        $this->contact_phone = $params['contact_phone'] ?? null;

        //ConsultingImage
        if(isset($files_params["consulting_images"]) && count($files_params["consulting_images"]) > 0) {
            $images_key = $files_params["consulting_images"];
            foreach($images_key["name"] as $key => $image){
                $props = [
                    "name" => $image,
                    "type" => $images_key["type"][$key],
                    "size" => $images_key["size"][$key],
                    "tmp_name" => $images_key["tmp_name"][$key]
                ];
    
                $this->consulting_images[] = new ConsultingImage($props);
            }
        }
        
        //consulting_benefits
        if(isset($params["benefits"]) && count($params["benefits"]) > 0) {
            foreach($params["benefits"] as $key => $benefit){
                $this->consulting_benefits[] = new ConsultingBenefit($benefit, $key);
            }
        }

        //consulting_professionals
        if(isset($params["professional_form"]) && count($params["professional_form"]) > 0) {
            foreach($params["professional_form"] as $key => $professional){
                $this->consulting_professionals[] = new ConsultingProfessional($professional);
            }
        }

        //consulting_plans^
        if(isset($params["plans"]) && count($params["plans"]) > 0) {
            foreach($params["plans"] as $key => $plan){
                $this->consulting_plans[] = new ConsultingPlan($plan);
            }
        }
    }

    public function __get($attr){
        return $this->$attr;
    }

    public function collection_for_professions(){
        $con = BaseModel::get_connection();
        $stmt = $con->query('SELECT * FROM profession');
        $result = $stmt->fetchALL(\PDO::FETCH_ASSOC);

        return array_map(function($profession){
            return [
                'id' => $profession['profession_id'],
                'name' => $profession['profession_name'],
                'desc' => $profession['profession_description']
            ];
        }, $result);
    }

    public function collection_for_register_types(){
        $con = BaseModel::get_connection();
        $stmt = $con->query('SELECT * FROM register_type');
        $result = $stmt->fetchALL(\PDO::FETCH_ASSOC);

        return array_map(function($register){
            return [
                'id' => $register['register_type_id'],
                'name' => $register['type_name'],
                'desc' => $register['type_description']
            ];
        }, $result);
    }

    public function valid_record(){
    }

    public function create_record(){
    }
}

?>
