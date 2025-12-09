--MVP for a Specific Season

SELECT
	player_name,
	season,
	pts,
	reb,
	ast,
	ts_pct,
	ROUND((pts * 0.4)+((reb + ast)* 0.3) + (ts_pct * 100 * 0.3),
	1) as mvp_score
FROM
	nba_seasons ns 
WHERE
	season = '2015-16'
	AND gp > 50
ORDER BY
	mvp_score DESC
LIMIT 5;

--all time greatest
SELECT
	player_name,
	season,
	pts,
	reb,
	ast,
	ts_pct,
	ROUND((pts * 0.4)+((reb + ast)* 0.3) + (ts_pct * 100 * 0.3),
	1) as mvp_score
FROM
	nba_seasons ns
WHERE
	gp > 50
ORDER BY
	mvp_score DESC
LIMIT 10;

-- My dream starting 5 (PG, SG, SF, PF, C) using stats across all seasons
--The Guards(Height<198cm)
SELECT DISTINCT 
	player_name,
	season,
	pts,
ROUND((pts * 0.4)+((reb + ast)* 0.3)+(ts_pct * 100 * 0.3), 1) as mvp_score
FROM
	nba_seasons ns
WHERE
	gp>50
	AND ns.player_height <198
ORDER BY
	mvp_score DESC
LIMIT 2;

--The Forwards (Height 198 - 208 cm) wingers
SELECT DISTINCT
	player_name,
	season,
	pts,
	ROUND((pts * 0.4)+((reb + ast)* 0.3)+(ts_pct * 100 * 0.3), 1) as mvp_score
FROM
	nba_seasons ns
WHERE
	gp>50
	AND ns.player_height BETWEEN 198 AND 208
ORDER BY
	mvp_score DESC
LIMIT 2;

--The Center (Height > 208 cm) big man
SELECT
	player_name,
	season,
	pts,
	ROUND((pts * 0.4)+((reb + ast)* 0.3)+(ts_pct * 100 * 0.3), 1) as mvp_score
FROM
	nba_seasons ns
WHERE
	gp>50
	AND ns.player_height > 208
ORDER BY
	mvp_score DESC
LIMIT 1;