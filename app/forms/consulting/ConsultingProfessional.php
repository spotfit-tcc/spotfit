<?php

namespace App\forms\consulting;

class ConsultingProfessional {
	private $name;
	private $instagram;
	private $phone;
	private $email;
	private $professional_registers;
	private $benefits;

    public function __construct($params){
        $this->name = $params['consulting_professional']['name'] ?? null;
        $this->instagram = $params['consulting_professional']['instagram'] ?? null;
        $this->phone = $params['consulting_professional']['phone'] ?? null;
        $this->email = $params['consulting_professional']['email'] ?? null;

        //consulting_professionals
        foreach($params["professional_registers"] as $key => $benefit){
            $this->professional_registers = new ConsultingProfessionalRegister($benefit);
        }

        $this->benefits = $params['benefits'] ?? null;
    }

    public function valid_record(){
    }
}

?>
