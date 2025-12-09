--Rank Season leaders
SELECT
	season,
	rank_num,
	player_name,
	pts,
	gp as games_played
FROM
	(
	SELECT
		season,
		player_name,
		pts,
		gp,
		RANK() OVER (PARTITION BY season
	ORDER BY
		pts DESC) as rank_num
	FROM
		nba_seasons ns
		--      filtered out players who played very few games to avaoid skewed data
	WHERE
		gp>20
      )as ranked_table
WHERE
	rank_num <= 3
ORDER BY
	season DESC,
	rank_num ASC;

--Efficiency stats(TS% vs usage%)
SELECT
	season,
	player_name,
	pts,
	gp,
	usg_pct as usage_rate,
	ts_pct as shooting_efficiency
FROM
	nba_seasons ns
WHERE
	usg_pct > 0.30
	AND ts_pct >0.60
	AND gp > 40
ORDER BY
	ts_pct DESC;

--Most improved players
SELECT
	t1.player_name,
	t1.season as current_season,
	t2.season as previous_season,
	t2.pts as previous_pts,
	t1.pts as current_pts,
	ROUND(t1.pts-t2.pts, 1) as pts_increase
FROM
	nba_seasons t1
JOIN nba_seasons t2
ON
	t1.player_name = t2.player_name
	AND CAST (SUBSTR(t1.season, 1, 4)AS INT) = CAST(SUBSTR(t2.season, 1, 4)As INT)+ 1
WHERE
	t1.gp>40
	AND t2.gp>40
ORDER BY
	pts_increase DESC
LIMIT 10;

