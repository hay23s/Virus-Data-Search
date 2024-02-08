<html>

<head>
	<title>Insertion, Deletion, Update</title>
</head>

<body>
	
		
	<section name="Insertion, Delete, Update">
		<h1>Insertion, Deletion, Update</h1>
		<form method = 'POST'>
		<label for="select">(if select RNA, leave Genome Shape empty. If select DNA, leave Sense empty.) <br><br> Type: </label>
		<select name="select" id="select">
			<option value="RNA">RNA</option>
			<option value="DNA">DNA</option>
		</select><br></br>
			<label for="virusCommonName">Virus Common Name:</label>
			<input type="text" id="virusCommonName" name="virusCommonName"><br></br>

			<label for="genomeShape">Genome Shape:</label>
			<input type="text" id="genomeShape" name="genomeShape"><br></br>

			<label for="Sense">Sense:</label>
			<input type="text" id="Sense" name="Sense"><br></br>

			<label for="Strandedness">Strandedness:</label>
			<input type="text" id="Strandedness" name="Strandedness"><br></br>

			<label for="Genus">Genus:</label>
			<input type="text" id="Genus" name="Genus"><br></br>

			<label for="Family">Family:</label>
			<input type="text" id="Family" name="Family"><br></br>

			<label for="Status">Status:</label>
			<input type="text" id="Status" name="Status"><br></br>

			<label for="TransmissionType">TransmissionType:</label>
			<input type="text" id="TransmissionType" name="TransmissionType"><br></br>

		<button name="insertButton" id="insertButton" type="submit" value = 'Submit'>Insert</button><br></br>
		<button name="deleteButton" id="deleteButton" type="submit" value = 'Submit'>Delete</button>To delete input the virus common name<br></br>
		<button name="updateButton" id="updateButton" type="submit" value = 'Submit'>Update</button><br></br>
		<br>
		<button type="button" onclick="location='main.php'">Home</button>
</form>

		<hr>

		
</body>


<?php


//Codes taken from oracle-test.php from tutorial 7

$success = True; //keep track of errors so it redirects the page only if there are no errors
$db_conn = NULL; // edit the login credentials in connectToDB()
$show_debug_alert_messages = False; // set to True if you want alerts to show you which methods are being triggered (see how it is used in debugAlertMessage())


function debugAlertMessage($message)
{
	global $show_debug_alert_messages;

	if ($show_debug_alert_messages) {
		echo "<script type='text/javascript'>alert('" . $message . "');</script>";
	}
}

function executePlainSQL($cmdstr)
{ //takes a plain (no bound variables) SQL command and executes it
	//echo "<br>running ".$cmdstr."<br>";
	global $db_conn, $success;

	$statement = OCIParse($db_conn, $cmdstr);
	//There are a set of comments at the end of the file that describe some of the OCI specific functions and how they work

	if (!$statement) {
		echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
		$e = OCI_Error($db_conn); // For OCIParse errors pass the connection handle
		echo htmlentities($e['message']);
		$success = False;
	}

	$r = OCIExecute($statement, OCI_DEFAULT);
	if (!$r) {
		echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
		$e = oci_error($statement); // For OCIExecute errors pass the statementhandle
		echo htmlentities($e['message']);
		$success = False;
	}

	return $statement;
}

function connectToDB()
{
	global $db_conn;

	// Your username is ora_(CWL_ID) and the password is a(student number). For example,
	// ora_platypus is the username and a12345678 is the password.
	$db_conn = OCILogon("ora_dingma", "a69680510", "dbhost.students.cs.ubc.ca:1522/stu");

	if ($db_conn) {
		debugAlertMessage("Database is Connected");
		return true;
	} else {
		debugAlertMessage("Cannot connect to Database");
		$e = OCI_Error(); // For OCILogon errors pass no handle
		echo htmlentities($e['message']);
		return false;
	}
}

function disconnectFromDB()
{
	global $db_conn;
	debugAlertMessage("Disconnect from Database");
	OCILogoff($db_conn);
}


function printResult($result)
{
	echo "<table border='1'>\n";
	echo "<tr>\n";
	for ($k = 1; $k <= oci_num_fields($result); $k += 1) {
		$colname = oci_field_name($result, $k);
		echo "  <th><b>" . htmlentities($colname, ENT_QUOTES) . "</b></th>\n";
	}
	echo "</tr>\n";

	while (($row = oci_fetch_array($result, OCI_ASSOC + OCI_RETURN_NULLS)) != false) {
		echo "<tr>\n";
		foreach ($row as $data) {
			echo "  <td>";
			if ($data != null) {
				$inner = htmlentities($data, ENT_QUOTES);
				echo $inner;
			} else {
				echo "&nbsp";
			}
			echo "</td>\n";
		}
		echo "</tr>\n";
	}
	echo "</table>\n";
}


function handleInsertRequest()
{
	global $db_conn;

	$virusCommonName = $_POST['virusCommonName'];
	$genomeShape = $_POST['genomeShape'];
	$Sense = $_POST['Sense'];
	$Status = $_POST['Status'];
	$Genus = $_POST['Genus'];
	$Strandedness = $_POST['Strandedness'];
	$TransmissionType = $_POST['TransmissionType'];
	$Family = $_POST['Family'];




	$sql = executePlainSQL("INSERT INTO  virus1 (Family, Strandedness)
		values('$Family','$Strandedness')");
	$sql = executePlainSQL("INSERT INTO  virus2 (Genus, Family)
		values('$Genus','$Family')");
	$sql = executePlainSQL("INSERT INTO  virus3 (virusCommonName,Genus,Status,TransmissionType)
		values('$virusCommonName', '$Genus','$Status','$TransmissionType')");
	$select = $_POST['select'];
	if ($select == "RNA") {

		$sql = executePlainSQL("INSERT INTO  RNAVirus (virusCommonName, Sense)
		values('$virusCommonName','$Sense')");
	} else if ($select == "DNA") {

		$sql = executePlainSQL("INSERT INTO  DNAVirus (virusCommonName, genomeShape)
		values('$virusCommonName','$genomeShape')");
	}
	OCICommit($db_conn);
	if ($sql) {
		echo "Inserteddd";
	}
}


function handleDeleteRequest()
{
	global $db_conn;
	$virusCommonName = $_POST['virusCommonName'];
	$sql = executePlainSQL("DELETE FROM virus3 WHERE virusCommonName = '$virusCommonName'");
	OCICommit($db_conn);
	if ($sql) {
		echo "Deleteddd";
	}
}

function handleUpdateRequest()
{
	global $db_conn;
	$virusCommonName = $_POST['virusCommonName'];
	$genomeShape = $_POST['genomeShape'];
	$Sense = $_POST['Sense'];
	$Status = $_POST['Status'];
	$Genus = $_POST['Genus'];
	$TransmissionType = $_POST['TransmissionType'];


	
	$select = $_POST['select'];
	if ($select == "RNA") {

		$sql = executePlainSQL("UPDATE RNAVirus SET Sense = '$Sense' WHERE virusCommonName = '$virusCommonName'");

	} else if ($select == "DNA") {

		$sql = executePlainSQL("UPDATE DNAVirus SET genomeShape = '$genomeShape' WHERE virusCommonName = '$virusCommonName'");
	}
		$sql = executePlainSQL("UPDATE virus3 SET Status = '$Status', Genus = '$Genus',  TransmissionType = '$TransmissionType' WHERE virusCommonName = '$virusCommonName'");
		OCICommit($db_conn);
		if ($sql) {
			echo "Updateddd";
		}
	}
	





function handleRequest()
{
	if (connectToDB()) {
		if (isset($_POST['insertButton'])) {


			handleInsertRequest();

		} else if (isset($_POST['deleteButton'])) {
			handleDeleteRequest();
		}
		else if (isset($_POST['updateButton'])) {
			handleUpdateRequest();
		}
		disconnectFromDB();
	}
}


if (isset($_POST['insertButton'])) {
	handleRequest();
} else if (isset($_POST['deleteButton'])) {
	handleRequest();
} else if (isset($_POST['updateButton'])) {
	handleRequest();
}


?>
</html>
