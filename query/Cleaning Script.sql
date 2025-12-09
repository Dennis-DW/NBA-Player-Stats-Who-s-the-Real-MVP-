-- Created database nba_db
-- Imported the nba_seasons cv

SELECT
	*
FROM
	nba_seasons ns ;
--Data cleaning
--Unamed column

ALTER TABLE nba_seasons
--RENAME COLUMN 'Column1' TO row_id;
-- replace 'Undrafted' text with NULL (Empty)
UPDATE
	nba_seasons
SET
	draft_year = NULL
WHERE
	draft_year = 'Undrafted';

UPDATE
	nba_seasons
SET
	draft_round = NULL
WHERE
	draft_round = 'Undrafted';

UPDATE
	nba_seasons
SET
	draft_number = NULL
WHERE
	draft_number = 'Undrafted';

UPDATE
	nba_seasons
SET
	draft_year = CAST(draft_year AS INTEGER)
WHERE
	draft_year IS NOT NULL;

UPDATE
	nba_seasons
SET
	draft_round = CAST(draft_year AS INTEGER)
WHERE
	draft_round IS NOT NULL;

UPDATE
	nba_seasons
SET
	draft_number = CAST(draft_year AS INTEGER)
WHERE
	draft_number IS NOT NULL;
-- Trim whitespaces
UPDATE
	nba_seasons
SET
	player_name = TRIM(player_name),
	team_abbreviation = TRIM(team_abbreviation),
	country = TRIM(country),
	college = TRIM(college);
-- Check for logical Duplicates
SELECT
	player_name,
	season,
	team_abbreviation,
	COUNT(*)
FROM
	nba_seasons
GROUP BY
	player_name,
	season,
	team_abbreviation
HAVING
	COUNT(*)>1;
--Standardize Country Names U.S.A => USA
UPDATE
	nba_seasons
SET
	country = 'USA'
WHERE
	country = 'U.S.A'
	OR country = 'United States';
--Standardize Bosnia and Herzegovina, Bosnia & Herzegovina, Bosnia
UPDATE
	nba_seasons
SET
	country = 'Bosnia and Herzegovina'
WHERE
	country = 'Bosnia'
	OR country = 'Bosnia & Herzegovina';
--Standardize "Republic" of Congo (Brazzaville) Merge Congo -> Republic of the Congo
UPDATE
	nba_seasons
SET
	country = 'Republic of the Congo'
WHERE
	country = 'Congo'
	--Standardize Democratic" Congo (Kinshasa) Merge DRC -> Democratic Republic of the Congo
   UPDATE
	nba_seasons
SET
	country = 'Democratic Replic of thr Congo'
WHERE
	country = 'DRC';