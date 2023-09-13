/*
-- This query retrieves a list of candidates for all electorates for the 2022 federal election.
-- The candidates are displayed in a randomized order within each electorate.
-- The query uses the DBMS_RANDOM.VALUE function to randomize the order of candidates within each electorate.
-- The candidate table is indirectly related to the electionevent table through the ballotpref and ballot tables.
-- The electionevent table is related to the electorate table via the electorate_electoratename column.
*/
SELECT e.electoratename AS "Electorate", 
       c.candidatename AS "Candidate Name", 
       p.partyname AS "Political Party"
FROM   candidate c
JOIN   ballotpref bp ON c.candid = bp.candidate_candid
JOIN   ballot b ON bp.ballot_ballotid = b.ballotid
JOIN   electionevent ee ON b.electionevent_electioneventid = ee.electioneventid
JOIN   electorate e ON ee.electorate_electoratename = e.electoratename
JOIN   party p ON c.party_partycode = p.partycode
WHERE  ee.electioneventid = 20220521
ORDER  BY e.electoratename, DBMS_RANDOM.VALUE;

-- Election Event Index:
CREATE INDEX idx_ee_electioneventid ON electionevent(electioneventid);
-- Candidate Index:
CREATE INDEX idx_candidate_candid ON candidate(candid);
-- Ballot Preference Index:
CREATE INDEX idx_bp_candid ON ballotpref(candidate_candid);
-- Party Index:
CREATE INDEX idx_party_partycode ON party(partycode);


-- After adding indexes
SELECT e.electoratename AS "Electorate", 
       c.candidatename AS "Candidate Name", 
       p.partyname AS "Political Party"
FROM   candidate c
JOIN   ballotpref bp ON c.candid = bp.candidate_candid
JOIN   ballot b ON bp.ballot_ballotid = b.ballotid
JOIN   electionevent ee ON b.electionevent_electioneventid = ee.electioneventid
JOIN   electorate e ON ee.electorate_electoratename = e.electoratename
JOIN   party p ON c.party_partycode = p.partycode
WHERE  ee.electioneventid = 20220521
ORDER  BY e.electoratename, DBMS_RANDOM.VALUE;


/*
DROP INDEX idx_ee_electioneventid;
DROP INDEX idx_candidate_candid;
DROP INDEX idx_bp_candid;
DROP INDEX idx_party_partycode;
*/

