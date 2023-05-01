// When You Code It //

/datum/reagent/consumable/ms13/water // When you code it
	name = "water"
	description = "Water. The base of all life. Don't run out."
	color = "#f1eeeca1"
	quality = DRINK_VERYGOOD
	taste_description = "water"

/datum/glass_style/drinking_glass/ms13/water // When you code it
	required_drink_type = /datum/reagent/consumable/ms13/water // When you code it
	name = "water"
	desc = "A clear liquid with no smell. Nothing out of the ordinary."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'

	var/clean_types = CLEAN_WASH

/datum/reagent/consumable/ms13/water/expose_turf(turf/open/exposed_turf, reac_volume) // easiest paste of my life
	. = ..()
	if(!istype(exposed_turf))
		return

	if(reac_volume >= 5)
		exposed_turf.MakeSlippery(TURF_WET_WATER, 10 SECONDS, min(reac_volume*1.5 SECONDS, 60 SECONDS))
	exposed_turf.wash(clean_types)

	for(var/mob/living/simple_animal/slime/exposed_slime in exposed_turf)
		exposed_slime.apply_water()

	var/obj/effect/hotspot/hotspot = (locate(/obj/effect/hotspot) in exposed_turf)
	if(hotspot && !isspaceturf(exposed_turf))
		if(exposed_turf.air)
			var/datum/gas_mixture/air = exposed_turf.air
			air.react(src)
			qdel(hotspot)

/datum/reagent/consumable/ms13/water/unfiltered
	name = "Unfiltered Water"
	description = "Water... Questionable water. Should run it through some filtering or something."
	color = "#d8d3cfa1"
	taste_description = "water with an off taste"

/datum/glass_style/drinking_glass/ms13/water/unfiltered
	required_drink_type = /datum/reagent/consumable/ms13/water/unfiltered
	name = "Unfiltered Water"
	desc = "A clear liquid with some stray particles seen floating around peacefully inside."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/water/dirty
	name = "Dirty Water"
	description = "An ubiquitous chemical substance that is composed of hydrogen and oxygen, this one is impure and toxic to drink."
	color = "#4439288c"
	taste_description = "vile water"

/datum/glass_style/drinking_glass/ms13/water/dirty
	required_drink_type = /datum/reagent/consumable/ms13/water/dirty
	name = "Dirty Water"
	desc = "A murky green liquid with a pungeant vile smell. Not so sure about this one."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/dirty_water/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjust_disgust(10)
	if(prob(50))
		M.adjustToxLoss(5)

	if(prob(10))
		M.vomit(lost_nutrition = 25, distance = 1, purge_ratio = 0.2)
	return ..()

//// E for Everyone drinks - Soda/Beverages ////

/datum/reagent/consumable/ms13/nuka_cola
	name = "Nuka-Cola"
	description = "Zap that thirst!"
	color = "#413022"
	quality = DRINK_VERYGOOD
	taste_description = "soda"

/datum/glass_style/drinking_glass/ms13/nuka_cola
	required_drink_type = /datum/reagent/consumable/ms13/nuka_cola
	name = "Nuka-Cola"
	desc = "A dark fizzy liquid with a slighty sweet smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_diet
	name = "Nuka-Diet"
	description = "Zap that thirst! Now with no sugar."
	color = "#413022"
	quality = DRINK_GOOD
	taste_description = "strange soda"

/datum/glass_style/drinking_glass/ms13/nuka_diet
	required_drink_type = /datum/reagent/consumable/ms13/nuka_diet
	name = "Nuka-Diet"
	desc = "A dark fizzy liquid with a slighty off sweet smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_diet/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(prob(5))
		M.adjustBruteLoss(0.5) //aspartame is bad for your bones. Shoulda just drank water.

/datum/reagent/consumable/ms13/nuka_cherry
	name = "Nuka-Cherry"
	description = "Classic Nuka with a cherry twist!"
	color = "#790604"
	quality = DRINK_VERYGOOD
	taste_description = "sweet fruity soda"

/datum/glass_style/drinking_glass/ms13/nuka_cherry
	required_drink_type = /datum/reagent/consumable/ms13/nuka_cherry
	name = "Nuka-Cherry"
	desc = "A dark red fizzy liquid with a slighty sweet and fruity smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_grape
	name = "Nuka-Grape"
	description = "Nuka cola! Tastes grape."
	color = "#60145C"
	quality = DRINK_VERYGOOD
	taste_description = "sweet grape soda"

/datum/glass_style/drinking_glass/ms13/nuka_grape
	required_drink_type = /datum/reagent/consumable/ms13/nuka_grape
	name = "Nuka-Grape"
	desc = "A purple fizzy liquid with a slighty sweet smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_orange
	name = "Nuka-Orange"
	description = "Orange you glad you've got Nuka?"
	color = "#FC8102"
	quality = DRINK_VERYGOOD
	taste_description = "fruity acidic soda"

/datum/glass_style/drinking_glass/ms13/nuka_orange
	required_drink_type = /datum/reagent/consumable/ms13/nuka_orange
	name = "Nuka-Orange"
	desc = "A orange fizzy liquid with a slighty sweet smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_cranberry
	name = "Nuka-Cranberry"
	description = "Fizzy Nuka, now in cranberry!"
	color = "#950714"
	quality = DRINK_VERYGOOD
	taste_description = "bitter fruit soda"

/datum/glass_style/drinking_glass/ms13/nuka_cranberry
	required_drink_type = /datum/reagent/consumable/ms13/nuka_cranberry
	name = "Nuka-Cranberry"
	desc = "A red fizzy liquid with a bittersweet smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_lemon
	name = "Nuka-Lemon"
	description = "All the zip of Nuka-Cola, with all the refreshing zing of lemon."
	color = "#cec32d"
	quality = DRINK_VERYGOOD
	taste_description = "sour and sweet fruity soda"

/datum/glass_style/drinking_glass/ms13/nuka_lemon
	required_drink_type = /datum/reagent/consumable/ms13/nuka_lemon
	name = "Nuka-Lemon"
	desc = "A clear yellow fizzy liquid with a slighty sweet smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_lime
	name = "Nuka-Lime"
	description = "Classic Nuka with a lime twist!"
	color = "#98b432"
	quality = DRINK_VERYGOOD
	taste_description = "sour and bitter fruity soda"

/datum/glass_style/drinking_glass/ms13/nuka_lime
	required_drink_type = /datum/reagent/consumable/ms13/nuka_lime
	name = "Nuka-Lime"
	desc = "A clear green fizzy liquid with a subtle bittersweet and fruity aroma. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_quantum
	name = "Nuka-Cola Quantum"
	description = "Glowy yet oh so good."
	color = "#15F4EE"
	quality = DRINK_FANTASTIC
	taste_description = "static-y dull soda"

/datum/glass_style/drinking_glass/ms13/nuka_quantum
	required_drink_type = /datum/reagent/consumable/ms13/nuka_quantum
	name = "Nuka-Cola Quantum"
	desc = "A blue fizzy liquid with an odd smell. It glows slightly, and makes small pops at random."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_quartz
	name = "Nuka-Cola Quartz"
	description = "A classy clear drink."
	color = "#dfdcdc"
	quality = DRINK_FANTASTIC
	taste_description = "extra fizzy soda"

/datum/glass_style/drinking_glass/ms13/nuka_quartz
	required_drink_type = /datum/reagent/consumable/ms13/nuka_quartz
	name = "Nuka-Cola Quartz"
	desc = "A clear sparkly liquid with a slighty sweet smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_victory
	name = "Nuka-Cola Victory"
	description = "Tastes like freedom."
	color = "#E3931D" //it's fizzy, it's ginger, it's phenomenal
	quality = DRINK_FANTASTIC
	taste_description = "sweet ginger soda"

/datum/glass_style/drinking_glass/ms13/nuka_victory
	required_drink_type = /datum/reagent/consumable/ms13/nuka_victory
	name = "Nuka-Cola Victory"
	desc = "A orange fizzy liquid with a slighty sweet smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_wild
	name = "Nuka-Wild"
	description = "Nuka-Cola's answer to Sunset Sarsaparilla, it never really made an impact in the Southwest."
	color = "#290E05"
	quality = DRINK_VERYGOOD
	taste_description = "sweet dense soda"

/datum/glass_style/drinking_glass/ms13/nuka_wild
	required_drink_type = /datum/reagent/consumable/ms13/nuka_wild
	name = "Nuka-Wild"
	desc = "A dark fizzy liquid with a bland smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_vaccinated //TBD
	name = "Nuka-Cola My Blood's In It"
	description = "Tested well in the PEOPLE WHO DON'T WANT TO GET SICK AND DIE demographic."
	color = "#4e2e13"
	quality = DRINK_VERYGOOD
	taste_description = "weird citrus-caramel flavoured soda"

/datum/glass_style/drinking_glass/ms13/nuka_vaccinated //TBD
	required_drink_type = /datum/reagent/consumable/ms13/nuka_vaccinated //TBD
	name = "Nuka-Cola My Blood's In It"
	desc = "A dark brown-ish fizzy liquid with a slighty sweet smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_vaccinated/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjustToxLoss(-0.2, 0, TRUE)
	for(var/thing in M.diseases)
		var/datum/disease/D = thing
		if(D.severity == DISEASE_SEVERITY_POSITIVE)
			continue
		D.cure()
	return ..()

/datum/reagent/consumable/ms13/nuka_fusion
	name = "Nuka-Fusion"
	description = "A wildcat beverage made by a Nuka-Cola fanatic."
	color = "#D97031"
	quality = DRINK_FANTASTIC
	taste_description = "intense sweet fruity soda"

/datum/glass_style/drinking_glass/ms13/nuka_fusion
	required_drink_type = /datum/reagent/consumable/ms13/nuka_fusion
	name = "Nuka-Fusion"
	desc = "A orange fizzy liquid with a slighty sweet smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_berry
	name = "Nuka-Berry"
	description = "Packed with berry flavour."
	color = "#5d1f81"
	quality = DRINK_VERYGOOD
	taste_description = "sweet berry soda"

/datum/glass_style/drinking_glass/ms13/nuka_berry
	required_drink_type = /datum/reagent/consumable/ms13/nuka_berry
	name = "Nuka-Berry"
	desc = "A purple fizzy liquid with a slighty berry smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/newka_cola
	name = "newka-Cola"
	description = "Based on the failed Cherry Nuka-Cola, this drink is guaranteed to disappoint."
	color = "#550404"
	quality = DRINK_NICE
	taste_description = "mediocre soda"

/datum/glass_style/drinking_glass/ms13/newka_cola
	required_drink_type = /datum/reagent/consumable/ms13/newka_cola
	name = "newka-Cola"
	desc = "A deep red fizzy liquid with a disapointing bland smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_frutti // Grape/Orange/Cherry
	name = "Nuka-Frutti"
	description = "Perfect for when you're feeling fruity."
	color = "#d8bd72"
	quality = DRINK_VERYGOOD
	taste_description = "strong fruity soda"

/datum/glass_style/drinking_glass/ms13/nuka_frutti // Grape/Orange/Cherry
	required_drink_type = /datum/reagent/consumable/ms13/nuka_frutti // Grape/Orange/Cherry
	name = "Nuka-Frutti"
	desc = "A pale yellow fizzy liquid with a strong fruit smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_love // Quartz and Cherry
	name = "Nuka-Love"
	description = "Aww, it's pink!"
	color = "#c06968"
	quality = DRINK_VERYGOOD
	taste_description = "sparkling sweet fruit soda"

/datum/glass_style/drinking_glass/ms13/nuka_love // Quartz and Cherry
	required_drink_type = /datum/reagent/consumable/ms13/nuka_love // Quartz and Cherry
	name = "Nuka-Love"
	desc = "A pale red sparkly liquid with a slighty fruity smell. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_rush //Victory and Wild
	name = "Nuka-Rush"
	description = "Fills you with energy."
	color = "#4db13f"
	quality = DRINK_VERYGOOD
	taste_description = "dense ginger soda"

/datum/glass_style/drinking_glass/ms13/nuka_rush //Victory and Wild
	required_drink_type = /datum/reagent/consumable/ms13/nuka_rush //Victory and Wild
	name = "Nuka-Rush"
	desc = "A deep green fizzy liquid with a slighty fruity smell, just a sniff gives you a bit of a head rush. Bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_free //Cola and Water
	name = "Nuka-Free"
	description = "That's not how diet drinks work, you know."
	color = "#4b3f35"
	quality = DRINK_VERYGOOD
	taste_description = "refreshing watered down soda"

/datum/glass_style/drinking_glass/ms13/nuka_free //Cola and Water
	required_drink_type = /datum/reagent/consumable/ms13/nuka_free //Cola and Water
	name = "Nuka-Free"
	desc = "A purple fizzy liquid with a slighty sugar-y smell. You can see an occasional bubble."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/nuka_black //Cola and Coffee
	name = "Nuka-Black"
	description = "Cola and coffee, finally married in perfect harmony."
	color = "#3B2F2F"
	quality = DRINK_VERYGOOD
	taste_description = "strong caffinated soda"

/datum/glass_style/drinking_glass/ms13/nuka_black //Cola and Coffee
	required_drink_type = /datum/reagent/consumable/ms13/nuka_black //Cola and Coffee
	name = "Nuka-Black"
	desc = "A dark liquid reeking of coffee. Nothing is going on inside the glass."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/vim_refresh
	name = "Vim Refresh"
	description = "Gives you the zip you need to get through the day."
	color = "#8db600"
	quality = DRINK_VERYGOOD
	taste_description = "light apple flavored soda"

/datum/glass_style/drinking_glass/ms13/vim_refresh
	required_drink_type = /datum/reagent/consumable/ms13/vim_refresh
	name = "Vim Refresh"
	desc = "A green bubbly liquid smelling of vague apple."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/sunset_sarsaparilla
	name = "Sunset sarsaparilla"
	description = "Build mass with sass!"
	color = "#290E05"
	quality = DRINK_VERYGOOD
	taste_description = "mildly sweet dense soda"

/datum/glass_style/drinking_glass/ms13/sunset_sarsaparilla
	required_drink_type = /datum/reagent/consumable/ms13/sunset_sarsaparilla
	name = "Sunset sarsaparilla"
	desc = "A dark fizzy liquid with a bland smell. Large bubbles form on the side."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


//// Horrible mixtures. Definitely DON'T drink. ////

/datum/reagent/consumable/ms13/gagquik // Vile stuff.
	name = "gagquik"
	description = "A common wastelander brew often used to induce vomiting."
	color = "#3a502b"
	quality = DRINK_VERYGOOD
	taste_description = "putrid herbs and fruit"

/datum/glass_style/drinking_glass/ms13/gagquik // Vile stuff.
	required_drink_type = /datum/reagent/consumable/ms13/gagquik // Vile stuff.
	name = "gagquik"
	desc = "A murky dark green liquid with bits of plant matter floating at the top. Has a vile smell to it."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/gagquik/on_mob_life(mob/living/carbon/M, delta_time, times_fired) // This definitely won't be slipped into drinks
	if(prob(25))
		M.vomit(lost_nutrition = 25, distance = 1, purge_ratio = 0.5)
	M.adjust_disgust(10)
	return ..()

/datum/reagent/consumable/ms13/redheave //Geigpunga wine, Toxic soot extract, Gagquik, CHEMICALS?
	name = "red heave"
	description = "An accidental discovery. Curious brewers dread this outcome."
	color = "#91a05b"
	quality = DRINK_VERYGOOD
	taste_description = "putrid sour fruit and herbs with chemical burn"

/datum/glass_style/drinking_glass/ms13/redheave //Geigpunga wine, Toxic soot extract, Gagquik, CHEMICALS?
	required_drink_type = /datum/reagent/consumable/ms13/redheave //Geigpunga wine, Toxic soot extract, Gagquik, CHEMICALS?
	name = "red heave"
	desc = "A murky pale green liquid. It occasionally frothes a bit and has a vile smell to it."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/redheave/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjustOrganLoss(ORGAN_SLOT_STOMACH, rand(1,10))
	to_chat(M, (span_cultboldtalic("It BURNS!")))
	if(prob(25))
		M.vomit(lost_nutrition = 10, distance = 2, purge_ratio = 0, blood = TRUE, harm = TRUE)
	M.adjust_disgust(5)
	return ..()

//// POWER GAMER brews- allegedly. ////

/* Not doin this yet
/datum/reagent/consumable/ms13/waster_tea // Ash Rose / Broc
	name = "waster's Tea"
	description = "A tea made by wasters to help aid recovery. Causes fatigue."
	color = "#a39d46"
	taste_description = "filling herbal brew with slight alcoholic burn"

/datum/glass_style/drinking_glass/ms13/waster_tea // Ash Rose / Broc
	required_drink_type = /datum/reagent/consumable/ms13/waster_tea // Ash Rose / Broc
	name = "waster's Tea"
	desc = "A faint pale green liquid with an herbal aroma practically falling off it."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/waster_tea/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(M.getFireLoss() && SPT_PROB(10, delta_time))
		M.heal_bodypart_damage(1,0, 0)
		. = TRUE

/datum/reagent/consumable/ms13/herb_brew // Coyote tobacco and lureweed
	name = "herbal Brew"
	description = "An herbal brew, made by tribals from the local forage."
	quality = DRINK_GOOD
	color = "#66693b"
	taste_description = "rough soothing broth"

/datum/glass_style/drinking_glass/ms13/herb_brew // Coyote tobacco and lureweed
	required_drink_type = /datum/reagent/consumable/ms13/herb_brew // Coyote tobacco and lureweed
	name = "herbal Brew"
	desc = "A faint pale-ish green liquid with a bitter earthy smell."
	icon = 'icons/obj/drinks/mixed_drinks.dmi'


/datum/reagent/consumable/ms13/herb_brew/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjustBruteLoss(-1)
	M.AdjustAllImmobility(5)
	..()
	. = 1
*/
