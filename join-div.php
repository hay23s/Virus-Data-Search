<?php
include 'join-div.html';

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

//Code has references from outside website on how print out table using php
//Webiste: "https://community.oracle.com/tech/developers/discussion/1097016/how-to-fetching-column-names-from-oracle-using-php"
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

//Handle join query request between DNAVirus And DNAVirus tables
function handleDNAJoinRequest(){
    global $db_conn;
    $result = executePlainSQL("SELECT DNAVirus.virusCommonName, Genus, Status, TransmissionType, GenomeShape
                            FROM DNAVirus, Virus3 
                            WHERE DNAVirus.virusCommonName = Virus3.virusCommonName AND ".$_POST['DNAcondition']);
    printResult($result);
    OCICommit($db_conn);
}
//Handle join query request between RNAVirus And DNAVirus tables
function handleRNAJoinRequest(){
    global $db_conn;
    $result = executePlainSQL("SELECT RNAVirus.virusCommonName, Genus, Status, TransmissionType, Sense
                            FROM RNAVirus, Virus3 
                            WHERE RNAVirus.virusCommonName = Virus3.virusCommonName AND ".$_POST['RNAcondition']);    
    printResult($result);
    OCICommit($db_conn);
}

//Handle divide request: "Find DNA Viruses's names infect all hosts"
function handDivideRequest(){
        global $db_conn;
        $result = executePlainSQL("SELECT DISTINCT D.virusCommonName
        FROM DNAVirus D
        WHERE NOT EXISTS 
        ((SELECT ho.hostCommonName
          FROM Host ho
        )
          MINUS
          (SELECT  I.hostCommonName
          FROM Infects I
          WHERE D.virusCommonName = I.virusCommonName))");
        

        printResult($result);
        OCICommit($db_conn);
}

function handleRequest(){
    if (connectToDB()) {
        if (array_key_exists('DNAJoinSubmit', $_POST)) {
            handleDNAJoinRequest();
        } else if (array_key_exists('RNAJoinSubmit', $_POST)) {
            handleRNAJoinRequest();
        } else if (array_key_exists('divSubmit', $_POST)) {
            handDivideRequest();
        }
        disconnectFromDB();
    }
}


if (isset($_POST['joinSubmit']) || isset($_POST['divSubmit'])) {
    handleRequest();
} 

?>