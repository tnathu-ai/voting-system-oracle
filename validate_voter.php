<?php
session_start();
include('db_connection.php');

try {
    // Fetch data from the submitted form
    $fullname = filter_input(INPUT_POST, 'fullname', FILTER_SANITIZE_STRING);
    $address = filter_input(INPUT_POST, 'address', FILTER_SANITIZE_STRING);
    $suburb = filter_input(INPUT_POST, 'suburb', FILTER_SANITIZE_STRING);
    $state = filter_input(INPUT_POST, 'state', FILTER_SANITIZE_STRING);
    $postcode = filter_input(INPUT_POST, 'postcode', FILTER_SANITIZE_STRING);
    $electorateName = filter_input(INPUT_POST, 'electorateName', FILTER_SANITIZE_STRING);
    $votedBefore = filter_input(INPUT_POST, 'votedBefore', FILTER_SANITIZE_STRING);

    // Split fullname into firstname and lastname
    $nameParts = explode(' ', $fullname, 2);
    $firstname = isset($nameParts[0]) ? $nameParts[0] : '';
    $lastname = isset($nameParts[1]) ? $nameParts[1] : '';    

    // Define the hard-coded electioneventid
    $electionEventId = 20220521;

    $query = oci_parse($conn, "SELECT VOTERID, ELECTORATENAME FROM voter WHERE firstname = :firstname AND lastname = :lastname AND residentialaddrstreet = :address AND residentialaddrsuburb = :suburb AND residentialaddrstate = :state AND residentialaddrpostcode = :postcode AND electoratename = :electorateName");

    oci_bind_by_name($query, ":firstname", $firstname);
    oci_bind_by_name($query, ":lastname", $lastname);
    oci_bind_by_name($query, ":address", $address);
    oci_bind_by_name($query, ":suburb", $suburb);
    oci_bind_by_name($query, ":state", $state);
    oci_bind_by_name($query, ":postcode", $postcode);
    oci_bind_by_name($query, ":electorateName", $electorateName);

    oci_execute($query, OCI_DEFAULT);

    if (!$query) {
        $e = oci_error($conn);
        trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }
    
    $r = oci_execute($query, OCI_DEFAULT);
    if (!$r) {
        $e = oci_error($query);
        trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }
    
    $row = oci_fetch_assoc($query);

    if ($votedBefore === 'yes') {
        throw new Exception('Thank you for indicating. You cannot vote again.');
    }

    if (!$row) {
        throw new Exception('Voter not found!');
    }

    $_SESSION['electorateName'] = $electorateName;
    echo "Electoral Name from Session: " . $_SESSION['electorateName']; 
    session_write_close();

    // Note: We are assuming that if a record exists in the ballotissuance table for a voter, they have already voted
    $hasVotedQuery = oci_parse($conn, "SELECT 1 FROM ballotissuance WHERE voter_voterid = :voterid AND electioneventid = :electionEventId");
    oci_bind_by_name($hasVotedQuery, ":voterid", $row['VOTERID']);
    oci_bind_by_name($hasVotedQuery, ":electionEventId", $electionEventId);

    oci_execute($hasVotedQuery, OCI_DEFAULT);

    if (oci_fetch_assoc($hasVotedQuery)) {
        throw new Exception('It is an offence under the Commonwealth Electoral Act 1918 to vote more than once in a federal election.');
    }

    // Inserting into the ballotissuance table
    $issuanceQuery = oci_parse($conn, "INSERT INTO ballotissuance (electioneventid, pollingstationname, timestamp, voter_voterid) VALUES (:electionEventId, 'YourPollingStationName', CURRENT_TIMESTAMP, :voterid)");

    oci_bind_by_name($issuanceQuery, ":voterid", $row['VOTERID']);
    oci_bind_by_name($issuanceQuery, ":electionEventId", $electionEventId);

    oci_execute($issuanceQuery, OCI_DEFAULT);

    oci_commit($conn);

    header("Location: ballot_paper.php");
    exit;

} catch (Exception $e) {
    oci_rollback($conn);
    echo "<script>alert('An error occurred: " . $e->getMessage() . "'); window.location.href='index.php';</script>";
    exit;
}
?>
