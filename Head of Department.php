<!DOCTYPE html>
<html>
<body>

<?php

session_start();

if (isset($_SESSION["Head of Department"]))
	foreach	($_SESSION["Head of Department"] as $number => $data) {
		if ($data["username"] == $_SESSION["current_username"]) {
			$id = $number;
			break;
		}
	}

if (!isset($id))
	exit();

$username = $_SESSION["Head of Department"][$id]["username"];
echo '<title>'.$_SESSION["Head of Department"][$id]["name"].'</title>';
$server = "localhost";
$server_username = "root";
$password = "mysql";
$database = "eren";

$connection = mysqli_connect($server, $server_username, $password, $database);

if (!$connection)
	die("connectionection failed: " . mysqli_connect_error());

echo '<form action = "Head of Department.php" method = "post">';

if (!isset($_POST["display_exams"]))
	echo '<input type = "submit" name = "display_exams" value = "Display Exams"></form><br>';

else {
	echo '<input type = "submit" value = "Hide Exams"></form><br>';
	$sql = "SELECT exam_date, exam_time, courses_name FROM exam, employee ";
	$sql .= "WHERE employee.employee_id = exam.employee_id and ";
	$sql .= "department_id = $id ";
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

					if ($date1 > $date2 || ($date1 == $date2 && $time1 > $time2)) {
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

echo '<form action = "Head of Department.php" method = "post">';
if (!isset($_POST["display_workloads"]))
	echo '<input type = "submit" name = "display_workloads" value = "Display Workloads"></form><br>';

else {
	echo '<input type = "submit" value = "Hide Workloads"></form><br>';
	$query = mysqli_query($connection, "SELECT * FROM employee WHERE department_id = $id and role = 'Assistant'") or die("Error!");

	if (mysqli_num_rows($query) > 0) {
		$number = 0;

		while($row = mysqli_fetch_array($query))
			$assistants[$number++] = $row["username"];

		$total_point = 0;

		for ($i = 0; $i < $number; $i++) {
			foreach	($_SESSION["Assistant"] as $data) {
				if ($data["username"] == $assistants[$i]) {
					$total_point = $total_point + $data["point"];
					break;
				}
			}
		}

		echo '<table border = "1">';
		echo '<tr><th>Assistant Name</th><th>Percentage</th></tr>';

		for ($i = 0; $i < $number; $i++) {
			foreach	($_SESSION["Assistant"] as $data) {
				if ($data["username"] == $assistants[$i]) {
					if ($total_point != 0)
						echo '<tr><td>'.$data["name"].'</td><td>'.(100 * $data["point"] / $total_point).'%</td></tr>';

					else
						echo '<tr><td>'.$data["name"].'</td><td>0%</td></tr>';

					break;
				}
			}
		}

		echo '</table><br>';
	}
}

echo '<form action = "home.php" method = "post">';
echo '<input type = "submit" value = "Return Home"></form>';

mysqli_close($connection);

?>

</body>
</html>