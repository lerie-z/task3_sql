--create table SPORT with 2 columns: name of the sportsman and participation year
CREATE TABLE sport (
	name VARCHAR ( 50 ) NOT NULL,
	year INT NOT NULL
);

--insert values into table
INSERT INTO sport VALUES
    ('cat', '2010');
INSERT INTO sport VALUES
    ('cat', '2011');
INSERT INTO sport VALUES
    ('cat', '2012');
INSERT INTO sport VALUES
    ('cat', '2015');
	
INSERT INTO sport VALUES
    ('dog', '2013');
INSERT INTO sport VALUES
    ('dog', '2014');
INSERT INTO sport VALUES
    ('dog', '2017');
INSERT INTO sport VALUES
    ('dog', '2018');
	
INSERT INTO sport VALUES
    ('fox', '2013');
INSERT INTO sport VALUES
    ('fox', '2014');	

INSERT INTO sport VALUES
    ('hedgehog', '2016');
INSERT INTO sport VALUES
    ('hedgehog', '2017');
INSERT INTO sport VALUES
    ('hedgehog', '2018');
INSERT INTO sport VALUES
    ('hedgehog', '2019');
	
--select sportsmen who participated in 3 consecutive years
--answer: cat, hedgehog

WITH partitioned AS (
  SELECT
    *,
    year - ROW_NUMBER() OVER (PARTITION BY name) AS grp
  FROM sport
),
counted AS (
  SELECT
    *,
    COUNT(*) OVER (PARTITION BY name, grp) AS cnt
  FROM partitioned
)
SELECT DISTINCT
  name
FROM counted
WHERE cnt >= 3
;


	