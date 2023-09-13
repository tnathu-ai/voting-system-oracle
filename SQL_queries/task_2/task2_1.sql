/* Task 2 question 1: Retrieve total voters per electorate */

-- Query before adding indexes
SELECT e.electoratename AS "Division",
       Count(v.voterid) AS "Electors on 20xx"
FROM   voter v
       JOIN electorate e ON v.residentialaddrelectorate = e.electoratename
GROUP  BY e.electoratename
ORDER  BY Count(v.voterid) DESC; 

/* Indexing for optimization */

-- Index on 'residentialaddrelectorate' for faster joins
CREATE INDEX idx_voter_residentialaddrelectorate ON voter(residentialaddrelectorate);
-- Index on 'electoratename' for quicker lookups
CREATE INDEX idx_electorate_name ON electorate(electoratename);

-- Query post-indexing (should have improved performance)
SELECT e.electoratename AS "Division",
       Count(v.voterid) AS "Electors on 20xx"
FROM   voter v
       JOIN electorate e ON v.residentialaddrelectorate = e.electoratename
GROUP  BY e.electoratename
ORDER  BY Count(v.voterid) DESC; 


EXEC DBMS_STATS.GATHER_TABLE_STATS('ELECTION_SCHEMA', 'VOTER');

/*
DROP INDEX idx_voter_residentialaddrelectorate;
DROP INDEX idx_electorate_name;
*/