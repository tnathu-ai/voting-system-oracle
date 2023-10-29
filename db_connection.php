<?php
// db_connection.php
// Establish a database connection to your Oracle database.

$username = 's3879312';
$password = 'catiscute02@';
$servername = 'talsprddb01.int.its.rmit.edu.au';
$servicename = 'CSAMPR1.ITS.RMIT.EDU.AU';
$connection = $servername . "/" . $servicename;

try {
    // Connect to the Oracle database
    $conn = oci_connect($username, $password, $connection);
    if (!$conn) {
        $e = oci_error();
        throw new Exception("A connection error occurred: " . htmlentities($e['message']));
    }
} catch (Exception $e) {
    // Rollback in case of any error
    oci_rollback($conn);
    // Display user-friendly error message
    die("An error occurred while connecting to the database. Please try again later.");
    // error_log($e->getMessage());
}
?>
