<!DOCTYPE html>
<html>
<body>

<?php

session_start();

if (isset($_SESSION["Head of Secretary"])) {
	foreach	($_SESSION["Head of Secretary"] as $number => $data) {
		if ($data["username"] == $_SESSION["current_username"]) {
			$id = $number;
			break;
		}
	}
}

if (!isset($id))
	exit();

$username = $_SESSION["Head of Secretary"][$id]["username"];
echo "<title>".$_SESSION["Head of Secretary"][$id]["name"]."</title>";
$server = "localhost";
$server_username = "root";
$password = "mysql";
$database = "eren";

$connection = mysqli_connect($server, $server_username, $password, $database);

if (!$connection)
	die("Connection failed: " . mysqli_connect_error());

$sql = "SELECT courses_name FROM employee, department, courses";
$sql .= " WHERE employee.department_id = department.department_id";
$sql .= " and courses.department_id = department.department_id";
$sql .= " GROUP BY courses_name";
$query = mysqli_query($connection, $sql) or die("Error!");

if (mysqli_num_rows($query) > 0) {
	echo '<table border = "1">';
	echo '<form action = "Head of Secretary.php" method = "post">';
	echo '<tr><td align = "center" valign = "middle">Course</td>';
	echo '<td align = "center" valign = "middle">Date</td>';
	echo '<td align = "center" valign = "middle">Time</td>';
	echo '<td align = "center" valign = "middle">Number of Assistants</td>';
	echo '</tr><tr><td><select name = "course">';

	while($row = mysqli_fetch_array($query))
		echo '<option value = "'.$row["courses_name"].'">'.$row["courses_name"].'</option>';

	echo '</select></td><td><input type = "text" name = "date" value = ""></td>';
	echo '<td><select name = "time">';
	$times = ["09:00:00", "11:00:00", "13:00:00", "15:00:00"];

	foreach ($times as $time)
		echo '<option value = "'.$time.'">'.$time.'</option>';

	echo '</select></td><td><input type = "text" name = "number_of_assistants" value = ""></td>';
	echo '<td><input type = "submit" name = "add_exam" value = "Add Exam"></td></tr></form>';

	if (!isset($_POST["add_exam"]))
		echo '</table>';
}

function is_date_valid($dateString) {
	try {
		$date = new DateTime($dateString);
		return true;
	}

	catch (Exception $e) {
		return false;
	}
}

function get_integer($string) {
	if (is_numeric($string) && strpos($string, '.') == false)
		return $string;

	return null;
}

if (isset($_POST["add_exam"])) {
	if ($_POST["date"] == "")
		echo '</table><br>Date is empty.<br>';

	else if ($_POST["number_of_assistants"] == "")
		echo '</table><br>Number of the assistants is empty.<br>';

	else if (is_date_valid($_POST["date"])) {
		$number_of_assistants = get_integer($_POST["number_of_assistants"]);

		if ($number_of_assistants == null)
			echo '</table><br>Number of the assistants is invalid.<br>';

		else if ((int) $number_of_assistants <= 0)
			echo '</table><br>Number of the assistants is invalid.<br>';

		else {
			$number_of_assistants = (int) $number_of_assistants;
			$date = (new DateTime($_POST["date"]))->format('Y-m-d');
			$course = $_POST["course"];
			$time = $_POST["time"];
			$query = mysqli_query($connection, "SELECT department_id FROM courses WHERE courses_name = '$course'") or die("Error!");
			$department_id = (int) mysqli_fetch_array($query)["department_id"];
			echo '<tr><td>'.$course.'</td><td>'.$date.'</td><td>'.$time.'</td><td>'.$number_of_assistants.'</td></tr></table>';
			$sql = "SELECT employee_id FROM employee, department";
			$sql .= " WHERE employee.department_id = department.department_id";
			$sql .= " and role = 'Assistant' and employee.department_id = '".$department_id."'";
			$query = mysqli_query($connection, $sql) or die("Error!");

			if (mysqli_num_rows($query) > 0) {
				$number = 0;

				while($row = mysqli_fetch_array($query)) {
					$assistant = $_SESSION["Assistant"][$row["employee_id"]];
					$assistant["$id"] = $row["employee_id"];

					if (!isset($assistant["plan"][$date][$time]) &&	!isset($assistant["plan"][(new DateTime($date))->format('l')][$time]))
						$assistants[$number++] = $assistant;
				}

				if ($number != 0) {
					for ($i = 0; $i < $number - 1; $i++) {
						for ($j = $i + 1; $j < $number; $j++) {
							if ($assistants[$j]["point"] < $assistants[$i]["point"]) {
								$tmp = $assistants[$j];
								$assistants[$j] = $assistants[$i];
								$assistants[$i] = $tmp;
							}
						}
					}

					$query = mysqli_query($connection, "SELECT * FROM exam") or die("Error!");
					$number_of_exams = 0;

					if (mysqli_num_rows($query) > 0) {
						while($row = mysqli_fetch_array($query))
							$number_of_exams++;
					}

					echo '<table border = "1"><br>';
					echo '<tr><th>Assistants</th></tr>';

					for ($i = 0; $i < $number_of_assistants && $i < $number; $i++) {
						$sql = "INSERT INTO exam (exam_id, exam_date, exam_time, courses_name, employee_id) VALUES";
						$sql .= " (".++$number_of_exams.", '$date', '$time', '$course', ".$assistants[$i]["$id"].")";
						mysqli_query($connection, $sql) or die("Error!");
						echo '<tr><td>'.$assistants[$i]["name"].'</td></tr>';
						$_SESSION["Assistant"][$assistants[$i]["$id"]]["point"]++;
						$_SESSION["Assistant"][$assistants[$i]["$id"]]["plan"][$date][$time] = $course." exam";
					}

					echo '</table>';
				}
			}
		}
	}

	else
		echo '</table><br>Date is invalid.<br>';
}

$query = mysqli_query($connection, "SELECT faculty_name FROM faculty") or die("Error!");

if (mysqli_num_rows($query) > 0) {
	echo '<br><form action = "Head of Secretary.php" method = "post">';
	echo '<table border = "1">';
	echo '<tr><td align = "center" valign = "middle">Faculty</td>';
	echo '<td align = "center" valign = "middle">Department</td>';
	echo '<td align = "center" valign = "middle">Course</td>';
	echo '<td align = "center" valign = "middle">Day</td>';
	echo '<td align = "center" valign = "middle">Time</td></tr><tr><td>';

	if (!isset($_POST["select_faculty"])) {
		echo '<select name = "faculty">';

		while($row = mysqli_fetch_array($query))
			echo '<option value = "'.$row["faculty_name"].'">'.$row["faculty_name"].'</option>';

		echo '</select><input type = "submit" name = "select_faculty" value = "Select Faculty">';
	}

	else {
		$_SESSION["selected_faculty"] = $_POST["faculty"];
		echo $_POST["faculty"];
		echo '<input type = "submit" value = "Refresh">';
	}

	echo '</td><td>';

	if (isset($_POST["select_faculty"])) {
		echo '<select name = "department">';
		$query = mysqli_query($connection, "SELECT department_name FROM department WHERE faculty_id = ".$_SESSION["faculty"][$_POST["faculty"]]." ") or die("Error!");

		if (mysqli_num_rows($query) > 0) {
			while($row = mysqli_fetch_array($query))
				echo '<option value = "'.$row["department_name"].'">'.$row["department_name"].'</option>';
		}

		echo '</select>';
	}

	echo '</td>';
	echo '<td><input type = "text" name = "course" value = ""></td><td><select name = "day">';
	$days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

	foreach ($days as $day)
		echo '<option value = "'.$day.'">'.$day.'</option>';

	echo '</select></td><td><select name = "time">';
	$times = ["09:00:00", "11:00:00", "13:00:00", "15:00:00"];

	foreach ($times as $time)
		echo '<option value = "'.$time.'">'.$time.'</option>';

	echo '</select></td><td><input type = "submit" name = "add_course" value = "Add Course"></td></tr></table></form>';
}

if (isset($_POST["add_course"])) {
	if ($_POST["course"] == "")
		echo '<br>Course is empty.<br>';

	else if (!isset($_POST["department"]))
		echo '<br>Department is empty.<br>';

	else {
		$query = mysqli_query($connection, "SELECT department_name FROM department WHERE faculty_id = ".$_SESSION["faculty"][$_SESSION["selected_faculty"]]." ") or die("Error!");
		$is_true = false;

		if (mysqli_num_rows($query) > 0) {
			while($row = mysqli_fetch_array($query)) {
				if ($row["department_name"] == $_POST["department"]) {
					$is_true = true;
					break;
				}
			}
		}

		if ($is_true) {
			$query = mysqli_query($connection, "SELECT * FROM courses") or die("Error!");
			$num_of_courses = 0;

			if (mysqli_num_rows($query) > 0) {
				while($row = mysqli_fetch_array($query))
					$num_of_courses++;
			}

			$sql = "INSERT INTO courses (courses_id, courses_name, courses_day, courses_time, department_id) VALUES";
			$sql .= " (".++$num_of_courses.", '".$_POST["course"]."', '".$_POST["day"]."', '".$_POST["time"]."', ".$_SESSION["faculty"][$_SESSION["selected_faculty"]].")";
			mysqli_query($connection, $sql) or die("Error!");
		}

		else
			echo '<br>Faculty and department are invalid.<br>';
	}
}

echo '<form action = "Head of Secretary.php" method = "post"><br><br>';
echo '<input type = "submit" name = "display_scores" value = "Display Scores"></form>';

if (isset($_POST["display_scores"])) {
	$query = mysqli_query($connection, "SELECT employee_id FROM employee WHERE role = 'Assistant'") or die("Error!");

	if (mysqli_num_rows($query) > 0) {
		echo '<br>';

		while($row = mysqli_fetch_array($query))
			echo $_SESSION["Assistant"][$row["employee_id"]]["name"]." => ".$_SESSION["Assistant"][$row["employee_id"]]["point"]."<br>";
	}
}

echo '<form action = "home.php" method = "post"><br>';
echo '<input type = "submit" value = "Return Home"></form>';

mysqli_close($connection);

?>

</body>
</html>