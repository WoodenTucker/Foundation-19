/obj/effect/overmap/visitable/sector/exoplanet/lush
	name = "lush exoplanet"
	desc = "Planet with abundant flora and fauna."
	scan_summary = "Humid, temperate world with a warm atmosphere. Continental landmasses are dominated by dense vegetation. Liquid water and complex life are highly abundant."
	scan_assessment = "Use caution when interacting with local life."
	color = "#407c40"
	planetary_area = /area/exoplanet/grass
	rock_colors = list(COLOR_ASTEROID_ROCK, COLOR_GRAY80, COLOR_BROWN)
	plant_colors = list("#0e1e14","#1a3e38","#5a7467","#9eab88","#6e7248", "RANDOM")
	map_generators = list(/datum/random_map/noise/exoplanet/lush)
	habitability_distribution = list(HABITABILITY_IDEAL = 70, HABITABILITY_OKAY = 20, HABITABILITY_BAD = 5)
	has_trees = TRUE
	flora_diversity = 7
	fauna_types = list(/mob/living/simple_animal/yithian, /mob/living/simple_animal/tindalos, /mob/living/simple_animal/hostile/retaliate/jelly)
	megafauna_types = list(/mob/living/simple_animal/hostile/retaliate/parrot/space/megafauna, /mob/living/simple_animal/hostile/retaliate/goose/dire)

/obj/effect/overmap/visitable/sector/exoplanet/lush/generate_map()
	if(prob(40))
		lightlevel = rand(1,7)/10	//give a chance of twilight jungle
	..()

/obj/effect/overmap/visitable/sector/exoplanet/lush/generate_atmosphere()
	..()
	if(atmosphere)
		atmosphere.temperature = T20C + rand(10, 30)
		atmosphere.update_values()

/obj/effect/overmap/visitable/sector/exoplanet/lush/get_surface_color()
	return grass_color

/obj/effect/overmap/visitable/sector/exoplanet/lush/adapt_seed(datum/seed/S)
	..()
	var/carnivore_prob = rand(100)
	if(carnivore_prob < 30)
		S.set_trait(TRAIT_CARNIVOROUS,2)
		if(prob(75))
			S.get_trait(TRAIT_STINGS, 1)
	else if(carnivore_prob < 60)
		S.set_trait(TRAIT_CARNIVOROUS,1)
		if(prob(50))
			S.get_trait(TRAIT_STINGS)
	if(prob(15) || (S.get_trait(TRAIT_CARNIVOROUS) && prob(40)))
		S.set_trait(TRAIT_BIOLUM,1)
		S.set_trait(TRAIT_BIOLUM_COLOUR,get_random_colour(0,75,190))

	if(prob(30))
		S.set_trait(TRAIT_PARASITE,1)
	if(!S.get_trait(TRAIT_LARGE))
		var/vine_prob = rand(100)
		if(vine_prob < 15)
			S.set_trait(TRAIT_SPREAD,2)
		else if(vine_prob < 30)
			S.set_trait(TRAIT_SPREAD,1)

/area/exoplanet/grass
	base_turf = /turf/simulated/floor/exoplanet/grass
	ambience = list('sounds/effects/wind/wind_2_1.ogg','sounds/effects/wind/wind_2_2.ogg','sounds/effects/wind/wind_3_1.ogg','sounds/effects/wind/wind_4_1.ogg','sounds/ambience/eeriejungle2.ogg','sounds/ambience/eeriejungle1.ogg')

/area/exoplanet/grass/play_ambience(mob/living/L)
	..()
	if(!L.ear_deaf && L.client && !L.client.ambience_playing)
		L.client.ambience_playing = TRUE
		L.playsound_local(get_turf(L),sound('sounds/ambience/jungle.ogg', repeat = 1, wait = 0, volume = 25, channel = GLOB.ambience_sound_channel))

/datum/random_map/noise/exoplanet/lush
	descriptor = "lush exoplanet"
	smoothing_iterations = 2
	land_type = /turf/simulated/floor/exoplanet/grass
	water_type = /turf/simulated/floor/exoplanet/water/shallow

	flora_prob = 10
	grass_prob = 50
	large_flora_prob = 30

/obj/effect/overmap/visitable/sector/exoplanet/lush/lifeseeded
	name = "life-seeded exoplanet"
	desc = "Planet with abundant flora and fauna. Shows signs of human terraformation."
	scan_summary = "Temperate world with a nitrogen-oxygen atmosphere. Abundant flora and fauna are present, seeded from Earth species, and accompanied by an active and stable hydrosphere."
	scan_assessment = "High probability of human terraforming."
	color = "#58aa8b"
	planetary_area = /area/exoplanet/grass
	rock_colors = list(COLOR_ASTEROID_ROCK, COLOR_GRAY80, COLOR_BROWN)
	plant_colors = list("#2f573e","#24574e","#6e9280","#9eab88","#868b58", "#84be7c", "RANDOM")
	map_generators = list(/datum/random_map/noise/exoplanet/lush/terraformed)
	lightlevel = 0.5
	has_trees = TRUE
	flora_diversity = 8
	fauna_types = list(/mob/living/simple_animal/friendly/cat, /mob/living/simple_animal/friendly/chicken, /mob/living/simple_animal/friendly/mouse, /mob/living/simple_animal/friendly/opossum, /mob/living/simple_animal/hostile/retaliate/goat, /mob/living/simple_animal/hostile/retaliate/goose, /mob/living/simple_animal/friendly/cow)
	megafauna_types = list(/mob/living/simple_animal/hostile/retaliate/parrot/space/megafauna, /mob/living/simple_animal/hostile/retaliate/goose/dire)

	//Animals being named alien creature is a bit odd as these would just be earth transplants
	species = list( /mob/living/simple_animal/friendly/cat 					  = "wild cat",
					/mob/living/simple_animal/friendly/chicken 				  = "wild chicken",
					/mob/living/simple_animal/friendly/mouse 				  = "mouse",
					/mob/living/simple_animal/friendly/opossum 				  =	"opossum",
					/mob/living/simple_animal/hostile/retaliate/goat		  = "wild goat",
					/mob/living/simple_animal/hostile/retaliate/goose		  = "goose",
					/mob/living/simple_animal/friendly/cow 					  = "wild cow")

/obj/effect/overmap/visitable/sector/exoplanet/lush/lifeseeded/generate_habitability()
	habitability_class = HABITABILITY_IDEAL

/obj/effect/overmap/visitable/sector/exoplanet/lush/generate_map()
	lightlevel = rand(0.7,0.9)/10
	..()

/datum/random_map/noise/exoplanet/lush/terraformed
	descriptor = "life-seeded exoplanet"
	flora_prob = 15
	large_flora_prob = 30
