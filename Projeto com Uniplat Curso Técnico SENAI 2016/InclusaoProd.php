<!DOCTYPE html>
<html lang="pt-br">
	<head>
		<meta charset="utf-8">	
		<title>Inclusão de Cadastro de Produtos</title>
	</head>
<body>
<?php  
   include 'conexao.php';     
	
  // Passando os dados obtidos pelo formulário para as variáveis abaixo
    
	$codigo        = $_POST['campoCodigo'];
	$descricao    = $_POST['campoDescricao'];	
	$linha      = $_POST['campoLinha'];
    $cor      = $_POST['campoCor'];
    $material       = $_POST['campoMaterial'];
    $aplicacao     = $_POST['campoAplicacao'];
    $detalhes      = $_POST['campoDetalhes'];    
   
	$result = mysql_query("insert into produtos(CD_PRODUTO,DS_PRODUTO,DS_LINHA,DS_COR,DS_MATERIAL,DS_APLIC_PRODUTO,DS_DETALHES) 
	values ('$codigo','$descricao','$linha','$cor','$material','$aplicacao','$detalhes')");     

		if ($result <= 0) {
 		   die('Problema na inserção:'.mysql_error());
 		 
		}
		else{
				mysql_query($result);	
				mysql_close();	
				echo "<script>alert('inclusão realizada com sucesso');</script>";
				echo "<script>window.location='ConsultaProd.php'</script>";
			}		
			
?>	
 </body>	
</html>	

