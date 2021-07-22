/mob/living/simple_animal/pony
	name = "pony"
	desc = "Ah, ah, ah, ah."
	icon_state = "pony1"
	icon_living = "pony1"
	icon_dead = "pony1"
	gender = FEMALE
	size = SIZE_SMALL

	speak = list("Neigh!", "Nicker!")
	speak_emote = list("squees")
	emote_hear = list("squees")
	emote_see = list("waves its hoof", "smiles")
	emote_sound = list("sound/misc/squee.ogg")
	speak_chance = 1
	turns_per_move = 5

	species_type = /mob/living/simple_animal/pony

	response_help  = "boops"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"
	min_oxy = 16      // Require atleast 16kPA oxygen
	minbodytemp = 223 // Below -50 Degrees Celcius
	maxbodytemp = 323 // Above 50 Degrees Celcius

/mob/living/simple_animal/pony/syndieponk
	name = "Syndieponk"
	desc = "Secure the disk!"
	icon_state = "pony2"
	icon_living = "pony2"
	icon_dead = "pony2"
