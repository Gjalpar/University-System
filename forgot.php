<!DOCTYPE html>
<html>
<body>

<?php

if (isset($_POST["name"])) {
	if ($_POST["name"] == "")
		echo 'Name and surname is empty.';

	else {
		session_start();
		$is_logged_in = false;

		if (isset($_SESSION[$_POST["role"]]))
			foreach	($_SESSION[$_POST["role"]] as $data)
				if ($data["name"] == $_POST["name"]) {
					echo $data["password"];
					$is_logged_in = true;
					break;
				}

		if (!$is_logged_in)
			echo 'User does not exist.';
	}
}

else {
	echo '<form action = "forgot.php" method = "post">';
	echo 'Name and Surname<br>';
	echo '<input type = "text" name = "name" value = ""><br><br>';
	echo '<select name = "role">';
	echo '<option value = "Assistant">Assistant</option>';
	echo '<option value = "Secretary">Secretary</option>';
	echo '<option value = "Head of Department">Head of Department</option>';
	echo '<option value = "Head of Secretary">Head of Secretary</option>';
	echo '<option value = "Dean">Dean</option></select>';
	echo '<br><br><br>';
	echo '<input type = "submit" value = "Reveal Password"></form>';
}

echo '<form action = "home.php" method = "post">';
echo '<br>';
echo '<input type = "submit" value = "Return Home"></form>';

?>

</body>
</html>