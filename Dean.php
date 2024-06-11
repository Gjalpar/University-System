<!DOCTYPE html>
<html>
<body>

<?php

session_start();

if (isset($_SESSION["Dean"])) {
	foreach	($_SESSION["Dean"] as $number => $data) {
		if ($data["username"] == $_SESSION["current_username"]) {
			$id = $number;
			break;
		}
	}
}

if (!isset($id))
	exit();

$username = $_SESSION["Dean"][$id]["username"];
echo '<title>'.$_SESSION["Dean"][$id]["name"].'</title>';
$server = "localhost";
$server_username = "root";
$password = "mysql";
$database = "eren";

$connection = mysqli_connect($server, $server_username, $password, $database);

if (!$connection)
	die("Connection failed: " . mysqli_connect_error());

$query = mysqli_query($connection, "SELECT faculty_name FROM faculty") or die("Error!");

if (mysqli_num_rows($query) > 0) {
	echo '<form action = "Dean.php" method = "post">';
	echo '<table border = "1">';
	echo '<tr><td align = "center" valign = "middle">Department</td></tr><tr><td>';
	echo '<select name = "department">';
	$query = mysqli_query($connection, "SELECT department_name FROM department WHERE faculty_id = ".$id." ") or die("Error!");

	if (mysqli_num_rows($query) > 0) {
		while($row = mysqli_fetch_array($query))
			echo '<option value = "'.$row["department_name"].'">'.$row["department_name"].'</option>';
	}

	echo "</select>";
	echo '</td><td><input type = "submit" name = "display_exams" value = "Display Exams"></td></tr></table></form><br>';
}

if (isset($_POST["display_exams"])) {
	$query = mysqli_query($connection, "SELECT department_id FROM department WHERE department_name = '".$_POST["department"]."'") or die("Error!");
	$department_id = (int) mysqli_fetch_array($query)["department_id"];
	$sql = "SELECT exam_date, exam_time, courses_name FROM exam, employee ";
	$sql .= "WHERE employee.employee_id = exam.employee_id and ";
	$sql .= "department_id = $department_id ";
	$sql .= "GROUP BY exam_date, exam_time, courses_name";
	$query = mysqli_query($connection, $sql) or die("Error!");

	if (mysqli_num_rows($query) > 0) {
		$number = 0;

		while($row = mysqli_fetch_array($query)) {
			$exams[$number]["exam_date"] = $row["exam_date"];
			$exams[$number]["exam_time"] = $row["exam_time"];
			$exams[$number++]["courses_name"] = $row["courses_name"];
		}

		if (isset($exams)) {
			for ($i = 0; $i < $number - 1; $i++) {
				$date1 = strtotime($exams[$i]["exam_date"]);
				$time1 = strtotime($exams[$i]["exam_time"]); 

				for ($j = $i + 1; $j < $number; $j++) {
					$date2 = strtotime($exams[$j]["exam_date"]);
					$time2 = strtotime($exams[$j]["exam_time"]);

					if 	($date1 > $date2 || ($date1 == $date2 && $time1 > $time2)) {
						$date1 = $date2;
						$time1 = $time2;
						$tmp = $exams[$i];
						$exams[$i] = $exams[$j];
						$exams[$j] = $tmp;
					}
				}
			}

			echo '<table border = "1">';
			echo '<tr><th>Date</th><th>Time</th><th>Course</th></tr>';

			for ($i = 0; $i < $number; $i++)
				echo '<tr><td>'.$exams[$i]["exam_date"].'</td><td>'.$exams[$i]["exam_time"].'</td><td>'.$exams[$i]["courses_name"].'</td></tr>';

			echo '</table><br>';
		}
	}
}

echo '<form action = "home.php" method = "post"><br>';
echo '<input type = "submit" value = "Return Home"></form>';

mysqli_close($connection);

?>

</body>
</html>