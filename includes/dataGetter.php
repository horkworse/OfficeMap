<?php
	require_once 'functions.php';

	$request = json_decode(file_get_contents('php://input'), true);

	if (isset($request['desks'])) {
		$dataSet = [
			'floor' => getCurrentFloor($pdo, 1),
			'rooms' => getRoomsOnCurrentFloor($pdo, 1),
			'desks' => getDesksOnCurrentFloor($pdo, 1)
		];	
		echo json_encode($dataSet);
		exit();
	}

	if (isset($request['isUser'])){
			if (isset($_SESSION['user'])) {
				echo json_encode($_SESSION['user']);
			}
			else {
				echo json_encode(false);
			}
		exit;
	}

	if (isset($request['logout'])){
		unset($_SESSION['user']);
		exit;
	}	

	if (isset($request['user'])){
		$email = $request['email'];
		$password = $request['password'];
		
		echo json_encode(signIn($pdo, $email, $password));
		exit;
	}
?>