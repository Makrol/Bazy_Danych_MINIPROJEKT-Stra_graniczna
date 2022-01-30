<?php
	
	error_reporting(0);
	if(isset($_POST['insert'])) 
	{
		$command=$_POST['commandcontent'];
		InsertCommand($command);
		
	}
	function InsertCommand($command="")
	{
		$conn=Connection();
		$CommandExecution = oci_parse($conn,$command);
		$check=oci_execute($CommandExecution);
		if(!$check)
		{ 
			$e = oci_error($CommandExecution);
			echo "Error: " . $e['message'];
		}
		else if(!($command==""))
		{
			echo "Komenda została wykonana";
		}
	} 
?>