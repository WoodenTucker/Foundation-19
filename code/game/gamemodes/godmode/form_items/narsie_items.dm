
//SACRIFICE DAGGER
//If used on a person on an altar, causes the user to carve into them, dealing moderate damage and gaining points for the altar's god.
/obj/item/weapon/material/knife/ritual/sacrifice
	name = "sacrificial dagger"
	desc = "This knife is dull but well used."
	default_material = "cult"

/obj/item/weapon/material/knife/ritual/sacrifice/resolve_attackby(atom/a, mob/user, click_params)
	var/turf/T = get_turf(a)
	var/obj/structure/deity/altar/altar = locate() in T
	if(!altar)
		return ..()
	if(isliving(a))
		var/mob/living/L = a
		var/multiplier = 1
		if(L.mind)
			multiplier++
		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			if(H.should_have_organ(BP_HEART))
				multiplier++
		if(L.stat == DEAD)
			to_chat(user, SPAN_WARNING("\The [a] is already dead! There is nothing to take!"))
			return

		user.visible_message(SPAN_WARNING("\The [user] hovers \the [src] over \the [a], whispering an incantation."))
		if(!do_after(user,200, L))
			return
		user.visible_message(SPAN_DANGER("\The [user] plunges the knife down into \the [a]!"))
		L.adjustBruteLoss(20)
		if(altar.linked_god)
			altar.linked_god.adjust_power(2 * multiplier,0,"from a delicious sacrifice!")


//EXEC AXE
//If a person hit by this axe within three seconds dies, sucks in their soul to be harvested at altars.
/obj/item/weapon/material/twohanded/fireaxe/cult
	name = "terrible axe"
	desc = "Its head is sharp and stained red with heavy use."
	icon_state = "bone_axe0"
	base_icon = "bone_axe"
	var/stored_power = 0

/obj/item/weapon/material/twohanded/fireaxe/cult/examine(mob/user)
	. = ..()
	if(. && stored_power)
		to_chat(user, SPAN_NOTICE("It exudes a death-like smell."))

/obj/item/weapon/material/twohanded/fireaxe/cult/resolve_attackby(atom/a, mob/user, click_params)
	if(istype(a, /obj/structure/deity/altar))
		var/obj/structure/deity/altar/altar = a
		if(stored_power && altar.linked_god)
			altar.linked_god.adjust_power(stored_power, "from harvested souls.")
			altar.visible_message(SPAN_WARNING("\The [altar] absorbs a black mist exuded from \the [src]."))
			return
	if(ismob(a))
		var/mob/M = a
		if(M.stat != DEAD)
			RegisterSignal(M, COMSIG_ADD_TO_DEAD_MOB_LIST, TYPE_PROC_REF(/obj/item/weapon/material/twohanded/fireaxe/cult, gain_power))
		spawn(30)
			UnregisterSignal(M, COMSIG_ADD_TO_DEAD_MOB_LIST)
	return ..()

/obj/item/weapon/material/twohanded/fireaxe/cult/proc/gain_power()
	stored_power += 50
	src.visible_message(SPAN_OCCULT("\The [src] screeches as the smell of death fills the air!"))

/obj/item/weapon/reagent_containers/food/drinks/zombiedrink
	name = "well-used urn"
	desc = "Said to bring those who drink it back to life, no matter the price."
	icon = 'icons/obj/xenoarchaeology.dmi'
	icon_state = "urn"
	volume = 120
	amount_per_transfer_from_this = 30

/obj/item/weapon/reagent_containers/food/drinks/zombiedrink/New()
	..()
	reagents.add_reagent(/datum/reagent/toxin/corrupting,120)
