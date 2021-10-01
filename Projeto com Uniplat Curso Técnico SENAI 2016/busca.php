<?php
	include 'conexao.php';
		mysql_query("SET NAMES 'utf8'");

	$busca = $_POST['procura'];

	$busca_query = mysql_query("SELECT * FROM `produtos` WHERE `DS_PRODUTO` Like '%$busca%' ORDER BY CD_PRODUTO")or die(mysql_error());

	if (empty($busca_query)) { 
		echo "Nenhum registro encontrado.";
	}
	
	while ($dados = mysql_fetch_array($busca_query)) {
    echo "Id do Produto: $dados[CD_PRODUTO]<br />"; 
    echo "Nome do Produto: $dados[DS_PRODUTO]<br /><br />";
	}
?>