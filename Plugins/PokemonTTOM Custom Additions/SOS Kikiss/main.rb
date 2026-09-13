# SOS Kikiss 1.0
ItemHandlers::UseFromBag.add(:SOSKIKISS, proc { |item|
	next 2
})

ItemHandlers::UseInField.add(:SOSKIKISS, proc{ |item|
	if !$game_map.metadata&.outdoor_map
		pbMessage(_INTL("You have to be outside to call Kikiss!"))
		next 1
	end
	if pbConfirmMessage(_INTL("Do you want to ask Kikiss to bring you back to Maple's lab?"))
		pbHiddenMoveAnimation(Pokemon.new(:TOGEKISS, 98))
		pbSEPlay("Fly")
		pbToneChangeAll(Tone.new(-255, -255, -255), 5)
		pbWait(0.5)
		$game_temp.player_new_map_id    = 8
		$game_temp.player_new_x         = 7
		$game_temp.player_new_y         = 14
		$game_temp.player_new_direction = 2
		pbDismountBike
		$scene.transfer_player
		$town.build_town 
		$game_map.autoplay
		$game_map.refresh
		pbWait(0.5)
		pbToneChangeAll(Tone.new(0, 0, 0), 5)
		pbEraseEscapePoint
		next 1
	end
})