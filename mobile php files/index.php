<?php

	$request = explode('/', trim($_SERVER['PATH_INFO'],'/'));

	// check if correct password
	$password_db = $_POST['password_db'];
	$hash_db = $_POST['hash_db'];
	$filename = $_POST['filename'];

	if (password_verify($password_db, $hash_db)) {

		// Edit database info here
		define("DB_HOST_SERVER", "");
		define("DB_USERNAME", "");
		define("DB_PASSWORD", $password_db);
		define("DB_NAME", "");

	
		// connect to the mysql database
  		$link = mysqli_connect(DB_HOST_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);
 	 	mysqli_set_charset($link,'utf8');

   		if (mysqli_connect_errno()){
       		   die("Failed to connect to MySQL: " . mysqli_connect_error());
    		}
	 
		////////////////////// switch
	 	switch ($filename) {
		       case 'read_authentication':
		       	    include 'read_authentication.php';
			    break;
		       case 'read_expenses':
			    include 'read_expenses.php'; 
			    break;
		       case 'add_expense':
			    include 'add_expense.php';
			    break;
		       case 'delete_expense':
		       	    include 'delete_expense.php';
			    break;
		       case 'edit_expense':
			    include 'edit_expense.php';
			    break;
			default:
			    die("Failed to find php file");
			    break;
		}

		mysqli_close($link);
		exit();
	}
	else {
	   echo 'Invalid password';
	   exit();
	}
?>
