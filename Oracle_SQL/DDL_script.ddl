-- drop all 12 existing entities
DROP TABLE ballot CASCADE CONSTRAINTS PURGE;
DROP TABLE ballotpref CASCADE CONSTRAINTS PURGE;
DROP TABLE candidate CASCADE CONSTRAINTS PURGE;
DROP TABLE election CASCADE CONSTRAINTS PURGE;
DROP TABLE electionevent CASCADE CONSTRAINTS PURGE;
DROP TABLE electorate CASCADE CONSTRAINTS PURGE;
DROP TABLE finalresult CASCADE CONSTRAINTS PURGE;
DROP TABLE party CASCADE CONSTRAINTS PURGE;
DROP TABLE prefdistribution CASCADE CONSTRAINTS PURGE;
DROP TABLE votecountrounds CASCADE CONSTRAINTS PURGE;
DROP TABLE voter CASCADE CONSTRAINTS PURGE;
DROP TABLE ballotissuance CASCADE CONSTRAINTS PURGE;

CREATE TABLE ballot (
    ballotid                      NUMBER NOT NULL,
    electionevent_electioneventid NUMBER NOT NULL,
    electioncode                  NUMBER,
    electoratename                VARCHAR2(200) NOT NULL
);

COMMENT ON TABLE ballot IS
    'This table is used to store confidential raw data of each ballot paper.';

ALTER TABLE ballot ADD CONSTRAINT ballot_pk PRIMARY KEY ( ballotid );

CREATE TABLE ballotissuance (
    electioneventid       NUMBER NOT NULL,
    pollingstationname    VARCHAR2(100),
    timestamp             TIMESTAMP,
    voter_voterid         NUMBER NOT NULL,
    election_electioncode NUMBER
);

COMMENT ON TABLE ballotissuance IS
    'Table logging the issuance of ballots to registered voters at polling stations with timestamps, connected to specific elections.'
    ;

ALTER TABLE ballotissuance ADD CONSTRAINT ballotissuance_pk PRIMARY KEY ( electioneventid,
                                                                          voter_voterid );

CREATE TABLE ballotpref (
    preference                VARCHAR2(100),
    ballot_ballotid           NUMBER NOT NULL,
    candidate_candid          NUMBER NOT NULL
);

ALTER TABLE ballotpref ADD candidate_party_partycode VARCHAR2(20);

COMMENT ON TABLE ballotpref IS
    'This table captures the candidates and preferences cast by a voter for a specific ballot.';

ALTER TABLE ballotpref ADD CONSTRAINT ballotpref_pk PRIMARY KEY ( ballot_ballotid, candidate_candid );

CREATE TABLE candidate (
    candid                    NUMBER NOT NULL,
    candidatename             VARCHAR2(100) NOT NULL,
    contactdetailname         VARCHAR2(100),
    contactdetaildaytimephone VARCHAR2(15),
    contactdetailmobilephone  VARCHAR2(15),
    contactdetailemail        VARCHAR2(100),
    electoratename            VARCHAR2(200) NOT NULL,
    electioneventid           NUMBER NOT NULL,
    party_partycode           VARCHAR2(20) NOT NULL
);

COMMENT ON TABLE candidate IS
    'Table storing details of individual candidates participating in the elections, including their contact details and affiliated political party.'
    ;

ALTER TABLE candidate ADD CONSTRAINT candidate_pk PRIMARY KEY (candid, party_partycode);

CREATE TABLE election (
    electioncode                  NUMBER NOT NULL,
    dateofelection                DATE NOT NULL,
    typeofelection                VARCHAR2(100),
    declarationdate               DATE,
    lastvoterregistrationdate     DATE,
    lastcandidaturesubmissiondate DATE,
    resultsdeclarationdate        DATE
);

COMMENT ON TABLE election IS
    'Table recording details of each specific election event, capturing the date, type, and other related metrics.';

ALTER TABLE election ADD CONSTRAINT election_pk PRIMARY KEY ( electioncode );

CREATE TABLE electionevent (
    electioneventid           NUMBER NOT NULL,
    campaignstartdate         DATE,
    campaignenddate           DATE,
    numberofcandidates        NUMBER,
    election_electioncode     NUMBER NOT NULL,
    electorate_electoratename VARCHAR2(200) NOT NULL,
    registeredvotersforevent  NUMBER
);

COMMENT ON TABLE electionevent IS
    ' This table captures specific events held for each electorate on an Election Day.
';

ALTER TABLE electionevent
    ADD CONSTRAINT electionevent_pk PRIMARY KEY ( electioneventid,
                                                  election_electioncode,
                                                  electorate_electoratename );

CREATE TABLE electorate (
    electoratename           VARCHAR2(200) NOT NULL,
    historicaldate           DATE,
    historicalnumberofvoters INTEGER,
    currentmpname            VARCHAR2(100)
);

COMMENT ON TABLE electorate IS
    'Table detailing individual electorates with information on current registered voters, historical voter data, and current representatives.'
    ;

ALTER TABLE electorate ADD CONSTRAINT electorate_pk PRIMARY KEY ( electoratename );

CREATE TABLE finalresult (
    resultid                      NUMBER NOT NULL,
    finalprefcount                INTEGER NOT NULL,
    electionevent_electioneventid NUMBER NOT NULL,
    electioncode                  NUMBER NOT NULL,
    electoratename                VARCHAR2(200) NOT NULL,
    candidate_candid              NUMBER NOT NULL,
    candidate_party_partycode     VARCHAR2(20) NOT NULL
);

COMMENT ON TABLE finalresult IS
    'This table stores the final result after all primary preferences and distribution counts are completed.';

ALTER TABLE finalresult
    ADD CONSTRAINT finalresult_pk PRIMARY KEY ( resultid,
                                                electionevent_electioneventid,
                                                electioncode,
                                                electoratename,
                                                candidate_candid,
                                                candidate_party_partycode );

CREATE TABLE party (
    partycode                VARCHAR2(20) NOT NULL,
    partyname                VARCHAR2(100),
    partylogo                BLOB,
    partyheadquartersaddr    VARCHAR2(200),
    secretaryname            VARCHAR2(100),
    contactpersonname        VARCHAR2(100),
    contactpersondayphone    VARCHAR2(15),
    contactpersonmobilephone VARCHAR2(15),
    contactpersonemail       VARCHAR2(100)
);

COMMENT ON TABLE party IS
    'Table representing political parties with details about their name, logo, headquarters, and contact information.';

ALTER TABLE party ADD CONSTRAINT party_pk PRIMARY KEY ( partycode );

CREATE TABLE prefdistribution (
    prefcount                 NUMBER NOT NULL,
    votecountrounds_roundnum  NUMBER NOT NULL,
    candidate_candid          NUMBER NOT NULL,
    candidate_party_partycode VARCHAR2(20) NOT NULL
);

COMMENT ON TABLE prefdistribution IS
    'This table, in association with the Vote Count Round, captures the preference tally for candidates at end of each round.';

ALTER TABLE prefdistribution
    ADD CONSTRAINT prefdistribution_pk PRIMARY KEY ( votecountrounds_roundnum,
                                                     candidate_candid,
                                                     candidate_party_partycode );

CREATE TABLE votecountrounds (
    roundnum                      NUMBER NOT NULL,
    electionevent_electioneventid NUMBER NOT NULL,
    electioncode                  NUMBER NOT NULL,
    electoratename                VARCHAR2(200) NOT NULL,
    countstatus                   VARCHAR2(100),
    tally                         NUMBER
);

COMMENT ON TABLE votecountrounds IS
    'This table helps keep track of each distribution round in the counting process.';

ALTER TABLE votecountrounds ADD CONSTRAINT votecountrounds_pk PRIMARY KEY ( roundnum );

CREATE TABLE voter (
    voterid                   NUMBER NOT NULL,
    title                     VARCHAR2(10),
    firstname                 VARCHAR2(50) NOT NULL,
    middlename                VARCHAR2(50),
    lastname                  VARCHAR2(50) NOT NULL,
    gender                    VARCHAR2(25),
    dateofbirth               DATE,
    residentialaddrunit       VARCHAR2(10),
    residentialaddrstreet     VARCHAR2(200),
    residentialaddrsuburb     VARCHAR2(100),
    residentialaddrpostcode   NUMBER(4),
    residentialaddrstate      VARCHAR2(3) NOT NULL,
    postaladdrunit            VARCHAR2(10),
    postaladdrstreet          VARCHAR2(200),
    postaladdrsuburb          VARCHAR2(100),
    postaladdrpostcode        NUMBER(4),
    postaladdrstate           VARCHAR2(3),
    dayphone                  VARCHAR2(15),
    mobilephone               VARCHAR2(15),
    email                     VARCHAR2(100),
    electoratename           VARCHAR2(200) NOT NULL
);

COMMENT ON TABLE voter IS
    'Table storing details of individuals registered to vote in elections, including their personal and contact information.';

ALTER TABLE voter ADD CONSTRAINT voter_pk PRIMARY KEY ( voterid );

ALTER TABLE ballot
    ADD CONSTRAINT ballot_electionevent_fk FOREIGN KEY ( electionevent_electioneventid,
                                                         electioncode,
                                                         electoratename )
        REFERENCES electionevent ( electioneventid,
                                   election_electioncode,
                                   electorate_electoratename );

ALTER TABLE ballotissuance
    ADD CONSTRAINT ballotissuance_election_fk FOREIGN KEY ( election_electioncode )
        REFERENCES election ( electioncode );

ALTER TABLE ballotissuance
    ADD CONSTRAINT ballotissuance_voter_fk FOREIGN KEY ( voter_voterid )
        REFERENCES voter ( voterid );

ALTER TABLE ballotpref
    ADD CONSTRAINT ballotpref_ballot_fk FOREIGN KEY ( ballot_ballotid )
        REFERENCES ballot ( ballotid );

-- Update foreign key constraints
ALTER TABLE ballotpref
    ADD CONSTRAINT ballotpref_candidate_fk FOREIGN KEY (candidate_candid, candidate_party_partycode)
        REFERENCES candidate (candid, party_partycode);


ALTER TABLE candidate
    ADD CONSTRAINT candidate_party_fk FOREIGN KEY ( party_partycode )
        REFERENCES party ( partycode );
        

ALTER TABLE electionevent
    ADD CONSTRAINT electionevent_election_fk FOREIGN KEY ( election_electioncode )
        REFERENCES election ( electioncode );

ALTER TABLE electionevent
    ADD CONSTRAINT electionevent_electorate_fk FOREIGN KEY ( electorate_electoratename )
        REFERENCES electorate ( electoratename );

ALTER TABLE votecountrounds
    ADD CONSTRAINT electionevent_fk FOREIGN KEY ( electionevent_electioneventid,
                                                  electioncode,
                                                  electoratename )
        REFERENCES electionevent ( electioneventid,
                                   election_electioncode,
                                   electorate_electoratename );

ALTER TABLE finalresult
    ADD CONSTRAINT finalresult_candidate_fk FOREIGN KEY (candidate_candid, candidate_party_partycode)
        REFERENCES candidate (candid, party_partycode);
        
ALTER TABLE finalresult
    ADD CONSTRAINT finalresult_electionevent_fk FOREIGN KEY ( electionevent_electioneventid,
                                                              electioncode,
                                                              electoratename )
        REFERENCES electionevent ( electioneventid,
                                   election_electioncode,
                                   electorate_electoratename );

ALTER TABLE prefdistribution
    ADD CONSTRAINT prefdistribution_candidate_fk FOREIGN KEY (candidate_candid, candidate_party_partycode)
        REFERENCES candidate (candid, party_partycode);

ALTER TABLE prefdistribution
    ADD CONSTRAINT votecountrounds_fk FOREIGN KEY ( votecountrounds_roundnum )
        REFERENCES votecountrounds ( roundnum );

