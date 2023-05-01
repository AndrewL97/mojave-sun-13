/datum/reagent/consumable/ethanol/ms13
	name = "Ethanol"
	description = "Pure, unrestricted... 95% ethanol."
	color = "#dadacb"
	nutriment_factor = 0
	taste_description = "pure, burning, absolute alcohol"
	boozepwr = 95

/datum/glass_style/drinking_glass/ethanol/ms13
	required_drink_type = /datum/reagent/consumable/ethanol/ms13
	name = "glass of clear liquid"
	desc = "A completely clear liquid, spare for the occasional bubble rising to the top. A sniff of this nearly burns your nose hairs clean off."

//// Basic pre-war alcohols ////

/datum/reagent/consumable/ethanol/ms13/absinthe
	name = "absinthe"
	description = "An old popular drink. Very strong."
	color = "#cecbc5"
	boozepwr = 75
	taste_description = "strong alcohol and strange herb-y sugar"

/datum/glass_style/drinking_glass/ms13/absinthe
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/absinthe
	name = "glass of clear green liquid"
	desc = "A clear green liquid with an intense alcoholic smell. Vaguely sweet herb aroma."

/datum/reagent/consumable/ethanol/ms13/moonshine
	name = "moonshine"
	description = "A bland alcohol. Basically a party gimmick unless you're a masochist."
	color = "#cecbc5"
	boozepwr = 70
	taste_description = "strong bland alcohol"

/datum/glass_style/drinking_glass/ms13/moonshine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/moonshine
	name = "glass of clear liquid"
	desc = "A clear liquid with an intense alcoholic smell."

/datum/reagent/consumable/ethanol/ms13/whiskey
	name = "whiskey"
	description = "Cinnamon hinted alcohol, and that's about it."
	quality = DRINK_NICE
	color = "#a87820"
	boozepwr = 50
	taste_description = "spiced alcohol"

/datum/glass_style/drinking_glass/ms13/whiskey
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/whiskey
	name = "glass of clear pale orange liquid"
	desc = "A clear orange liquid with a moderate alcoholic smell."

/datum/reagent/consumable/ethanol/ms13/vodka
	name = "vodka"
	description = "Another bland yet strong alcohol. This one is a classic ingredient."
	color = "#e7e5e1"
	boozepwr = 75
	taste_description = "strong alcohol with subtle flavors"

/datum/glass_style/drinking_glass/ms13/vodka
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/vodka
	name = "glass of clear liquid"
	desc = "A clear liquid with no smell. Nothing out of the ordinary." // ☻

/datum/reagent/consumable/ethanol/ms13/tequila
	name = "tequila"
	description = "Tequila, made before the war. It's got nothin' on the recent home brews, but it's still good."
	color = "#c4c486"
	boozepwr = 45 // Irradiated agave do be hittin harder tho
	taste_description = "moderate agave alcohol"

/datum/glass_style/drinking_glass/ms13/tequila
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/tequila
	name = "glass of pale yellow-ish liquid"
	desc = "A faint pale yellow liquid with a familiar distant agave smell to it. Smells decently alcoholic."

/datum/reagent/consumable/ethanol/ms13/wine
	name = "wine"
	description = "Old grape-based liquor. Not much to say."
	color = "#af444a"
	boozepwr = 15
	taste_description = "subtle fruit and bittersweet alcohol"

/datum/glass_style/drinking_glass/ms13/wine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/wine
	name = "glass of clear red liquid"
	desc = "A clear red liquid with a faint alcoholic smell."

/datum/reagent/consumable/ethanol/ms13/champagne
	name = "champagne"
	description = "An uncommonly found type of wine. Nobody knows what the name means."
	quality = DRINK_NICE
	color = "#daae6c"
	boozepwr = 25
	taste_description = "sweet fruit and alcohol"

/datum/glass_style/drinking_glass/ms13/champagne
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/champagne
	name = "glass of clear pale yellow liquid"
	desc = "A clear pale yellow liquid with an occasional bubble found rising to the top. There is a light alcoholic smell."

/datum/reagent/consumable/ethanol/ms13/cognac
	name = "cognac"
	description = "Old distilled wine. Delicious and prized to this day, due to limited supply."
	quality = DRINK_GOOD
	color = "#af444a"
	boozepwr = 35
	taste_description = "spicy fruit and bittersweet alcohol"

/datum/glass_style/drinking_glass/ms13/cognac
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/cognac
	name = "glass of clear orange-red liquid"
	desc = "A clear orange-red liquid with a moderate alcoholic smell."

/datum/reagent/consumable/ethanol/ms13/beer // The only beer variant other than waster beer. They all taste the same. Fight me.
	name = "beer"
	description = "A generic ale brew. It could be anything, really."
	quality = DRINK_GOOD
	color = "#d0d8ac"
	boozepwr = 25
	taste_description = "beer"

/datum/glass_style/drinking_glass/ms13/beer
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/beer
	name = "glass of dark liquid"
	desc = "A dark liquid with a bland alcoholic smell."

/datum/reagent/consumable/ethanol/ms13/gin
	name = "gin"
	description = "An alcohol. Something to do with berries. Who cares? It's pretty good."
	quality = DRINK_GOOD
	color = "#d0d8ac"
	boozepwr = 45
	taste_description = "spicy fruit and bittersweet alcohol"

/datum/glass_style/drinking_glass/ms13/gin
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/gin
	name = "glass of clear off-white liquid"
	desc = "A clear off-white liquid with an alcoholic smell."

/datum/reagent/consumable/ethanol/ms13/sake
	name = "sake"
	description = "Sake, a sterotype of the east. Appreciated a bit more today than two hundred years ago."
	color = "#b9b9b9"
	boozepwr = 45
	taste_description = "moderate grain alcohol"

/datum/glass_style/drinking_glass/ms13/sake
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/sake
	name = "glass of clear liquid"
	desc = "A clear murky liquid that gives of a moderate alcoholic odor."

/datum/reagent/consumable/ethanol/ms13/vermouth
	name = "vermouth"
	description = "A spicy, sweet, and earthy herb infused grape wine. High class!"
	color = "#d67c7c"
	boozepwr = 40
	taste_description = "sweet and spicy wine"

/datum/glass_style/drinking_glass/ms13/vermouth
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/vermouth
	name = "glass of clear light red liquid"
	desc = "A clear light red liquid that gives of a moderate sweet and spiced alcoholic odor."

/datum/reagent/consumable/ethanol/ms13/triple_sec
	name = "triple sec"
	description = "A spicy, sweet, and earthy herb infused grape wine. High class!"
	color = "#e49328"
	boozepwr = 45
	taste_description = "sweet fruit alcohol"

/datum/glass_style/drinking_glass/ms13/triple_sec
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/triple_sec
	name = "glass of clear orange liquid"
	desc = "A clear light orange that gives of a sweet fruity smell, followed by alcohol."

/datum/reagent/consumable/ethanol/ms13/kaluha
	name = "kaluha"
	description = "A coffee liqueur. At least it once was. It's pretty bland these days."
	quality = DRINK_FANTASTIC
	color = "#dbab74"
	boozepwr = 35
	taste_description = "sugary alcohol"

/datum/glass_style/drinking_glass/ms13/kaluha
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/kaluha
	name = "glass of cream colored liquid"
	desc = "A cream colored liquid with an alcoholic smell."

/datum/reagent/consumable/ethanol/ms13/rum
	name = "rum"
	description = "A classic rum, with a nice sugary molasses taste. Can't go wrong."
	color = "#6b3811"
	boozepwr = 35
	taste_description = "sugary alcohol"

/datum/glass_style/drinking_glass/ms13/rum
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/rum
	name = "glass of clear dark orange liquid"
	desc = "A clear orange liquid with an alcoholic smell."

/datum/reagent/consumable/ethanol/ms13/nuka_dark
	name = "Nuka-Dark"
	description = "A blend of Nuka-Cola and a some unknown alcohol. Overrated."
	color = "#3E1B00"
	boozepwr = 25
	taste_description = "alcoholic nuka-cola"

/datum/glass_style/drinking_glass/ms13/nuka_dark
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/nuka_dark
	name = "glass of dark liquid"
	desc = "A still and dark liquid with a moderate alcoholic smell, with a hint of sweet cola mixed in."

//// Mixed Drinks ////

/datum/reagent/consumable/ethanol/ms13/rum_nuka // Rum and Nuka
	name = "rum and nuka"
	description = "Rum mixed with Nuka-Cola. Not much to be said."
	quality = DRINK_GOOD
	color = "#381d08"
	boozepwr = 45
	taste_description = "alcoholic nuka cola"

/datum/glass_style/drinking_glass/ms13/rum_nuka
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/rum_nuka
	name = "glass of dark fizzing liquid"
	desc = "A dark fizzing liquid with a fair alcohlic smell to it."

/datum/reagent/consumable/ethanol/ms13/whiskey_nuka //Whiskey and Nuka
	name = "whiskey and nuka"
	description = "Whiskey, mixed with Nuka-Cola. Surprisingly refreshing."
	color = "#3E1B00"
	quality = DRINK_GOOD
	boozepwr = 60
	taste_description = "strong alcoholic nuka cola with spice"

/datum/glass_style/drinking_glass/ms13/whiskey_nuka
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/whiskey_nuka
	name = "glass of dark fizzing liquid"
	desc = "A dark fizzing liquid with a hint of spice and a decent alcohlic smell to it."

/datum/reagent/consumable/ethanol/ms13/commie_bomb // Vodka, Nuka Quartz
	name = "commie bomb"
	description = "A post-war drink devoded to the obvious victory over the communist threat."
	quality = DRINK_GOOD
	color = "#6e3e18"
	boozepwr = 70
	taste_description = "strong alcoholic nuka cola"

/datum/glass_style/drinking_glass/ms13/commie_bomb
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/commie_bomb
	name = "glass of brown fizzing liquid"
	desc = "A brown fizzing liquid with a sharp alcohlic smell to it."

/datum/reagent/consumable/ethanol/ms13/mammoth_bait // Mutfruit wine / Champagne / Something mushroom
	name = "Mammoth bait"
	description = "A recipe passed down through the generations in Mammoth. Best served warm."
	quality = DRINK_FANTASTIC
	color = "#ce99c2"
	boozepwr = 25
	taste_description = "off-tasting bubbly alcohol"

/datum/glass_style/drinking_glass/ms13/mammoth_bait
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/mammoth_bait
	name = "glass of dull pink liquid"
	desc = "A dull pink bubbly liquid with a strange smell- Vaguely alcoholic."

/datum/reagent/consumable/ethanol/ms13/atomic_cocktail // Mentat powder / Nuka Victory / Vodka
	name = "Atomic Cocktail"
	description = "A favourite from old Nevada."
	quality = DRINK_FANTASTIC
	color = "#A6B199"
	boozepwr = 60
	taste_description = "ginger-y caffinated alcohol with chemicals"

/datum/glass_style/drinking_glass/ms13/atomic_cocktail
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/atomic_cocktail
	name = "glass of pale green liquid"
	desc = "A pale green liquid with a strange smell. Based on smell, definitely has alcohol."

/datum/reagent/consumable/ethanol/ms13/necromancer // Vodka / Rum / Ash Blossom powder
	name = "Necromancer"
	description = "Strong enough to wake the dead.."
	quality = DRINK_NICE
	color = "#360705"
	boozepwr = 75
	taste_description = "intense alcoholic taste with nostril burning"

/datum/glass_style/drinking_glass/ms13/necromancer
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/necromancer
	name = "glass of dark red liquid"
	desc = "A dark red liquid with particles floating around in it. Intense alcoholic aroma."

/*/datum/reagent/consumable/ethanol/ms13/necromancer/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.drowsyness = max(0,M.drowsyness-3)
	..()
	. = 1 */

/datum/reagent/consumable/ethanol/ms13/dirty_wastelander // Mutfruit juice / Nuka / Whiskey
	name = "Dirty Wastelander"
	description = "A pre-war classic adapted to the post-war world."
	quality = DRINK_VERYGOOD
	color = "#703817"
	boozepwr = 35
	taste_description = "spiced fruit cola with alcohol"

/datum/glass_style/drinking_glass/ms13/dirty_wastelander
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/dirty_wastelander
	name = "glass of dull orange liquid"
	desc = "A dull orange liquid with a spiced fruity smell to it. Has alcohol in it, though the amount is uncertain."

/datum/reagent/consumable/ethanol/ms13/nawlins_sazerac // Cognac / Coyote tobacco powder / Absinthe
	name = "Nawlins Sazerac"
	description = "A favourite from Nawlins, way down South. Not to be confused with the New Orleans version."
	quality = DRINK_VERYGOOD
	color = "#c74f1c"
	boozepwr = 50
	taste_description = "bitter herb-y alcohol with a strange aftertaste"

/datum/glass_style/drinking_glass/ms13/nawlins_sazerac
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/nawlins_sazerac
	name = "glass of orange liquid"
	desc = "A orange liquid with small leaf bits floating around in it. Decent alcoholic smell."

/datum/reagent/consumable/ethanol/ms13/clogged_pump //nuka-cola / rad-ant lager
	name = "Clogged pump"
	description = "Nuka-Cola and brewed ant meat. Interesting."
	quality = DRINK_VERYGOOD
	color = "#552c2b"
	boozepwr = 25
	taste_description = "meat tinted soda with hint of alcohol"

/datum/glass_style/drinking_glass/ms13/clogged_pump
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/clogged_pump
	name = "glass of dark red liquid"
	desc = "A dark red liquid with a slight sweet meat-y smell. Strange. You can also pick up hints of alcohol in it."

////B for Brewed - Home brewed fun ////

// Basic Brews/Distilling //

/datum/reagent/consumable/ethanol/ms13/barrel_wine // Barrel Fruit
	name = "barrel cactus wine"
	description = "Wine brewed from a barrel cactus fruit. Tangy."
	quality = DRINK_GOOD
	color = "#dbcb35"
	boozepwr = 20
	taste_description = "sour, barrel fruit alcohol"

/datum/glass_style/drinking_glass/ms13/barrel_wine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/barrel_wine
	name = "glass of yellow liquid"
	desc = "A yellow liquid with a bland aroma. Smells vaguely alcoholic."

/datum/reagent/consumable/ethanol/ms13/mutfruit_wine // Mutfruit / Crunchy Mutfruit
	name = "mutfruit wine"
	description = "A sweet mutfruit wine. Best served with seeds in it."
	quality = DRINK_NICE
	color = "#472d58"
	boozepwr = 15
	taste_description = "sweet mutfruit alcohol"

/datum/glass_style/drinking_glass/ms13/mutfruit_wine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/mutfruit_wine
	name = "glass of dark purple liquid"
	desc = "A dark purple liquid with tiny black seeds drifting around it. Smells vaguely alcoholic."

/datum/reagent/consumable/ethanol/ms13/apple_cider // Apple
	name = "hard apple cider"
	description = "A sweet apple cider."
	quality = DRINK_NICE
	color = "#cdd465"
	boozepwr = 10
	taste_description = "sweet apple cider"

/datum/glass_style/drinking_glass/ms13/apple_cider
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/apple_cider
	name = "glass of murky yellow liquid"
	desc = "A murky yellow liquid. A sweet smell accompanied by an alcoholic follower."

/datum/reagent/consumable/ethanol/ms13/pricklypear_wine // Prickly Pear
	name = "prickly pear wine"
	description = "A sweet prickly pear wine."
	quality = DRINK_NICE
	color = "#7725ad"
	boozepwr = 35
	taste_description = "bittersweet prickly pear and alcohol"

/datum/glass_style/drinking_glass/ms13/pricklypear_wine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/pricklypear_wine
	name = "glass of bright purple liquid"
	desc = "A bright and murky purple liquid. Smells vaguely alcoholic."

/datum/reagent/consumable/ethanol/ms13/punga_wine // Punga Fruit
	name = "punga fruit wine"
	description = "Wine made from punga fruit. Delicious."
	quality = DRINK_NICE
	color = "#3a8546"
	boozepwr = 50
	taste_description = "sour punga fruit and alcohol"

/datum/glass_style/drinking_glass/ms13/punga_wine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/punga_wine
	name = "glass of green liquid"
	desc = "A green murky liquid. Heavy alcoholic aromas waft from it."

/datum/reagent/consumable/ethanol/ms13/geigpunga_wine // Geigpunga Fruit
	name = "geigpunga fruit wine"
	description = "An acidic wine. You could almost melt something with it"
	quality = DRINK_NICE
	color = "#33d64e"
	boozepwr = 75
	taste_description = "rancid punga fruit and alcohol"

/datum/glass_style/drinking_glass/ms13/geigpunga_wine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/geigpunga_wine
	name = "glass of green liquid"
	desc = "A bright green murky liquid. Heavy alcoholic aromas waft from it."

/datum/reagent/consumable/ethanol/ms13/snaptail_rum // Snaptail
	name = "snaptail rum"
	description = "A sweet rum, brewed locally!"
	quality = DRINK_NICE
	color = "#c9a9a9"
	boozepwr = 45
	taste_description = "subtly sweet and smooth alcohol"

/datum/glass_style/drinking_glass/ms13/snaptail_rum
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/snaptail_rum
	name = "glass of clear tinted liquid"
	desc = "A clear liquid with a subtle tint. Definitely smells of alcohol."

/datum/reagent/consumable/ethanol/ms13/tarberry_wine // Tarberry
	name = "tarberry wine"
	description = "Wine made from tarberries. Delicious."
	quality = DRINK_NICE
	color = "#aa0fa2"
	boozepwr = 40
	taste_description = "oily tarberry and alcohol"

/datum/glass_style/drinking_glass/ms13/tarberry_wine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/tarberry_wine
	name = "glass of bright purple liquid"
	desc = "A bright purple liquid. Bitter smell, with an alcoholic afterburn."

/datum/reagent/consumable/ethanol/ms13/blackberry_wine // Blackberry
	name = "blackberry wine"
	description = "Wine made from blackberries. Delicious."
	quality = DRINK_NICE
	color = "#5f1946"
	boozepwr = 45
	taste_description = "sweet blackberries and alcohol"

/datum/glass_style/drinking_glass/ms13/blackberry_wine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/blackberry_wine
	name = "glass of purple liquid"
	desc = "A purple liquid. Sweet smell, with an alcoholic afterburn."

/datum/reagent/consumable/ethanol/ms13/radberry_wine // Radberry
	name = "radberry wine"
	description = "Wine made from radberries. Delicious."
	quality = DRINK_NICE
	color = "#0a9969"
	boozepwr = 45
	taste_description = "sweet berry with a hint of metal and alcohol"

/datum/glass_style/drinking_glass/ms13/radberry_wine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/radberry_wine
	name = "glass of dull green liquid"
	desc = "A dull green liquid Sometimes, you can see a shimmer in it. Sweet smell, with an alcoholic afterburn."

/datum/reagent/consumable/ethanol/ms13/yucca_wine // Yucca
	name = "yucca wine"
	description = ""
	quality = DRINK_NICE
	color = "#acac87"
	boozepwr = 25 // That thing is incredibly sugar-y. Tell me it aint so
	taste_description = "sweet starch and strong alcohol"

/datum/glass_style/drinking_glass/ms13/yucca_wine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/yucca_wine
	name = "glass of pale clear liquid"
	desc = "A faint pale yellow liquid with a familiar distant agave smell to it. Smells pretty alcoholic."

/datum/reagent/consumable/ethanol/ms13/tato_liquor // Tato
	name = "tato liquor"
	description = "liquor made from tatos. Not delicious at all."
	quality = null
	color = "#a13f2e"
	boozepwr = 65
	taste_description = "bitter eggs and alcohol"

/datum/glass_style/drinking_glass/ms13/tato_liquor
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/tato_liquor
	name = "glass of red-orange liquid"
	desc = "A red-orange liquid, with pieces of plant still floating around in it. Gives off a sickening smell. Definitely alcoholic."

/datum/reagent/consumable/ethanol/ms13/waster_vodka // Potato???
	name = "wasteland vodka"
	description = "A modern version of an ancient alcohol. Not commonly found."
	color = "#dfddd5"
	boozepwr = 75
	taste_description = "distant starch with strong alcohol"

/datum/glass_style/drinking_glass/ms13/waster_vodka
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/waster_vodka
	name = "glass of clear liquid"
	desc = "A clear liquid that gives of a strong alcoholic odor."

/datum/reagent/consumable/ethanol/ms13/tomato_wine // Tomato???
	name = "tomato wine"
	description = "A wine brewed from a tomato. Not exactly desired."
	color = "#c57f73"
	boozepwr = 35
	taste_description = "subtle tomato and alcohol"

/datum/glass_style/drinking_glass/ms13/tomato_wine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/tomato_wine
	name = "glass of faintly red liquid"
	desc = "A nearly clear red liquid. It gives of a moderate alcoholic odor."

/datum/reagent/consumable/ethanol/ms13/waster_beer // Razorgrain
	name = "wasteland beer"
	description = "A homebrew beer from razorgrain. About as generic as you can get."
	color = "#442b1b"
	boozepwr = 25
	taste_description = "beer"

/datum/glass_style/drinking_glass/ms13/waster_beer
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/waster_beer
	name = "glass of dark brown liquid"
	desc = "A dark brown liquid that gives of a moderate alcoholic odor."

/datum/reagent/consumable/ethanol/ms13/waster_sake // Baifan
	name = "baifan brew"
	description = "A homebrew sake from baifan grain. Strong alcoholic content."
	color = "#ada9a6"
	boozepwr = 55
	taste_description = "strong grain alcohol"

/datum/glass_style/drinking_glass/ms13/waster_sake
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/waster_sake
	name = "glass of clear murky liquid"
	desc = "A clear murky liquid that gives of a strong alcoholic odor."

/datum/reagent/consumable/ethanol/ms13/waster_tequila // Agave
	name = "wasteland tequila"
	description = "A rough-and-ready tequila born of the wasteland."
	color = "#b6b687"
	boozepwr = 65
	taste_description = "rough agave alcohol"

/datum/glass_style/drinking_glass/ms13/waster_tequila
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/waster_tequila
	name = "glass of pale yellow-ish liquid"
	desc = "A faint pale yellow liquid with a familiar distant agave smell to it. Smells pretty alcoholic."

/datum/reagent/consumable/ethanol/ms13/waster_tequila/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(M.getToxLoss() && prob(20))
		M.adjustToxLoss(-1*REM, 0)
		. = 1
	if(holder.has_reagent(/datum/reagent/toxin))
		holder.remove_reagent(/datum/reagent/toxin, 0.5)
	..()

/datum/reagent/consumable/ethanol/ms13/waster_whiskey // Maize
	name = "wasteland whiskey"
	description = "A homemade whiskey. Some argue better than the pre-war bottles."
	color = "#8f5b1f"
	boozepwr = 45
	taste_description = "sweet alcohol with a hint of maize"

/datum/glass_style/drinking_glass/ms13/waster_whiskey
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/waster_whiskey
	name = "glass of clear brown liquid"
	desc = "A clear brown liquid that gives of a strong alcoholic odor."

/datum/reagent/consumable/ethanol/ms13/carrot_wine // Carrots
	name = "carrot wine"
	description = "Wine. From. Carrots. How exotic!"
	color = "#c99355"
	boozepwr = 55
	taste_description = "sweet alcoholic carrots"

/datum/glass_style/drinking_glass/ms13/carrot_wine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/carrot_wine
	name = "glass of clear orange liquid"
	desc = "A clear orange liquid with a sweet subtle smell with some alcohol definitely present."

/datum/reagent/consumable/ethanol/ms13/brew_sludge // Anything random
	name = "brew sludge"
	description = "The result of trying to brew something questionable. Curiosity doesn't always bear fruit. Sometimes it bears this."
	color = "#462814"
	boozepwr = 5
	taste_description = "vile earthy sludge and subtle alcohol"

/datum/glass_style/drinking_glass/ms13/brew_sludge
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/brew_sludge
	name = "glass of murky brown liquid"
	desc = "A murky brown liquid with a gross smell to it. You can ALMOST pick up the faint smell of alcohol."

/datum/reagent/consumable/ethanol/ms13/brew_sludge/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjustOrganLoss(ORGAN_SLOT_STOMACH, rand(1,2))
	M.adjust_disgust(15)
	..()

//// Combination Brews ////

/datum/reagent/consumable/ethanol/ms13/ballistic_bock // Gunpowder, Waster beer
	name = "ballistic Bock"
	description = "A dark, malty ale complemented perfectly with gunpowder."
	color = "#5D0F0C"
	boozepwr = 15
	taste_description = "faint gunpowder and beer"

/datum/glass_style/drinking_glass/ms13/ballistic_bock
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/ballistic_bock
	name = "glass of dark liquid"
	desc = "A dark and liquid. It smells faintly of alcohol and gunpowder."

/datum/reagent/consumable/ethanol/ms13/rad_ant_lager // Rad ant pulp, Waster beer
	name = "rad ant lager"
	description = "A light, hoppy beer complemented exquisitely with Rad Ant meat."
	color = "#864b49"
	boozepwr = 30
	taste_description = "meat tinted alcohol"

/datum/glass_style/drinking_glass/ms13/rad_ant_lager
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/rad_ant_lager
	name = "glass of pale red liquid"
	desc = "A faint pale red liquid with a slight meat-y smell. Strange. You can also pick up hints of alcohol in it."

/datum/reagent/consumable/ethanol/ms13/swift_recovery // Brain fungus and Tato
	name = "swift recovery brew"
	description = "A flavorful and light beer. Reeks of fungus."
	quality = DRINK_NICE
	color = "#cead42"
	boozepwr = 25
	taste_description = "tato and fungus flavored alcohol"

/datum/glass_style/drinking_glass/ms13/swift_recovery
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/swift_recovery
	name = "glass of pale orange liquid"
	desc = "A pale orange liquid. It reeks of fungus and has hints of tato."

/datum/reagent/consumable/ethanol/ms13/swift_recovery/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(-5,-1))
	if(M.getToxLoss() && prob(20))
		M.adjustToxLoss(1*REM, 0)
		. = 1
	..()

/datum/reagent/consumable/ethanol/ms13/fire_wine // Firecap and xander
	name = "fire Wine"
	description = "Perfect for warming yourself in the harsh winters."
	quality = DRINK_NICE
	color = "#2b0b0a"
	boozepwr = 35
	taste_description = "rough spicy alcohol"

/datum/glass_style/drinking_glass/ms13/fire_wine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/fire_wine
	name = "glass of deep red liquid"
	desc = "A deep red liquid with a spiced aroma. Smelling it brings a comforting aura."

/datum/reagent/consumable/ethanol/ms13/fire_wine/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjust_bodytemperature(25 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, M.get_body_temp_normal())
	..()
	. = 1

//// N for NOBODY should consume - Horrible mixtures ////

/datum/reagent/consumable/ms13/nuka_lixir // Med-X / Cola :denthead:
	name = "Nuka-lixir"
	description = "...Who thought this was a good idea?"
	color = "#2accc7"
	taste_description = "burning chemical taste and soda"

/datum/glass_style/drinking_glass/ms13/nuka_lixir
	required_drink_type = /datum/reagent/consumable/ms13/nuka_lixir
	name = "glass of pale blue fizzy liquid"
	desc = "A pale blue fizzy liquid with a slighty sweet smell."

/datum/reagent/consumable/ethanol/ms13/lead_champagne // lead powder / Champagne - What a cruel joke.
	name = "lead champagne"
	description = "Are you sure this is safe to drink?"
	quality = DRINK_NICE
	color = "#7c1f4d"
	boozepwr = 35
	taste_description = "sweet fruit and alcohol, with a metallic aftertaste"

/datum/glass_style/drinking_glass/ms13/lead_champagne
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/lead_champagne
	name = "glass of a reddish-purple liquid"
	desc = "A reddish-purple liquid with a distant fruit aroma to it, occasional black flakes can be seen floating around. Alcohol is present in it, albeit not too strong."

/datum/reagent/consumable/ethanol/ms13/lead_champagne/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(prob(20))
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(1,5))
	..() // Not positive this works right. Radiation is when you unscuff it :tm:

/datum/reagent/consumable/ethanol/ms13/nukashine //this stuff makes you harder to stun, but liver hurtie.
	name = "Nukashine"
	description = "The best drink a college freshman could ask for."
	color = "#48c2be"
	quality = null
	boozepwr = 85
	taste_description = "vile burning cola"

/datum/glass_style/drinking_glass/ms13/nukashine
	required_drink_type = /datum/reagent/consumable/ethanol/ms13/nukashine
	name = "glass of bright blue fizzy liquid"
	desc = "A bright blue fizzy liquid with a overwealming alcoholic smell. You feel like you get a hangover from the fumes itself."

/datum/reagent/consumable/ethanol/ms13/nukashine/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/ephedrine)
	to_chat(L, (span_warning("Your stomach burns with pain as you drink the Nukashine, your heart beating faster.")))

/datum/reagent/consumable/ethanol/ms13/nukashine/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/ephedrine)
	to_chat(L, (span_danger("Against it all odds, it looks like the pain faded...")))
	..()

/datum/reagent/consumable/ethanol/ms13/nukashine/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.AdjustStun(-20, FALSE)
	M.AdjustKnockdown(-20, FALSE)
	M.adjustStaminaLoss(-5, 0)
	M.set_jitter_if_lower(2 SECONDS * seconds_per_tick)
	if(prob(25))
		M.adjustOrganLoss(ORGAN_SLOT_HEART, rand(1,3))
	..()
