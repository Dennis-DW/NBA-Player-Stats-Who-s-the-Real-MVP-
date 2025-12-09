
-- Era Analysis 1090s,2000s, 2010s, 2020s
-- Average NBA players size, style and performance.
-- Use case statement to group the seasons into decades.
SELECT
	CASE
		WHEN CAST (SUBSTR(season, 1, 4) AS INT) BETWEEN 1990 AND 1999 THEN '1990s'
		WHEN CAST (SUBSTR(season, 1, 4) AS INT) BETWEEN 2000 AND 2009 THEN '2000s'
		WHEN CAST (SUBSTR(season, 1, 4) As INT) BETWEEN 2010 AND 2019 THEN '2010s'
		ELSE '2020s'
	END as decade,
	ROUND(AVG(player_height), 2) as avg_height_cm,
	ROUND(AVG(player_weight), 2) as avg_weight_kg,
	ROUND(AVG(pts), 2) as avg_points
FROM
	nba_seasons ns 
GROUP BY
	decade
ORDER BY
	decade;

--Teams  which produced top perfoming players
--More then 20 points per game
SELECT
	team_abbreviation,
	COUNT(*) as star_seasons
FROM
	nba_seasons ns
WHERE
	pts>20
GROUP BY
	team_abbreviation
ORDER BY
	star_seasons DESC
LIMIT 10;

--rookies vs veterans
SELECT
	CASE
		WHEN CAST(draft_year AS INT)= CAST(SUBSTR(season, 1, 4) AS INT) THEN 'Rookie'
		ELSE 'Veteran'
	END as player_status,
	COUNT (*) as total_players,
	ROUND(AVG(pts), 1) as avg_pts,
	ROUND(AVG(reb), 1) as avg_reb,
	ROUND(AVG(ast), 1) as avg_ast,
	ROUND(AVG(net_rating), 1) as avg_impact
FROM
	nba_seasons ns
WHERE
	draft_year IS NOT NULL
GROUP BY
	player_status ;

--List of every player taging weather rookie or vetiran
SELECT 
player_name,
season,
draft_year,
CASE 
	WHEN CAST(draft_year AS INT)= CAST(SUBSTR(season, 1, 4) AS INT) THEN 'Rookie'
	ELSE 'Veteran'
END AS status
FROM nba_seasons ns 
WHERE draft_year IS NOT NULL 
ORDER BY season DESC, status ASC
LIMIT 50;


SELECT player_name, season, pts
FROM nba_seasons ns 
WHERE CAST(draft_year AS INT) = CAST(SUBSTR(season, 1, 4) AS INT)
AND season = '2003-04';

