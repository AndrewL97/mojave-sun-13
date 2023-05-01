/*

	Note to future MS13 devs.
	If you need to replace an entire category (i.e underwear)
	in TG's config, set the base class's locked to TRUE to disable everything by default
	and then add your own entries here with Locked set to FALSE

	If you are only toggling some types (like disabling anime hair, etc.)
	Then set the base class's locked to TRUE, and just add the locked=False to the main file
	Otherwise we end up with duplicate type definitions, and it makes it painful to maintain
	especially if TG makes changes in an upstream merge.

	Also be sure to use NEW types, don't just override the old TG types.

	To summarize the changes I made ~May2023:

		TG side (code/**/sprite_accessories.dm)
		Reverted to upstream
		Added the category var + defines
		Set sprite_accessory/hair/locked to TRUE
		Set sprite_accessory/hair types we are using to locked = FALSE, and set the group (hair length)
		set sprite_accessory/underwear/locked = TRUE
		set sprite_accessory/undershirt/locked = TRUE
		set sprite_accessory/socks/locked = TRUE

		MS13 side (mojave/code/**/sprite_accessories.dm)
		Removed the duplicate + modified TG side code
		Defined OUR underwear, undershirt, and socks types, and set locked = FALSE
*/

// Accessory category lists -- I didn't want to pollute the TG init subtypes proc just so we can have a nice mirror UI
// So we fetch + cache them only if we need them
// Uses SPRITE_CATEGORY_ defines

GLOBAL_LIST_EMPTY(ms13_categorized_sprite_accessories)


/proc/get_sprite_category(category)
	RETURN_TYPE(/list)
	LAZYINITLIST(GLOB.ms13_categorized_sprite_accessories[category])
	var/list/catList = GLOB.ms13_categorized_sprite_accessories[category]

	if(catList.len > 0)
		return catList

	var/list/targetList

	switch(category)
		if(SPRITE_CATEGORY_HAIR_BALD, SPRITE_CATEGORY_HAIR_SHORT, SPRITE_CATEGORY_HAIR_MEDIUM, SPRITE_CATEGORY_HAIR_LONG)
			targetList = GLOB.hairstyles_list
		else return list() // unhandled category bro
	for(var/type in targetList)
		var/datum/sprite_accessory/P = type
		if(initial(P.category) == category)
			catList += type
	return catList


///////////////////////////
// Underwear Definitions //
///////////////////////////

//MALE UNDERWEAR
/datum/sprite_accessory/underwear/rag_male
	name = "Rag"
	icon_state = "rag_u_m"
	gender = MALE
	use_static = TRUE
	locked = FALSE

//FEMALE UNDERWEAR

/datum/sprite_accessory/underwear/rag_female
	name = "Ragkini"
	icon_state = "rag_u_f"
	gender = FEMALE
	use_static = TRUE
	locked = FALSE

/datum/sprite_accessory/underwear/bikini
	name = "Bikini"
	icon_state = "bikini"
	gender = FEMALE
	locked = FALSE

/datum/sprite_accessory/underwear/bralette
	name = "Bralette"
	icon_state = "bralette"
	gender = FEMALE
	locked = FALSE

//NEUTRAL UNDERWEAR

/datum/sprite_accessory/underwear/briefs
	name = "Briefs"
	icon_state = "briefs"
	gender = NEUTER
	locked = FALSE

/datum/sprite_accessory/underwear/boxers
	name = "Boxers"
	icon_state = "boxers"
	gender = NEUTER
	locked = FALSE

////////////////////////////
// Undershirt Definitions //
////////////////////////////

/datum/sprite_accessory/undershirt
	icon = 'mojave/icons/mob/clothing/underwear.dmi'
	// locked = FALSE -- keep this locked, as we are just overwriting the icon


// please make sure they're sorted alphabetically and categorized

/datum/sprite_accessory/undershirt/rag
	name = "Rag"
	icon_state = "rag_s"
	gender = NEUTER
	use_static = TRUE
	locked = FALSE

/datum/sprite_accessory/undershirt/shirt
	name = "T-Shirt"
	icon_state = "shirt"
	gender = NEUTER
	use_static = TRUE
	locked = FALSE

/datum/sprite_accessory/undershirt/vest
	name = "Vest"
	icon_state = "vest"
	gender = NEUTER
	use_static = TRUE
	locked = FALSE

///////////////////////
// Socks Definitions //
///////////////////////

// please make sure they're sorted alphabetically and categorized

/datum/sprite_accessory/socks/rag
	name = "Rag"
	icon_state = "rag_so"
	use_static = TRUE

/datum/sprite_accessory/socks/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/socks/long
	name = "Long"
	icon_state = "long"

