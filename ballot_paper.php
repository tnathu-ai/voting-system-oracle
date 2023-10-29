<?php
session_start();
include('db_connection.php');

$commit_mode = OCI_DEFAULT;

$electorateName = isset($_SESSION['electorateName']) ? $_SESSION['electorateName'] : null;

// if (!$electorateName) {
//     die("Electorate name is not provided.");
// }

// $query = oci_parse($conn, "SELECT DISTINCT c.CANDID, c.CANDIDATENAME, p.PARTYNAME 
//                           FROM candidate c
//                           JOIN electionevent ee ON c.ELECTIONEVENTID = ee.ELECTIONEVENTID
//                           LEFT JOIN party p ON c.PARTY_PARTYCODE = p.PARTYCODE
//                           WHERE c.ELECTORATENAME = :electorateName AND ee.ELECTIONEVENTID = 20220521
//                           ORDER BY c.CANDIDATENAME");

// oci_bind_by_name($query, ":electorateName", $electorateName);

// if (!oci_execute($query, $commit_mode)) {
//     oci_rollback($conn);
//     $e = oci_error($query);
//     trigger_error("An error occurred while processing your request.", E_USER_ERROR);
// }

// $candidates = array();
// $candidateCount = 0;
// while ($row = oci_fetch_assoc($query)) {
//     $candidateCount++;
//     $candidates[] = $row;
// }

// if ($candidateCount > 0) {
//     oci_commit($conn);
// } else {
//     oci_rollback($conn);
//     $error_message = "There was a problem fetching the candidates.";
// }

// Hard coded values for testing
$electorateName = "Sample Electorate";
$candidates = array(
    array(
        "candid" => "1",
        "candidatename" => "John Doe",
        "partyname" => "Party A"
    ),
    array(
        "candid" => "2",
        "candidatename" => "Jane Smith",
        "partyname" => "Party B"
    ),
    array(
        "candid" => "3",
        "candidatename" => "Alice Johnson",
        "partyname" => "Party C"
    )
);
$candidateCount = count($candidates);

$pageTitle = "Ballot Paper";
$subheaderTitle = "House of Representatives Ballot Paper";
$headerTitle = "Victoria Electoral Division of " . htmlspecialchars($electorateName, ENT_QUOTES, 'UTF-8');
include('header.php');
?>
<div class="container">
    <div class="sub-header">
        <?php
        echo "Number the boxes from 1 to " . htmlspecialchars($candidateCount, ENT_QUOTES, 'UTF-8') . " in the order of your choice";
        ?>
    </div>

    <?php if (!empty($candidates)): ?>
    <form action="process_ballot.php" method="post">
        <?php foreach ($candidates as $row): ?>
            <div class="candidate-row">
                <div class="candidate-details">
                    <span class="candidate-name">
                        <label for="preference[<?php echo htmlspecialchars($row['CANDID'], ENT_QUOTES, 'UTF-8'); ?>]">
                        <?php echo isset($row['CANDIDATENAME']) ? htmlspecialchars($row['CANDIDATENAME'], ENT_QUOTES, 'UTF-8') : 'N/A'; ?></label>
                    </span>
                    <span class="party-name"><?php echo isset($row['PARTYNAME']) ? htmlspecialchars($row['PARTYNAME'], ENT_QUOTES, 'UTF-8') : 'N/A'; ?></span>
                </div>
                <div class="preference-input">
                    <input type="text" id="preference[<?php echo htmlspecialchars($row['CANDID'], ENT_QUOTES, 'UTF-8'); ?>]" name="preference[<?php echo htmlspecialchars($row['CANDID'], ENT_QUOTES, 'UTF-8'); ?>]" placeholder="Order">
                </div>
            </div>
        <?php endforeach; ?>
        <div class="submit-button">
            <input type="submit" value="VOTE">
        </div>
    </form>
    <?php else: ?>
        <?php echo isset($error_message) ? "<div class='error'>" . htmlspecialchars($error_message, ENT_QUOTES, 'UTF-8') . "</div>" : "<div class='error'>No candidates found.</div>"; ?>
    <?php endif; ?>
</div>
<div class="note">
    Remember...number <span class="highlight">every</span> box to make your vote count.
</div>
<?php 
include('footer.php');
?>
