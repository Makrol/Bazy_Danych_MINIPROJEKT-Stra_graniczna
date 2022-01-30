<?php 
	mb_internal_encoding("UTF-8");
	$conn=Connection();
	
	///////////////////////////////////////////////////////////////////////////////////////////////////
	$viewsbuttons=oci_parse($conn, "select view_name from user_views");
	oci_execute($viewsbuttons);												
	$nrows = oci_fetch_all($viewsbuttons, $res, null, null, OCI_FETCHSTATEMENT_BY_ROW);	
	foreach ($res as $col) 
	{
		foreach ($col as $item) 
		{
			$viewname=(utf8_encode($item) !== null ? htmlentities(utf8_encode($item), ENT_QUOTES) : "");
			if($viewname=='NAJBARDZIEJ_EFEKTYWNA_JEDNOSTKA'||$viewname=='ZLAPANI'||$viewname=='WAGA_ZATRZYMANNYCH'||$viewname=='ZATRZ_PO30'||$viewname=='PSYNAEMERYTURE'||$viewname=='ZABIERANE_WYPOSAZENIE')
			{
				echo "<input  class='button  collapse multi-collapse2' id='expanding'  type='submit' name='Submit_Button' value='$viewname'/>";
			}
		}
	}
	
	
	
	
	
	
	
	
?>