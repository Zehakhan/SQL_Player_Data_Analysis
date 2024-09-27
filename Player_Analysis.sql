-- 1. What is the total number of players in the dataset?
SELECT COUNT(player_name) AS total_players 
FROM all_t20_world_cup_players_list;

-- 2. Which team has the most players in the dataset?
SELECT COUNT(player_name) AS num_players, team
FROM all_t20_world_cup_players_list
GROUP BY team
ORDER BY num_players DESC
LIMIT 1;

-- 3. What is the average number of players per team in the dataset?
SELECT AVG(player_count) AS avg_players_per_team
FROM (
    SELECT COUNT(player_name) AS player_count
    FROM all_t20_world_cup_players_list
    GROUP BY team
) AS team_players;

-- 4. Which year has the most teams in the dataset?
SELECT COUNT(DISTINCT team) AS num_teams, year
FROM all_t20_world_cup_players_list
GROUP BY year
ORDER BY num_teams DESC
LIMIT 1;

-- 5. What is the total number of players from the team "India"?
SELECT COUNT(player_name) AS num_players_from_india
FROM all_t20_world_cup_players_list
WHERE team = 'India';

-- 6. Which team has the most players who have played in multiple years?
SELECT team, COUNT(DISTINCT player_name) AS num_multiyear_players
FROM all_t20_world_cup_players_list
GROUP BY team
HAVING COUNT(DISTINCT year) > 1
ORDER BY num_multiyear_players DESC
LIMIT 1;

-- 7. What is the average number of years played by players from the team "Australia"?
SELECT AVG(years_played) AS avg_years_played_by_australian_players
FROM (
    SELECT player_name, COUNT(DISTINCT year) AS years_played
    FROM all_t20_world_cup_players_list
    WHERE team = 'Australia'
    GROUP BY player_name
) AS australian_player_years;

-- 8. Which player has played for the most teams in the dataset?
SELECT player_name, COUNT(DISTINCT team) AS num_teams_played_for
FROM all_t20_world_cup_players_list
GROUP BY player_name
ORDER BY num_teams_played_for DESC
LIMIT 1;



-- 10. Which team has the highest percentage of players who have played in multiple years?
WITH multiyear_players AS (
    SELECT player_name, team, COUNT(DISTINCT year) AS years_played
    FROM all_t20_world_cup_players_list
    GROUP BY player_name, team
    HAVING COUNT(DISTINCT year) > 1
)
SELECT team, 
       COUNT(player_name) * 100.0 / (SELECT COUNT(player_name) FROM all_t20_world_cup_players_list WHERE all_t20_world_cup_players_list.team = multiyear_players.team) AS percentage_multiyear_players
FROM multiyear_players
GROUP BY team
ORDER BY percentage_multiyear_players DESC
LIMIT 1;

