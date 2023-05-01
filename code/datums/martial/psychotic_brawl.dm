/datum/martial_art/psychotic_brawling
	name = "Psychotic Brawling"
	id = MARTIALART_PSYCHOBRAWL

/datum/martial_art/psychotic_brawling/disarm_act(mob/living/attacker, mob/living/defender)
	return psycho_attack(attacker, defender)

/datum/martial_art/psychotic_brawling/grab_act(mob/living/attacker, mob/living/defender)
	return psycho_attack(attacker, defender, TRUE)

/datum/martial_art/psychotic_brawling/harm_act(mob/living/attacker, mob/living/defender)
	return psycho_attack(attacker, defender)

// MOJAVE SUN EDIT BEGIN - This is a really dirty edit, but I don't have to time to do anything otherwise for now. This should be reverted and made a seperate 'martial art' later



/datum/martial_art/psychotic_brawling/proc/psycho_attack(mob/living/attacker, mob/living/defender, grab_attack)
	var/atk_verb
	switch(rand(1,5))
		if(1)
			if(attacker.grab_state >= GRAB_AGGRESSIVE)
				defender.grabbedby(attacker, 1)
			else
				attacker.start_pulling(defender, supress_message = TRUE)
				if(attacker.pulling)
					defender.drop_all_held_items()
					defender.stop_pulling()
					if(grab_attack)
						log_combat(attacker, defender, "grabbed", addition="aggressively")
						defender.visible_message(span_warning("[attacker] violently grabs [defender]!"), \
										span_userdanger("You're violently grabbed by [attacker]!"), span_hear("You hear sounds of aggressive fondling!"), null, attacker)
						to_chat(attacker, span_danger("You violently grab [defender]!"))
						attacker.setGrabState(GRAB_AGGRESSIVE) //Instant aggressive grab
					else
						log_combat(attacker, defender, "grabbed", addition="passively")
						attacker.setGrabState(GRAB_PASSIVE)
		if(2, 3)
			attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
			atk_verb = "heavily punch"
			defender.visible_message(span_danger("[attacker] [atk_verb]s [defender]!"), \
							span_userdanger("You're [atk_verb]ed by [attacker]!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), null, attacker)
			to_chat(attacker, span_danger("You [atk_verb] [defender]!"))
			playsound(get_turf(defender), 'sound/weapons/punch1.ogg', 40, TRUE, -1)
			if (iscarbon(defender))
				var/mob/living/carbon/carbon_defender = defender
				if(!istype(carbon_defender.head,/obj/item/clothing/head/helmet/) && !istype(carbon_defender.head,/obj/item/clothing/head/hardhat))
					carbon_defender.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
			defender.Stun(rand(5,10))
		if(4)
			attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
			atk_verb = pick("kick", "hit", "slam")
			defender.visible_message(span_danger("[attacker] [atk_verb]s [defender] with such inhuman strength that it sends [defender.p_them()] flying backwards!"), \
							span_userdanger("You're [atk_verb]ed by [attacker] with such inhuman strength that it sends you flying backwards!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), null, attacker)
			to_chat(attacker, span_danger("You [atk_verb] [defender] with such inhuman strength that it sends [defender.p_them()] flying backwards!"))
			defender.apply_damage(rand(15,30), attacker.get_attack_type())
			playsound(get_turf(defender), 'sound/effects/meteorimpact.ogg', 25, TRUE, -1)
			var/throwtarget = get_edge_target_turf(attacker, get_dir(attacker, get_step_away(defender, attacker)))
			defender.throw_at(throwtarget, 2, 2, attacker)//So stuff gets tossed around at the same time.
			defender.Paralyze(10)
		if(5)
			return FALSE //Resume default behaviour

	if(atk_verb)
		log_combat(attacker, defender, "[atk_verb] (Psychotic Brawling)")
	return TRUE


/*
/datum/martial_art/psychotic_brawling/proc/psycho_attack(mob/living/attacker, mob/living/defender, grab_attack)
	var/atk_verb
	switch(rand(1,8))
		if(1)
			if(iscarbon(defender) && iscarbon(attacker))
				var/mob/living/carbon/carbon_defender = defender
				carbon_defender.help_shake_act(attacker)
			atk_verb = "helped"
		if(2)
			attacker.emote("cry")
			attacker.Stun(2 SECONDS)
			atk_verb = "cried looking at"
		if(3)
			if(attacker.grab_state >= GRAB_AGGRESSIVE)
				defender.grabbedby(attacker, 1)
			else
				attacker.start_pulling(defender, supress_message = TRUE)
				if(attacker.pulling)
					defender.drop_all_held_items()
					defender.stop_pulling()
					if(grab_attack)
						log_combat(attacker, defender, "grabbed", addition="aggressively")
						defender.visible_message(span_warning("[attacker] violently grabs [defender]!"), \
										span_userdanger("You're violently grabbed by [attacker]!"), span_hear("You hear sounds of aggressive fondling!"), null, attacker)
						to_chat(attacker, span_danger("You violently grab [defender]!"))
						attacker.setGrabState(GRAB_AGGRESSIVE) //Instant aggressive grab
					else
						log_combat(attacker, defender, "grabbed", addition="passively")
						attacker.setGrabState(GRAB_PASSIVE)
		if(4)
			attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
			atk_verb = "headbutt"
			defender.visible_message(span_danger("[attacker] [atk_verb]s [defender]!"), \
							span_userdanger("You're [atk_verb]ed by [attacker]!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), null, attacker)
			to_chat(attacker, span_danger("You [atk_verb] [defender]!"))
			playsound(get_turf(defender), 'sound/weapons/punch1.ogg', 40, TRUE, -1)
			defender.apply_damage(rand(5,10), attacker.get_attack_type(), BODY_ZONE_HEAD)
			attacker.apply_damage(rand(5,10), attacker.get_attack_type(), BODY_ZONE_HEAD)
			if(iscarbon(defender))
				var/mob/living/carbon/carbon_defender = defender
				if(!istype(carbon_defender.head, /obj/item/clothing/head/helmet/) && !istype(carbon_defender.head, /obj/item/clothing/head/utility/hardhat))
					carbon_defender.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5)
			attacker.Stun(rand(1 SECONDS, 4.5 SECONDS))
			defender.Stun(rand(0.5 SECONDS, 3 SECONDS))
		if(5,6)
			attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
			atk_verb = pick("kick", "hit", "slam")
			defender.visible_message(span_danger("[attacker] [atk_verb]s [defender] with such inhuman strength that it sends [defender.p_them()] flying backwards!"), \
							span_userdanger("You're [atk_verb]ed by [attacker] with such inhuman strength that it sends you flying backwards!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), null, attacker)
			to_chat(attacker, span_danger("You [atk_verb] [defender] with such inhuman strength that it sends [defender.p_them()] flying backwards!"))
			defender.apply_damage(rand(15,30), attacker.get_attack_type())
			playsound(get_turf(defender), 'sound/effects/meteorimpact.ogg', 25, TRUE, -1)
			var/throwtarget = get_edge_target_turf(attacker, get_dir(attacker, get_step_away(defender, attacker)))
			defender.throw_at(throwtarget, 4, 2, attacker)//So stuff gets tossed around at the same time.
			defender.Paralyze(6 SECONDS)
		if(7,8)
			return FALSE //Resume default behaviour

	if(atk_verb)
		log_combat(attacker, defender, "[atk_verb] (Psychotic Brawling)")
	return TRUE*/

// MOJAVE SUN EDIT END
