-- party table
INSERT INTO party (partycode, partyname) VALUES ('LDP', 'Liberal Democrats');
INSERT INTO party (partycode, partyname) VALUES ('ALP', 'Australian Labor Party');
INSERT INTO party (partycode, partyname) VALUES ('GRN', 'The Greens');
INSERT INTO party (partycode, partyname) VALUES ('UAP', 'United Australia Party');
INSERT INTO party (partycode, partyname) VALUES ('PHON', 'Pauline Hanson''s One Nation');
INSERT INTO party (partycode, partyname) VALUES ('LIB', 'Liberal');
INSERT INTO party (partycode, partyname) VALUES ('AJP', 'Animal Justice Party');
INSERT INTO party (partycode, partyname) VALUES ('VS', 'Victorian Socialists');
INSERT INTO party (partycode, partyname) VALUES ('IND', 'Independent');

-- electorate table
INSERT INTO electorate (electoratename, historicaldate, historicalnumberofvoters, currentmpname) 
VALUES ('Hotham', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 50000, 'Current MP for Hotham');
INSERT INTO electorate (electoratename, historicaldate, historicalnumberofvoters, currentmpname) 
VALUES ('Melbourne', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 60000, 'Current MP for Melbourne');


-- election table
-- Assuming hypothetical dates and types for the elections
-- 2022 Federal election for Hotham electorate
INSERT INTO ELECTION (ELECTIONCODE, DATEOFELECTION, TYPEOFELECTION, DECLARATIONDATE, LASTVOTERREGISTRATIONDATE, LASTCANDIDATURESUBMISSIONDATE, RESULTSDECLARATIONDATE) 
VALUES (202201, TO_DATE('2022-05-21', 'YYYY-MM-DD'), 'Federal', TO_DATE('2022-06-01', 'YYYY-MM-DD'), TO_DATE('2022-04-21', 'YYYY-MM-DD'), TO_DATE('2022-04-28', 'YYYY-MM-DD'), TO_DATE('2022-06-05', 'YYYY-MM-DD'));
-- 2022 Federal election for Melbourne electorate
INSERT INTO ELECTION (ELECTIONCODE, DATEOFELECTION, TYPEOFELECTION, DECLARATIONDATE, LASTVOTERREGISTRATIONDATE, LASTCANDIDATURESUBMISSIONDATE, RESULTSDECLARATIONDATE) 
VALUES (202202, TO_DATE('2022-05-21', 'YYYY-MM-DD'), 'Federal', TO_DATE('2022-06-01', 'YYYY-MM-DD'), TO_DATE('2022-04-21', 'YYYY-MM-DD'), TO_DATE('2022-04-28', 'YYYY-MM-DD'), TO_DATE('2022-06-05', 'YYYY-MM-DD'));


-- voter table
-- Inserting Joe Bloggs into VOTER table
INSERT INTO VOTER (
    VOTERID,
    TITLE,
    FIRSTNAME,
    MIDDLENAME,
    LASTNAME,
    GENDER,
    DATEOFBIRTH,
    RESIDENTIALADDRUNIT,
    RESIDENTIALADDRSTREET,
    RESIDENTIALADDRSUBURB,
    RESIDENTIALADDRPOSTCODE,
    RESIDENTIALADDRSTATE,
    POSTALADDRUNIT,
    POSTALADDRSTREET,
    POSTALADDRSUBURB,
    POSTALADDRPOSTCODE,
    POSTALADDRSTATE,
    DAYPHONE,
    MOBILEPHONE,
    EMAIL,
    ELECTORATENAME
) VALUES (
    1, -- Assuming VOTERID for Joe Bloggs is 1
    NULL, -- Title not provided
    'Joe',
    NULL, -- Middle name not provided
    'Bloggs',
    NULL, -- Gender not provided
    NULL, -- Date of birth not provided
    NULL, -- Residential address unit not provided
    '124 Latrobe Street',
    'Melbourne',
    3000,
    'VIC',
    NULL, -- Postal address unit not provided
    NULL, -- Postal address street not provided
    NULL, -- Postal address suburb not provided
    NULL, -- Postal address postcode not provided
    NULL, -- Postal address state not provided
    NULL, -- Day phone not provided
    NULL, -- Mobile phone not provided
    NULL, -- Email not provided
    'Melbourne' -- Electorate name
);
-- Inserting Penny Chan into VOTER table
INSERT INTO VOTER (
    VOTERID,
    TITLE,
    FIRSTNAME,
    MIDDLENAME,
    LASTNAME,
    GENDER,
    DATEOFBIRTH,
    RESIDENTIALADDRUNIT,
    RESIDENTIALADDRSTREET,
    RESIDENTIALADDRSUBURB,
    RESIDENTIALADDRPOSTCODE,
    RESIDENTIALADDRSTATE,
    POSTALADDRUNIT,
    POSTALADDRSTREET,
    POSTALADDRSUBURB,
    POSTALADDRPOSTCODE,
    POSTALADDRSTATE,
    DAYPHONE,
    MOBILEPHONE,
    EMAIL,
    ELECTORATENAME
) VALUES (
    2, -- Assuming VOTERID for Penny Chan is 2
    NULL, -- Title not provided
    'Penny',
    NULL, -- Middle name not provided
    'Chan',
    NULL, -- Gender not provided
    NULL, -- Date of birth not provided
    NULL, -- Residential address unit not provided
    '246 Clayton Road',
    'Clayton',
    3168,
    'VIC',
    NULL, -- Postal address unit not provided
    NULL, -- Postal address street not provided
    NULL, -- Postal address suburb not provided
    NULL, -- Postal address postcode not provided
    NULL, -- Postal address state not provided
    NULL, -- Day phone not provided
    NULL, -- Mobile phone not provided
    NULL, -- Email not provided
    'Hotham' -- Electorate name
);


-- candidate table
-- Hotham Electorate Candidates
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (1, 'SOK, Edward', 'Hotham', 20220521, 'LDP');
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (2, 'O''NEIL, Clare', 'Hotham', 20220521, 'ALP');
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (3, 'WILLOUGHBY, Louisa', 'Hotham', 20220521, 'GRN');
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (4, 'RIDGWAY, Bruce Scott', 'Hotham', 20220521, 'UAP');
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (5, 'TULL, Roger', 'Hotham', 20220521, 'PHON');
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (6, 'BEVINAKOPPA, Savitri', 'Hotham', 20220521, 'LIB');
-- Melbourne Electorate Candidates
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (7, 'BORG, Justin', 'Melbourne', 20220521, 'UAP');
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (8, 'PATERSON, Keir', 'Melbourne', 20220521, 'ALP');
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (9, 'BANDT, Adam', 'Melbourne', 20220521, 'GRN');
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (10, 'DAMCHES, James', 'Melbourne', 20220521, 'LIB');
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (11, 'PEPPARD, Richard', 'Melbourne', 20220521, 'LDP');
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (12, 'ROBSON, Scott', 'Melbourne', 20220521, 'IND');
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (13, 'STRAGAN, Walter', 'Melbourne', 20220521, 'PHON');
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (14, 'POON, Bruce', 'Melbourne', 20220521, 'AJP');
INSERT INTO CANDIDATE (CANDID, CANDIDATENAME, ELECTORATENAME, ELECTIONEVENTID, PARTY_PARTYCODE) VALUES (15, 'BOLGER, Colleen', 'Melbourne', 20220521, 'VS');

-- electionevent table
-- Inserting data for the 2022 Federal election for Hotham electorate
INSERT INTO electionevent (
    electioneventid,
    election_electioncode,
    electorate_electoratename,
    registeredvotersforevent
) VALUES (
    20220521, -- Assuming electioneventid is always 20220521 as per  note
    202201,     -- Assuming electioncode for the 2022 Federal election is 2022
    'Hotham', -- Electorate name
    NULL      -- Number of registered voters for the event (you can replace NULL with the actual number if available)
);
-- Inserting data for the 2022 Federal election for Melbourne electorate
INSERT INTO electionevent (
    electioneventid,
    election_electioncode,
    electorate_electoratename,
    registeredvotersforevent
) VALUES (
    20220521,   -- Assuming electioneventid is always 20220521 as per  note
    202202,       -- Assuming electioncode for the 2022 Federal election is 2022
    'Melbourne', -- Electorate name
    NULL        -- Number of registered voters for the event (you can replace NULL with the actual number if available)
);

COMMIT;


