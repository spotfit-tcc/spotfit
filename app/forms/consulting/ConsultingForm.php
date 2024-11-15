<?php

namespace App\forms\consulting;
use App\models\BaseModel;
use App\models\Comment;

class ConsultingForm extends BaseModel {
	private $consulting_id;
	private $consulting_name;
	private $description;
	private $contact_email;
	private $contact_phone;
	private $adm_user_id;
    private $consulting_images = [];
    private $delete_images = [];
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
        $this->delete_images = $params['delete_images'] ?? [];

        //ConsultingImage
        if(isset($files_params["consulting_images"]) && count($files_params["consulting_images"]) > 0 && !empty($files_params["consulting_images"]['tmp_name'][0])) {
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
        } elseif (isset($params["consulting_images"]) && count($params["consulting_images"]) > 0) {
            foreach($params["consulting_images"] as $key => $image){
                $this->consulting_images[] = new ConsultingImage($image);
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

    public static function build_form_from_id($id){
        $user_id = self::logged_user(true);

        $con = self::get_connection();
        $stmt = $con->prepare("SELECT * FROM consulting WHERE consulting_id = :id AND adm_user_id = :user_id");
        $stmt->bindParam(':id', $id);
        $stmt->bindParam(':user_id', $user_id);
        $stmt->execute();
        $params = $stmt->fetch(\PDO::FETCH_ASSOC);

        $stmt = $con->prepare("SELECT * FROM consulting WHERE consulting_id = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        $consulting = $stmt->fetch(\PDO::FETCH_ASSOC);
        $params['consulting'] = $consulting;

        $stmt = $con->prepare("SELECT * FROM consulting_image WHERE consulting_id = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        $params['consulting_images'] = array_map(function($img){
            return [
                "name" => $img['description'],
                "db_saved_name" => $img['image_dir'],
                "consulting_image_id" => $img['consulting_image_id']
            ];
        }, $stmt->fetchAll(\PDO::FETCH_ASSOC));

        $stmt = $con->prepare("SELECT * FROM consulting_category WHERE consulting_id = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        $params['categories'] = array_map(function($cat){
            return $cat["category_id"];
        }, $stmt->fetchAll(\PDO::FETCH_ASSOC));

        $comment_model = new Comment();
        $params['comments'] = $comment_model->list_records($id);

        $params['rating_detail'] = $comment_model->list_rating_detail($id);

        
        $stmt = $con->prepare("SELECT * FROM consulting_benefit WHERE consulting_id = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        $params['benefits'] = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        $stmt = $con->prepare(
            "SELECT * from consulting c 
            inner join consulting_plan cp
            on c.consulting_id = cp.consulting_id 
            inner join consulting_plan_benefit cpb 
            on cp.consulting_plans_id = cpb.consulting_plans_id 
            inner join consulting_benefit cb 
            on cb.consulting_benefit_id = cpb.id_beneficio_consultoria
            where c.consulting_id = :id"
        );
        $stmt->bindParam(':id', $id);
        $stmt->execute();

        $queryResult = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        $plans = [];
        foreach ($queryResult as $row) {
            $planId = $row['consulting_plans_id'];

            if (!isset($plans[$planId])) {
                $plans[$planId] = [
                    "name" => $row["plan"],
                    "description" => $row["description"],
                    "price" => $row["price"],
                    "period" => $row["period"],
                    "benefits" => []
                ];
            }

            $plans[$planId]["benefits"][] = [
                "icon" => $row["icon"],
                "benefit_name" => $row["benefit"]
            ];
        }
        $plans = array_values($plans);
        $params['plans_benefits'] =  $plans;


        $stmt = $con->prepare("SELECT * FROM consulting_professional WHERE consulting_id = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        $professionals = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        $stmt = $con->prepare("SELECT count(*) as qtd FROM consulting_access WHERE liked = 1 AND consulting_id = :consulting_id");
        $stmt->bindParam(':consulting_id', $id);
        $stmt->execute();
        $params['likes_quantity'] = $stmt->fetch(\PDO::FETCH_ASSOC);

        $userHasLiked = false;
        if (!empty($user_id)) {
            $stmt = $con->prepare("SELECT count(*) qtd FROM consulting_access WHERE liked = 1 AND consulting_id = :consulting_id and user_id=:user_id");
            $stmt->bindParam(':user_id', $user_id);
            $stmt->bindParam(':consulting_id', $id);
            $stmt->execute();
            $result = $stmt->fetch(\PDO::FETCH_ASSOC);
            $userHasLiked = $result["qtd"] == 1;
        }
        $params['user_has_liked'] = $userHasLiked;

        $stmt = $con->prepare("SELECT count(*) as qtd, user_id, consulting_id from consulting_view where consulting_id = :consulting_id  group by user_id, consulting_id; ");
        $stmt->bindParam(':consulting_id', $id);
        $stmt->execute();
        $params["views"] = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        $totalViews = 0;
        foreach ($params["views"] as $view) {
            $totalViews += $view['qtd'];
        }

        $params["totalViews"] = $totalViews;
        

        foreach ($professionals as $key => $professional) {
            $params['professional_form'][$key]['consulting_professional'] = $professional;

            $stmt = $con->prepare("SELECT * FROM professional_register WHERE consulting_professional_id  = :id");
            $stmt->bindParam(':id', $professional['consulting_professional_id']);
            $stmt->execute();
            $params['professional_form'][$key]['professional_registers'] = $stmt->fetchAll(\PDO::FETCH_ASSOC);

            $stmt = $con->prepare(
                "SELECT * FROM professional_register pr 
                INNER JOIN profession p 
                ON pr.profession_id  = p.profession_id 
                WHERE pr.professional_register_id = :professional_register_id"
            );
            $stmt->bindParam(':professional_register_id', $professional['consulting_professional_id']);
            $stmt->execute();
            $params['professional_form'][$key]['profession'] = array_map(function($benef){
                return $benef;
            }, $stmt->fetchAll(\PDO::FETCH_ASSOC));

            $stmt = $con->prepare("SELECT * FROM consulting_benefit_professional WHERE consulting_professional_id  = :id");
            $stmt->bindParam(':id', $professional['consulting_professional_id']);
            $stmt->execute();
            $params['professional_form'][$key]['benefits'] = array_map(function($benef){
                return $benef["consulting_benefit_id"];
            }, $stmt->fetchAll(\PDO::FETCH_ASSOC));
        }

        $stmt = $con->prepare("SELECT * FROM consulting_plan WHERE consulting_id = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        $params['plans'] = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        foreach ($params['plans'] as $key => $plan) {
            $stmt = $con->prepare("SELECT * FROM consulting_plan_benefit WHERE consulting_plans_id   = :id");
            $stmt->bindParam(':id', $plan['consulting_plans_id']);
            $stmt->execute();
            $params['plans'][$key]['benefits'] = array_map(function($benef){
                return $benef["id_beneficio_consultoria"];
            }, $stmt->fetchAll(\PDO::FETCH_ASSOC));
        }

        return $params;
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

        if($this->consulting_id){
            $con = self::get_connection();
            $cur_images_qnt = $con->query("SELECT COUNT(*) as qnt FROM consulting_image WHERE consulting_id = " . $this->consulting_id)->fetch(\PDO::FETCH_ASSOC)['qnt'];
            if($cur_images_qnt == count($this->delete_images) && empty($this->consulting_images)){
                $this->errors[] = "É necessário escolher pelo menos 1 imagem para consultoria";
            } elseif(!empty($this->consulting_images)) {
                foreach ($this->consulting_images as $image) {
                    $this->errors[] = $image->get_errors();
                }
            }
        } else{
            if(empty($this->consulting_images)){
                $this->errors[] = "É necessário escolher pelo menos 1 imagem para consultoria";
            } else {
                foreach ($this->consulting_images as $image) {
                    $this->errors[] = $image->get_errors();
                }
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
                    ':price' => $plan->get_unformated_price(),
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

    public function update_record(){
        if(count($this->get_errors()) > 0) return false;

        try{
            $pdo = self::get_connection();
            $pdo->beginTransaction();

            //save consulting basic info
            $stmt = $pdo->prepare(
                'UPDATE consulting SET consulting_name = :consulting_name, '.
                'description = :description, contact_email = :contact_email, '.
                'contact_phone = :contact_phone WHERE consulting_id = :consulting_id'
            );

            $stmt->execute([
                ':consulting_name' => $this->consulting_name,
                ':description' => $this->description,
                ':contact_email' => $this->contact_email,
                ':contact_phone' => $this->contact_phone,
                ':consulting_id' => $this->consulting_id
            ]);

            //delete selected images
            if(count($this->delete_images) > 0){
                $placeholders = rtrim(str_repeat('?,', count($this->delete_images)), ',');

                $stmt = $pdo->prepare(
                    "DELETE FROM consulting_image WHERE consulting_image_id IN ($placeholders)"
                );

                $stmt->execute($this->delete_images);
            }

            //deleting consulting_plans to create them again later
            $stmt = $pdo->prepare('DELETE FROM consulting_plan WHERE consulting_id = :consulting_id');
            $stmt->bindParam(':consulting_id', $this->consulting_id);
            $stmt->execute();

            //deleting consulting_categories to create them again later
            $stmt = $pdo->prepare('DELETE FROM consulting_category WHERE consulting_id = :consulting_id');
            $stmt->bindParam(':consulting_id', $this->consulting_id);
            $stmt->execute();

            //deleting consulting_professionals to create them again later
            $stmt = $pdo->prepare('DELETE FROM consulting_professional WHERE consulting_id = :consulting_id');
            $stmt->bindParam(':consulting_id', $this->consulting_id);
            $stmt->execute();

            //deleting consulting_benefits to create them again later
            $stmt = $pdo->prepare('DELETE FROM consulting_benefit WHERE consulting_id = :consulting_id');
            $stmt->bindParam(':consulting_id', $this->consulting_id);
            $stmt->execute();

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

                $benefits_ids[$benefit->consulting_benefit_id] = $pdo->lastInsertId();
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
                    ':price' => $plan->get_unformated_price(),
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

    public function cant_edit(){
        return empty($this->consulting_images) ||
        empty($this->categories) ||
        empty($this->consulting_benefits) ||
        empty($this->consulting_professionals) ||
        empty($this->consulting_plans) ||
        empty($this->consulting_id);
    }

    public function toggle_user_like($user_id, $consulting_id) {
        $con = self::get_connection();
    
        try {
            // Check if a record exists for the user and consulting combination
            $stmt = $con->prepare(
                'SELECT liked FROM consulting_access WHERE user_id = :user_id AND consulting_id = :consulting_id'
            );
            $stmt->execute([
                ':user_id' => $user_id,
                ':consulting_id' => $consulting_id
            ]);
    
            $record = $stmt->fetch(\PDO::FETCH_ASSOC);

            if (!$record || empty($record) || count($record) <= 0) {
                // If not found, insert a new record with liked = 1
                $insertStmt = $con->prepare(
                    'INSERT INTO consulting_access (user_id, consulting_id, liked) VALUES (:user_id, :consulting_id, :liked)'
                );
                $insertStmt->execute([
                    ':user_id' => $user_id,
                    ':consulting_id' => $consulting_id,
                    ':liked' => 1
                ]);
            }
            
            // If found, toggle the "liked" value
            $newLikedValue = $record['liked'] == 1 ? 0 : 1;
            $updateStmt = $con->prepare(
                'UPDATE consulting_access SET liked = :liked WHERE user_id = :user_id AND consulting_id = :consulting_id'
            );
            $updateStmt->execute([
                ':liked' => $newLikedValue,
                ':user_id' => $user_id,
                ':consulting_id' => $consulting_id
            ]);

            return [
                'liked' => $newLikedValue,
                'user_id' => $user_id,
                'consulting_id' => $consulting_id
            ];
        } catch (\PDOException $e) {
            $this->errors[] = $e->getMessage();
            return false;
        }
    }

    public function insert_view($user_id, $consulting_id) {
        // Ensure that user_id and consulting_id are not empty
        if (empty($user_id) || empty($consulting_id)) {
            return false; // Validation failed
        }

        $con = self::get_connection();

        try {
            $stmt = $con->prepare(
                'INSERT INTO consulting_view (user_id, consulting_id, time_stamp) ' .
                'VALUES (:user_id, :consulting_id, NOW())'
            );

            // Execute the statement with the provided values
            $stmt->execute([
                ':user_id' => $user_id,
                ':consulting_id' => $consulting_id
            ]);

            return true; // Success
        } catch (\PDOException $e) {
            $this->errors[] = $e->getMessage();
            return false; // Error occurred
        }
    }
}

?>
