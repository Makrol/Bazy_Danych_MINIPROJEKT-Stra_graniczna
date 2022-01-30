<?php

	mb_internal_encoding("UTF-8");	
	
	if(isset($_POST['BasicAplicationButton'])) 
	{
		$action=$_POST['BasicAplicationButton'];
		ChooseAction("$action");
	}
	
	function ChooseAction($action="")
	{
		if($action=="Stwórz tabele")
		{
			$action="data/tworzenie_tabel.sql";
			cosc($action);
			
		}
		
		if($action=="Zainicjuj tabele wartościami")
		{
			$action="data/dodawanie_danych.sql";
			cosc($action);
		}
		
		if($action=="Usuń całą baze")
		{
			$action="data/usuwanie_tabel.sql";
			cosc($action);
		}
		
		if($action=="Stwórz kursory i wyzwalacze")
		{
			$action="";
			foreach(file('data/kursory.sql') as $line)
			{
				$action=$action.$line;
				if (str_contains($action, 'end;')) 
				{ 
					ActionExecution("$action");
					$action="";
				}
			}
			$action="";
			foreach(file('data/wyzwalacze.sql') as $line)
			{
				$action=$action.$line;
				if (str_contains($action, 'end;')) 
				{ 
					ActionExecution("$action");
					$action="";
				}
			}
		}
		
		if($action=="Stwórz widoki")
		{
			$action="data/widoki.sql";
			cosc($action);
		}
		
	}
	function cosc($path="")
	{
		$action="";
		foreach(file($path) as $line)
			{
				$action=$action.$line;
				if (str_contains($action, ';')) 
				{ 
					$action = str_replace(';', '', $action);
					ActionExecution("$action");
					$action="";
				}
			}
	}
	
	
	
	
	function ActionExecution($execution="")
	{
		
		$conn=Connection();
		$wykonane = oci_parse($conn,$execution);
		oci_execute($wykonane);
		
	}
	
	

?>
