<?php
// db_connection.php
// Establish a database connection to your Oracle database.

$username = 'REPLACE_WITH_YOUR_USERNAME';
$password = 'REPLACE_WITH_YOUR_PASSWORD';
$servername = 'REPLACE_WITH_YOUR_SERVER_NAME';
$servicename = 'REPLACE_WITH_YOUR_SERVICE_NAME';
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
