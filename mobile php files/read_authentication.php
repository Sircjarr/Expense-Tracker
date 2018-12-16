<?php
	$username_entered = $_POST['username_entered'];
	$password_entered = $_POST['password_entered'];
	
	// make query to get the hash from the db with username as key
	$sql = "SELECT * FROM users WHERE uidUsers='$username_entered'";

	// excecute SQL statement
	$result = mysqli_query($link, $sql);

	// die if SQL statement failed
    	if (!$result) {
		http_response_code(404);
		die(mysqli_error());
	}

	// get result from sql query in an associative array
	$row = mysqli_fetch_assoc($result);

	// compare hash of entered password with hash in database
	if (password_verify($password_entered, $row['pwdUsers'])) {

	   	// inform the receiver of the response that this is JSON data
        	header('Content-Type: application/json');

		// encode array to json data
		echo json_encode($row);
	}
?>
