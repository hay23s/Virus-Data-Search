<?php
include "select-project.html";

//Codes taken from oracle-test.php from tutorial 7

$success = True; //keep track of errors so it redirects the page only if there are no errors
$db_conn = NULL; // edit the login credentials in connectToDB()
$show_debug_alert_messages = False; // set to True if you want alerts to show you which methods are being triggered (see how it is used in debugAlertMessage())


function debugAlertMessage($message) {
    global $show_debug_alert_messages;

    if ($show_debug_alert_messages) {
        echo "<script type='text/javascript'>alert('" . $message . "');</script>";
    }
}

function executePlainSQL($cmdstr) { //takes a plain (no bound variables) SQL command and executes it
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

function connectToDB() {
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

function disconnectFromDB() {
    global $db_conn;
    debugAlertMessage("Disconnect from Database");
    OCILogoff($db_conn);
}
//New Code 

//Code has references from outside website on basic function on how print out table using php
// webiste "https://community.oracle.com/tech/developers/discussion/1097016/how-to-fetching-column-names-from-oracle-using-php"
function printResult($result) { 
    echo "<table border='1'>\n";
    echo "<tr>\n";
    for ($k = 1; $k <= oci_num_fields($result); $k+=1){
        $colname = oci_field_name($result, $k);
        echo "  <th><b>".htmlentities($colname, ENT_QUOTES)."</b></th>\n";
    }
    echo "</tr>\n";
    
    while (($row = oci_fetch_array($result, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
        echo "<tr>\n";
        foreach ($row as $data) {
            echo "  <td>";
            if ($data != null){
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

//Handle Selection Query
function handleSelectiontRequest(){
    global $db_conn;
    $table = $_POST['selectTable'];
    $condition = $_POST['condition'];
    $result = executePlainSQL("SELECT * FROM " . $table . " WHERE " . $condition);
    printResult($result);
    OCICommit($db_conn);
    
}

//Handle Projection Query
function handleProjectionRequest(){
    global $db_conn;
    $table = $_POST['projTable'];
    $column = $_POST['columns'];
    $result = executePlainSQL("SELECT " .$column.  " FROM " . $table);
    printResult($result);
    OCICommit($db_conn);

}

function handleRequest(){
    if (connectToDB()) {
        if (array_key_exists('selSubmit', $_POST)) {
            handleSelectiontRequest();
        } else if (array_key_exists('projSubmit', $_POST)) {
            handleProjectionRequest();
        } 
        disconnectFromDB();
    }
}


if (isset($_POST['selSubmit']) || isset($_POST['projSubmit'])) {
    handleRequest();
} 

?>