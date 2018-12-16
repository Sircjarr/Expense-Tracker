<?php
	// NOTE: deleted expenses are identified by every one of their attributes lol

	// create array of values to identify expense to delete
	$arr_where = array('propertyID' => $_POST['propertyID'],
	       'description' => $_POST['description'],
	       'urgent' => $_POST['urgent'],
	       'important' => $_POST['important'],
	       'category' => $_POST['category'],
	       'estimated_cost' => $_POST['estimated_cost'],
	       'estimated_based_on' => $_POST['estimated_based_on'],
	       'note' => $_POST['note'],
	       'hidden' => $_POST['hidden'],
	       'completed' => $_POST['completed']);
	       
	// create array of values to be updated
	$arr_set = array('propertyID' => $_POST['update_propertyID'],
	       'description' => $_POST['update_description'],
               'urgent' => $_POST['update_urgent'],
               'important' => $_POST['update_important'],
               'category' => $_POST['update_category'],
               'estimated_cost' => $_POST['update_estimated_cost'],
               'estimated_based_on' => $_POST['update_estimated_based_on'],
               'note' => $_POST['update_note'],
               'hidden' => $_POST['update_hidden'],
               'completed' => $_POST['update_completed']);

	// escape the columns and values from the WHERE
  	$columns_where = preg_replace('/[^a-z0-9_]+/i','',array_keys($arr_where));
   	$values_where = array_map(function ($value) use ($link) {
   	if ($value===null) return null;
       	   return mysqli_real_escape_string($link,(string)$value);
    	}, array_values($arr_where));

	// escape the columns and values from the SET
  	$columns_set = preg_replace('/[^a-z0-9_]+/i','',array_keys($arr_set));
   	$values_set = array_map(function ($value) use ($link) {
   	if ($value===null) return null;
       	   return mysqli_real_escape_string($link,(string)$value);
    	}, array_values($arr_set));

	 // build the SET part of the SQL command
        $set = '';
        for ($i=0;$i<count($columns_set);$i++) {
            $set.=($i>0?',':'').'`'.$columns_set[$i].'`=';
            $set.=($values_set[$i]===null?'NULL':'"'.$values_set[$i].'"');
        }

   	// build the WHERE part of the SQL command
   	$where = '';
   	for ($i=0;$i<count($columns_where);$i++) {
     	    $where.=($i>0?'AND':'').'`'.$columns_where[$i].'`=';
       	    $where.=($values_where[$i]===null?'NULL':'"'.$values_where[$i].'"');
   	}
	
	$sql = "UPDATE expenses SET $set WHERE $where";

	// execute SQL statement
   	$result = mysqli_query($link,$sql);

   	// die if SQL statement failed
   	if (!$result) {
	   echo "error";
     	   http_response_code(404);
     	   die(mysqli_error());
    	}
?>