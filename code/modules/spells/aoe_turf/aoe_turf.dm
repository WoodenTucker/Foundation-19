/*
Aoe turf spells target a ring of tiles around the user
This ring has an outer radius (range) and an inner radius (inner_radius)
Aoe turf spells have two useful flags: IGNOREDENSE and IGNORESPACE. These are explained in setup.dm
*/

/datum/spell/aoe_turf //affects all turfs in view or range (depends)
	spell_flags = IGNOREDENSE
	var/inner_radius = -1 //for all your ring spell needs

/datum/spell/aoe_turf/choose_targets(mob/user = usr)
	var/list/targets = list()

	for(var/turf/target in view_or_range(range, holder, selection_type))
		if(!(target in view_or_range(inner_radius, holder, selection_type)))
			if(target.density && (spell_flags & IGNOREDENSE))
				continue
			if(isspaceturf(target) && (spell_flags & IGNORESPACE))
				continue
			targets += target

	if(!targets.len) //doesn't waste the spell
		return

	perform(user, targets)
