<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<meta name="author" content="">
		<title>UniPlast</title>
	   
	   <link href="estilo.css" rel="stylesheet" type="text/css"/>
	   
		<link href="assets/css/bootstrap.css" rel="stylesheet">
	  
		<link href="assets/css/font-awesome.min.css" rel="stylesheet" />
	   
		<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
	  
		<link href="assets/ItemSlider/css/main-style.css" rel="stylesheet" />
		
		<link href="assets/css/style.css" rel="stylesheet" />
			  
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</head>
	<?php
	include 'conexao.php';
	mysql_query("set names 'utf8'");   
	$resultado = mysql_query("select * from produtos");
  ?> 
	<body> <font face="Century Gothic">
		<nav class="navbar navbar-default" role="navigation">
		 <div class="container-fluid">
           
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
				<a class="navbar-brand" href="inicio.html"><strong>UNI</strong>Plast </a>
				</div>

          
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                <form class="navbar-form navbar-right" role="search">
                    <div class="form-group">
                        <input type="text" placeholder="O que você deseja..." class="form-control">
                    </div>
                    &nbsp; 
                    <button type="submit" class="btn btn-primary" id="botaobusca">Buscar</button>
                </form>
            </div>
           
         </div>
		</nav>
	
		<div class="container"> 
			<div id="myCarousel" class="carousel slide" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
			<li data-target="#myCarousel" data-slide-to="2"></li>
		</ol>

    <div class="carousel-inner">
      <div class="item active">
        <img src="carousel1.jpg" alt="Contrução Civil" style="width: 1600px;height: 550px;">
		<div class="carousel-caption">
        <h3>Construções civis </h3>
        <p>Seu texto aqui</p>
    </div>
      </div>

      <div class="item">
        <img src="carousel2.jpg" alt="Expo" style="width: 1600px;height: 550px;">
		<div class="carousel-caption">
        <h3>Design de interiores</h3>
        <p>Seu texto aqui</p>
    </div>
      </div>
    
      <div class="item">
        <img src="loc.png" alt="mapa" style="width: 1600px;height: 550px;">
		<div class="carousel-caption">
        <h3>Entre em contato!</h3>
        <p>Seu texto aqui</p>
    </div>
      </div>
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Anterior</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Próximo</span>
    </a>
  </div>
</div>
	<br>
	<hr class='colorgraph'>
	
	
	<div id="produtos">
		<div class="produto1">
		 Compre isso
		</div>
		
		<div class="produto2">
		 Compre aquilo
		</div>
		
		<div class="produto3">
		 Compre ali
		</div>
	</div>
	
	<?php
		include ('footer.html');
	?> 	
	
</body>
</html>