<?php
	$propertyID = $_POST['propertyID'];
	
	$sql = "SELECT * FROM expenses WHERE propertyID = '$propertyID'";

	// excecute SQL statement
   	$result = mysqli_query($link,$sql);

   	// die if SQL statement failed
   	if (!$result) {
     	   http_response_code(404);
     	   die(mysqli_error());
    	}

	// Echo query result as JSON data
	echo '[';
	for ($i=0; $i<mysqli_num_rows($result); $i++) {
            echo ($i>0?',':'').json_encode(mysqli_fetch_object($result));
	}
	echo ']';	
?>