#===============================================================================
# Social Link Profile registrations
#
# These are the Social Links for individual NPCs the player can interact with.
#===============================================================================
# Parameters:
#   - :id => Symbol - The ID of the Social Link 
#   - :name => String - The name of the NPC
#   - :image => String - The filename of the image used to represent the NPC's profile picture. 
#               File location: UI/Social Links/Profile Pictures
#   - :init_location => (Optional) String - The default location to show for the Social Link
#   - :init_status => (Optional) String - The default status message to show for the Social link
#   - :favorite_pokemon => (Optional) The default favorite Pokemon for the Social link. You have two options to set:
#                       - Set to a Symbol defining the species of Pokemon
#                       - Set to an array with the following structure:
#                         [Symbol of the species of Pokemon, gender (0 = male, 1 = female), form number, shiny? (true or false)]
#   - :im_contact_id => [Requires the Instant Messages plugin] (Optional) Symbol defining the Contact ID to associate with this Social Link
#   - :bond_max => (Optional) Integer - The max bond level of the NPC, which overrides BOND_LEVEL_MAX
#   - :bond_icon_coords => (Optional) Array - Set custom bond icon coordinates. Review the BOND_ICON_COORDS setting for instructions on how to set up.
#   - :bond_effects => (Optional) Hash defining bond effects gained at certain bond levels. Use the following structure:
#                           {
#                               Integer => [[:EFFECT_TYPE, :TYPE, rate]],
#                           }
#                               - Integer => The bond level needed to gain the effect
#                               - :EFFECT_TYPE => Set as either :EXP or :Shiny, depending on which effect you want
#                               - :TYPE => Symbol defining the type of Pokemon to get the effects
#                               - rate => Set as either a Float to multiply the EXP rate by, or Integer to add that number of retries for being a shiny.
#
#      NOTE: If multiple EXP rates or shiny retries can be applied at once, either by the same Social Link or across all Social Links, only
#           the highest rate/retry value will be applied. For dual type Pokemon, rates/retries do not stack between the two types; only the
#           highest rate/retry value between the two types will be used.
#           For example:
#               - If one Social Link provide a 1.3 EXP rate for Fire types, and a second Social Link provides a 1.5 EXP rate for Fire types, only the 
#                 1.5 EXP rate will apply, not 1.5 * 1.3.
#               - If you have active effects for Normal types to gain 1.3 EXP, and Flying types to gain 1.2 EXP, a Pidgey will only gain 1.3 EXP, not 1.3 * 1.2.
#               - If you have active effects for Normal types to have 3 extra shiny retries, and Flying types to have 1 extra shiny retry, a Pidgey will only 
#                 gain 3 extra shiny retries, not 3 + 1.
#
#
#   - :static_status_pool => (Optional) An Array of Strings. These are predefined status messages you can make appear for the
#                            Social Link using pbSetSocialLinkStatus
#   - :random_status_pool => (Optional) An Array of Arrays. These are predefined status messages you can make appear for the
#                            Social Link using pbSetSocialLinkStatusRandom. Each status message can have a minimum bond level
#                            in order to appear. For each subarray, use the following structure:
#                               [Status, MinBondLevel]
#                               - Status => String representing the status message
#                               - MinBondLevel => (Optional) Integer representing the minimum bond level needed for this status to appear.
#===============================================================================

GameData::SocialLinkProfile.register({
    :id             => :PROFMAPLE,
    :name		    => _INTL("Professor Maple"),
    :image		    => "Maple",
    :init_location  => _INTL("Pokémon Lab"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level, gain another random starter"),
    :favorite_pokemon => :EXEGGUTOR,
	:static_status_pool => ["Rewards :<br>  For each ♥ level, gain another random starter"]

})

GameData::SocialLinkProfile.register({
    :id             => :MARLEY,
    :name		    => _INTL("Marley"),
    :image		    => "Marley",
	:init_location  => _INTL("Your Gym"),
	:favorite_pokemon => [:DUGTRIO,0,1,true],
    :init_status    => _INTL("Rewards :<br>  Gain shiny chance with each ♥ level"),
	

})

GameData::SocialLinkProfile.register({
    :id             => :NURSES,
    :name		    => _INTL("Nurses"),
    :image		    => "Nurses",
	:init_location  => _INTL("Your Town's PokéCenter"),
	:favorite_pokemon => :BLISSEY,
    :init_status    => _INTL("Rewards :<br>  One more Life Vial utilisation with each ♥ level"),
	

})

GameData::SocialLinkProfile.register({
    :id             => :RIVALNormal,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :RIOLU
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALGrass,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :NIDORANfE
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALFire,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :GIBLE
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALWater,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :PICHU
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALElectric,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :GIBLE
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALFighting,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :RALTS
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALPoison,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :GIBLE
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALGround,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :SPHEAL
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALFlying,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :PICHU
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALPsychic,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :ZORUA
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALBug,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :ROOKIDEE
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALRock,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :RIOLU
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALGhost,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :ZORUA
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALIce,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :RIOLU
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALDragon,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :TINKATINK
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALDark,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :RIOLU
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALSteel,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :RIOLU
    
})

GameData::SocialLinkProfile.register({
    :id             => :RIVALFairy,
    :name		    => _INTL("Rival"),
    :image		    => "Rival",
    :init_location  => _INTL("???"),
    :init_status    => _INTL("Rewards :<br>??? "),
    :favorite_pokemon => :NIDORANfE
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYNormal,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :MUNCHLAX
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYGrass,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :CHERUBI
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYFire,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :MAGBY
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYWater,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :MANTYKE
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYElectric,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :PACHIRISU
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYFighting,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :TYROGUE
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYPoison,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => [:WOOPER,0,1,false],
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYGround,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :WOOPER
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYFlying,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :ORICORIO
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYPsychic,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :WYNAUT
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYBug,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :CUTIEFLY
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYRock,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :BONSLY
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYGhost,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :MIMIKYU
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYIce,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :SMOOCHUM
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYDragon,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :SWABLU
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYDark,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :MORPEKO
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYSteel,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :TOGEDEMARU
    
})

GameData::SocialLinkProfile.register({
    :id             => :MELLYFairy,
    :name		    => _INTL("Melly"),
    :image		    => "Melly",
    :init_location  => _INTL("Your Gym"),
    :init_status    => _INTL("Rewards :<br>  For each ♥ level,<br>  - Melly will have a better team<br> - ??? "),
    :favorite_pokemon => :DEDENNE
    
})

