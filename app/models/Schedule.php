<?php

namespace App\Models;
use App\Models\BaseModel;

class Schedule extends BaseModel {

    public function list_records($consulting_id = null)
    {
        $con = self::get_connection();
    
        try {
            $query = "SELECT cs.*, u.name as user_name 
                      FROM consulting_schedules cs
                      INNER JOIN `user` u ON cs.user_id = u.user_id";
    
            if ($consulting_id) {
                $query .= ' WHERE cs.consulting_id = :consulting_id';
            }

            $stmt = $con->prepare($query);
    
            if ($consulting_id) {
                $stmt->bindParam(':consulting_id', $consulting_id, \PDO::PARAM_INT);
            }
    
            $stmt->execute();
            $records = $stmt->fetchAll(\PDO::FETCH_ASSOC);
            return $records;
        } catch (PDOException $e) {
            $this->errors[] = $e->getMessage();
            return false;
        }
    }

    public function create_record($schedule)
    {
        $con = self::get_connection();

        try {
            $stmt = $con->prepare(
                "INSERT INTO consulting_schedules (user_id, consulting_id, reason, contact_date)
                VALUES (:user_id, :consulting_id, :reason, :contact_date)"
            );
            $stmt->execute([
                ':user_id' => $schedule["user_id"],
                ':consulting_id' => $schedule["consulting_id"],
                ':reason' => $schedule["reason"],
                ':contact_date' => $schedule["contact_date"]
            ]);
            return true;
        } catch(PDOException $e) {
            $this->errors[] = $e->getMessage();
            return false;
        }
    }
}

?>
