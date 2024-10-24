<?php

namespace App\forms\consulting;

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

        //consulting_benefits
        foreach($params["benefits"] as $key => $benefit){
            $this->consulting_benefits[] = new ConsultingBenefit($benefit, $key);
        }

        //consulting_professionals
        foreach($params["professional_form"] as $key => $professional){
            $this->consulting_professionals[] = new ConsultingProfessional($professional);
        }

        //consulting_plans
        foreach($params["plans"] as $key => $plan){
            $this->consulting_plans[] = new ConsultingPlan($plan);
        }
    }

    public function valid_record(){
    }

    public function create_record(){
    }
}

?>
