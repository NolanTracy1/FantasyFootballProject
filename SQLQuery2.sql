WITH deleted_player AS (
  SELECT *
  FROM dbo.player_teams
  WHERE Player = 'Josh Allen' AND Tm = 'JAX'
)
DELETE FROM deleted_player;

WITH remaining_players AS (
  SELECT p.Tm, d.*
  FROM dbo.player_teams p
  RIGHT OUTER JOIN dbo.BBM_III_Data_Dump_Finals_01302023 d ON p.Player = d.player_name
  AND p.Season = 2022
)
SELECT * FROM remaining_players;

