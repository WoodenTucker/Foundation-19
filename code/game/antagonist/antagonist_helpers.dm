/datum/antagonist/proc/can_become_antag(datum/mind/player, ignore_role)

	if(player.current)
		if(jobban_isbanned(player.current, id))
			return FALSE
		if(player.current.faction != MOB_FACTION_NEUTRAL)
			return FALSE

	if(is_type_in_list(player.assigned_job, blacklisted_jobs))
		return FALSE

	if(!isnull(whitelisted_jobs) && !is_type_in_list(player.assigned_job, whitelisted_jobs))
		return FALSE

	if(!ignore_role)
		if(player.current && player.current.client)
			var/client/C = player.current.client
			// Limits antag status to clients above player age, if the age system is being used.
			if(C && config.use_age_restriction_for_jobs && isnum(C.player_age) && isnum(min_player_age) && (C.player_age < min_player_age))
				return FALSE
		if(player.current && (player.current.status_flags & NO_ANTAG))
			return FALSE
	return TRUE

/datum/antagonist/proc/antags_are_dead()
	for(var/datum/mind/antag in current_antagonists)
		if(mob_path && !istype(antag.current,mob_path))
			continue
		if(antag.current.stat==2)
			continue
		return 0
	return 1

/datum/antagonist/proc/get_antag_count()
	return current_antagonists ? current_antagonists.len : 0

/datum/antagonist/proc/get_active_antag_count()
	var/active_antags = 0
	for(var/datum/mind/player in current_antagonists)
		var/mob/living/L = player.current
		if(!L || L.stat == DEAD)
			continue //no mob or dead
		if(!L.client && !L.teleop)
			continue //SSD
		active_antags++
	return active_antags

/datum/antagonist/proc/is_antagonist(datum/mind/player)
	if(player in current_antagonists)
		return 1

/datum/antagonist/proc/is_type(antag_type)
	if(antag_type == id || antag_type == role_text)
		return 1
	return 0

/datum/antagonist/proc/is_votable()
	return (flags & ANTAG_VOTABLE)

/datum/antagonist/proc/can_late_spawn()
	if(!SSticker.mode)
		return 0
	if(!(id in SSticker.mode.latejoin_antag_tags))
		return 0
	return 1

/datum/antagonist/proc/is_latejoin_template()
	return (flags & (ANTAG_OVERRIDE_MOB|ANTAG_OVERRIDE_JOB))

/proc/all_random_antag_types()
	// No caching as the ANTAG_RANDOM_EXCEPTED flag can be added/removed mid-round.
	var/list/antag_candidates = GLOB.all_antag_types_.Copy()
	for(var/datum/antagonist/antag in antag_candidates)
		if(antag.flags & ANTAG_RANDOM_EXCEPTED)
			antag_candidates -= antag
	return antag_candidates
