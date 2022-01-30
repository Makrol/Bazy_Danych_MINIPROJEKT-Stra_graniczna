<?php 
	mb_internal_encoding("UTF-8");
	$conn=Connection();
	
	
	if(isset($_POST['Submit_Button'])) {
		$nazwa_tabeli=$_POST['Submit_Button'];
		TableDisplay("$nazwa_tabeli",$conn);
	}
	if(isset($_POST['Submit_Button2'])) {
		$cursor=$_POST['Submit_Button2'];
		CursorExecution("$cursor",$conn);
	}
	
	function CursorExecution($cursor="",$conn="")
	{
		if($cursor=='procent_zatrz')
		{
			$toexecute = oci_parse($conn,"select $cursor from dual");
			$new = oci_new_cursor($conn);
			oci_execute($toexecute);
			$nrows2 = oci_fetch_all($toexecute, $res2, null, null, OCI_FETCHSTATEMENT_BY_ROW);
			echo "<div id='intablebox'>\n<p1 id='tablename'>TABELA ".$cursor."</p1>\n</div>\n";
			echo "<table class='WygladTabel' >\n<thead>\n";		
			echo "</thead>\n<tbody>\n";
			foreach ($res2 as $col2) {
			echo "<tr>\n";
			foreach ($col2 as $item2) {
				echo "    <td>".($item2 !== null ? htmlentities($item2, ENT_QUOTES) : "")."</td>\n";
			}
			echo "</tr>\n";
		}
		echo "</tbody>\n</table>\n";	
		}
		else
		{
		$toexecute = oci_parse($conn,"begin $cursor;end;");
		$new = oci_new_cursor($conn);

		}
		if( !oci_execute($toexecute) )
		{
			$error = oci_error($toexecute);
			echo "Error: " . $error['message'] . "\n";
		}else
		{
			echo "Kursor $cursor zostal wykonany.\n";
		}
	}
	
	function TableDisplay($nazwa_tabeli=" ",$conn="")
	{

		////////////////////////////////////////Wyświetlanie wybranej tabeli///////////////////////////////
		echo "<div id='intablebox'>\n<p1 id='tablename'>TABELA ".$nazwa_tabeli."</p1>\n</div>\n";
		$ColumnName=oci_parse($conn, "select COLUMN_NAME from ALL_TAB_COLUMNS where TABLE_NAME='$nazwa_tabeli'");
		$TableContent = oci_parse($conn, 'SELECT * FROM '.$nazwa_tabeli);

		oci_execute($ColumnName);
		oci_execute($TableContent);
		$nrows = oci_fetch_all($ColumnName, $res, null, null);	
		$nrows2 = oci_fetch_all($TableContent, $res2, null, null, OCI_FETCHSTATEMENT_BY_ROW);	

	
		echo "<table class='WygladTabel' >\n<thead>\n";
		foreach ($res as $col) {
			echo "<tr>\n";
			foreach ($col as $item) {
				echo "    <td>".($item !== null ? htmlentities($item, ENT_QUOTES) : "")."</td>\n";
			}
			echo "</tr>\n";
		}
		echo "</thead>\n<tbody>\n";
		foreach ($res2 as $col2) {
			echo "<tr>\n";
			foreach ($col2 as $item2) {
				echo "    <td>".($item2 !== null ? htmlentities($item2, ENT_QUOTES) : "")."</td>\n";
			}
			//utf8_encode();
			echo "</tr>\n";
		}
		echo "</tbody>\n</table>\n";	


		////////////////////////////////////////////////////////////////////////////////////////////////////	
		
		oci_free_statement($TableContent);
		oci_close($conn);
	}		
?>