<?php
	include 'conexao.php';
	if(is_numeric($_GET["id"])){
		$sql="delete from produtos where CD_PRODUTO = ".$_GET["id"];
		$query = mysql_query($sql);
		if(mysql_affected_rows() >=0){
		echo 
		 "<script>alert('Registro apagado com sucesso');</script>";
		echo 
		"<script>window.location='consultaprod.php'</script>";
	}
}
?>