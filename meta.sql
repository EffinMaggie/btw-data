create table rawResult
(
    id integer not null primary key,
    year integer not null,
    constituency integer not null,
    party text not null,
    primaryVote integer null,
    secondaryVote integer null
);
