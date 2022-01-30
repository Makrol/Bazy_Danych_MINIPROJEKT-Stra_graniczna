<?php
session_start();
if(isset($_SESSION['login'])){
	unset($_SESSION['login']);
}
if(isset($_SESSION['haslo'])){
	unset($_SESSION['haslo']);
}
if(isset($_SESSION['zalogowany'])){
	unset($_SESSION['zalogowany']);
	header('location:logowanie.html');
}else{
	header('location:logowanie.html');
	exit;
}

session_destroy();

?>