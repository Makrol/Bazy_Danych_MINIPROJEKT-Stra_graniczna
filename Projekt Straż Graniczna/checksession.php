<?php
session_start();

if(isset($_SESSION['zalogowany'])){
	header('location:main.php');
	exit;
}else{
	if(isset($_POST['login']) && isset($_POST['haslo'])){
		$login=$_POST['login'];
		$password=$_POST['haslo'];
		if($conn = oci_pconnect($login, $password, 'localhost/XE','AL32UTF8')){
			$_SESSION['zalogowany']='zalogowany';
			$_SESSION['login']=$_POST['login'];
			$_SESSION['haslo']=$_POST['haslo'];

			header('location:main.php');
			exit;
		}else{
			$_session['blad']='blad';
			header('location:logowanie.html');
		}
	}
}

?>
<html>
<head>
<title>Wylogowanie</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<p>Zostałeś wylogowany</p>
</body>
</html>