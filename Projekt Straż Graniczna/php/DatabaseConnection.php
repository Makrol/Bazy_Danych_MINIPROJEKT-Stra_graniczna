<?php 
	error_reporting(0);
	session_start();
	if(!isset($_SESSION['zalogowany']))
	{
		header('Location: logowanie.html');
	}
	
	function Connection($login='systemm',$password="123456")
	{
		$login= $_SESSION['login'];
		$password= $_SESSION['haslo'];
		if(!$conn = oci_pconnect($login, $password, 'localhost/XE','AL32UTF8'))
		{ 
			$e = oci_error();
			echo "Error: " . $e['message'];
		
		}
		
		return $conn;
	}
	
?>
