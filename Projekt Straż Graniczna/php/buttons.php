<?php 
	mb_internal_encoding("UTF-8");
	$conn=Connection();
	$TableName="";
	$TableButtons=oci_parse($conn, "
								SELECT table_name
								FROM user_tables where 
								table_name not like 'LOGMNR%' and 
								table_name not like 'LOGSTDBY$%' and 
								table_name not like 'ROLLING$%' and  
								table_name not like 'ROLLING$%' and
								table_name not like 'REPL_%' and
								table_name not like 'SQLPLUS_%' and
								table_name not like 'HELP'");
	oci_execute($TableButtons);												
	$nrows = oci_fetch_all($TableButtons, $res, null, null, OCI_FETCHSTATEMENT_BY_ROW);	
	foreach ($res as $col) 
	{
		foreach ($col as $item) 
		{
			$TableName=(utf8_encode($item) !== null ? htmlentities(utf8_encode($item), ENT_QUOTES) : "");
			if($TableName=="RODZAJ_UZBROJENIA"||$TableName=="ADRESY"||$TableName=="OSOBY"||$TableName=="JEDNOSTKI_ORGANIZACYJNE"||$TableName=="PRACOWNICY"||
			$TableName=="POSZUKIWANI"||$TableName=="ZATRZYMANI_DO_KONTROLI"||$TableName=="POJAZDY"||$TableName=="UZBROJENIE"||$TableName=="PSY_TROPIACE"||
			$TableName=="KONTROLE"||$TableName=="PRZEDMIOTY_ZATRZYMANE")
			{
				echo "<input  class='button  collapse multi-collapse' id='expanding'  type='submit' name='Submit_Button' value='$TableName'/>";
			}
		}
	}
	
	
	
	
	
	
	
	
?>