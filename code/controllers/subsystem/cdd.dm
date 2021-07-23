var/datum/subsystem/cdd/SScdd

/datum/subsystem/cdd
	name = "Continuous Delivery Daemare"
	wait = 20 SECONDS
	priority = SS_DISPLAY_CDD
	flags = SS_BACKGROUND | SS_FIRE_IN_LOBBY

	var/should_restart = FALSE
	var/last_vote_time = -SS_CDD_VOTE_CD

/datum/subsystem/cdd/New()
	NEW_SS_GLOBAL(SScdd)

/datum/subsystem/cdd/fire(resumed = FALSE)
	// Make a GET request with the number of players to the daemare
	var/http[] = world.Export("[config.cdd_address]?players=[clients.len]")
	if (!http)
		return

	var/F = http["CONTENT"]
	// did you know the code for voting is in modules/html_interface?
	if (F && file2text(F) == "restart") 
		should_restart = TRUE

	// If there are no players on, reboot now
	if (should_restart && (clients.len == 0))
		if(blackbox)
			blackbox.save_all_data_to_sql()
		CallHook("Reboot",list())
		sleep(50)
		log_game("Rebooting for update")
		world.pre_shutdown()
		shutdown()
		return // just in case
		
	// Will not start if there is already a vote going
	// A non-stopping vote will put us on cooldown for 15 minutes since the vote was called
	if (should_restart && vote.currently_voting == FALSE && vote.is_updating == FALSE && (world.time > (last_vote_time + SS_CDD_VOTE_CD)))
		vote.initiate_vote("update", "Continuous Delivery Daemare")
		last_vote_time = vote.started_time

/datum/subsystem/cdd/proc/debug_info()
	return "should_restart: [should_restart]\n" + "currently_voting: [vote.currently_voting]\n" + "is_updating: [vote.is_updating]\n" + "world.time: [world.time]\n" + "last_vote_time + SS_CDD_VOTE_CD: [last_vote_time + SS_CDD_VOTE_CD]\n"

/datum/subsystem/cdd/Shutdown()
	world.Export("[config.cdd_address]?shutdown")
