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
                :Text => _INTL("Each quest has a color code depending on what you have to do to complete it:\n- Gold: Main Quests (various objectives)\n- Red: Battle Quest (win battle(s))\n-Blue: Item Quest (give/find an item)\n- Green: Pokémon Quest (give/show a Pokémon, an Egg...)"),
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
                :Text => _INTL("More infos on how these different phases flow together will be given later.\n\nOh and if you want to speed up the game, just press the AUX button (Default : Q)"),
                :Background => "bg2",
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
				:Funds => 500,
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
				:Funds => 2000,
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
				:Funds => 3000,
				:Workers => 0,
				:Instant => 1,
				:BuildingIndex => 10
			},
			:TOWNDEV10REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Various rewards :\n- New scientist (and his quest)\n- Improved version of the Pokégear : access to the Jukebox.\n- Passive town income +2000 per week"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV11 => {
                :Title => _INTL("Your House"),
                :Text => _INTL("Build your House."),
                :Image => "towndev11",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 2000,
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
                :Text => _INTL("Give access to the rest of the Town. Gain access to the south west exit of the Town, which lead to the Daycare."),
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
				:Funds => 2000,
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
				:Funds => 2000,
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
				:Funds => 5000,
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
                :Text => _INTL("Improve the money earned from the challengers by 20%."),
                :Background => "bg2",
			},
			
			
			:TOWNDEV19 => {
                :Title => _INTL("Pokémon Center - Mezzanine"),
                :Text => _INTL("Give access to the PokéCenter's mezzanine - The help center."),
                :Image => "towndev19",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 3000,
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
				:Funds => 5000,
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
				:Funds => 4000,
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
				:Funds => 5000,
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
				:Funds => 8000,
				:Workers => 2,
				:BuildingIndex => 23
			},
			:TOWNDEV23REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Various rewards:\n- Prettier exteriors\n- Passive Town income +2000 per week\n- A new Park with new PNJs and quests"),
                :Background => "bg2",
			},
			
			:TOWNDEV24 => {
                :Title => _INTL("Bike Seller"),
                :Text => _INTL("The Day Care Man now sells bikes"),
                :Image => "towndev24",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 10000,
				:Workers => 2,
				:BuildingIndex => 24
			},
			:TOWNDEV24REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("The Daycare man now sells bikes (and you will have one for free, that allows you access to the Route 4's Cycling road) \nPassive Town income +500 per week"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV25 => {
                :Title => _INTL("Trainer's Academy"),
                :Text => _INTL("Build the Trainers Academy, giving you a lot of fame and tourism."),
                :Image => "towndev25",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 10000,
				:Workers => 2,
				:BuildingIndex => 25
			},
			:TOWNDEV25REWARDS => {
                :Title => _INTL("Rewards"),
                :Text => _INTL("Various rewards:\n- A lot of PNJs, quests, items...\n- Passive town income + 3000\n- Passive fame +10 per week"),
                :Background => "bg2",
			},
			
			
			:TOWNDEV26 => {
                :Title => _INTL("Clearing - Major spot 2"),
                :Text => _INTL("Clears the wreckage on the major spot 2."),
                :Image => "towndev26",
				:ImagePosition => :Top,
                :Background => "bg2",
				:Funds => 5000,
				:Workers => 1,
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
				:Funds => 2000,
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