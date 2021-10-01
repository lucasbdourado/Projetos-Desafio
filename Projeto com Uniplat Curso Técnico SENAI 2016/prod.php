<!DOCTYPE html>
<html lang="pt-br">
	<head>
	  <meta charset='utf-8'>
			
	</head>
<?php
	include 'conexao.php';
	mysql_query("set names 'utf8'");   
	$resultado = mysql_query("select * from produtos");

	include ('container.html');
  ?> 
<body>
	<?php
	if(isset($_GET["id"])){
		if(is_numeric($_GET["id"])){	
			$codigo = $_GET["id"];
			$sql = "select * from produtos where CD_PRODUTO = ".$_GET["id"];
			$executa   = mysql_query($sql);
			$resultado = mysql_fetch_array($executa);
		}}

	?>
	<hr class='colorgraphprd'>
	<div class="col-xs-12 col-sm-6 col-md-3">
            <div class="col-item" id="colitem">
                <div class="photo">
                    <img src="0416.jpg" class="img-responsive" alt="a" />
                </div>
                <div class="info">
                    <div class="row">
                        <div class="price col-md-6">
                            <h5><strong><?php echo $resultado["DS_PRODUTO"];?></strong></h5>
                            <h5 class="price-text-color">Cód. <?php echo $resultado["CD_PRODUTO"];?></h5>
                        </div>
                        </div>
                    </div>
                    <div class="separator clear-left">
                        <p class="btn-add">
                            <i class="fa fa-scissors"></i><a href="medidas.html" class="hidden-sm">Ver Medidas</a></p>
                    <div class="clearfix">
                    </div>
                </div>
            </div>
    </div>
	<div class='product name'> <font size="3">
				<h1><?php echo $resultado["DS_PRODUTO"];?></h1>
				<span><strong>Cód.</strong> <?php echo $resultado["CD_PRODUTO"];?></span>
				<br>
				<br>
				<span><strong>Linhas:</strong> <?php echo $resultado["DS_LINHA"];?></span>
				<br>
				<br>
				<h2>Aplicações do produto</h2> </font>
				<font size="3"><?php echo $resultado["DS_APLIC_PRODUTO"];?></font>
				</br></br>
				<h2>Cores</h2>
				<font size="3"><?php echo $resultado["DS_COR"];?></font><br /> <br /><br /> <br /> 
				<hr class='colorgraphprd'>
				<h3>Material</h3>	
				<font size="3"><?php echo $resultado["DS_MATERIAL"];?></font><br /> <br />
				<h3>Detalhes<h3>	
				<font size="3"><?php echo $resultado["DS_DETALHES"];?></font><br /> <br />
				</font>
			</div>
</body>
</html>
</html>