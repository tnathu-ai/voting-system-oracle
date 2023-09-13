DELETE FROM finalresult;

/*
Auto-generate RESULTID using a sequence: 
    Since RESULTID is meant to be a unique identifier for each record in the FINALRESULT table, 
    then we use a sequence to auto-generate this value.

Provide a value for RESULTID: 
    We have a specific way of determining the value for RESULTID, 
    we can modify the stored procedure to include this value when inserting a record.
*/
DROP SEQUENCE resultid_seq;
CREATE SEQUENCE resultid_seq
START WITH 1
INCREMENT BY 1;


-- Define the stored procedure primaryVoteCount
CREATE OR REPLACE PROCEDURE primaryVoteCount(
    p_electioncode NUMBER,         -- Input parameter for the election code
    p_electoratename VARCHAR2      -- Input parameter for the electorate name
) AS
    v_candidate_id NUMBER;         -- Variable to store the current candidate's ID
    v_vote_count NUMBER;           -- Variable to store the vote count for the current candidate
    v_total_candidates NUMBER;     -- Variable to store the total number of candidates
BEGIN
    -- Get the total number of candidates for the election and electorate
    SELECT COUNT(*)
    INTO v_total_candidates
    FROM candidate
    WHERE party_partycode IN 
        (SELECT party_partycode 
         FROM electionevent 
         WHERE election_electioncode = p_electioncode 
         AND electorate_electoratename = p_electoratename);

    -- Loop through each candidate in the specified election and electorate
    FOR r_candidate IN (SELECT candid 
                        FROM candidate 
                        WHERE party_partycode IN 
                            (SELECT party_partycode 
                             FROM electionevent 
                             WHERE election_electioncode = p_electioncode 
                             AND electorate_electoratename = p_electoratename)) LOOP

        -- Count the primary votes (first preferences) for the current candidate
        SELECT COUNT(*)
        INTO v_vote_count
        FROM ballotpref bp
        WHERE preference = '1'
        AND candidate_candid = r_candidate.candid
        AND ballot_ballotid IN (SELECT ballotid 
                                FROM ballot 
                                WHERE electioncode = p_electioncode 
                                AND electoratename = p_electoratename
                                AND MOD(ballotid, 100) != 0) -- Exclude informal ballots
        AND NOT EXISTS ( -- Ensure that the ballot contains only numbers 1 to n
            SELECT 1 
            FROM ballotpref 
            WHERE ballot_ballotid = bp.ballot_ballotid 
            AND (preference NOT BETWEEN '1' AND TO_CHAR(v_total_candidates) 
                 OR LENGTH(preference) > LENGTH(TO_CHAR(v_total_candidates))));

        -- Update the Election Results table with the primary vote count for the current candidate
        INSERT INTO finalresult (resultid, finalprefcount, electionevent_electioneventid, electioncode, electoratename, 
                         candidate_candid, candidate_party_partycode)
        VALUES (resultid_seq.NEXTVAL,  -- Use the sequence to generate a unique value for RESULTID
        v_vote_count, 
        (SELECT electioneventid 
         FROM electionevent 
         WHERE election_electioncode = p_electioncode 
         AND electorate_electoratename = p_electoratename), 
        p_electioncode, 
        p_electoratename, 
        r_candidate.candid, 
        (SELECT party_partycode FROM candidate WHERE candid = r_candidate.candid));

    END LOOP;

    COMMIT;  -- Commit the changes to the database

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;  -- Rollback any changes in case of an error
        RAISE;     -- Raise the caught exception to the caller
END primaryVoteCount;
/

EXEC primaryVoteCount(1, 'Adelaide'); 
