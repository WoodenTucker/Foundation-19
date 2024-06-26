/obj/item/psychic_power/tinker
	name = "psychokinetic crowbar"
	icon_state = "tinker"
	force = 1
	var/emulating = "Crowbar"

/obj/item/psychic_power/tinker/iscrowbar()
	return emulating == "Crowbar"

/obj/item/psychic_power/tinker/iswrench()
	return emulating == "Wrench"

/obj/item/psychic_power/tinker/isscrewdriver()
	return emulating == "Screwdriver"

/obj/item/psychic_power/tinker/iswirecutter()
	return emulating == "Wirecutters"

/obj/item/psychic_power/tinker/ismultitool()
	return emulating == "Multitool"

/obj/item/psychic_power/tinker/attack_self()

	if(!owner || loc != owner)
		return

	var/choice = input("Select a tool to emulate.","Power") as null|anything in list("Crowbar","Wrench","Screwdriver","Wirecutters","Multitool","Dismiss")
	if(!choice)
		return

	if(!owner || loc != owner)
		return

	if(choice == "Dismiss")
		owner.drop_from_inventory(src)
		return

	emulating = choice
	name = "psychokinetic [lowertext(emulating)]"
	to_chat(owner, SPAN_NOTICE("You begin emulating \a [lowertext(emulating)]."))
	sound_to(owner, 'sounds/effects/psi/power_fabrication.ogg')
