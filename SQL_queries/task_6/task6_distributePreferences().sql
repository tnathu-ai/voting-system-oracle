DELETE FROM finalresult;
DROP SEQUENCE resultid_seq;
CREATE SEQUENCE resultid_seq
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE distributePreferences(p_electionCode NUMBER, p_electorateName VARCHAR2) AS
    v_roundNum NUMBER := 1;
    v_lowestCandidate NUMBER;
    v_nextPreference VARCHAR2(20);
    v_ballotID NUMBER;
    v_candidateID NUMBER;
    v_candidateCount NUMBER;
BEGIN
    -- Populate the prefdistribution table with initial preferences
    INSERT INTO prefdistribution (prefcount, votecountrounds_roundnum, candidate_candid)
    SELECT 1, v_roundNum, candidate_candid
    FROM ballotpref bp
    JOIN ballot b ON bp.ballot_ballotid = b.ballotid
    WHERE preference = '1'
    AND b.electioncode = p_electionCode
    AND b.electoratename = p_electorateName;

    -- Loop until only two candidates remain
    LOOP
        BEGIN
            -- Find the candidate with the lowest preference count for this round
            SELECT candidate_candid 
            INTO v_lowestCandidate 
            FROM (
                SELECT candidate_candid, SUM(prefcount) as totalPref 
                FROM prefdistribution 
                WHERE votecountrounds_roundnum = v_roundNum 
                GROUP BY candidate_candid 
                ORDER BY totalPref ASC
            ) WHERE ROWNUM = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                EXIT;
        END;

        -- Check the number of distinct candidates for this round
        SELECT COUNT(DISTINCT candidate_candid) 
        INTO v_candidateCount
        FROM prefdistribution 
        WHERE votecountrounds_roundnum = v_roundNum;

        EXIT WHEN v_candidateCount <= 2;

        -- For each ballot that has the lowest candidate as their current preference, redistribute the vote
        FOR c IN (SELECT bp.ballot_ballotid 
                  FROM ballotpref bp
                  JOIN ballot b ON bp.ballot_ballotid = b.ballotid
                  WHERE bp.candidate_candid = v_lowestCandidate 
                  AND TO_NUMBER(bp.preference) = v_roundNum -- convert to number to perform numeric operations 
                  AND b.electioncode = p_electionCode
                  AND b.electoratename = p_electorateName) LOOP
            v_ballotID := c.ballot_ballotid;

            -- Find the next valid preference for this ballot
            SELECT MIN(preference), candidate_candid 
            INTO v_nextPreference, v_candidateID 
            FROM ballotpref 
            WHERE ballot_ballotid = v_ballotID 
            AND TO_NUMBER(preference) > v_roundNum 
            AND candidate_candid != v_lowestCandidate
            GROUP BY candidate_candid;

            -- Update the preference distribution for the next candidate
            INSERT INTO prefdistribution (prefcount, votecountrounds_roundnum, candidate_candid)
            VALUES (1, v_roundNum + 1, v_candidateID);
        END LOOP;

        -- Increment the round number
        v_roundNum := v_roundNum + 1;
    END LOOP;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END distributePreferences;
/

EXEC distributePreferences(20220521, 'Adelaide');
