<?php
session_start();
include('db_connection.php');

// Validate session variables
if (!isset($_SESSION['electioneventID'], $_SESSION['electorateName'], $_POST['preference'])) {
    die("Invalid request.");
}
if (!isset($_SESSION['voterID'])) {
    die("Voter ID not found.");
}

$voterID = $_SESSION['voterID'];
$electorateName = $_SESSION['electorateName'];
$electioneventID = 20220521; // This needs to be dynamically set based on your requirements

try {
    // Fetch the maximum BallotID for the current electioneventID
    $fetchMaxIDQuery = oci_parse($conn, "SELECT MAX(ballotid) AS max_id FROM ballot WHERE electionevent_electioneventid = :electioneventID");
    oci_bind_by_name($fetchMaxIDQuery, ":electioneventID", $electioneventID);

    if (!oci_execute($fetchMaxIDQuery, OCI_DEFAULT)) {
        throw new Exception("Error fetching maximum BallotID.");
    }

    $result = oci_fetch_assoc($fetchMaxIDQuery);
    $ballotID = $result['MAX_ID'] ? $result['MAX_ID'] + 1 : 1; 

    // Insert into ballot table first
    $insertBallotQuery = oci_parse($conn, "INSERT INTO ballot (ballotid, electionevent_electioneventid, electioncode, electoratename) VALUES (:ballotID, :electioneventID, :electionCode, :electorateName)");
    oci_bind_by_name($insertBallotQuery, ":ballotID", $ballotID);
    oci_bind_by_name($insertBallotQuery, ":electioneventID", $electioneventID);
    oci_bind_by_name($insertBallotQuery, ":electionCode", $electionCode);
    oci_bind_by_name($insertBallotQuery, ":electorateName", $electorateName);

    if (!oci_execute($insertBallotQuery, OCI_DEFAULT)) {
        throw new Exception("Error inserting into ballot table.");
    }

    // Store preference data in the database without data cleaning
    foreach ($_POST['preference'] as $candidateID => $preferenceOrder) {
        $insertPreferenceQuery = oci_parse($conn, "INSERT INTO ballotpref (preference, ballot_ballotid, candidate_candid, candidate_party_partycode) VALUES (:preferenceOrder, :ballotID, :candidateID, :partyCode)");
        oci_bind_by_name($insertPreferenceQuery, ":preferenceOrder", $preferenceOrder);
        oci_bind_by_name($insertPreferenceQuery, ":ballotID", $ballotID);
        oci_bind_by_name($insertPreferenceQuery, ":candidateID", $candidateID);
        oci_bind_by_name($insertPreferenceQuery, ":partyCode", $partyCode);

        if (!oci_execute($insertPreferenceQuery, OCI_DEFAULT)) {
            throw new Exception("Error inserting preference data.");
        }
    }

    // If everything went well, commit the transaction
    oci_commit($conn);

    // Redirect to a confirmation page
    header("Location: confirmation.php");

} catch (Exception $e) {
    oci_rollback($conn);
    error_log($e->getMessage());
    echo "Sorry, there was a problem processing your request. Please try again later.";
}
?>
