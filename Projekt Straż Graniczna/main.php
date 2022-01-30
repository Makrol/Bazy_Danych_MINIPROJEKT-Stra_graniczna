<html>
	<head>
		<title>Straż Graniczna</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="author" content="Damian Gajda | Artur Graba | Karol Gardian"/>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
		 <!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
		<!-- jQuery library -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<!-- Latest compiled JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> 
		<?php
		session_start();
		if(!isset($_SESSION['zalogowany']))
		{
			header('Location: logowanie.html');
		}
		?>
		<?php include 'php/DatabaseConnection.php';?>
		

	</head>
	<body>
		<div id="buttonbox">
			
			<div id="inbuttonbox">
				<form method="post" action="mainpage.php">
					<input  class='button'  id="MainPage" type='submit' name='MainPage' value='MainPage'/>	
				</form>
				<form action='wyloguj.php' method='POST'>
					<input type='submit' id="MainPage" name='wyloguj2' value='wyloguj'>
				</form>
			</div>
			<div id="inbuttonbox">
				<form method="post" action="mainpage.php">
					<input  class='button'  id="Expand_Button" type='submit' name='BasicAplicationButton' value='Stwórz tabele'/>
					<input  class='button'  id="Expand_Button" type='submit' name='BasicAplicationButton' value='Zainicjuj tabele wartościami'/>
					<input  class='button'  id="Expand_Button" type='submit' name='BasicAplicationButton' value='Usuń całą baze'/>
					<input  class='button'  id="Expand_Button" type='submit' name='BasicAplicationButton' value='Stwórz kursory i wyzwalacze'/>
					<input  class='button'  id="Expand_Button" type='submit' name='BasicAplicationButton' value='Stwórz widoki'/>
					<?php include 'php/BasicAplication.php';?>	
				</form>
			</div>
			<div id="inbuttonbox">
				<form method="post">
					<input  class="button" data-toggle="collapse" data-target=".multi-collapse" aria-expanded="false" aria-controls="expanding" type="button" name="Expand_Button_1" id="Expand_Button" value="Tabele"/>
					<?php include 'php/buttons.php';?>
				</form>
			</div>
			<div id="inbuttonbox">
				<form method="post">
					<input  class="button" data-toggle="collapse" data-target=".multi-collapse2" aria-expanded="false" aria-controls="expanding2" type="button" name="Expand_Button_2" id="Expand_Button"
							 value="Widoki"/>
					<!-- <input  class='button  collapse multi-collapse2' id='expanding'  type='submit' name='Submit_Button' value='test'/> -->
					<?php include 'php/viewbuttons.php';?>
				</form>
			</div>
			<div id="inbuttonbox">
				<form method="post">
					<input  class="button" data-toggle="collapse" data-target=".multi-collapse3" aria-expanded="false" aria-controls="expanding3" type="button" name="Expand_Button_2" id="Expand_Button" value="Kursory"/>
					<input  class='button  collapse multi-collapse3' id='expanding'  type='submit' name='Submit_Button2' value='podwyzka'/>
					<input  class='button  collapse multi-collapse3' id='expanding'  type='submit' name='Submit_Button2' value='awans_kapral'/>
					<input  class='button  collapse multi-collapse3' id='expanding'  type='submit' name='Submit_Button2' value='procent_zatrz'/>
					<input  class='button  collapse multi-collapse3' id='expanding'  type='submit' name='Submit_Button2' value='podwyzka_jednostki'/>
				</form>
			</div>
			<div id="inbuttonerrorbox">
				
				<form method="post" action="mainpage.php">
					
					<input type="text" name="commandcontent" placeholder="Podaj polecenie bez srednika..." id="pole_tekstowe">
					<input  type='submit' class="button" name="insert" id="Expand_Button" value="Wprowadź"/>
					<?php include 'php/nwm.php';?>
				</form>
				
			</div>
		</div>
		<div id="tablebox">
			<?php include 'php/tables.php';?>	
		</div>
	</body>
</html>