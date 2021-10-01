<html lang="pt-br">
	<head>
		<title>Cadastro de Produtos</title>
		<link href="assets/css/cadtubos.css" rel="stylesheet" type="text/css"/>
		<script language="javascript" src="js/funcoes.js"></script>	
		<meta charset="utf-8">	
		
		<link href="assets/css/bootstrap.css" rel="stylesheet">
  
		<link href="assets/css/font-awesome.min.css" rel="stylesheet" />
		
		<link href="assets/css/style.css" rel="stylesheet" />
		
		<link href="assets/css/estilo.css" rel="stylesheet" />
	</head>
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
	<body>

<div class="container" id="wrap">
	  <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <form name="frmCadProdutos" id="frmCadProdutos" action="alterar_prod.php" method="post" accept-charset="utf-8" class="form" role="form">   
            <legend>Cadastro de Produtos</legend>
			
				<input type="hidden" name="campoCodigoAux" id="campoCodigoAux" placeholder="Informe o codigo do produto" value="<?php echo $resultado["CD_PRODUTO"];?>"required/>
 
                <input type="text" name="campoCodigo" id="campoCodigo" value="<?php echo $resultado["CD_PRODUTO"];?>" class="form-control input-lg" placeholder="Código do Produto"required  /> 
      
                <input type="text" name="campoDescricao" id="campoDescricao" value="<?php echo $resultado["DS_PRODUTO"];?>" class="form-control input-lg" placeholder="Descrição do Produto"required  />
				
                <input type="text" name="campoLinha" id="campoLinha" value="<?php echo $resultado["DS_LINHA"];?>" class="form-control input-lg" placeholder="Linha do Produto"required/>

                <input type="text" name="campoCor" id="campoCor" value="<?php echo $resultado["DS_COR"];?>" class="form-control input-lg" placeholder="Cores"required/>
                
                <input type="text" name="campoMaterial" id="campoMaterial" value="<?php echo $resultado["DS_MATERIAL"];?>" class="form-control input-lg" placeholder="Materiais"required/>

                <input type="text" name="campoAplicacao" id="campoAplicacao" value="<?php echo $resultado["DS_APLIC_PRODUTO"];?>" class="form-control input-lg" placeholder="Aplicação"required  />
				
				<textarea type="text" rows="8" name="campoDetalhes" id="campoDetalhes" value="" class="form-control input-lg" placeholder="Detalhes"required  /><?php echo $resultado["DS_DETALHES"];?></textarea>
				
				
                    <br />
                    <button class="btn btn-lg btn-primary btn-block signup-btn" value="Alterar" type="submit" id="buttonalt">Alterar Produto</button>
					<button class="btn btn-lg btn-primary btn-block signup-btn" value="Limpar" type="reset" id="buttonlimp">Limpar</button>
            </form>          
          </div>
</div>            
</div>
</div>