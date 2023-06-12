--Join Best Ball data with player data to get the Teams--
SELECT dbo.best_ball_finals.*, dbo.player_stats.Tm
FROM dbo.best_ball_finals LEFT OUTER JOIN dbo.player_stats
ON dbo.best_ball_finals.player_name = dbo.player_stats.Player
AND dbo.player_stats.Season = 2022;
