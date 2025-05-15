module Settings
    #====================================================================================
    #=============================== Tip Cards Settings =================================
    #====================================================================================
    
        #--------------------------------------------------------------------------------
        #  Set the default background for tip cards.
        #  The files are located in Graphics/Pictures/Tip Cards
        #--------------------------------------------------------------------------------	
        TIP_CARDS_DEFAULT_BG            = "bg"

        #--------------------------------------------------------------------------------
        #  If set to true, if only one group is shown when calling pbRevisitTipCardsGrouped,
        #  the group header will still appear. Otherwise, the header won't appear.
        #--------------------------------------------------------------------------------	
        TIP_CARDS_SINGLE_GROUP_SHOW_HEADER = false

        #--------------------------------------------------------------------------------
        #  If set to true, when the player uses the SPECIAL control, a list of all
        #  groups available to view will appear for the player to jump to one.
        #--------------------------------------------------------------------------------	
        TIP_CARDS_GROUP_LIST = false

        #--------------------------------------------------------------------------------
        #  Set the default text colors
        #--------------------------------------------------------------------------------	
        TIP_CARDS_TEXT_MAIN_COLOR       = Color.new(80, 80, 88)
        TIP_CARDS_TEXT_SHADOW_COLOR     = Color.new(160, 160, 168)

        #--------------------------------------------------------------------------------
        #  Set the sound effect to play when showing, dismissing, and switching tip cards.
        #  For TIP_CARDS_SWITCH_SE, set to nil to use the default cursor sound effect.
        #--------------------------------------------------------------------------------	
        TIP_CARDS_SHOW_SE               = "GUI menu open"
        TIP_CARDS_DISMISS_SE            = "GUI menu close"
        TIP_CARDS_SWITCH_SE             = nil

        #--------------------------------------------------------------------------------
        #  Define your tips in this hash. The :EXAMPLE describes what some of the 
        #  parameters do.
        #--------------------------------------------------------------------------------	
        TIP_CARDS_CONFIGURATION = {
            :EXAMPLE => { # ID of the tip
                    # Required Settings
                    :Title => _INTL("Example Tip"),
                    :Text => _INTL("This is the text of the tip. You can include formatting."),
                    # Optional Settings
                    :Image => "example", # An image located in Graphics/Pictures/Tip Cards/Images
                    :ImagePosition => :Top, # Set to :Top, :Bottom, :Left, or :Right.
                        # If not defined, it will place wider images to :Top, and taller images to :Left.
                    :Background => "bg2", # A replacement background image located in Graphics/Pictures/Tip Cards
                    :YAdjustment => 0, # Adjust the vertical spacing of the tip's text (in pixels)
                    :HideRevisit => true # Set to true if you don't want the player to see the tip again when revisiting seen tips.
            },
			
			:DAYRECAP1 => {
                :Title => _INTL("Day recap"),
                :Text => _INTL("WIP"),
                :Background => "bg2",
				:Recap => 1
			},
			
			:DAYRECAP2 => {
                :Title => _INTL("Fame gains"),
                :Text => _INTL("WIP"),
                :Background => "bg2",
				:Recap => 2
			},
			
			:DAYRECAP3 => {
                :Title => _INTL("Fame Progression"),
                :Text => _INTL("WIP"),
                :Background => "bg2",
				:Recap => 3
			},
			
			:WEEKENDBONUS => {
                :Title => _INTL("Week End Bonus"),
                :Text => _INTL("WIP"),
                :Background => "bg2",
				:Weekend => 1
			},
			
			:WEEKENDFAME => {
                :Title => _INTL("Fame Progression"),
                :Text => _INTL("WIP"),
                :Background => "bg2",
				:Weekend => 2
			},
			
			:MIDWEEKRECAP => {
                :Title => _INTL("Mid-Week Bonus"),
                :Text => _INTL("WIP"),
                :Background => "bg2",
				:Weekend => 3
			},
			
			:GYMINFOS1 => {
				:Title => _INTL("Gym general informations"),
                :Text => _INTL("WIP"),
                :Background => "bg2",
				:GymInfos => 1
			},
			
			:GYMINFOS2 => {
				:Title => _INTL("Fame Progression"),
                :Text => _INTL("WIP"),
                :Background => "bg2",
				:GymInfos => 2
			},
			
			:MELLYINFOS => {
				:Title => _INTL("Melly"),
                :Text => _INTL("WIP"),
                :Image => "MELLY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:TrainersInfos => 1
			},
			
			:SAMYINFOS => {
				:Title => _INTL("Samy"),
                :Text => _INTL("WIP"),
                :Image => "MELLY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:TrainersInfos => 2
			},
			
			:KIANAINFOS => {
				:Title => _INTL("Kiana"),
                :Text => _INTL("WIP"),
                :Image => "MELLY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:TrainersInfos => 3
			},
			
			:RIVALINFOS => {
				:Title => _INTL("Rival"),
                :Text => _INTL("WIP"),
                :Image => "MELLY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:TrainersInfos => 4
			},
			
			#---------------------------------------------------------------------------------------
			#
			#	Tutorials
			#
			#---------------------------------------------------------------------------------------
			
			#---------------------------------------------------------------------------------------
			#	Social Links
			#---------------------------------------------------------------------------------------			
			:SOCIALLINKS1 => {
                :Title => _INTL("Social Links - Presentation"),
                :Text => _INTL("The Social Links system represents your relation with various PNJs. Improve those relations to gain various rewards!"),
                :Background => "bg2",
			},
			:SOCIALLINKS2 => {
                :Title => _INTL("Social Links - List"),
                :Text => _INTL("In the Social links screen menu you can see all of you relations, and the level of these."),
                :Image => "sociallinks_list",
				:ImagePosition => :Topcenter,
                :Background => "bg2",
			},
			:SOCIALLINKS3 => {
                :Title => _INTL("Social Links - Infos"),
                :Text => _INTL("By selecting a link you can see various infos - their favorite Pokémon, their location, and the rewards you can get by improving your bond."),
                :Image => "sociallinks_infos",
				:ImagePosition => :Topcenter,
                :Background => "bg2",
			},
			:SOCIALLINKS4 => {
                :Title => _INTL("Social Links - Improve bonds"),
                :Text => _INTL("You can improve your bond by completing their quests, offering them gift, and spending time with them during the weekend.\nDuring the Introduction, these mecanisms aren't available. More infos later."),
                :Background => "bg2",
			},
			
			#---------------------------------------------------------------------------------------
			#	Pokédex & Pokémon resume
			#---------------------------------------------------------------------------------------			
			:POKEMON1 => {
                :Title => _INTL("Pokemon Resume"),
                :Text => _INTL("Submenu of the first screen allows you notably to modify Pokémon nickname, or directly access its Pokedex entry."),
				:Image => "pokemon_resume",
				:ImagePosition => :Topcenter,
                :Background => "bg2",
			},
			:POKEMON2 => {
                :Title => _INTL("Pokemon legacy"),
                :Text => _INTL("The next page offers little info but the submenu allows you to access legacy info on the Pokémon - check it out!"),
                :Image => "pokemon_legacy",
				:ImagePosition => :Topcenter,
                :Background => "bg2",
			},
			:POKEMON3 => {
                :Title => _INTL("Pokemon Resume - EV and IV"),
                :Text => _INTL("In the stat page, you can see which stats are boosted (red) or lowered (blue) by nature. You can also see IV, EV and Hidden Power type by pressing enter."),
                :Image => "pokemon_stats",
				:ImagePosition => :Right,
                :Background => "bg2",
			},
			:POKEMON4 => {
                :Title => _INTL("Pokemon Resume - Move relearner"),
                :Text => _INTL("In the move page, the submenu allows you to check, forget but also relearn moves wherever you are."),
				:Image => "pokemon_relearn",
				:ImagePosition => :Topcenter,
                :Background => "bg2",
			},
			:POKEMON5 => {
                :Title => _INTL("Pokedex - Data page"),
                :Text => _INTL("The Pokédex notably have the DATA page, which shows you nearly every info you can imagine on the species - check it out!"),
                :Image => "pokemon_pokedex",
				:ImagePosition => :Topcenter,
                :Background => "bg2",
			},
			
			#---------------------------------------------------------------------------------------
			#	Quest System
			#---------------------------------------------------------------------------------------			
			:QUESTS1 => {
                :Title => _INTL("Quests System - Presentation"),
                :Text => _INTL("The Quest System tracks the various tasks given to you by various PNJs."),
                :Background => "bg2",
			},
			:QUESTS2 => {
                :Title => _INTL("Quests System - List"),
                :Text => _INTL("You can see all of your quests in the Quest System screen menu."),
                :Image => "quests_list",
				:ImagePosition => :Topcenter,
                :Background => "bg2",
			},
			:QUESTS3 => {
                :Title => _INTL("Quests System - Color"),
                :Text => _INTL("Each quest has a color code depending on what you have to do to complete it:\n- Gold: Main Quests (various objectives)\n- Red: Battle Quest (win battle(s))\n- Blue: Item Quest (give/find an item)\n- Green: Pokémon Quest (give/show a Pokémon, an Egg...)"),
                :Background => "bg2",
			},
			:QUESTS4 => {
                :Title => _INTL("Quests System - Infos"),
                :Text => _INTL("You can select a quest to have more infos (localisation, who gave it to you, reward...)"),
                :Image => "quests_infos",
				:ImagePosition => :Left,
                :Background => "bg2",
			},
			
			#---------------------------------------------------------------------------------------
			#	Nekanta Map
			#---------------------------------------------------------------------------------------			
			:MAP1 => {
                :Title => _INTL("Nekanta Map - Overview"),
                :Text => _INTL("The Nekanta map shows you the layout of the Nekanta Region"),
                :Image => "map_overview",
				:ImagePosition => :Topcenter,
                :Background => "bg2",
			},
			:MAP2 => {
                :Title => _INTL("Nekanta Map - Infos"),
                :Text => _INTL("Selecting a place shows you infos (trainers, Pokémons, items...)"),
                :Image => "map_infos",
				:ImagePosition => :Topcenter,
                :Background => "bg2",
			},
			:MAP3 => {
                :Title => _INTL("Nekanta Map - Pokémon List"),
                :Text => _INTL("Pressing Right shows you the available wild Pokémons on this place"),
                :Image => "map_pkmnlist",
				:ImagePosition => :Topcenter,
                :Background => "bg2",
			},
			:MAP4 => {
                :Title => _INTL("Nekanta Map - Switch Pokémon categories"),
                :Text => _INTL("You can press Up or Down to change categories (night or day, water, oldrod...)"),
                :Image => "map_switch",
				:ImagePosition => :Topcenter,
                :Background => "bg2",
			},
			
			#---------------------------------------------------------------------------------------
			#	Time System
			#---------------------------------------------------------------------------------------			
			:TIME1 => {
                :Title => _INTL("Time System - Overview"),
                :Text => _INTL("The time in this game is NOT equal to real life time.\nThis game is split between two phases : Weekend and Weekdays. Time system is different during these phases."),
                :Background => "bg2",
			},
			:TIME2 => {
                :Title => _INTL("Time System - Weekend"),
                :Text => _INTL("Weekends are for free roaming and such. During weekends, this game uses dynamic time system as in Pokemon Legends Arceus. That means that 1 second in real life equals to 1 minute in game.You can see the current time in the start screen."),
                :Background => "bg2",
			},
			:TIME3 => {
                :Title => _INTL("Time System - Weekdays"),
                :Text => _INTL("During the weekdays, time is halted.\nThe weekdays are split in 3 time days :\n- Morning, equivalent to daytime\n- Afternoon, when you will be in your Gym battling challengers\n- Evening, equivalent to night time."),
                :Background => "bg2",
			},
			:TIME4 => {
                :Title => _INTL("Time System - Changing time"),
                :Text => _INTL("More infos on how these different phases flow together will be given later.\n\nOh and if you want to speed up the game, just press the AUX1 button (Default : TAB)"),
                :Background => "bg2",
			},
			
			#---------------------------------------------------------------------------------------
			#
			#	Trainers Tip cards
			#
			#---------------------------------------------------------------------------------------
			
			#---------------------------------------------------------------------------------------
			#	1 star trainers
			#---------------------------------------------------------------------------------------
			:BUGCATCHER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Bug Catcher"),
                :Image => "BUGCATCHER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:CAMPERBOY => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Camper &m;"),
                :Image => "CAMPERBOY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:CAMPERGIRL => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Camper &f;"),
                :Image => "CAMPERGIRL",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:FUNOLDLADY => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Fun Old Lady"),
                :Image => "FUNOLDLADY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:FUNOLDMAN => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Fun Old Man"),
                :Image => "FUNOLDMAN",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:IDOL => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Idol"),
                :Image => "IDOL",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:LADY => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Lady"),
                :Image => "LADY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:NURSE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Nurse"),
                :Image => "NURSE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:POKEFANFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Pokéfan &f;"),
                :Image => "POKEFANFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:POKEFANMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Pokéfan &m;"),
                :Image => "POKEFANMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:POKEKIDBOY => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Pokekid &m;"),
                :Image => "POKEKIDBOY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:POKEKIDGIRL => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Pokekid &f;"),
                :Image => "POKEKIDGIRL",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:PRESCHOOLERBOY => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Preschooler &m;"),
                :Image => "PRESCHOOLERBOY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:PRESCHOOLERGIRL => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Preschooler &f;"),
                :Image => "PRESCHOOLERGIRL",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:RICHBOY => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Rich Boy"),
                :Image => "RICHBOY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:SCHOOLBOY => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Schoolboy"),
                :Image => "SCHOOLBOY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:SCHOOLGIRL => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Schoolgirl"),
                :Image => "SCHOOLGIRL",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:TOURISTFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Tourist &f;"),
                :Image => "TOURISTFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:TUBERBOY => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Tuber &m;"),
                :Image => "TUBERBOY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:TUBERGIRL => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Tuber &f;"),
                :Image => "TUBERGIRL",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			:YOUNGSTER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Youngster"),
                :Image => "YOUNGSTER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 1
			},
			
			
			#---------------------------------------------------------------------------------------
			#	2 stars trainers
			#---------------------------------------------------------------------------------------
			:BACKPACKERMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Backpacker &m;"),
                :Image => "BACKPACKERMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:BACKPACKERFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Backpacker &f;"),
                :Image => "BACKPACKERFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:BELLHOP => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Bellhop"),
                :Image => "BELLHOP",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:BUGMANIAC => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Bug Maniac"),
                :Image => "BUGMANIAC",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:CLOWN => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Clown"),
                :Image => "CLOWN",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:COLLECTOR => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Colector"),
                :Image => "COLLECTOR",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:ENGINEER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Engineer"),
                :Image => "ENGINEER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:FAIRYTALEGIRL => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Fairy Tale Girl"),
                :Image => "FAIRYTALEGIRL",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:FISHERMAN => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Fisherman"),
                :Image => "FISHERMAN",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:FISHERWOMAN => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Fisherwoman"),
                :Image => "FISHERWOMAN",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:FURISODEGIRLBLACK => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Furisode Girl - Black"),
                :Image => "FURISODEGIRLBLACK",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:FURISODEGIRLBLUE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Furisode Girl - Blue"),
                :Image => "FURISODEGIRLBLUE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:FURISODEGIRLPURPLE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Furisode Girl - Purple"),
                :Image => "FURISODEGIRLPURPLE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:FURISODEGIRLWHITE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Furisode Girl - White"),
                :Image => "FURISODEGIRLWHITE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:GENTLEMAN => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Gentleman"),
                :Image => "GENTLEMAN",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:JANITOR => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Janitor"),
                :Image => "JANITOR",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:KIMONOGIRL => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Kimono Girl"),
                :Image => "KIMONOGIRL",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:LASS => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Lass"),
                :Image => "LASS",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:MAID => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Maid"),
                :Image => "MAID",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:MODEL => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Model"),
                :Image => "MODEL",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:NINJABOY => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Ninja Boy"),
                :Image => "NINJABOY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:PAINTER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Painter"),
                :Image => "PAINTER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:PKMNBREEDERMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Pokemon Breeder &m;"),
                :Image => "POKEMONBREEDERMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:PKMNBREEDERFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Pokemon Breeder &f;"),
                :Image => "POKEMONBREEDERFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:POKEMANIAC => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Poké Maniac"),
                :Image => "POKEMANIAC",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:PUNKMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Punk &m;"),
                :Image => "PUNKMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:PUNKFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Punk &f;"),
                :Image => "PUNKFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:SWIMMERMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Swimmer &m;"),
                :Image => "SWIMMERMAN",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:SWIMMERFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Swimmer &f;"),
                :Image => "SWIMMERMAN",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:TEAMGRUNTFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Team Absolution Grunt &f;"),
                :Image => "TEAMGRUNTFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			:TEAMGRUNTMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Team Absolution Grunt &m;"),
                :Image => "TEAMGRUNTMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			
			#---------------------------------------------------------------------------------------
			#	3 stars trainers
			#---------------------------------------------------------------------------------------
			:AROMALADY => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Aroma Lady"),
                :Image => "AROMALADY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:ARTISTFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Artist &f;"),
                :Image => "ARTISTFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:ARTISTMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Artist &g;"),
                :Image => "ARTISTMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:BAKER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Baker"),
                :Image => "BAKER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:BEAUTY => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Beauty"),
                :Image => "BEAUTY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:BIKER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Biker"),
                :Image => "BIKER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:BURGLAR => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Burglar"),
                :Image => "BURGLAR",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:BUTLER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Butler"),
                :Image => "BUTLER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:CABBIE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Cabbie"),
                :Image => "CABBIE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:CHANNELER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Channeler"),
                :Image => "CHANNELER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:CHEF => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Chef"),
                :Image => "CHEF",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:CLERKFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Clerk &f;"),
                :Image => "CLERKFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:CLERKMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Clerk &m;"),
                :Image => "CLERKMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:COOK => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Cook"),
                :Image => "COOK",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:COWGIRL => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Cowgirl"),
                :Image => "COWGIRL",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:CYCLISTFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Cyclist &f;"),
                :Image => "CYCLISTFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:CYCLISTMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Cyclist &m;"),
                :Image => "CYCLISTMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:DANCER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Dancer"),
                :Image => "DANCER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:DELINQUENT => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Delinquent"),
                :Image => "DELINQUENT",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:DOCTORFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Doctor &f;"),
                :Image => "DOCTORFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:DOCTORMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Doctor &g;"),
                :Image => "DOCTORMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:FIREBREATHER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Firebreather"),
                :Image => "FIREBREATHER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:GARDENER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Gardener"),
                :Image => "GARDENER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:GOLFER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Golfer"),
                :Image => "GOLFER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:GUITARIST => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Guitarist"),
                :Image => "GUITARIST",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:HIKER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Hiker"),
                :Image => "HIKER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:HOOPSTER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Hoopster"),
                :Image => "HOOPSTER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:INFIELDER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Infielder"),
                :Image => "INFIELDER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:JOGGER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Jogger"),
                :Image => "JOGGER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:KINDLER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Kindler"),
                :Image => "KINDLER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:LINEBACKER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Linebacker"),
                :Image => "LINEBACKER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:MUSICIAN => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Musician"),
                :Image => "MUSICIAN",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:PARASOLLADY => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Parasol Lady"),
                :Image => "PARASOLLADY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:POSTMAN => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Postman"),
                :Image => "POSTMAN",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:ROLLERSKATERFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Roller Skater &f;"),
                :Image => "ROLLERSKATERFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:ROLLERSKATERMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Roller Skater &g;"),
                :Image => "ROLLERSKATERMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:RUINMANIAC => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Ruin Maniac"),
                :Image => "RUINMANIAC",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:SAGE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Sage"),
                :Image => "SAGE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:SAILOR => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Sailor"),
                :Image => "SAILOR",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:SKIERFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Skier &f;"),
                :Image => "SKIERFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:SKIERMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Skier &m;"),
                :Image => "SKIERMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:SMASHER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Smasher"),
                :Image => "SMASHER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:STRIKER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Striker"),
                :Image => "STRIKER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:SURFER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Surfer"),
                :Image => "SURFER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:TAMER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Tamer"),
                :Image => "TAMER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:TEACHER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Teacher"),
                :Image => "TEACHER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:WORKERFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Worker &f;"),
                :Image => "WORKERFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			:WORKERMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Worker &m;"),
                :Image => "WORKERMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 3
			},
			
			#---------------------------------------------------------------------------------------
			#	4 stars trainers
			#---------------------------------------------------------------------------------------
			:BLACKBELT => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Black Belt"),
                :Image => "BLACKBELT",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:BOARDER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Boarder"),
                :Image => "BOARDER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:CRUSHGIRL => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Crush Girl"),
                :Image => "CRUSHGIRL",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:DIVERFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Diver &f;"),
                :Image => "DIVERFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:DIVERMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Diver &m;"),
                :Image => "DIVERMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:FIREFIGHTER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Firefighter"),
                :Image => "FIREFIGHTER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:HARLEQUIN => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Harlequin"),
                :Image => "HARLEQUIN",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:HEXMANIAC => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Hex Maniac"),
                :Image => "HEXMANIAC",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:JUGGLER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Juggler"),
                :Image => "JUGGLER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:MADAME => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Madame"),
                :Image => "MADAME",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:MONSIEUR => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Monsieur"),
                :Image => "MONSIEUR",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:PILOT => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Pilot"),
                :Image => "PILOT",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:PKMNRANGERFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Pokémon Ranger &f;"),
                :Image => "PKMNRANGERFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:PKMNRANGERMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Pokémon Ranger &m;"),
                :Image => "PKMNRANGERMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:PSYCHICFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Psychic &f;"),
                :Image => "PSYCHICFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:PSYCHICMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Psychic &m;"),
                :Image => "PSYCHICMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:RISINGSTARBOY => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Rising Star &m;"),
                :Image => "RISINGSTARBOY",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:RISINGSTARGIRL => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Rising Star &f;"),
                :Image => "RISINGSTARGIRL",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:ROUGHNECK => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Roughneck"),
                :Image => "ROUGHNECK",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:SCIENTISTFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Scientist &f;"),
                :Image => "SCIENTISTFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:SCIENTISTMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Scientist &m;"),
                :Image => "SCIENTISTMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:SKYTRAINERFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Sky Trainer &f;"),
                :Image => "SKYTRAINERFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:SKYTRAINERMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Sky Trainer &m;"),
                :Image => "SKYTRAINERMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
		
			:STREETTHUG => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Street Thug"),
                :Image => "STREETTHUG",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:SUPERNERD => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Super Nerd &f;"),
                :Image => "SUPERNERD",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:TRIATHLETEFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Triathlete &f;"),
                :Image => "TRIATHLETEFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:TRIATHLETEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Triathlete &m;"),
                :Image => "TRIATHLETEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:WAITER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Waiter"),
                :Image => "WAITER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:WAITRESS => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Waitress"),
                :Image => "WAITRESS",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:TEAMADMINFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Absolution Admin &f;"),
                :Image => "TEAMADMINFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			:TEAMADMINMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Absolution Admin &m;"),
                :Image => "TEAMADMINMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 4
			},
			
			#---------------------------------------------------------------------------------------
			#	5 stars trainers
			#---------------------------------------------------------------------------------------
			:ACETRAINERFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Ace Trainer &f;"),
                :Image => "ACETRAINERFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 5
			},
			
			:ACETRAINERMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Ace Trainer &m;"),
                :Image => "ACETRAINERMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 5
			},
			
			:BATTLEGIRL => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Battle Girl"),
                :Image => "BATTLEGIRL",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 5
			},
			
			:BIRDKEEPER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Bird Keeper"),
                :Image => "BIRDKEEPER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 5
			},
			
			:COOLTRAINERFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Cool Trainer &f;"),
                :Image => "COOLTRAINERFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 5
			},
			
			:COOLTRAINERMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Cool Trainer &m;"),
                :Image => "COOLTRAINERMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 5
			},
			
			:DRAGONTAMER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Dragon Tamer"),
                :Image => "DRAGONTAMER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 5
			},
			
			:EXPERTFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Expert &f;"),
                :Image => "EXPERTFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 5
			},
			
			:EXPERTMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Expert &m;"),
                :Image => "EXPERTMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 5
			},
			
			:GAMBLER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Gambler"),
                :Image => "GAMBLER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 5
			},
			
			:OWNER => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Owner"),
                :Image => "OWNER",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 5
			},
			
			:TEAMGENIUS => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Team Absolution Genius"),
                :Image => "TEAMGENIUS",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 5
			},
			
			:VETERANFEMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Veteran &f;"),
                :Image => "VETERANFEMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 5
			},
			
			:VETERANMALE => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Veteran &g;"),
                :Image => "VETERANMALE",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 5
			},
			
			#---------------------------------------------------------------------------------------
			#	6 stars trainers
			#---------------------------------------------------------------------------------------
			
			#---------------------------------------------------------------------------------------
			#	7 stars trainers
			#---------------------------------------------------------------------------------------
			
			#---------------------------------------------------------------------------------------
			#	Rival tip cards
			#---------------------------------------------------------------------------------------
			:RIVALRANK1 => {
                :Title => _INTL("Challenger"),
                :Text => _INTL("Rival"),
                :Image => "RIVAL1",
				:ImagePosition => :Left,
                :Background => "bg2",
				:Stars => 2
			},
			#---------------------------------------------------------------------------------------
			#
			#	Town Development Tip cards
			#
			#---------------------------------------------------------------------------------------
			
			
			#---------------------------------------------------------------------------------------
			#	Fame 0
			#---------------------------------------------------------------------------------------
			:TOWNDEV0 => {
                :Title => _INTL("Gym Team - First Trainer"),
                :Text => _INTL("Allows you to have a trainer in your Gym."),
                :Image => "towndev0",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => "?",
				:Workers => "?",
				:BuildingIndex => 0
			},
			:TOWNDEV0REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Have a trainer in your Gym.\nChallengers coming in your Gym will battle the trainer before coming to you.\nYour trainer might win against them, earning you the money ; the challenger then have a chance to come back, effectively granting you double rewards."),
                :Background => "bg2",
			},
			
			
			:TOWNDEV1 => {
                :Title => _INTL("Gym Interiors - Lvl. 1"),
                :Text => _INTL("Base for your gym's interiors."),
                :Image => "towndev1",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => "?",
				:Workers => "?",
				:BuildingIndex => 1
			},
			:TOWNDEV1REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Basic interiors for your Gym. Allows challenger to come in and challenge your Gym."),
                :Background => "bg2",
			},
			
			
			:TOWNDEV2 => {
                :Title => _INTL("Leader's room - Lvl. 1"),
                :Text => _INTL("Base leader room."),
                :Image => "towndev2",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => "?",
				:Workers => "?",
				:BuildingIndex => 2
			},
			:TOWNDEV2REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Basic Leader Room. Allows you to battle challengers."),
                :Background => "bg2",
			},
			
			
			:TOWNDEV3 => {
                :Title => _INTL("Gym Exteriors - Lvl. 1"),
                :Text => _INTL("Base for your gym's exteriors."),
                :Image => "towndev3",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => "?",
				:Workers => "?",
				:BuildingIndex => 3
			},
			:TOWNDEV3REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Basic exteriors for your Gym. Allows challenger to know you have a Gym and that they can come in to challenge it!"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV4 => {
                :Title => _INTL("Pokémon Center - Floor 1"),
                :Text => _INTL("Reconstruction of the Pokémon Center."),
                :Image => "towndev4",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => "?",
				:Workers => "?",
				:BuildingIndex => 4
			},
			:TOWNDEV4REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Inside the pokémon Center, you can :\n- Heal your pokémons\n- Access the PC : Pokémon Storage\n- Bond with the nurses"),
                :Background => "bg2",
			},
			
			:TOWNDEV5 => {
                :Title => _INTL("Pokémon Lab - Lvl. 1"),
                :Text => _INTL("Prof. Maple's Lab. A kind of HQ for the Town."),
                :Image => "towndev5",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => "?",
				:Workers => "?",
				:BuildingIndex => 5
			},
			:TOWNDEV5REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Allows you to heal your Pokémons with the machine. Access to the Pokédex, Nekanta map and the Pokégear."),
                :Background => "bg2",
			},
			
			
			:TOWNDEV6 => {
                :Title => _INTL("Clearing - Your House"),
                :Text => _INTL("Clears the wreckage on your House."),
                :Image => "towndev6",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 0,
				:Workers => 1,
				:BuildingIndex => 6
			},
			:TOWNDEV6REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Allows the reconstruction of your house afterwards."),
                :Background => "bg2",
			},
			
			
			
			#---------------------------------------------------------------------------------------
			#	Fame 1
			#---------------------------------------------------------------------------------------			
			:TOWNDEV7 => {
                :Title => _INTL("Dept. Store - Floor 1 opening"),
                :Text => _INTL("Opens the first floor of the Dept. Store (Medicines & Balls)."),
                :Image => "towndev7",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 1500,
				:Workers => 0,
				:Instant => 1,
				:BuildingIndex => 7
			},
			:TOWNDEV7REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Unlocks these items:\n- Medicines : Potion, Paralyz heal, Antidote\n- Balls : Pokeball"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV8 => {
                :Title => _INTL("Gym Welcoming - Consolation"),
                :Text => _INTL("Send Marley on a formation to improve the odds of the challengers coming back after defeat."),
                :Image => "towndev8",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 1000,
				:Workers => 0,
				:BuildingIndex => 8
			},
			:TOWNDEV8REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Change the odds of challengers coming back :\n- Come back once : 50% -> 70% chances\n- Come back twice : 20%\n- Come back 3 times and more : 0%\n<i>Marley will be unavailable for the week</i>"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV9 => {
                :Title => _INTL("Gym Interiors - Lvl. 2"),
                :Text => _INTL("Improve interiors of your Gym. Repairs and clears everything."),
                :Image => "towndev9",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 1500,
				:Workers => 1,
				:BuildingIndex => 9
			},
			:TOWNDEV9REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Gain passive fame everyday.\nPassive fame : +5 per week."),
                :Background => "bg2",
			},
			
			
            :TOWNDEV10 => {
                :Title => _INTL("Pokémon Lab - Lvl. 2"),
                :Text => _INTL("Upgrades the Lab with a new scientist and research funds."),
                :Image => "towndev10",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 2000,
				:Workers => 0,
				:Instant => 1,
				:BuildingIndex => 10
			},
			:TOWNDEV10REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Various rewards :\n- New scientist (and his quest)\n- Improved version of the Pokégear : access to the Jukebox and the Town Status Center.\n- Passive town income +500 per week"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV11 => {
                :Title => _INTL("Your House"),
                :Text => _INTL("Build your House."),
                :Image => "towndev11",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 2500,
				:Workers => 1,
				:BuildingIndex => 11
			},
			:TOWNDEV11REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Unlocks the running shoes.\nAllows you to sleep until the next day in your house."),
                :Background => "bg2",
			},
			
			
			:TOWNDEV12 => {
                :Title => _INTL("Clearing - House n°1"),
                :Text => _INTL("Clears the wreckage on the house n°1."),
                :Image => "towndev12",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 0,
				:Workers => 1,
				:BuildingIndex => 12
			},
			:TOWNDEV12REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Allows the reconstruction of the house n°1 afterwards."),
                :Background => "bg2",
			},
			
			
			:TOWNDEV13 => {
                :Title => _INTL("Clearing - Town exteriors"),
                :Text => _INTL("Clears the wreckage of the town's roads."),
                :Image => "towndev13",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 0,
				:Workers => 1,
				:BuildingIndex => 13
			},
			:TOWNDEV13REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Give access to the rest of the Town. Gain access to the south west exit of the Town, which lead to the Daycare.\nThe Daycare couple have an egg for you!"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV14 => {
                :Title => _INTL("Clearing - Major Spot n°1"),
                :Text => _INTL("Clears the wreckage on the major spot n°1."),
                :Image => "towndev14",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 0,
				:Workers => 1,
				:BuildingIndex => 14
			},
			:TOWNDEV14REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Allows the reconstruction of the trainer's academy afterwards."),
                :Background => "bg2",
			},
			
			#---------------------------------------------------------------------------------------
			#	Fame 5
			#---------------------------------------------------------------------------------------		
			
			
			:TOWNDEV15 => {
                :Title => _INTL("Dept.Store - Floor 2 opening"),
                :Text => _INTL("Opens the second floor of the Dept. Store (Exploration items & Berries)."),
                :Image => "towndev15",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 1500,
				:Workers => 0,
				:Instant => 1,
				:BuildingIndex => 15
			},
			:TOWNDEV15REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Unlocks these items:\n- Exploration items: Escape rope, Repel\n- Berries: Oran, Cheri, Chesto, Pecha, Rawst, Aspear, Persim"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV16 => {
                :Title => _INTL("Dept.Store - Floor 1 Lvl. 2"),
                :Text => _INTL("Upgrades the first floor of the Department Store (Medicines & Balls)."),
                :Image => "towndev16",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 2500,
				:Workers => 0,
				:Instant => 1,
				:BuildingIndex => 16
			},
			:TOWNDEV16REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Unlocks these items:\n- Medicines : Super Potion, Burn heal, Awakening\n- Balls : Greatball"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV17 => {
                :Title => _INTL("Gym Team - Second trainer"),
                :Text => _INTL("Allows you to have another trainer on your Gym."),
                :Image => "towndev17",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 1500,
				:Workers => 0,
				:Instant => 1,
				:BuildingIndex => 17
			},
			:TOWNDEV17REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Second trainer on your Gym - more chances to have double rewards!\n<i>You will have to find and meet this trainer first</i>"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV18 => {
                :Title => _INTL("Leader room - Lvl.2"),
                :Text => _INTL("Upgrades the visuals of your Leader room."),
                :Image => "towndev18",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 2000,
				:Workers => 1,
				:BuildingIndex => 18
			},
			:TOWNDEV18REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Improve the money earned from the challengers (and the money lost when losing!) by 10%."),
                :Background => "bg2",
			},
			
			
			:TOWNDEV19 => {
                :Title => _INTL("Pokémon Center - Mezzanine"),
                :Text => _INTL("Give access to the PokéCenter's mezzanine - The help center."),
                :Image => "towndev19",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 1500,
				:Workers => 1,
				:BuildingIndex => 19
			},
			:TOWNDEV19REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("PokéCenter Mezzanine :\n- Help board (various quests)\n- Prof board (achievement system)"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV20 => {
                :Title => _INTL("Negociations - Double battle"),
                :Text => _INTL("Allows you to toggle single or double battle for your Gym battle."),
                :Image => "towndev20",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 3000,
				:Workers => 0,
				:Instant => 1,
				:BuildingIndex => 20
			},
			:TOWNDEV20REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Allows you to toggle single or double battle for your Gym battle."),
                :Background => "bg2",
			},
			
			
			:TOWNDEV21 => {
                :Title => _INTL("House n°1"),
                :Text => _INTL("Build the first house : Melly's house."),
                :Image => "towndev21",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 3000,
				:Workers => 1,
				:BuildingIndex => 21
			},
			:TOWNDEV21REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Various rewards:\n- Melly will be glad!\n- An additionnal worker, Melly's mother\n- Unlocks the name changer, Melly's father"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV22 => {
                :Title => _INTL("Clearing - Block 1"),
                :Text => _INTL("Clears the wreckage on the Block 1."),
                :Image => "towndev22",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 0,
				:Workers => 2,
				:BuildingIndex => 22
			},
			:TOWNDEV22REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Allows you to build the Block 1 afterwards."),
                :Background => "bg2",
			},
			
			
			:TOWNDEV23 => {
                :Title => _INTL("Town Exteriors - Lvl.2"),
                :Text => _INTL("Upgrades the exteriors of your Town, improving tourism."),
                :Image => "towndev23",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 5000,
				:Workers => 2,
				:BuildingIndex => 23
			},
			:TOWNDEV23REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Various rewards:\n- Prettier exteriors\n- Passive Town income +1000 per week\n- A new Park with new PNJs and quests"),
                :Background => "bg2",
			},
			
			:TOWNDEV24 => {
                :Title => _INTL("Bike Seller"),
                :Text => _INTL("The Day Care Man now sells bikes"),
                :Image => "towndev24",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 2000,
				:Workers => 1,
				:BuildingIndex => 24
			},
			:TOWNDEV24REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("The Daycare man now sells bikes (and will give you one for free! It can grants you access to the Route 4's Cycling road)"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV25 => {
                :Title => _INTL("Trainer's Academy"),
                :Text => _INTL("Build the Trainers Academy, giving you a lot of fame and tourism."),
                :Image => "towndev25",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 8000,
				:Workers => 2,
				:BuildingIndex => 25
			},
			:TOWNDEV25REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Various rewards:\n- A lot of PNJs, quests, items...\n- Passive town income + 1500\n- Passive fame +10 per week"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV26 => {
                :Title => _INTL("Clearing - Major spot 2"),
                :Text => _INTL("Clears the wreckage on the major spot 2."),
                :Image => "towndev26",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 0,
				:Workers => 2,
				:BuildingIndex => 26
			},
			:TOWNDEV26REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Allows you to build the Safari Park afterwards."),
                :Background => "bg2",
			},
			
			
			:TOWNDEV27 => {
                :Title => _INTL("Clearing - Major spot 3"),
                :Text => _INTL("Clears the wreckage on the major spot 2."),
                :Image => "towndev27",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 0,
				:Workers => 1,
				:BuildingIndex => 27
			},
			:TOWNDEV27REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Allows you to build the Beauty Market afterwards."),
                :Background => "bg2",
			},
			
			
			#---------------------------------------------------------------------------------------
			#	Fame 10
			#---------------------------------------------------------------------------------------
			
        }

        TIP_CARDS_GROUPS = {
            
        }

end