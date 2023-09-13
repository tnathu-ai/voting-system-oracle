-- Retrieve names and addresses of voters who didn't vote in 2022 and 2019 general elections.
SELECT 
    firstname, 
    lastname, 
    residentialaddrstreet, 
    residentialaddrsuburb, 
    residentialaddrpostcode, 
    residentialaddrstate
FROM 
    voter
WHERE 
    voterid NOT IN (
        -- Subquery to get voter IDs who voted in specified elections.
        SELECT 
            voter_voterid
        FROM 
            ballotissuance bi
        JOIN 
            ballot b ON bi.election_electioncode = b.electioncode
        WHERE 
            b.electionevent_electioneventid IN (20220521, 20190518)
    )
ORDER BY 
    lastname, 
    firstname;
    
    
-- Index to optimize filtering on 'ballotissuance'.
CREATE INDEX idx_ballotissuance_voterid ON ballotissuance(voter_voterid);
-- Index to optimize lookups on 'ballot' for given election event IDs.
CREATE INDEX idx_ballot_electioneventid ON ballot(electionevent_electioneventid);


-- after adding indexes
SELECT 
    firstname, 
    lastname, 
    residentialaddrstreet, 
    residentialaddrsuburb, 
    residentialaddrpostcode, 
    residentialaddrstate
FROM 
    voter
WHERE 
    voterid NOT IN (
        -- Subquery to get voter IDs who voted in specified elections.
        SELECT 
            voter_voterid
        FROM 
            ballotissuance bi
        JOIN 
            ballot b ON bi.election_electioncode = b.electioncode
        WHERE 
            b.electionevent_electioneventid IN (20220521, 20190518)
    )
ORDER BY 
    lastname, 
    firstname;