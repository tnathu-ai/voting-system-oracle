CREATE OR REPLACE PROCEDURE primaryVoteCount(
  election_code IN NUMBER,
  electorate IN VARCHAR2
) IS
BEGIN
  INSERT INTO ElectionResults(election_code, electorate, candidate_id, primary_votes)
  SELECT election_event_id, electorate_name, candidate_id, COUNT(*)
  FROM ComputerisedBallotPapers
  WHERE election_event_id = election_code AND electorate_name = electorate AND preference_order = 1
  GROUP BY election_event_id, electorate_name, candidate_id;

  COMMIT;
END primaryVoteCount;
