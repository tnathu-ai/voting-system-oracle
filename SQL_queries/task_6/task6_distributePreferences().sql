CREATE OR REPLACE PROCEDURE distributePreferences(
  election_code IN NUMBER,
  electorate IN VARCHAR2
) IS
  v_pref_order NUMBER := 2;
BEGIN
  LOOP
    MERGE INTO ElectionResults ER
    USING (
      SELECT election_event_id, electorate_name, candidate_id, COUNT(*) AS pref_count
      FROM ComputerisedBallotPapers
      WHERE election_event_id = election_code AND electorate_name = electorate AND preference_order = v_pref_order
      GROUP BY election_event_id, electorate_name, candidate_id
    ) CB
    ON (ER.election_code = CB.election_event_id AND ER.electorate = CB.electorate_name AND ER.candidate_id = CB.candidate_id)
    WHEN MATCHED THEN
      UPDATE SET ER.preference_votes = ER.preference_votes + CB.pref_count
    WHEN NOT MATCHED THEN
      INSERT (election_code, electorate, candidate_id, preference_votes) VALUES (CB.election_event_id, CB.electorate_name, CB.candidate_id, CB.pref_count);

    v_pref_order := v_pref_order + 1;
    
    EXIT WHEN NOT EXISTS (
      SELECT 1 FROM ComputerisedBallotPapers
      WHERE election_event_id = election_code AND electorate_name = electorate AND preference_order = v_pref_order
    );
  END LOOP;

  COMMIT;
END distributePreferences;
