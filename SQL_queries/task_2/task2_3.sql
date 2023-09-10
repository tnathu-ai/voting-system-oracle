/*
Indexes that would help:
ballotissuance on voter_voterid: Since we are looking up the voter IDs that appear in the ballotissuance table, an index on this column will speed up this selection process.

ballotissuance on election_electioncode: Since we are filtering the ballotissuance entries based on specific election codes, indexing this column will facilitate faster searching.

Types of Indexes:

B-tree index: This is the default index type in Oracle, suitable for high-cardinality columns (like voterid) and performs well for equality and range-based searches.
*/
SELECT 
    v.firstname, 
    v.lastname, 
    v.residentialaddrunit,
    v.residentialaddrstreet, 
    v.residentialaddrsuburb, 
    v.residentialaddrpostcode,
    v.residentialaddrstate
FROM 
    voter v
WHERE 
    v.voterid NOT IN (
        SELECT 
            bi.voter_voterid 
        FROM 
            ballotissuance bi 
        WHERE 
            bi.election_electioncode IN (20220521, 20190518)
    );
