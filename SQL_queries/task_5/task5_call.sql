-- EXEC primaryVoteCount(1, 'Adelaide'); --  election code and desired electorate name

-- double check the result

-- Calculate the total valid votes
WITH total_votes AS (
    SELECT SUM(finalprefcount) AS total_valid_votes
    FROM finalresult
    WHERE electioncode = 1 AND electoratename = 'Adelaide'
)
-- Query the results and calculate the percentage
SELECT f.resultid, 
       f.finalprefcount, 
       f.electionevent_electioneventid, 
       f.electioncode, 
       f.electoratename, 
       f.candidate_candid, 
       f.candidate_party_partycode,
       ROUND((f.finalprefcount / t.total_valid_votes) * 100, 2) AS vote_percentage
FROM finalresult f, total_votes t
WHERE f.electioncode = 1 
AND f.electoratename = 'Adelaide';
