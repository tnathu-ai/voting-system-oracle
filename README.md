# Australian Electoral Commission (AEC) Computerized Voting System

## Introduction
The AEC is dedicated to offering Australians an independent electoral service. While ensuring integrity, accuracy, and transparency, the current manual voting system has its challenges. This project aims to transition to a computerised voting system for federal elections, addressing concerns like time efficiency, resource allocation, and environmental impact.

## Development Tools
+ Database Management: Oracle Developer
+ Design: Entity-Relationship Diagram (ERD) for logical and relational design
+ Code Generation: DDL code generated from the finalized ERD


## Project Scope
This project's initial phase focuses on federal general elections for the House of Representatives. The following are out of scope:
Senate federal general elections:
+ Federal by-elections
+ State and territory elections
+ City and Shire Council elections
+ Referendums
+ Other AEC services

## Counting Process
A candidate is elected if they gain over 50% of the formal vote. The process involves counting all number '1' votes for each candidate. If no candidate has over half the votes, the candidate with the fewest votes is excluded, and their votes are transferred based on the next preference. This continues until a candidate has over half the total votes.

## Important Notes
Ballot vs Issuance Record: The Ballot is the digital equivalent of the ballot paper. It captures voters' preferences but cannot be associated with any voter. The Issuance Record, on the other hand, records when and where a ballot is issued to a specific voter. It tracks who has voted but should not be used to track down the ballot issued and cast by a specific voter.
Informal Ballots: The database should accommodate both formal and informal ballots. Informal ballots should be identified and eliminated from the counting process. A formal ballot must have a preference cast for each candidate. If there are n candidates, they must be numbered from 1 to n.

## Query Execution Plan: 
When running the query, generate a query execution plan to check if it uses a full table scan, index scan, or index-only scan. The primary key plays a crucial role, so dropping it even for testing is not advisable.
Preference Redistribution: The preference redistribution process is complex. It's carried out in several rounds, with one candidate eliminated in each round. The process continues until only two candidates remain. The redistribution process can involve multiple small additions in the later rounds due to the complexity of the preference flow.

## Project Directory
```
├── LICENSE
├── README.md
├── SQL_queries
│   ├── ddl
│   │   ├── DDL_script.ddl
│   │   └── final_DDL_script_updated.ddl
│   ├── insert_query
│   │   ├── insert.sql
│   │   ├── insert_ballot.sql
│   │   ├── insert_ballotpref.sql
│   │   ├── insert_candidate.sql
│   │   ├── insert_election.sql
│   │   ├── insert_electionevent.sql
│   │   ├── insert_electorate.sql
│   │   ├── insert_party.sql
│   │   └── insert_voter.sql
│   ├── task_2
│   │   ├── images
│   │   │   ├── and.png
│   │   │   ├── autotrace.png
│   │   │   ├── bookmark.png
│   │   │   ├── cancel.png
│   │   │   ├── commandrunning.gif
│   │   │   ├── dbms_out.png
│   │   │   ├── empty.png
│   │   │   ├── filesave.png
│   │   │   ├── format.png
│   │   │   ├── gray.png
│   │   │   ├── index.png
│   │   │   ├── indexesicon.png
│   │   │   ├── join.png
│   │   │   ├── minus.gif
│   │   │   ├── open.png
│   │   │   ├── or.png
│   │   │   ├── owa_out.png
│   │   │   ├── pi.png
│   │   │   ├── plus.gif
│   │   │   ├── print.png
│   │   │   ├── red.png
│   │   │   ├── rootfoldericon.png
│   │   │   ├── run_default.png
│   │   │   ├── runscript.png
│   │   │   ├── runscript2.png
│   │   │   ├── script_default.png
│   │   │   ├── sigma.png
│   │   │   ├── sigmafilter.png
│   │   │   ├── sigmakeys.png
│   │   │   ├── sqlprofileicon.png
│   │   │   ├── sqlrestructicon.png
│   │   │   ├── sqltuning_advisor.png
│   │   │   ├── sqltuningadvisorrestruct.png
│   │   │   ├── statisticsicon.png
│   │   │   ├── table.png
│   │   │   ├── union.png
│   │   │   └── view.png
│   │   ├── task2_1.html
│   │   ├── task2_1.sql
│   │   ├── task2_1_after_adding_index.html
│   │   ├── task2_2.sql
│   │   ├── task2_2_after_adding_index.html
│   │   ├── task2_2_before_adding_index.html
│   │   ├── task2_3.sql
│   │   ├── task2_3_after_adding_indexes.html
│   │   └── task2_3_before_adding_indexes.html
│   ├── task_4
│   │   ├── task4_call.sql
│   │   └── task4_previouslyVoted.sql
│   ├── task_5
│   │   ├── task5_call.sql
│   │   └── task5_primaryVoteCount.sql
│   └── task_6
│       ├── task6_call.sql
│       └── task6_distributePreferences().sql
├── data_modeler
│   └── milestone1.dmd
├── html
│   ├── task2_1_after_adding_index.html
│   ├── task2_1_before_adding_index.html
│   ├── task2_2_after_adding_index.html
│   ├── task2_2_before_adding_index.html
│   ├── task2_3_after_adding_indexes.html
│   └── task2_3_before_adding_indexes.html
├── images
│   ├── Logical.png
│   └── Relational.png
├── notebooks
│   ├── partition.ipynb
│   └── pre_processing.ipynb
├── sample_data
│   ├── Ballot Preferences -- separate rows for each preference.csv
│   ├── Ballots - raw preferences.csv
│   ├── Common First Names.csv
│   ├── Common Last Names.csv
│   ├── Current Members of Parliament.csv
│   ├── GeneralEnrolmentByDivision.csv
│   ├── List of Electorates.csv
│   ├── MOCK_DATA_ballot.csv
│   ├── MOCK_DATA_ballotpref.csv
│   ├── MOCK_DATA_candidate.csv
│   ├── MOCK_DATA_election.csv
│   ├── MOCK_DATA_electionevent.csv
│   ├── MOCK_DATA_electorate.csv
│   ├── MOCK_DATA_party.csv
│   ├── MOCK_DATA_voter.csv
│   ├── Preference Distribution - Five Rounds.xlsx
│   ├── Preference Redistribution - Chisholm Electorate VIC 2022 May Election.xlsx
│   ├── Primary Votes - Chisholm Electorate VIC 2022 May Election.csv
│   ├── Street_Name_Labels.csv
│   ├── australian_postcodes.csv
│   └── voter.csv
└── sample_output
    └── Preference Redistribution - Chisholm Electorate VIC 2022 May Election.xlsx
```