<html>
	<head>
		<title>Página de alteração</title>
		<link href="estilo.css" rel="stylesheet" type="text/css"/>	
		<meta charset="utf-8">
	</head>
<body class="pagina_principal">	  
	<?php
	include 'conexao.php';	
	if(isset($_GET["id"])){
		if(is_numeric($_GET["id"])){	
			$codigo = $_GET["id"];
			$sql = "select * from produtos where CD_PRODUTO = ".$_GET["id"];
			$executa   = mysql_query($sql);
			$resultado = mysql_fetch_array($executa);
		}}

	?>
	<form name="frmalteraProdutos" id="frmCadProdutos" method="POST"  action="alterar_prod.php">
			<label for="campoCodigoAux">	       
				<input type="hidden" name="campoCodigoAux" id="campoCodigoAux" placeholder="Informe o codigo do produto" value="<?php echo $resultado["CD_PRODUTO"];?>"required/>
			</label>
		    <label for="campoCodigo">	       
				Cod. do produto:<input type="text" name="campoCodigo" id="campoCodigo" placeholder="Informe o codigo do produto" value="<?php echo $resultado["CD_PRODUTO"];?>"required/>
			</label>
	  		
			<label for="campoDescricao">	       
				Nome Prod: <input type="text" name="campoDescricao" id="campoDescricao" placeholder="Informe a descriçao" value="<?php echo $resultado["DS_PRODUTO"];?>"required/>
			</label>
			
			<label for="campoLinha"> 
				Linha: <input type="text" name="campoLinha" id="campoLinha" placeholder="Informe a linha" value="<?php echo $resultado["DS_LINHA"];?>" required />
			</label>			
			
			<label for="campoCor"> 
				Cores: <input type="text" name="campoCor" id="campoCor" placeholder="Informe a cor" value="<?php echo $resultado["DS_COR"];?>" required />			              
			</label>
			
			<label for="campoMaterial"> 
				Material: <input type="text" name="campoMaterial" id="campoMaterial" placeholder="Informe o Material" value="<?php echo $resultado["DS_MATERIAL"];?>" required />
			</label>			
			
			<label for="campoAplicacao">
				Aplic. do produto: <input type="text" name="campoAplicacao" id="campoAplicacao" placeholder="Informe a aplicaçao do produto" value="<?php echo $resultado["DS_APLIC_PRODUTO"];?>" required />
			</label>

			<label for="campoDetalhes">
				Detalhes: <input type="text" name="campoDetalhes" id="campoDetalhes" placeholder="Informe os detalhes" value="<?php echo $resultado["DS_DETALHES"];?>" required />
			</label>   
	  <input type="submit" value="Alterar" id="botao_login"/>
	  <a href="consultaprod.php" id="link">Voltar</a>					   
	</form>	
		
	    
</body>
</html>