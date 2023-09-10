# Australian Electoral Commission (AEC) Computerized Voting System

## Introduction
The AEC is dedicated to offering Australians an independent electoral service. While ensuring integrity, accuracy, and transparency, the current manual voting system has its challenges. This project aims to transition to a computerised voting system for federal elections, addressing concerns like time efficiency, resource allocation, and environmental impact.

## Development Tools
+ Database Management: Oracle Developer
+ Design: Entity-Relationship Diagram (ERD) for logical and relational design
+ Code Generation: DDL code generated from the finalized ERD

![Inital DDL code](https://carbon.now.sh/E4JQd3NGrAmSjRHAf8kW)

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
