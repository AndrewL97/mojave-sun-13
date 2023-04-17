
/mob/living/proc/get_bodypart(zone)
	return

/mob/living/carbon/get_bodypart(zone)
	RETURN_TYPE(/obj/item/bodypart)

	if(!zone)
		zone = BODY_ZONE_CHEST
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		if(bodypart.body_zone == zone)
			return bodypart

///Replaces a single limb and deletes the old one if there was one
/mob/living/carbon/proc/del_and_replace_bodypart(obj/item/bodypart/new_limb, special)
	var/obj/item/bodypart/old_limb = get_bodypart(new_limb.body_zone)
	if(old_limb)
		qdel(old_limb)
	new_limb.try_attach_limb(src, special = special)

/mob/living/carbon/has_hand_for_held_index(i)
	if(!i)
		return FALSE
	var/obj/item/bodypart/hand_instance = hand_bodyparts[i]
	if(hand_instance && !hand_instance.bodypart_disabled)
		return hand_instance
	return FALSE


///Get the bodypart for whatever hand we have active, Only relevant for carbons
/mob/proc/get_active_hand()
	return FALSE

/mob/living/carbon/get_active_hand()
	var/which_hand = BODY_ZONE_PRECISE_L_HAND
	if(!(active_hand_index % 2))
		which_hand = BODY_ZONE_PRECISE_R_HAND
	return get_bodypart(check_zone(which_hand))


/mob/proc/has_left_hand(check_disabled = TRUE)
	return TRUE


/mob/living/carbon/has_left_hand(check_disabled = TRUE)
	for(var/obj/item/bodypart/hand_instance in hand_bodyparts)
		if(!(hand_instance.held_index % 2) || (check_disabled && hand_instance.bodypart_disabled))
			continue
		return TRUE
	return FALSE


/mob/living/carbon/alien/larva/has_left_hand()
	return TRUE


/mob/proc/has_right_hand(check_disabled = TRUE)
	return TRUE


/mob/living/carbon/has_right_hand(check_disabled = TRUE)
	for(var/obj/item/bodypart/hand_instance in hand_bodyparts)
		if(hand_instance.held_index % 2 || (check_disabled && hand_instance.bodypart_disabled))
			continue
		return TRUE
	return FALSE


/mob/living/carbon/alien/larva/has_right_hand()
	return TRUE


/mob/living/proc/get_missing_limbs()
	return list()

/mob/living/carbon/get_missing_limbs()
	RETURN_TYPE(/list)
	var/list/full = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
	for(var/zone in full)
		if(get_bodypart(zone))
			full -= zone
	return full

/mob/living/carbon/alien/larva/get_missing_limbs()
	var/list/full = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST)
	for(var/zone in full)
		if(get_bodypart(zone))
			full -= zone
	return full

/mob/living/proc/get_disabled_limbs()
	return list()

/mob/living/carbon/get_disabled_limbs()
	var/list/full = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
	var/list/disabled = list()
	for(var/zone in full)
		var/obj/item/bodypart/affecting = get_bodypart(zone)
		if(affecting?.bodypart_disabled)
			disabled += zone
	return disabled

/mob/living/carbon/alien/larva/get_disabled_limbs()
	var/list/full = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST)
	var/list/disabled = list()
	for(var/zone in full)
		var/obj/item/bodypart/affecting = get_bodypart(zone)
		if(affecting?.bodypart_disabled)
			disabled += zone
	return disabled

///Remove a specific embedded item from the carbon mob
/mob/living/carbon/proc/remove_embedded_object(obj/item/embedded)
	SEND_SIGNAL(src, COMSIG_CARBON_EMBED_REMOVAL, embedded)

///Remove all embedded objects from all limbs on the carbon mob
/mob/living/carbon/proc/remove_all_embedded_objects()
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		for(var/obj/item/embedded in bodypart.embedded_objects)
			remove_embedded_object(embedded)

/mob/living/carbon/proc/has_embedded_objects(include_harmless=FALSE)
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		for(var/obj/item/embedded in bodypart.embedded_objects)
			if(!include_harmless && embedded.isEmbedHarmless())
				continue
			return TRUE

//Helper for quickly creating a new limb - used by augment code in species.dm spec_attacked_by
//
// FUCK YOU AUGMENT CODE - With love, Kapu
/mob/living/carbon/proc/newBodyPart(zone)
	var/path = dna.species.bodypart_overrides[zone]
	var/obj/item/bodypart/new_bodypart = new path()
	return new_bodypart

/mob/living/carbon/alien/larva/newBodyPart(zone)
	var/obj/item/bodypart/new_bodypart
	switch(zone)
		if(BODY_ZONE_HEAD)
			new_bodypart = new /obj/item/bodypart/head/larva()
		if(BODY_ZONE_CHEST)
			new_bodypart = new /obj/item/bodypart/chest/larva()
	. = new_bodypart

/mob/living/carbon/alien/humanoid/newBodyPart(zone)
	var/obj/item/bodypart/new_bodypart
	switch(zone)
		if(BODY_ZONE_L_ARM)
			new_bodypart = new /obj/item/bodypart/l_arm/alien()
		if(BODY_ZONE_R_ARM)
			new_bodypart = new /obj/item/bodypart/r_arm/alien()
		if(BODY_ZONE_HEAD)
			new_bodypart = new /obj/item/bodypart/head/alien()
		if(BODY_ZONE_L_LEG)
			new_bodypart = new /obj/item/bodypart/l_leg/alien()
		if(BODY_ZONE_R_LEG)
			new_bodypart = new /obj/item/bodypart/r_leg/alien()
		if(BODY_ZONE_CHEST)
			new_bodypart = new /obj/item/bodypart/chest/alien()
	if(new_bodypart)
		new_bodypart.update_limb(src)



/proc/skintone2hex(skin_tone)
	. = 0
	//MOJAVE SUN EDIT START - Skin Colours
	switch(skin_tone)
		if("arab")
			. = "#cc926a"
		if("asian1")
			. = "#e1c898"
		if("asian2")
			. = "#c8b088"
		if("african1")
			. = "#78544f"
		if("african2")
			. = "#4c3735"
		if("albino")
			. = "#ffe0d1"
		if("caucasian1")
			. = "#fcccb3"
		if("caucasian2")
			. = "#ffc19e"
		if("caucasian3")
			. = "#edb198"
		if("indian")
			. = "#915e4c"
		if("latino")
			. = "#cc9e6c"
		if("mediterranean")
			. = "#ddb47b"
		if("orange")
			. = "#ffc905"
	//MOJAVE SUN EDIT END - Skin Colours
