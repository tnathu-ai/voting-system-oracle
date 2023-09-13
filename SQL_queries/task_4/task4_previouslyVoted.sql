/*
The function checks if a voter, 
    identified by p_voterid, 
    has already been issued a ballot for 
    a specific election (identified by p_electioncode) 
    and electorate (identified by p_electoratename). 
If the voter has been issued a ballot, the function returns TRUE, indicating that they have already voted. Otherwise, it returns FALSE.
@parameters:
    p_electioncode: This parameter represents the election code. It is of type NUMBER.
    p_electoratename: This parameter represents the name of the electorate. It is of type VARCHAR2.
    p_voterid: This parameter represents the identification of the voter. It is of type NUMBER.
@Output
    1: TRUE 
    0: FALSE
*/
-- Creating the stored function to check if a voter has voted before
CREATE OR REPLACE FUNCTION previouslyVoted(
    p_electioncode NUMBER,
    p_electoratename VARCHAR2,
    p_voterid NUMBER
) RETURN NUMBER AS
    v_count NUMBER;
BEGIN
    -- Check if the voter has been issued a ballot for the given election and electorate
    SELECT COUNT(*)
    INTO v_count
    FROM ballotissuance
    WHERE election_electioncode = p_electioncode
    AND voter_voterid = p_voterid;

    -- If count is greater than 0, it means the voter has been issued a ballot (i.e., has voted)
    IF v_count > 0 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        -- Handle unexpected errors
        DBMS_OUTPUT.PUT_LINE('Error encountered: ' || SQLERRM);
        RETURN 0;
END previouslyVoted;
/



