-- want to have indexes on the fields used in joins, group bys, and where conditions.
/*
Indexes:

An index on voter.residentialaddrsuburb
An index on electorate.electoratename
CREATE INDEX idx_voter_suburb ON voter(residentialaddrsuburb);
CREATE INDEX idx_electorate_name ON electorate(electoratename);
*/
SELECT e.electoratename AS "Division", 
       COUNT(v.voterid) AS "Electors on 20xx"
FROM voter v 
JOIN electorate e ON v.residentialaddrelectorate = e.electoratename
GROUP BY e.electoratename
ORDER BY COUNT(v.voterid) DESC;
