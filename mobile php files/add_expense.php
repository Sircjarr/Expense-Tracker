<?php

	// create array of values to be inserted into table
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

   	// build the SET part of the SQL command
   	$set = '';
   	for ($i=0;$i<count($columns);$i++) {
     	    $set.=($i>0?',':'').'`'.$columns[$i].'`=';
       	    $set.=($values[$i]===null?'NULL':'"'.$values[$i].'"');
   	}
	
	$sql = "INSERT INTO expenses SET $set";

	// excecute SQL statement
   	$result = mysqli_query($link,$sql);

   	// die if SQL statement failed
   	if (!$result) {
	   echo "error";
     	   http_response_code(404);
     	   die(mysqli_error());
    	}

	// '0' if table had no auto-increment, or insert/update was unsuccessful
	// echo "new record has id: " . mysqli_insert_id($link);
?>