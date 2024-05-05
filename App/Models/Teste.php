<?php

namespace App\Models;

use MF\Model\Model;

class Teste extends Model {

	public function getInfo() {
		$query = "select titulo, descricao from tb_info";
		return $this->db->query($query)->fetchAll();
	}

	public function getTestes(){
		return [
			"name" => "Natan",
			"github" => "www.com"
		];
	}
}

?>