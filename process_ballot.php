<?php
session_start();
include('db_connection.php');

// Sanitize and validate input
if (!isset($_SESSION['electioneventID'], $_SESSION['electorateName'], $_POST['preference'])) {
    die("Invalid request.");
}

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
    $ballotID = $result['MAX_ID'] ? $result['MAX_ID'] + 1 : 1; // If there's no record yet, start from 1

    // Insert into ballot table first
    $insertBallotQuery = oci_parse($conn, "INSERT INTO ballot (ballotid, electionevent_electioneventid, electioncode, electoratename) VALUES (:ballotID, :electioneventID, :electionCode, :electorateName)");
    oci_bind_by_name($insertBallotQuery, ":ballotID", $ballotID);
    oci_bind_by_name($insertBallotQuery, ":electioneventID", $electioneventID);
    oci_bind_by_name($insertBallotQuery, ":electionCode", $electionCode); // This needs to be dynamically set based on your requirements
    oci_bind_by_name($insertBallotQuery, ":electorateName", $electorateName);
    
    if (!oci_execute($insertBallotQuery, OCI_DEFAULT)) {
        throw new Exception("Error inserting into ballot table.");
    }

    // Store preference data in the database
    foreach ($_POST['preference'] as $candidateID => $preferenceOrder) {
        $insertPreferenceQuery = oci_parse($conn, "INSERT INTO ballotpref (preference, ballot_ballotid, candidate_candid, candidate_party_partycode) VALUES (:preferenceOrder, :ballotID, :candidateID, :partyCode)");
        oci_bind_by_name($insertPreferenceQuery, ":preferenceOrder", $preferenceOrder);
        oci_bind_by_name($insertPreferenceQuery, ":ballotID", $ballotID);
        oci_bind_by_name($insertPreferenceQuery, ":candidateID", $candidateID);
        oci_bind_by_name($insertPreferenceQuery, ":partyCode", $partyCode); // Ensure $partyCode is initialized with the correct value

        if (!oci_execute($insertPreferenceQuery, OCI_DEFAULT)) {
            throw new Exception("Error inserting preference data.");
        }
    }

    // Insert a ballot issuance record (assuming this remains unchanged)
    $pollingStationName = '';  // Example name
    $timestamp = date('Y-m-d H:i:s'); // Current timestamp
    $electionCode = 20220521;  // As per the provided hard-coded value

    $insertIssuanceQuery = oci_parse($conn, "INSERT INTO ballotissuance (electioneventid, pollingstationname, timestamp, voter_voterid, election_electioncode) VALUES (:electioneventID, :pollingStationName, TO_TIMESTAMP(:timestamp, 'YYYY-MM-DD HH24:MI:SS'), :voterID, :electionCode)");
    oci_bind_by_name($insertIssuanceQuery, ":electioneventID", $electioneventID);
    oci_bind_by_name($insertIssuanceQuery, ":pollingStationName", $pollingStationName);
    oci_bind_by_name($insertIssuanceQuery, ":timestamp", $timestamp);
    oci_bind_by_name($insertIssuanceQuery, ":voterID", $voterID); // Ensure $voterID is initialized with the correct value
    oci_bind_by_name($insertIssuanceQuery, ":electionCode", $electionCode);

    if (!oci_execute($insertIssuanceQuery, OCI_DEFAULT)) {
        throw new Exception("Error inserting ballot issuance data.");
    }

    // If everything went well, commit the transaction
    oci_commit($conn);

    // Redirect to a confirmation page
    header("Location: confirmation.php");

} catch (Exception $e) {
    oci_rollback($conn);
    error_log($e->getMessage()); // Log the detailed error for administrative review
    echo "Sorry, there was a problem processing your request. Please try again later.";
}
?>
