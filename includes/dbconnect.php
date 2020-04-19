<?php
	session_start();
	
	define("HOST", "localhost");
	define("DB", "OfficeMap");
	define("USER", "root");
	define("PASSWORD", "");

	$pdo = new PDO("mysql:host=" . HOST . ";dbname=" . DB . ";charset=utf8", USER, PASSWORD);
?>