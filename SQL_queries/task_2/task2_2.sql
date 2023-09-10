/*
-- Note: Using the DBMS_RANDOM.VALUE function will give different orderings 
-- each time the query is executed, achieving the randomized order of candidates.
*/
-- SQL query to produce candidate lists for all electorates for the 2022 federal election 
-- with election event id: 20220521.
-- The result set is sorted by electorate, 
-- and then candidates within each electorate are randomized.

SELECT 
    e.electoratename AS "Electorate",      -- Selecting the name of the electorate
    c.candidatename AS "Candidate Name",   -- Selecting the name of the candidate
    p.partyname AS "Political Party"       -- Selecting the name of the political party the candidate belongs to
FROM 
    electionevent ee                       -- Main table for the election event details
-- Joining the electorate table to fetch details about each electorate
JOIN electorate e ON ee.electorate_electoratename = e.electoratename
-- Joining the candidate table to fetch details about each candidate participating in the election
JOIN candidate c ON c.party_partycode = ee.election_electioncode
-- Joining the party table to fetch details about each political party in the election
JOIN party p ON c.party_partycode = p.partycode
WHERE 
    ee.electioneventid = 20220521           -- Filtering the results for the 2022 federal election event
ORDER BY 
    e.electoratename,                      -- Sorting by the electorate name to group candidates by their electorates
    DBMS_RANDOM.VALUE;                     -- Using DBMS_RANDOM.VALUE to randomize the order of candidates within each electorate


