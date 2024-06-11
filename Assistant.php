<!DOCTYPE html>
<html>
<body>

<?php

session_start();

if (isset($_SESSION["Assistant"])) {
	foreach	($_SESSION["Assistant"] as $number => $data) {
		if ($data["username"] == $_SESSION["current_username"]) {
			$id = $number;
			break;
		}
	}
}

if (!isset($id))
	exit();

$has_course = false;
$new_course = false;
$username = $_SESSION["Assistant"][$id]["username"];
echo '<title>'.$_SESSION["Assistant"][$id]["name"].'</title>';
$server = "localhost";
$server_username = "root";
$password = "mysql";
$database = "eren";

$connection = mysqli_connect($server, $server_username, $password, $database);

if (!$connection)
	die("Connection failed: " . mysqli_connect_error());

if (isset($_POST["course"])) {
	if (isset($_SESSION["Assistant"][$id]["courses"])) {
		foreach	($_SESSION["Assistant"][$id]["courses"] as $number => $data) {
			if ($data == $_POST["course"]) {
				$has_course = true;
				unset($_SESSION["Assistant"][$id]["courses"][$number]);
				$sql = "SELECT courses_name, courses_day, courses_time FROM employee, department, courses";
				$sql .= " WHERE employee.department_id = department.department_id";
				$sql .= " and courses.department_id = department.department_id";
				$sql .= " and employee.username = '".$username."' and courses_name = '".$_POST["course"]."'";
				$query = mysqli_query($connection, $sql) or die("Error!");

				if (mysqli_num_rows($query) > 0) {
					while($row = mysqli_fetch_array($query))
						unset($_SESSION["Assistant"][$id]["plan"][$row["courses_day"]][$row["courses_time"]]);
				}

				break;
			}
		}
	}

	if (!$has_course) {
		$number = 0;

		while (isset($_SESSION["Assistant"][$id]["courses"][$number]))
			$number++;

		$_SESSION["Assistant"][$id]["courses"][$number] = $_POST["course"];
		$new_course = true;
	}
}

$sql = "SELECT courses_name FROM employee, department, courses";
$sql .= " WHERE employee.department_id = department.department_id";
$sql .= " and courses.department_id = department.department_id and employee.username = '".$username."'";
$sql .= " GROUP BY courses_name";

$query = mysqli_query($connection, $sql) or die("Error!");

if (mysqli_num_rows($query) > 0) {
	echo '<form action = "Assistant.php" method = "post"><select name = "course">';

	while($row = mysqli_fetch_array($query))
		echo '<option value = "'.$row["courses_name"].'">'.$row["courses_name"].'</option>';

	echo '</select><br><br><input type = "submit" value = "Add/Remove Course"></form>';
}

if (isset($_SESSION["Assistant"][$id]["courses"]) && $new_course) {
	$sql = "SELECT courses_name, courses_day, courses_time FROM employee, department, courses";
	$sql .= " WHERE employee.department_id = department.department_id";
	$sql .= " and courses.department_id = department.department_id";
	$sql .= " and employee.username = '".$username."' and courses_name = '".$_POST["course"]."'";
	$query = mysqli_query($connection, $sql) or die("Error!");

	if (mysqli_num_rows($query) > 0) {
		while($row = mysqli_fetch_array($query))
			$temp[$row["courses_day"]][$row["courses_time"]] = $row["courses_name"];
	}

	$control = true;

	foreach	($temp as $day => $data) {
		foreach ($data as $time => $data_2) {
			if (isset($_SESSION["Assistant"][$id]["plan"][$day][$time]))
				$control = false;

			$days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
			$day_number = 0;

			foreach ($days as $day2) {
				if ($day == $day2)
					break;

				$day_number++;
			}

			if (isset($_SESSION["Assistant"][$id]["plan"][date('Y-m-d', strtotime("this week + $day_number days"))][$time]))
				$control = false;
		}
	}

	if ($control) {
		foreach	($temp as $day => $data) {
			foreach ($data as $time => $data_2) {
				if ($data_2 != "wrong")
					$_SESSION["Assistant"][$id]["plan"][$day][$time] = $data_2;
			}
		}
	}

	else {
		unset($_SESSION["Assistant"][$id]["courses"][$number]);
		echo '<br>You cannot take this course because of conflicts!<br>';
	}

	unset($temp);
}

$days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
$times = ["09:00:00", "11:00:00", "13:00:00", "15:00:00"];

echo '<br><table border = "1">';
echo '<tr>';
echo '<th>Date</th>';

for ($i = 0; $i < 7; $i++)
	echo '<th>'.date('Y-m-d', strtotime("this week + $i days")).'</th>';

echo '</tr>';
echo '<tr>';
echo '<th>Time/Day</th>';

foreach ($days as $day)
	echo '<th>'.$day.'</th>';

echo '</tr>';

foreach ($times as $time) {
	echo '<tr>';
	echo '<th>'.$time.'</th>';
	$day_number = 0;

	foreach ($days as $day) {
		if (isset($_SESSION["Assistant"][$id]["plan"][$day][$time]))
			echo '<td>'.$_SESSION["Assistant"][$id]["plan"][$day][$time].'</td>';

		else {
			$day_date = date('Y-m-d', strtotime("this week + $day_number days"));

			if (isset($_SESSION["Assistant"][$id]["plan"][$day_date][$time]))
				echo '<td>'.$_SESSION["Assistant"][$id]["plan"][$day_date][$time].'</td>';

			else
				echo '<td></td>';
		}

		$day_number++;
	}

	echo '</tr>';
}

echo '</table>';
echo '<form action = "Assistant.php" method = "post"><br><br>';
echo '<input type = "submit" value = "Refresh"></form>';
echo '<form action = "home.php" method = "post"><br>';
echo '<input type = "submit" value = "Return Home"></form>';

mysqli_close($connection);

?>

</body>
</html>