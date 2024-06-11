<!DOCTYPE html>
<html>
<body>

<?php

if (isset($_POST["username"])) {
	if ($_POST["username"] == "") {
		echo 'Username is empty.';
		echo '<form action = "home.php" method = "post"><br>';
		echo '<input type = "submit" value = "Return Home"></form>';
	}

	else if ($_POST["password"] == "") {
		echo 'Password is empty.';
		echo '<form action = "home.php" method = "post"><br>';
		echo '<input type = "submit" value = "Return Home"></form>';
	}

	else {
		session_start();
		$is_logged_in = false;
		$role = $_POST["role"];

		if (isset($_SESSION[$role])) {
			foreach	($_SESSION[$role] as $data) {
				if ($data["username"] == $_POST["username"] and $data["password"] == $_POST["password"]) {
					$_SESSION["current_username"] = $data["username"];
					$is_logged_in = true;
					break;
				}
			}
		}

		if ($is_logged_in)
			header("Location: $role.php");

		else {
			echo 'Username or password is not correct.';
			echo '<form action = "home.php" method = "post"><br>';
			echo '<input type = "submit" value = "Return Home"></form>';
		}
	}

	exit();
}

session_start();
if (!isset($_SESSION["Dean"])) {
	$server = "localhost";
	$username = "root";
	$password = "mysql";
	$database = "eren";

	$connection = mysqli_connect($server, $username, $password, $database);

	if (!$connection)
		die("Connection failed: " . mysqli_connect_error());

	$query = mysqli_query($connection, "SELECT * FROM faculty") or die("Error!");

	if (mysqli_num_rows($query) > 0) {
		while($row = mysqli_fetch_array($query)) {
			$_SESSION["Dean"][$row["faculty_id"]] = ["name" => $row["dean_name"], "username" => $row["dean_username"], "password" => $row["dean_password"]];
			$_SESSION["Head of Secretary"][$row["faculty_id"]] = ["name" => $row["head_of_secretary_name"], "username" => $row["head_of_secretary_username"], "password" => $row["head_of_secretary_password"]];
			$_SESSION["faculty"][$row["faculty_name"]] = $row["faculty_id"];
		}
	}

	$query = mysqli_query($connection, "SELECT * FROM department") or die("Error!");

	if (mysqli_num_rows($query) > 0) {
		while($row = mysqli_fetch_array($query))
			$_SESSION["Head of Department"][$row["department_id"]] = ["name" => $row["head_of_department_name"], "username" => $row["head_of_department_username"], "password" => $row["head_of_department_password"]];
	}

	$query = mysqli_query($connection, "SELECT * FROM employee") or die("Error!");

	if (mysqli_num_rows($query) > 0) {
		while($row = mysqli_fetch_array($query)) {
			$_SESSION[$row["role"]][$row["employee_id"]] = ["name" => $row["employee_name"], "username" => $row["username"], "password" => $row["password"], "role" => $row["role"], "department_id" => $row["department_id"]];
			if ($row["role"] == "Assistant")
				$_SESSION["Assistant"][$row["employee_id"]]["point"] = 0;
		}
	}

	$query = mysqli_query($connection, "SELECT * FROM exam") or die("Error!");

	if (mysqli_num_rows($query) > 0) {
		while($row = mysqli_fetch_array($query)) {
			$_SESSION["Assistant"][$row["employee_id"]]["plan"][$row["exam_date"]][$row["exam_time"]] = $row["courses_name"]." exam";
			if (isset($_SESSION["Assistant"][$row["employee_id"]]["point"]))
				$_SESSION["Assistant"][$row["employee_id"]]["point"]++;
			else
				echo $row["employee_id"].'<br>';
		}
	}

	mysqli_close($connection);
}

echo '<form action = "home.php" method = "post">';
echo 'Username<br>';
echo '<input type = "text" name = "username" value = ""><br><br>';
echo 'Password<br>';
echo '<input type = "password" name = "password" value = ""><br><br>';
echo '<select name = "role">';
echo '<option value = "Assistant">Assistant</option>';
echo '<option value = "Secretary">Secretary</option>';
echo '<option value = "Head of Department">Head of Department</option>';
echo '<option value = "Head of Secretary">Head of Secretary</option>';
echo '<option value = "Dean">Dean</option>';
echo '</select><br><br><br>';
echo '<input type = "submit" name = "login" value = "Log In"></form>';
echo '<form action = "forgot.php" method = "post"><br>';
echo '<input type = "submit" value = "Forgot Password"></form>';

?>

</body>
</html>