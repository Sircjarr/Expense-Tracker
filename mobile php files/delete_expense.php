<?php
	// NOTE: deleted expenses are identified by every one of their attributes lol
	$input = array('propertyID' => $_POST['propertyID'],
	       'description' => $_POST['description'],
	       'urgent' => $_POST['urgent'],
	       'important' => $_POST['important'],
	       'category' => $_POST['category'],
	       'estimated_cost' => $_POST['estimated_cost'],
	       'estimated_based_on' => $_POST['estimated_based_on'],
	       'note' => $_POST['note'],
	       'hidden' => $_POST['hidden'],
	       'completed' => $_POST['completed']);

	// escape the columns and values from the input object
  	$columns = preg_replace('/[^a-z0-9_]+/i','',array_keys($input));
   	$values = array_map(function ($value) use ($link) {
   	if ($value===null) return null;
       	   return mysqli_real_escape_string($link,(string)$value);
    	}, array_values($input));

   	// build the WHERE part of the SQL command
   	$where = '';
   	for ($i=0;$i<count($columns);$i++) {
     	    $where.=($i>0?'AND':'').'`'.$columns[$i].'`=';
       	    $where.=($values[$i]===null?'NULL':'"'.$values[$i].'"');
   	}
	
	$sql = "DELETE FROM expenses WHERE $where";

	// execute SQL statement
   	$result = mysqli_query($link,$sql);

   	// die if SQL statement failed
   	if (!$result) {
	   echo "error";
     	   http_response_code(404);
     	   die(mysqli_error());
    	}
?>