SELECT 	 name as team,
		(select CONCAT(PERSON.first_name, ' ', PERSON.middle_initial, ' ', PERSON.last_name) from PERSON where PERSON.id = TEAM.PLAYER_captain_id) as coach,
		(select distinct CONCAT(PERSON.first_name, ' ', PERSON.middle_initial, ' ', PERSON.last_name) FROM PERSON where COACH.EMPLOYEE_id = PERSON.id and COACH.team = TEAM.name) as captain,
        TEAM.city as team_city,
        TEAM.state as team_state,
        TEAM.color as team_color,
        (select COUNT(*) from FAN where FAN.favorite_team = TEAM.name) as Fans
        FROM TEAM inner join COACH on COACH.team = TEAM.namePLAYER;
