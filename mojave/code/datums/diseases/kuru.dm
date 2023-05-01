/datum/disease/kuru
	name = "Kuru"
	desc = "A disease that slowly corrodes the brain into uselessness."
	disease_flags = CAN_CARRY
	max_stages = 4
	stage_prob = 3
	spread_text = "Non-contagious"
	spread_flags = NONE
	cure_text = "Incurable"
	form = "Prion"
	agent = "prions"
	viable_mobtypes = list(/mob/living/carbon/human)
	required_organs = list(/obj/item/organ/brain)
	bypasses_immunity = TRUE
	severity = DISEASE_SEVERITY_BIOHAZARD

/datum/disease/kuru/stage_act(delta_time, times_fired) //Removed toxloss because damaging diseases are pretty horrible. Last round it killed the entire station because the cure didn't work -- Urist -ACTUALLY Removed rather than commented out, I don't see it returning - RR
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(SPT_PROB(1, delta_time))
				affected_mob.emote("laugh")
			if(SPT_PROB(3, delta_time))
				affected_mob.adjust_jitter(10 SECONDS)
		if(2)
			if(SPT_PROB(1, delta_time))
				affected_mob.Knockdown(4 SECONDS)
			if(SPT_PROB(2, delta_time))
				affected_mob.emote("laugh")
			if(SPT_PROB(3, delta_time))
				affected_mob.adjust_jitter(10 SECONDS)

			if(SPT_PROB(2, delta_time))
				affected_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1, 150)
		if(3)
			if(SPT_PROB(1, delta_time))
				affected_mob.Unconscious(4 SECONDS)
			if(SPT_PROB(2, delta_time))
				affected_mob.Knockdown(4 SECONDS)
			if(SPT_PROB(2, delta_time))
				affected_mob.emote("laugh")
			if(SPT_PROB(2, delta_time))
				affected_mob.emote("scream")
			if(SPT_PROB(2, delta_time))
				affected_mob.adjust_confusion(10 SECONDS)
			if(SPT_PROB(5, delta_time))
				affected_mob.adjust_jitter(10 SECONDS)
			if(SPT_PROB(7.5, delta_time))
				affected_mob.adjust_stutter(3 SECONDS)

			if(SPT_PROB(3, delta_time))
				affected_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2, 150)
			if(SPT_PROB(1, delta_time))
				affected_mob.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_LOBOTOMY)
		if(4)
			if(SPT_PROB(2, delta_time))
				affected_mob.Unconscious(4 SECONDS)
			if(SPT_PROB(3, delta_time))
				affected_mob.emote("laugh")
			if(SPT_PROB(3, delta_time))
				affected_mob.emote("scream")
			if(SPT_PROB(3, delta_time))
				affected_mob.adjust_confusion(10 SECONDS)
			if(SPT_PROB(4, delta_time))
				affected_mob.Knockdown(4 SECONDS)
			if(SPT_PROB(7.5, delta_time))
				affected_mob.adjust_jitter(10 SECONDS)
			if(SPT_PROB(10, delta_time))
				affected_mob.adjust_stutter(6 SECONDS)

			if(SPT_PROB(5, delta_time))
				affected_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, 3, 150)
			if(SPT_PROB(1, delta_time))
				affected_mob.gain_trauma_type(pick(BRAIN_TRAUMA_MILD, BRAIN_TRAUMA_SEVERE), TRAUMA_RESILIENCE_LOBOTOMY)
