// Obligatory basetype //

/datum/addiction/ms13
	name = "base type MS13 crack addiction"
	withdrawal_stage_messages = list("", "", "")
	///Higher threshold, when you start being addicted. Should be high so that it's hard to shrug off addictions.
	addiction_gain_threshold = 950
	///Lower threshold, when you stop being addicted
	addiction_loss_threshold = 50
	///Rates at which you lose addiction (in units/second) if you are not on the drug at that time per stage
	addiction_loss_per_stage = list(0.5, 0.5, 1, 1)

// Jet //

/datum/addiction/ms13/jet
	name = "jet"
	withdrawal_stage_messages = list("", "", "")

/datum/addiction/jet/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_red("[pick("Need some jet man...", "It's a good time for some jet.")]"))

/datum/addiction/ms13/jet/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.adjust_dizzy(5 SECONDS)
	if(prob(5))
		affected_carbon.emote("groan")

/datum/addiction/jet/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_red("[pick("Could really use some jet right now.", "Come on... Let's go get some jet.")]"))

/datum/addiction/ms13/jet/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_disgust(25)
	affected_carbon.adjust_dizzy(10 SECONDS)
	if(prob(15))
		affected_carbon.emote(pick("groan", "moan"))

/datum/addiction/jet/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_red("[pick("I really need some jet- NOW!", "I'm FALLING APART!")]"))

/datum/addiction/ms13/jet/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	if(!HAS_TRAIT(affected_carbon, TRAIT_IMMOBILIZED) && !isspaceturf(M.loc) && isturf(M.loc))
		step(affected_carbon, pick(GLOB.cardinals))
	affected_carbon.set_disgust(45)
	affected_carbon.adjust_dizzy(15 SECONDS)
	if(prob(25))
		affected_carbon.emote(pick("drool", "groan"))

// Rocket //

/datum/addiction/ms13/rocket
	name = "rocket"
	withdrawal_stage_messages = list("", "", "")

/datum/addiction/rocket/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_red("[pick("Need some rocket man...", "It's a good time for some rocket.")]"))

/datum/addiction/ms13/rocket/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_disgust(25)
	affected_carbon.adjust_dizzy(5 SECONDS)
	if(prob(30))
		affected_carbon.emote("groan")

/datum/addiction/rocket/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_red("[pick("Could really use some rocket right now.", "Come on... Let's go get some rocket.")]"))

/datum/addiction/ms13/rocket/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_disgust(60)
	affected_carbon.adjust_dizzy(10 SECONDS)
	if(prob(40))
		affected_carbon.emote(pick("groan", "moan"))

/datum/addiction/rocket/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_red("[pick("I really need some rocket- NOW!", "I'm FALLING APART!")]"))

/datum/addiction/ms13/rocket/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	if(!HAS_TRAIT(affected_carbon, TRAIT_IMMOBILIZED) && !isspaceturf(M.loc) && isturf(M.loc))
		step(affected_carbon, pick(GLOB.cardinals))
	affected_carbon.set_disgust(100)
	affected_carbon.adjust_dizzy(25 SECONDS)
	if(prob(50))
		affected_carbon.emote(pick("drool", "groan"))
// Turbo //

/datum/addiction/ms13/turbo
	name = "turbo"
	withdrawal_stage_messages = list("", "", "")

/datum/addiction/turbo/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_red("[pick("Going any faster just seems so impossible...", "I don't think I can maintain speed without turbo...")]"))
	if(M.has_movespeed_modifier(/datum/movespeed_modifier/reagent/ms13/turbo_slow)) // Stacking this could break stuff.
		affected_carbon.add_movespeed_modifier(/datum/movespeed_modifier/reagent/ms13/turbo_slow) // Don't do drugs, kids. Dependencies are real.

/datum/addiction/ms13/turbo/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.adjust_dizzy(5 SECONDS)
	if(prob(5))
		affected_carbon.emote("groan")

/datum/addiction/turbo/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_red("[pick("Really need a speedup right about now.", "I should go get some Turbo. Then I can be fast again.")]"))

/datum/addiction/ms13/jet/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.adjust_dizzy(10 SECONDS)
	if(prob(15))
		affected_carbon.emote(pick("groan", "moan"))

/datum/addiction/turbo/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_red("[pick("I really gotta go fast.", "I want to go NOW!")]"))

/datum/addiction/ms13/turbo/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	if(!HAS_TRAIT(affected_carbon, TRAIT_IMMOBILIZED) && !isspaceturf(M.loc) && isturf(M.loc))
		step(affected_carbon, pick(GLOB.cardinals))
	affected_carbon.adjust_dizzy(15 SECONDS)
	if(prob(25))
		affected_carbon.emote(pick("drool", "groan"))

// Mentats //

/datum/addiction/ms13/mentats
	name = "mentats"
	withdrawal_stage_messages = list("", "", "")

/datum/addiction/mentats/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_notice("[pick("Your head strains slightly", "You begin to feel unwell.")]"))

/datum/addiction/ms13/mentats/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_jitter_if_lower(3 SECONDS * seconds_per_tick)
	affected_carbon.adjust_dizzy(5 SECONDS)
	if(prob(20))
		to_chat(affected_carbon, span_warning("[pick("Your head hurts.", "Your head pounds.")]"))

/datum/addiction/mentats/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_notice("[pick("Your head strains heavily", "You begin to feel very headsick.")]"))

/datum/addiction/ms13/mentats/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_jitter_if_lower(5 SECONDS * seconds_per_tick)
	affected_carbon.adjust_dizzy(10 SECONDS)
	if(prob(20))
		affected_carbon.adjustStaminaLoss(25)
		to_chat(affected_carbon, span_warning("[pick("Your head hurts a lot.", "Your head pounds incessantly.")]"))

/datum/addiction/mentats/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_notice("[pick("Your head pounds in anguish", "You sulk in pain as your head constricts and expands.")]"))

/datum/addiction/ms13/mentats/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(1,3))
	affected_carbon.set_jitter_if_lower(5 SECONDS * seconds_per_tick)
	affected_carbon.adjust_dizzy(10 SECONDS)
	if(prob(20))
		affected_carbon.Stun(35)
		to_chat(affected_carbon, span_userdanger("[pick("Your head hurts!", "You feel a burning knife inside your brain!", "A wave of pain fills your head!")]"))

// Psycho //

/datum/addiction/ms13/psycho
	name = "psycho"
	withdrawal_stage_messages = list("", "", "")

/datum/addiction/ms13/psycho/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_warning("Your eye twitches slightly."))

/datum/addiction/ms13/psycho/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_jitter_if_lower(5 SECONDS * seconds_per_tick)
	if(prob(20))
		to_chat(affected_carbon, span_warning("You feel angry, and you don't know why..."))

/datum/addiction/ms13/psycho/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_warning("You feel like something changed- But you can't figure out what. This angers you!"))

/datum/addiction/ms13/psycho/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_jitter_if_lower(10 SECONDS * seconds_per_tick)
	affected_carbon.adjust_dizzy(10 SECONDS)
	if(prob(20))
		to_chat(affected_carbon, span_warning("[pick("You are filled with anger.", "Is the room spinning...? This is PISSING YOU OFF!", "You REALLY want to PUNCH someone right now.")]"))

/datum/addiction/ms13/psycho/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_boldwarning("Everything is just- Wrong! What the HELL IS GOING ON?"))

/datum/addiction/ms13/psycho/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.25)
	affected_carbon.set_jitter_if_lower(5 SECONDS * seconds_per_tick)
	affected_carbon.adjust_dizzy(10 SECONDS)
	if(prob(20))
		to_chat(affected_carbon, span_warning("[pick("Your head burns... Your heart aches... You are FURIOUS!", "You feel a sickening nausea run over you- You're filled with RAGE!", "Why is EVERYONE so adamant on PISSING YOU OFF at a time like this?!")]"))

// Overdrive //

/datum/addiction/ms13/overdrive
	name = "overdrive"
	withdrawal_stage_messages = list("", "", "")

/datum/addiction/ms13/overdrive/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_warning("Your eye twitches slightly."))

/datum/addiction/ms13/overdrive/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_jitter_if_lower(15 SECONDS * seconds_per_tick)
	if(prob(20))
		to_chat(affected_carbon, span_warning("You begin to shake in fury."))

/datum/addiction/ms13/overdrive/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_warning("You begin to shake with fury."))

/datum/addiction/ms13/overdrive/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.set_jitter_if_lower(25 SECONDS * seconds_per_tick)
	affected_carbon.adjust_dizzy(10 SECONDS)
	if(prob(20))
		to_chat(affected_carbon, span_warning("[pick("You have trouble thinking clearly through your rage", "You're REALLY pissed off right now.")]"))


/datum/addiction/ms13/overdrive/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	to_chat(affected_carbon, span_boldwarning("You're so mad- You could just KILL someone!"))

/datum/addiction/ms13/overdrive/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1)
	affected_carbon.set_jitter_if_lower(45 SECONDS * seconds_per_tick)
	affected_carbon.adjust_dizzy(10 SECONDS)
	affected_carbon.adjustStaminaLoss(2.5)
	if(prob(20))
		to_chat(affected_carbon, span_warning("[pick("You feel so tired- and it's REALLY pissing you off!", "Your arms ache heavily.", "Your whole body throbs with fatigue.")]"))

// Day Tripper //

/datum/addiction/ms13/daytripper
	name = "day tripper"
	withdrawal_stage_messages = list("", "", "")

/datum/addiction/ms13/daytripper/withdrawal_stage_1_process(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.hallucination += 20
	if(!HAS_TRAIT(affected_carbon, TRAIT_IMMOBILIZED) && !isspaceturf(M.loc) && isturf(M.loc))
		step(affected_carbon, pick(GLOB.cardinals))
	affected_carbon.set_jitter_if_lower(10 SECONDS * seconds_per_tick)
	affected_carbon.adjust_dizzy(10 SECONDS)
	affected_carbon.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
	if(prob(30))
		affected_carbon.emote(pick("twitch","drool","moan"))

/datum/addiction/ms13/daytripper/withdrawal_stage_2_process(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.hallucination += 30
	if(!HAS_TRAIT(affected_carbon, TRAIT_IMMOBILIZED) && !isspaceturf(M.loc) && isturf(M.loc))
		step(affected_carbon, pick(GLOB.cardinals))
	affected_carbon.set_jitter_if_lower(15 SECONDS * seconds_per_tick)
	affected_carbon.adjust_dizzy(15 SECONDS)
	affected_carbon.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
	if(prob(40))
		affected_carbon.emote(pick("twitch","drool","moan"))

/datum/addiction/ms13/daytripper/withdrawal_stage_3_process(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.hallucination += 30
	if(!HAS_TRAIT(affected_carbon, TRAIT_IMMOBILIZED) && !isspaceturf(M.loc) && isturf(M.loc))
		step(affected_carbon, pick(GLOB.cardinals))
	affected_carbon.set_jitter_if_lower(50 SECONDS * seconds_per_tick)
	affected_carbon.adjust_dizzy(50 SECONDS)
	affected_carbon.adjustToxLoss(5, 0)
	affected_carbon.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
	if(prob(50))
		affected_carbon.emote(pick("twitch","drool","moan"))
