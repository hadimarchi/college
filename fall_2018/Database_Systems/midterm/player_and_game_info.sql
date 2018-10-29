SELECT PLAYER.EMPLOYEE_id as id,
	   (select CONCAT(PERSON.first_name, ' ', 
					  IF(PERSON.middle_initial='NULL', '', PERSON.middle_initial), 
                      ' ', PERSON.last_name) 
		from PERSON where PERSON.id = PLAYER.EMPLOYEE_id) as name,
        PLAYER.team,
        IF(TEAM.PLAYER_captain_id = PLAYER.EMPLOYEE_id, 'Y', 'N') as captain,
        PLAYER_STATS.assists as assists,
        PLAYER_STATS.rebounds as rebounds,
        PLAYER_STATS.points as points,
        PLAYER_STATS.fouls as fouls,
        PLAYER_STATS.GAME_date_time as Game_date_time,
        PLAYER_STATS.GAME_home_team as Game_home_team,
        GAME.home_team_score as home_score,
        PLAYER_STATS.GAME_visiting_team as visiting_team,
        GAME.visiting_team_score as visiting_score
        FROM PLAYER_STATS
        inner join PLAYER on PLAYER_STATS.PLAYER_id = PLAYER.EMPLOYEE_id
        inner join TEAM on PLAYER.team = TEAM.name
        inner join GAME on 
			PLAYER_STATS.GAME_date_time = GAME.date_time 
            and PLAYER_STATS.GAME_home_team = GAME.home_team
            and PLAYER_STATS.GAME_visiting_team = GAME.visiting_team;
        
        
       