/*
"No rows" would mean that there are no voters in the voter table 
    who have previously voted in the election.
*/
SELECT voterid, firstname, lastname
FROM voter
WHERE previouslyVoted(1, 'Adelaide', voterid) = 1;
