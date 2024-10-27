<?php

namespace App\forms\consulting;
use App\models\BaseModel;

class ConsultingForm extends BaseModel {
	private $consulting_id;
	private $consulting_name;
	private $description;
	private $contact_email;
	private $contact_phone;
	private $adm_user_id;
    private $consulting_images = [];
    private $categories = [];
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
        $this->categories = $params['categories'] ?? [];

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

    public function get_errors(){
        $result = [];

        array_walk_recursive($this->errors, function($value) use (&$result) {
            $result[] = $value;
        });

        return array_filter($result, function($value){
            return !empty($value);
        });
    }

    public function collection_for_professions(){
        $con = self::get_connection();
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
        $con = self::get_connection();
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

    public function validate_record(){
        $this->errors = [];

        if(empty($this->consulting_images)){
            $this->errors[] = "É necessário escolher pelo menos 1 imagem para consultoria";
        } else {
            foreach ($this->consulting_images as $image) {
                $this->errors[] = $image->get_errors();
            }
        }

        if(empty($this->categories)){
            $this->errors[] = "É necessário escolher pelo menos 1 categoria para consultoria";
        }

        if(empty($this->consulting_benefits)){
            $this->errors[] = "É necessário criar ao menos 1 benefício para consultoria";
        } else {
            foreach ($this->consulting_benefits as $benefit) {
                $this->errors[] = $benefit->get_errors();
            }
        }

        if(empty($this->consulting_professionals)){
            $this->errors[] = "A consultoria precisa de pelo menos 1 profissional";
        } else {
            foreach ($this->consulting_professionals as $professional) {
                $this->errors[] = $professional->get_errors();
            }
        }

        if(empty($this->consulting_plans)){
            $this->errors[] = "A consultoria precisa de pelo menos 1 plano";
        } else {
            foreach ($this->consulting_plans as $plan) {
                $this->errors[] = $plan->get_errors();
            }
        }

        if (
            empty(trim($this->consulting_name)) ||
            empty(trim($this->contact_email))
        ){
            $this->errors[] = "Preencha todos os campos obrigatórios das informações básicas";
        }
    }

    public function create_record(){
        if(count($this->get_errors()) > 0) return false;

        try{
            $pdo = self::get_connection();
            $pdo->beginTransaction();

            //save consulting basic info
            $stmt1 = $pdo->prepare(
                'INSERT INTO consulting(consulting_name, description, contact_email, contact_phone, adm_user_id) '.
                'VALUE(:consulting_name, :description, :contact_email, :contact_phone, :adm_user_id)'
            );

            $stmt1->execute([
                ':consulting_name' => $this->consulting_name,
                ':description' => $this->description,
                ':contact_email' => $this->contact_email,
                ':contact_phone' => $this->contact_phone,
                ':adm_user_id' => self::logged_user(true)
            ]);

            $this->consulting_id = $pdo->lastInsertId();

            foreach ($this->consulting_images as $image) {
                if($image->save_image(self::file_upload_dir())){
                    $img_stmt = $pdo->prepare(
                        'INSERT INTO consulting_image(description, image_dir, consulting_id) '.
                        'VALUE(:description, :image_dir, :consulting_id)'
                    );

                    $img_stmt->execute([
                        ':description' => $image->__get('name'),
                        ':image_dir' => $image->__get('db_saved_name'),
                        ':consulting_id' => $this->consulting_id
                    ]);
                }else {
                    $pdo->rollBack();
                    return false;
                }
            }

            foreach ($this->categories as $category) {
                $cat_stmt = $pdo->prepare(
                    'INSERT INTO consulting_category(consulting_id, category_id) '.
                    'VALUE(:consulting_id, :category_id)'
                );

                $cat_stmt->execute([
                    ':consulting_id' => $this->consulting_id,
                    ':category_id' => $category,
                ]);
            }

            $benefits_ids = [];
            foreach ($this->consulting_benefits as $benefit) {
                $ben_stmt = $pdo->prepare(
                    'INSERT INTO consulting_benefit(benefit, description, icon, consulting_id) '.
                    'VALUE(:benefit, :description, :icon, :consulting_id)'
                );

                $ben_stmt->execute([
                    ':benefit' => $benefit->__get('benefit'),
                    ':description' => $benefit->__get('description'),
                    ':icon' => $benefit->__get('icon'),
                    ':consulting_id' => $this->consulting_id
                ]);

                $benefits_ids[$benefit->idx] = $pdo->lastInsertId();
            }

            foreach ($this->consulting_professionals as $professional) {
                $pro_stmt = $pdo->prepare(
                    'INSERT INTO consulting_professional(name, instagram, phone, email, consulting_id) '.
                    'VALUE(:name, :instagram, :phone, :email, :consulting_id)'
                );

                $pro_stmt->execute([
                    ':name' => $professional->__get('name'),
                    ':instagram' => $professional->__get('instagram'),
                    ':phone' => $professional->__get('phone'),
                    ':email' => $professional->__get('email'),
                    ':consulting_id' => $this->consulting_id
                ]);

                $cur_professional_id = $pdo->lastInsertId();

                foreach ($professional->professional_registers as $register) {
                    $reg_stmt = $pdo->prepare(
                        'INSERT INTO professional_register(profession_id, register_type_id, register, consulting_professional_id) '.
                        'VALUE(:profession_id, :register_type_id, :register, :consulting_professional_id)'
                    );
    
                    $reg_stmt->execute([
                        ':profession_id' => $register->__get('profession'),
                        ':register_type_id' => $register->__get('register_type'),
                        ':register' => $register->__get('register'),
                        ':consulting_professional_id' => $cur_professional_id
                    ]);
                }

                foreach ($professional->benefits as $pro_benefit) {
                    $pb_stmt = $pdo->prepare(
                        'INSERT INTO consulting_benefit_professional(consulting_benefit_id, consulting_professional_id) '.
                        'VALUE(:consulting_benefit_id, :consulting_professional_id)'
                    );
    
                    $pb_stmt->execute([
                        ':consulting_benefit_id' => $benefits_ids[$pro_benefit],
                        ':consulting_professional_id' => $cur_professional_id
                    ]);
                }
            }

            foreach ($this->consulting_plans as $plan) {
                $plan_stmt = $pdo->prepare(
                    'INSERT INTO consulting_plan(plan, price, description, period, consulting_id) '.
                    'VALUE(:plan, :price, :description, :period, :consulting_id)'
                );

                $plan_stmt->execute([
                    ':plan' => $plan->__get('plan'),
                    ':price' => $plan->__get('price'),
                    ':description' => $plan->__get('description'),
                    ':period' => $plan->__get('period'),
                    ':consulting_id' => $this->consulting_id
                ]);

                $cur_plan_id = $pdo->lastInsertId();

                foreach ($plan->benefits as $plan_benefit) {
                    $plb_stmt = $pdo->prepare(
                        'INSERT INTO consulting_plan_benefit(consulting_plans_id, id_beneficio_consultoria) '.
                        'VALUE(:consulting_plans_id, :id_beneficio_consultoria)'
                    );
    
                    $plb_stmt->execute([
                        ':id_beneficio_consultoria' => $benefits_ids[$plan_benefit],
                        ':consulting_plans_id' => $cur_plan_id
                    ]);
                }
            }

            $pdo->commit();
            return true;
        } catch(Exception $e){
            $pdo->rollBack();
            print_r($e);
            die();
            
            //return false;
        }
    }
}

?>
