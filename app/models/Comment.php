<?php

namespace App\models;
use App\models\BaseModel;

class Comment extends BaseModel {
    public function list_records($consulting_id = null)
    {
        $con = self::get_connection();
    
        try {
            $query =
            "SELECT * FROM consulting_comment cc
            INNER JOIN `user` u ON cc.user_id = u.user_id"
            ;
    
            if ($consulting_id) {
                $query .= ' WHERE consulting_id = :id;';
            }
    
            $stmt = $con->prepare($query);
    
            if ($consulting_id) {
                $searchParam = "%{$consulting_id}%";
                $stmt->bindParam(':id', $consulting_id, \PDO::PARAM_STR);
            }
    
            $stmt->execute();
            $records = $stmt->fetchAll(\PDO::FETCH_ASSOC);
            return $records;
        } catch (PDOException $e) {
            $this->errors[] = $e->getMessage();
            return false;
        }
    }

    public function create_record($comment){

        $con = self::get_connection();

        try{
            $stmt = $con->prepare(
                "INSERT INTO consulting_comment(user_id, consulting_id, comment_type, comment_text, rating)
                VALUE (:user_id, :consulting_id, :comment_type, :comment_text, :rating)"
            );
            $stmt->execute([
                ':user_id' => $comment["user_id"],
                ':consulting_id' => $comment["consulting_id"],
                ':comment_type' => $comment["comment_type"],
                ':comment_text' => $comment["comment_text"],
                ':rating' => $comment["rating"],
            ]);
            return true;
        } catch(PDOException $e) {
            $this->errors[] = $e->getMessage();
            return false;
        }
    }
}

?>