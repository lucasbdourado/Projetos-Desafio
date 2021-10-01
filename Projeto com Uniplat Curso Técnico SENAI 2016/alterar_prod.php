<?php        
	include 'conexao.php';
	mysql_query("SET NAMES 'utf8'");
	$codigoaux			= $_POST["campoCodigoAux"];
    $codigo 		  = $_POST["campoCodigo"];
	$descricao       = $_POST['campoDescricao'];
    $linha     = $_POST['campoLinha'];	
	$cor       = $_POST['campoCor'];
	$material       = $_POST['campoMaterial'];
	$aplicacao	      = $_POST['campoAplicacao'];
	$detalhes      = $_POST['campoDetalhes'];
     
	$sql = "UPDATE produtos SET CD_PRODUTO='$codigo', DS_PRODUTO='$descricao', DS_LINHA='$linha', DS_COR='$cor', DS_MATERIAL='$material', DS_APLIC_PRODUTO='$aplicacao', DS_DETALHES='$detalhes' where CD_PRODUTO='$codigoaux'";	   
    echo $sql;	
    
	if ($sql < 0) {
 		   die('Problema na alteração:'.mysql_error());
 		     

 	}	   
 	else
 	{
		$executa = mysql_query($sql);	
		echo "<script>alert('registro alterado');</script>";
		echo "<script>window.location='consultaprod.php'</script>";	
	}	
?>
