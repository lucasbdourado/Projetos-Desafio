<!DOCTYPE html>
<html lang="pt-br">
	<head>
	  <meta charset="utf-8">
		<link href="assets/css/estilo.css" rel="stylesheet" />	  
	  <script>
		function apagar(id){		     
			if(window.confirm("Confirma a exclusão ?")){
				window.location = 'excluir_prod.php?id=' + id;			
			}	
		}  	  
	  </script>
	  
	</head>
<?php
	include 'conexao.php';
	mysql_query("set names 'utf8'");   
	$resultado = mysql_query("select * from produtos");

	include ('container.html');
  ?> 
  <body>
	<div class='botaocadprod'>
	 	<a href="cadprod.html" class="btn btn-primary" style="margin:0px 0px 0px 0.2%;">Cadastrar Produto</a>	 
	</div>
	<br>
	<table class="tabela" border="5px">	
			<thead class="cabecalho">
				<tr>
					<th><center>Cod.</center></th>
					<th><center>Descrição</center></th>
					<th><center>Linha</center></th>
					<th><center>Cor</center></th>
					<th><center>Material</center></th>
					<th><center>Aplicação</center></th>
					<th><center>Detalhes</center></th>
					<th><center>Alterar</center></th>
					<th><center>Excluir</center></th>
					<th><center>Página</center></th>
				</tr>	
			</thead>	
	<?php 
      $contLin = 2;
	  while($reg_cadastro=mysql_fetch_array($resultado))
		{
			$codigo=$reg_cadastro["CD_PRODUTO"];
			$descricao=$reg_cadastro["DS_PRODUTO"]."<br>";
			$linha=$reg_cadastro["DS_LINHA"]."<br>";	
			$cor=$reg_cadastro["DS_COR"]."<br>";
			$material=$reg_cadastro["DS_MATERIAL"]."<br>";			
			$aplicacao=$reg_cadastro["DS_APLIC_PRODUTO"]."<br>";	
			$detalhes=$reg_cadastro["DS_DETALHES"]."<br>";    
	?>
		<tr>
		<?php	
			if($contLin%2 == 0){
			   ?>
			   <tr class="trpar">
			<?php
			}
		?>	
			<td><?php echo $codigo ?></td>
			<td><?php echo $descricao ?></td>
			<td><?php echo $linha ?></td>
			<td><?php echo $cor ?></td>
			<td><?php echo $material ?></td>			
			<td><?php echo $aplicacao ?></td>
			<td><?php echo $detalhes ?></td>
			<td align="center"><a href="editar_prod.php?id=<?php echo $reg_cadastro["CD_PRODUTO"]?>" class="btn btn-success">Alterar</a><br>
			<td align="center"> <a href="#" class="btn btn-danger" onclick = "apagar('<?php echo $reg_cadastro["CD_PRODUTO"]?>');">Excluir</td>
			<td align="center"><a href="prod.php?id=<?php echo $reg_cadastro["CD_PRODUTO"]?>" class="btn btn-primary"id="linkPag">Pagina</a><br>
			
		</tr>
	<?php	
	  $contLin = $contLin + 1;
	}	

 ?> 
   </table>
   <br>
	<a href="index.html" class="btn btn-primary" style="margin:0px 0px 0px 0.2%;">Voltar</a>
	<br>
	
	<?php
		include ('footer.html');
	?> 	
 </body> 
</html>	