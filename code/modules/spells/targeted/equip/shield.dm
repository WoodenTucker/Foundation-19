/datum/spell/targeted/equip_item/shield
	name = "Summon Shield"
	desc = "Summons the most holy of shields, the riot shield. Commonly used during wizard riots."
	invocation = "Sia helda!"
	invocation_type = INVOKE_SHOUT
	spell_flags = INCLUDEUSER | NEEDSCLOTHES
	range = -1
	max_targets = 1

	compatible_mobs = list(/mob/living/carbon/human)

	level_max = list(UPGRADE_TOTAL = 3, UPGRADE_SPEED = 2, UPGRADE_POWER = 1)
	charge_type = SPELL_RECHARGE
	charge_max = 900
	cooldown_min = 300
	equipped_summons = list("off hand" = /obj/item/shield/)
	duration = 300
	delete_old = 0
	var/item_color = "#6666ff"
	var/block_chance = 30

	hud_state = "wiz_shield"

/datum/spell/targeted/equip_item/shield/summon_item(new_type)
	var/obj/item/shield/I = new new_type()
	I.icon_state = "buckler"
	I.color = item_color
	I.SetName("Wizard's Shield")
	I.base_block_chance = block_chance
	return I

/datum/spell/targeted/equip_item/shield/ImproveSpellPower()
	if(!..())
		return 0

	item_color = "#6600ff"
	block_chance = 60

	return "Your summoned shields will now block more often."
