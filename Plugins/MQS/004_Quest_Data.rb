module QuestModule
  
	##############################################################################
	#
	#		Main Quests
	#
	##############################################################################
  
	# Chapter 1
	MainQuest1 = {
		:ID => "MQ1",
		:Name => _INTL("Chapter 1: Beginning your journey"),
		:QuestGiver => "Prof Maple",
		:Stage1 => _INTL("Head outside"),
		:Stage2 => _INTL("Find Melly in Route 1"),
		:Stage3 => _INTL("Go back to your Gym"),
		:Location1 => _INTL("Outside"),
		:Location2 => "Route 1",
		:Location3 => _INTL("Your Gym"),
		:QuestDescription => _INTL("Begin your journey by visiting the Gym and meeting important people."),
		:RewardString => ""
	}

	# Chapter 2
	MainQuest2 = {
		:ID => "MQ2",
		:Name => _INTL("Chapter 2: Becoming a Gym Leader"),
		:QuestGiver => "Prof Maple",
		:Stage1 => _INTL("Reach the Pokémon League"),
		:Stage2 => _INTL("Obtain the badge"),
		:Stage3 => _INTL("Win the rank up battle"),
		:Stage4 => _INTL("Speak to Prof Maple"),
		:Location1 => _INTL("Center Town"),
		:Location2 => "Pokémon League",
		:Location3 => "Pokémon League",
		:Location4 => "Pokémon Lab",
		:QuestDescription => _INTL("Travel to the Pokémon League to become a true Gym Leader!"),
		:RewardString => ""
	}

	# Chapter 3
	MainQuest3 = {
		:ID => "MQ3",
		:Name => _INTL("Chapter 3: First week at work"),
		:QuestGiver => "Prof Maple",
		:Stage1 => _INTL("Go to sleep"),
		:Stage2 => _INTL("Speak to Prof Maple"),
		:Stage3 => _INTL("Finish the first week"),
		:Location1 => _INTL("Pokemon Lab (upstairs)"),
		:Location2 => _INTL("Your Gym"),
		:Location3 => "/",
		:QuestDescription => _INTL("Learn the ropes of being a Gym Leader by opening the Gym for your first week !"),
		:RewardString => ""
	}

	# Chapter 4
	MainQuest4 = {
		:ID => "MQ4",
		:Name => _INTL("Chapter 4: Get to rank 2"),
		:QuestGiver => "Prof Maple",
		:Stage1 => _INTL("Complete Sub-goals (0/3)"),
		:Stage2 => _INTL("Complete Sub-goals (1/3)"),
		:Stage3 => _INTL("Complete Sub-goals (2/3)"),
		:Stage4 => _INTL("Win the rank up battle"),
		:Stage5 => _INTL("Report back to Maple"),
		:Location1 => "/",
		:Location2 => "/",
		:Location3 => "/",
		:Location4 => "Pokémon League",
		:Location5 => "/",
		:QuestDescription => _INTL("Progress as a Gym leader by completing sub-goals (quests called Ch.4-A, Ch.4-B and Ch.4-C), and get to rank 2 by winning the rank up battle."),
		:RewardString => "Rank up"
	}

	MainQuest4A = {
		:ID => "MQ4A",
		:Name => _INTL("Ch.4-A: Get to fame level 3"),
		:QuestGiver => "Prof Maple",
		:Stage1 => _INTL("Get to fame level 3"),
		:Location1 => "/",
		:QuestDescription => _INTL("Gain fame to let your Gym be recognized by getting to fame level 3."),
		:RewardString => ""
	}

	MainQuest4B = {
		:ID => "MQ4B",
		:Name => _INTL("Ch.4-B: Get Sombake badge"),
		:QuestGiver => "Prof Maple",
		:Stage1 => _INTL("Get Sombake Gym's badge"),
		:Location1 => _INTL("Sombake Gym"),
		:QuestDescription => _INTL("Travel to Sombake through Green Lush Forest and routes 7 & 8 to earn a new badge."),
		:RewardString => ""
	}

	MainQuest4C = {
		:ID => "MQ4C",
		:Name => _INTL("Ch.4-C: Free the Daycare"),
		:QuestGiver => "Prof Maple",
		:Stage1 => _INTL("Gain access to the Daycare"),
		:Location1 => "/",
		:QuestDescription => _INTL('Complete the city task n°13 : "Clearing - Town exteriors" to get access to the Daycare.'),
		:RewardString => ""
	}
  
  ##############################################################################
  #
  #		Item Quests
  #
  ##############################################################################
  
	# Jon's Glasses
	ItemQuest1 = {
		:ID => "IQ1",
		:Name => _INTL("Find the glasses"),
		:QuestGiver => "Jon",
		:Stage1 => _INTL("Find the glasses."),
		:Stage2 => _INTL("Give the glasses to Jon."),
		:Location1 => _INTL("Somewhere in your town"),
		:Location2 => "Pokémon Lab",
		:QuestDescription => _INTL("Jon in Prof. Maple's lab lost his glasses while investigating the seism somewhere in the city. Find it and return it to him."),
		:RewardString => _INTL("A reward from Jon")
	}

	# Jeremy's Notebook
	ItemQuest2 = {
		:ID => "IQ2",
		:Name => _INTL("Find the notebook"),
		:QuestGiver => "Jeremy",
		:Stage1 => _INTL("Find the notebook."),
		:Stage2 => _INTL("Give the notebook to Jeremy."),
		:Location1 => _INTL("Green Lush Forest"),
		:Location2 => _INTL("Your town's Pokemon Center"),
		:QuestDescription => _INTL("Jeremy in the Pokemon Center lost his notebook somewhere in the Green Lush Forest. Find it and return it to him."),
		:RewardString => _INTL("A reward from Jeremy")
	}

	# Abandonned scarf route 3 to route 5
	ItemQuest3 = {
		:ID => "IQ3",
		:Name => _INTL("Find the scarf's owner"),
		:QuestGiver => _INTL("None"),
		:Stage1 => _INTL("Find the scarf's owner"),
		:Location1 => "???",
		:QuestDescription => _INTL("You found a scarf lost by someone. Where can it's owner be? The scarf is partially covered by sand..."),
		:RewardString => "???"
	}
  
    # Find a custap berry in green lush forest
	ItemQuest4 = {
		:ID => "IQ4",
		:Name => _INTL("Find a custap berry"),
		:QuestGiver => _INTL("A scientist"),
		:Stage1 => _INTL("Give a custap berry"),
		:Location1 => _INTL("Green lush forest (west)"),
		:QuestDescription => _INTL("A scientist studying berries in Green lush forest (west) wants a rare custap berry. He said there might be some in the forest. Give him a custap berry!"),
		:RewardString => "???"
	}
	
  ##############################################################################
  #
  #		Battle Quests
  #
  ##############################################################################
  
	# The croagunks in route 1
	BattleQuest1 = {
		:ID => "BQ1",
		:Name => _INTL("Reclaim the bag (lvl 15+)"),
		:QuestGiver => "Henry",
		:Stage1 => _INTL("Defeat the wild Croagunks (lvl 15+)."),
		:Stage2 => _INTL("Pick up the bag."),
		:Stage3 => _INTL("Give the bag to Henry"),
		:Location1 => "Route 1",
		:Location2 => "Route 1",
		:Location3 => "Route 1",
		:QuestDescription => _INTL("Some wild Pokémons have stolen a bag from Henry. Take it back from them!"),
		:RewardString => _INTL("A reward from Henry")
	}

	# Team absolution kidnapping in Geodude Pit
	BattleQuest2 = {
		:ID => "BQ2",
		:Name => _INTL("Free the Milcery (lvl 12+)"),
		:QuestGiver => "Martha",
		:Stage1 => _INTL("Take Milcery from them!"),
		:Stage2 => _INTL("Go back to Martha"),
		:Location1 => _INTL("Geodude Pit"),
		:Location2 => _INTL("Geodude Pit"),
		:QuestDescription => _INTL("Some strange looking persons stole Martha's Milcery. Confront them and take it back!"),
		:RewardString => "???"
	}
	
	# Blackbelt battle inside Tlingit gates
	BattleQuest3 = {
		:ID => "BQ3",
		:Name => _INTL("Spar with Ben (lvl 22+)"),
		:QuestGiver => "Ben",
		:Stage1 => _INTL("Battle Ben"),
		:Location1 => _INTL("Tlingit gates"),
		:QuestDescription => _INTL("A judoka named Ben is disappointed that he can't go to Tlingit to train. Go battle with him!"),
		:RewardString => "???"
	}
  
  ##############################################################################
  #
  #		Pokémon Quests
  #
  ##############################################################################
  
	# Show a MimeJr to the scientist in Central Town PC
	PokemonQuest1 = {
		:ID => "PQ1",
		:Name => _INTL("Show a MimeJr"),
		:QuestGiver => _INTL("Scientist"),
		:Stage1 => _INTL("Show a MimeJr to the scientist"),
		:Location1 => _INTL("Central Town PC"),
		:QuestDescription => _INTL("A scientist inside the Central Town pokémon Center need to study a MimeJr for a few minutes. Go capture one and show it to her."),
		:RewardString => _INTL("Some growth medecines (Protein etc...)")
	}
  
  ##############################################################################
  #
  #		Social Quests
  #
  ##############################################################################
  
  # Maple
  ##############################################################################
  
	MapleQuest1= {
		:ID => "MapleQ1",
		:Name => _INTL("Clear the binacles (lvl 15+)"),
		:QuestGiver => "Prof Maple",
		:Stage1 => _INTL("Defeat or capture all binacles"),
		:Stage2 => _INTL("Report to Maple"),
		:Location1 => _INTL("Route 1 (north)"),
		:Location2 => "Pokémon Lab",
		:QuestDescription => _INTL("Prof Maple asked you to help stop the propagation of Binacles on the beach down Route 1 (north). Go there and check all the rocks for binacles ; capture or defeat them all!"),
		:RewardString => _INTL("Maple relation up.")
	}

	MapleQuest2= {
		:ID => "MapleQ2",
		:Name => _INTL("Make an egg of your starter"),
		:QuestGiver => "Prof Maple",
		:Stage1 => _INTL("Bring the egg to Maple"),
		:Location1 => "Pokémon Lab",
		:QuestDescription => _INTL("Prof Maple has a shortage of starter Pokémons to give to new trainers. He asked you to give him an egg of your starter. To produce eggs, you must use the Day-Care."),
		:RewardString => _INTL("Maple relation up.")
	}


	MapleQuest3= {
		:ID => "MapleQ3",
		:Name => _INTL("Bring a fossil"),
		:QuestGiver => "Prof Maple",
		:Stage1 => _INTL("Bring a fossil to Maple"),
		:Location1 => "Pokémon Lab",
		:QuestDescription => _INTL("Prof Maple needs a fossil for his researchs. Bring him one. You can found fossils in glowing rocks, or in the desert."),
		:RewardString => _INTL("Maple relation up.")
	}


	MapleQuest4= {
		:ID => "MapleQ4",
		:Name => _INTL("Your own shiny"),
		:QuestGiver => "Prof Maple",
		:Stage1 => _INTL("Show Maple a \\gt shiny"),
		:Location1 => "Pokémon Lab",
		:QuestDescription => _INTL("Prof Maple talked to you about shinies. He asked you to show him a shiny of your Gym type. Capture one \\gt shiny and show it to him."),
		:RewardString => _INTL("Maple relation up.")
	}


	MapleQuest5= {
		:ID => "MapleQ5",
		:Name => _INTL("A roof for everyone"),
		:QuestGiver => "Prof Maple",
		:Stage1 => _INTL("Build every useful housing"),
		:Stage2 => _INTL("Report to Maple"),
		:Location1 => "/",
		:Location2 => "Pokémon Lab",
		:QuestDescription => _INTL("Prof Maple is concerned about the lack of housing in the city. He wants you to rebuild every house and block (except the last house)."),
		:RewardString => _INTL("Maple relation up, and a gift.")
	}

	# Marley
	##############################################################################
  
	MarleyQuest1= {
		:ID => "MarleyQ1",
		:Name => _INTL("Catch a shiny"),
		:QuestGiver => "Marley",
		:Stage1 => _INTL("Show a shiny Pokémon to Marley"),
		:Location1 => _INTL("Your Gym"),
		:QuestDescription => _INTL("Marley loves shinies and can help you find more of them. For starters, catch any shiny Pokémon and show it to him."),
		:RewardString => _INTL("Marley relation up.")
	}


	MarleyQuest2= {
		:ID => "MarleyQ2",
		:Name => _INTL("Catch a regional form"),
		:QuestGiver => "Marley",
		:Stage1 => _INTL("Show a regional form to Marley"),
		:Location1 => _INTL("Your Gym"),
		:QuestDescription => _INTL("Marley also loves regional forms. Catch a Pokémon in a regional form and show it to him."),
		:RewardString => _INTL("Marley relation up.")
	}


	MarleyQuest3= {
		:ID => "MarleyQ3",
		:Name => _INTL("Full shiny party"),
		:QuestGiver => "Marley",
		:Stage1 => _INTL("Show a full shiny party to Marley"),
		:Location1 => _INTL("Your Gym"),
		:QuestDescription => _INTL("Marley wants a treat: see a Pokémon party of 6 shinies! Show that to him."),
		:RewardString => _INTL("Marley relation up.")
	}


	MarleyQuest4= {
		:ID => "MarleyQ4",
		:Name => _INTL("Shiny AND regional"),
		:QuestGiver => "Marley",
		:Stage1 => _INTL("Show a shiny Pokémon with a regional form to Marley"),
		:Location1 => _INTL("Your Gym"),
		:QuestDescription => _INTL("Marley loves shinies and regional forms: why not both? Catch a regional form shiny Pokémon and show it to him."),
		:RewardString => _INTL("Marley relation up.")
	}


	MarleyQuest5= {
		:ID => "MarleyQ5",
		:Name => _INTL("Shiny egg"),
		:QuestGiver => "Marley",
		:Stage1 => _INTL("Show a lvl 1 shiny Pokémon to Marley"),
		:Location1 => _INTL("Your Gym"),
		:QuestDescription => _INTL("Marley explained to you another method to have shinies: produce many eggs until one of the babies is shiny. It is the only way to get a lvl 1 shiny. Test this method and show him a lvl 1 shiny as a proof."),
		:RewardString => _INTL("Marley relation up, and a gift.")
	}
  
	# Melly
	##############################################################################
  
	MellyQuest1= {
		:ID => "MellyQ1",
		:Name => _INTL("Melly first training battle (lvl 20+)"),
		:QuestGiver => "Melly",
		:Stage1 => _INTL("Have a training battle with Melly"),
		:Location1 => _INTL("Your Gym or Melly's house."),
		:QuestDescription => _INTL("Melly wants to train with you. Battle her at your Gym. Her Pokémons will be around lvl 20. Note: you HAVE to win the battle to complete the quest"),
		:RewardString => _INTL("Melly relation up.")
	}


	MellyQuest2= {
		:ID => "MellyQ2",
		:Name => _INTL("Pink and purple Pokémon love"),
		:QuestGiver => "Melly",
		:Stage1 => _INTL("Show pink or purple Pokémons to Melly"),
		:Location1 => _INTL("Your Gym or Melly's house."),
		:QuestDescription => _INTL("Melly loves pink and purple ; she asked you to show her three (different species) pink or purple Pokémons"),
		:RewardString => _INTL("Melly relation up.")
	}


	MellyQuest3= {
		:ID => "MellyQ3",
		:Name => _INTL("Melly second training battle (lvl 35+)"),
		:QuestGiver => "Melly",
		:Stage1 => _INTL("Have another training battle with Melly"),
		:Location1 => _INTL("Your Gym or Melly's house."),
		:QuestDescription => _INTL("Melly wants to train with you again. Battle her at your Gym. Her Pokémons will be around lvl 35. Note: you HAVE to win the battle to complete the quest."),
		:RewardString => _INTL("Melly relation up.")
	}


	MellyQuest4= {
		:ID => "MellyQ4",
		:Name => _INTL("Shiny pink or purple"),
		:QuestGiver => "Melly",
		:Stage1 => _INTL("Show a pink or purple shiny to Melly"),
		:Location1 => _INTL("Your Gym or Melly's house."),
		:QuestDescription => _INTL("Melly learnt from Maple about the shinies and she is very excited about it. She wants you to capture a shiny Pokémon that's pink or purple, and is not pink or purple if not shiny."),
		:RewardString => _INTL("Melly relation up.")
	}


	MellyQuest5= {
		:ID => "MellyQ5",
		:Name => _INTL("Melly last training battle (lvl 50+)"),
		:QuestGiver => "Melly",
		:Stage1 => _INTL("Have a training battle with Melly"),
		:Location1 => _INTL("Your Gym or Melly's house."),
		:QuestDescription => _INTL("Melly wants to train with you one last time. Battle her at your Gym. Her Pokémon will be around lvl 50. Note: you HAVE to win the battle to complete the quest"),
		:RewardString => _INTL("Melly relation up, and a gift.")
	}
  
	# Samy
	##############################################################################
  
	SamyQuest1= {
		:ID => "SamyQ1",
		:Name => _INTL("Samy first training battle (lvl 30+)"),
		:QuestGiver => "Samy",
		:Stage1 => _INTL("Have a training battle with Samy"),
		:Location1 => _INTL("Your Gym or Samy's house."),
		:QuestDescription => _INTL("Samy wants to train with you. Battle him at your Gym. His Pokémons will be around lvl 30. Note: you HAVE to win the battle to complete the quest"),
		:RewardString => _INTL("Samy relation up.")
	}
	  
	  
	SamyQuest2= {
		:ID => "SamyQ2",
		:Name => _INTL("Find shards"),
		:QuestGiver => "Samy",
		:Stage1 => _INTL("Give shards to Samy"),
		:Location1 => _INTL("Your Gym or Samy's house."),
		:QuestDescription => _INTL("Samy needs shards that you can find by mining glowing rocks. Collect and give to him 5 of each color (blue red green and yellow)."),
		:RewardString => _INTL("Samy relation up.")
	}


	SamyQuest3= {
		:ID => "SamyQ3",
		:Name => _INTL("Samy second training battle (lvl 50+)"),
		:QuestGiver => "Samy",
		:Stage1 => _INTL("Have another training battle with Samy"),
		:Location1 => _INTL("Your Gym or Samy's house."),
		:QuestDescription => _INTL("Samy wants to train with you once again. Battle him at your Gym. His Pokémons will be around lvl 50. Note: you HAVE to win the battle to complete the quest"),
		:RewardString => _INTL("Samy relation up.")
	}


	SamyQuest4= {
		:ID => "SamyQ4",
		:Name => _INTL("More shards"),
		:QuestGiver => "Samy",
		:Stage1 => _INTL("Give more shards to Samy"),
		:Location1 => _INTL("Your Gym or Samy's house."),
		:QuestDescription => _INTL("Samy needs even more shards that you can find by mining glowing rocks. Collect and give to him 8 of each color (blue red green and yellow."),
		:RewardString => _INTL("Samy relation up.")
	}


	SamyQuest5= {
		:ID => "SamyQ5",
		:Name => _INTL("Samy last training battle (lvl 70+)"),
		:QuestGiver => "Samy",
		:Stage1 => _INTL("Have yet another training battle with Samy"),
		:Location1 => _INTL("Your Gym or Samy's house."),
		:QuestDescription => _INTL("Samy wants to train with you one last time. Battle him at your Gym. His Pokémons will be around lvl 70. Note: you HAVE to win the battle to complete the quest"),
		:RewardString => _INTL("Samy relation up, and a gift.")
	}
	  
	# Kiana
	##############################################################################
  
	# Rival
	##############################################################################
  
	# Nurses
	##############################################################################
  
	NursesQuest1= {
		:ID => "NursesQ1",
		:Name => _INTL("Nurses' (express?) delivery."),
		:QuestGiver => "Nurses",
		:Stage1 => _INTL("Deliver packages (0/3)"),
		:Stage2 => _INTL("Deliver packages (1/3)"),
		:Stage3 => _INTL("Deliver packages (2/3)"),
		:Stage4 => _INTL("Report back to the nurses"),
		:Location1 => "/",
		:Location2 => "/",
		:Location3 => "/",
		:Location4 => _INTL("Your town's Pokémon Center"),
		:QuestDescription => _INTL("The nurses of your town have new pharmaceutical products to share with other Pokémon Centers. Deliver a package to the Pokémon Centers of Sombake, Grey Moose and Central Town."),
		:RewardString => _INTL("Nurses relation up.")
	}
	  
	  
	NursesQuest2= {
		:ID => "NursesQ2",
		:Name => _INTL("Catch with a heal ball"),
		:QuestGiver => _INTL("Nurses"),
		:Stage1 => _INTL("Catch a Pokémon with a heal ball"),
		:Location1 => _INTL("Pokémon Center of your town"),
		:QuestDescription => _INTL("The nurses talked to you about the heal ball and want you to try it: Go catch a Pokémon with a heal ball and show it to them! "),
		:RewardString => _INTL("Nurses relation up.")
	}
	  
	  
	NursesQuest3= {
		:ID => "NursesQ3",
		:Name => _INTL("Healing abilities"),
		:QuestGiver => _INTL("Nurses"),
		:Stage1 => _INTL("Show a Pokémon with a healing ability"),
		:Location1 => _INTL("Pokémon Center of your town"),
		:QuestDescription => _INTL("The nurses explained to you that some Pokémons have abilities that can heal itselves or its friends. Go catch and show them a Pokémon with one of these abilities : Medic Nature, Regenerator (...)"),
		:RewardString => _INTL("Nurses relation up.")
	}
	  
	  
	NursesQuest4= {
		:ID => "NursesQ4",
		:Name => _INTL("Healing moves"),
		:QuestGiver => _INTL("Nurses"),
		:Stage1 => _INTL("Show a Pokémon which knows healing move"),
		:Location1 => _INTL("Pokémon Center of your town"),
		:QuestDescription => _INTL("The nurses explained to you that some Pokémons can learn moves that heal its battle partner. Show them a Pokémon which knows one of these moves : Pollen Puff, (...)"),
		:RewardString => _INTL("Nurses relation up.")
	}
	  
	  
	NursesQuest5= {
		:ID => "NursesQ5",
		:Name => _INTL("A shiny healer"),
		:QuestGiver => _INTL("Nurses"),
		:Stage1 => _INTL('Give a shiny "healer" Pokémon'),
		:Location1 => _INTL("Pokémon Center of your town"),
		:QuestDescription => _INTL("The nurses wants to impress visitors by having a shiny healer Pokémon. Give them a shiny Pokémon with either a healing abilitiy (Medic Nature, Regenerator (...)) or a (not-self) healing move (Pollen Puff, (...)). "),
		:RewardString => _INTL("Nurses relation up, and a gift.")
	}
  
	# Madame S
	##############################################################################
  
	# Normal Leader
	##############################################################################
  
	NLQuest1= {
		:ID => "NLQ1",
		:Name => _INTL("Show a Kecleon"),
		:QuestGiver => _INTL("Normal Leader"),
		:Stage1 => _INTL("Show Kecleon to the normal Leader"),
		:Location1 => _INTL("Normal Gym"),
		:QuestDescription => _INTL("It's hard to tell for sure but you think that the normal Leader wants to see a Kecleon. Go catch one and show it to them."),
		:RewardString => _INTL("Normal Leader relation up.")
	}
	  
	  
	NLQuest2= {
		:ID => "NLQ2",
		:Name => _INTL("First normal rematch (lvl ??)"),
		:QuestGiver => _INTL("Normal Leader"),
		:Stage1 => _INTL("Battle the Normal Leader again"),
		:Location1 => _INTL("Normal Gym"),
		:QuestDescription => _INTL("You're not 100% sure but you think that the Normal Leader wants a rematch. No clue about their Pokémon level though... Note: you HAVE to win the battle to complete the quest"),
		:RewardString => _INTL("Normal Leader relation up.")
	}
	  
	  
	NLQuest3= {
		:ID => "NLQ3",
		:Name => _INTL("Using a love ball"),
		:QuestGiver => _INTL("Normal Leader"),
		:Stage1 => _INTL("Catch a normal Pokémon with a love ball"),
		:Location1 => _INTL("Normal Gym"),
		:QuestDescription => _INTL("The normal Leader showed you a love ball. You think they want you to catch a normal-type Pokémon with a love ball and show it to them."),
		:RewardString => _INTL("Normal Leader relation up.")
	}
	  
	  
	NLQuest4= {
		:ID => "NLQ4",
		:Name => _INTL("Second normal rematch (lvl ??)"),
		:QuestGiver => _INTL("Normal Leader"),
		:Stage1 => _INTL("Battle the Normal Leader again"),
		:Location1 => _INTL("Normal Gym"),
		:QuestDescription => _INTL("Again, you're not really sure, but you think that the Normal Leader wants a second rematch. Still no clue about their Pokémon level though, but probably higher than the last time... Note: you HAVE to win the battle to complete the quest"),
		:RewardString => _INTL("Normal Leader relation up.")
	}
	  
	  
	NLQuest5= {
		:ID => "NLQ5",
		:Name => _INTL("Normal shiny"),
		:QuestGiver => _INTL("Normal Leader"),
		:Stage1 => _INTL("Show a shiny normal Pokémon to the Normal Leader"),
		:Location1 => _INTL("Normal Gym"),
		:QuestDescription => _INTL("You're pretty sure this time that the normal Leader wants to see a shiny normal Pokémon. Go catch one and show it to them."),
		:RewardString => _INTL("Normal Leader relation up, and a gift.")
	}
	  
	  
	# Kathleen
	##############################################################################
  
	KathleenQuest1= {
		:ID => "KathleenQ1",
		:Name => _INTL("Fast evolutions"),
		:QuestGiver => "Kathleen",
		:Stage1 => _INTL("Follow Kathleen advice"),
		:Location1 => _INTL("Bug Gym"),
		:QuestDescription => _INTL("Kathleen bragged about bug Pokémons evolving at very low level. Show that you listened to her by showing her a fully evolved (with 3 evolutions stages) bug Pokémon, max level 15."),
		:RewardString => _INTL("Kathleen relation up.")
	}
	  
	  
	KathleenQuest2= {
		:ID => "KathleenQ2",
		:Name => _INTL("First Bug rematch (lvl 40+)"),
		:QuestGiver => "Kathleen",
		:Stage1 => _INTL("Battle Kathleen again."),
		:Location1 => _INTL("Bug Gym"),
		:QuestDescription => _INTL("Kathleen wants a rematch, this time with a better team. Her Pokémons will be around lvl 40. Note: you HAVE to win the battle to complete the quest"),
		:RewardString => _INTL("Kathleen relation up.")
	}
	  
	  
	KathleenQuest3= {
		:ID => "KathleenQ3",
		:Name => _INTL("Using a net ball"),
		:QuestGiver => "Kathleen",
		:Stage1 => _INTL("Show a bug Pokémon in a net ball to Kathleen"),
		:Location1 => _INTL("Bug Gym"),
		:QuestDescription => _INTL("Kathleen explained to you the power of net balls to catch bug (and water) Pokémons. Show her a bug Pokémon catched with a net ball."),
		:RewardString => _INTL("Kathleen relation up.")
	}
	  
	  
	KathleenQuest4= {
		:ID => "KathleenQ4",
		:Name => _INTL("Second Bug rematch (lvl 60+)"),
		:QuestGiver => "Kathleen",
		:Stage1 => _INTL("Battle Kathleen again"),
		:Location1 => _INTL("Bug Gym"),
		:QuestDescription => _INTL("Kathleen wants a rematch with an even better team. Her Pokémons will be around lvl 60. Note: you HAVE to win the battle to complete the quest"),
		:RewardString => _INTL("Kathleen relation up.")
	}
	  
	  
	KathleenQuest5= {
		:ID => "KathleenQ5",
		:Name => _INTL("A shiny bug"),
		:QuestGiver => "Kathleen",
		:Stage1 => _INTL("Show a shiny bug Pokémon to Kathleen"),
		:Location1 => _INTL("Bug Gym"),
		:QuestDescription => _INTL("Kathleen wants to see a shiny bug Pokémon. Show one to her!"),
		:RewardString => _INTL("Kathleen relation up, and a gift.")
	}
	  
	  
	# Cassian
	##############################################################################
	CassianQuest1= {
		:ID => "CassianQ1",
		:Name => _INTL("(x) invasion"),
		:QuestGiver => "Cassian",
		:Stage1 => _INTL("Capture or defeats (x)"),
		:Stage2 => _INTL("Report to Cassian"),
		:Location1 => _INTL("The Grey Mines"),
		:Location2 => _INTL("Rock Gym"),
		:QuestDescription => _INTL("The Grey Mines are being invaded with a lot of (x). To keep its population under control and don't endanger miners, Cassian asked you to defeat or capture at least 5 (x)."),
		:RewardString => _INTL("Cassian relation up.")
	}
	  
	  
	CassianQuest2= {
		:ID => "CassianQ2",
		:Name => _INTL("First Rock rematch (lvl 40+)"),
		:QuestGiver => "Cassian",
		:Stage1 => _INTL("Battle Cassian again."),
		:Location1 => _INTL("Rock Gym"),
		:QuestDescription => _INTL("Cassian wants a rematch, this time with a better team. His Pokémons will be around lvl 40. Note: you HAVE to win the battle to complete the quest"),
		:RewardString => _INTL("Cassian relation up.")
	}
	  
	  
	CassianQuest3= {
		:ID => "CassianQ3",
		:Name => _INTL("Using a dusk ball"),
		:QuestGiver => "Cassian",
		:Stage1 => _INTL("Show a rock Pokémon in a dusk ball to Cassian"),
		:Location1 => _INTL("Rock Gym"),
		:QuestDescription => _INTL("Cassian explained to you the power of dusk balls to catch Pokémons inside grottos or at night. Show him a rock Pokémon catched with a dusk ball."),
		:RewardString => _INTL("Cassian relation up.")
	}
	  
	  
	CassianQuest4= {
		:ID => "CassianQ4",
		:Name => _INTL("Second Rock rematch (lvl 60+)"),
		:QuestGiver => "Cassian",
		:Stage1 => _INTL("Battle Cassian again"),
		:Location1 => _INTL("Rock Gym"),
		:QuestDescription => _INTL("Cassian wants a rematch with an even better team. His Pokémons will be around lvl 60. Note: you HAVE to win the battle to complete the quest"),
		:RewardString => _INTL("Cassian relation up.")
	}
	  
	  
	CassianQuest5= {
		:ID => "CassianQ5",
		:Name => _INTL("A shiny rock"),
		:QuestGiver => "Cassian",
		:Stage1 => _INTL("Show a shiny rock Pokémon to Cassian"),
		:Location1 => _INTL("Rock Gym"),
		:QuestDescription => _INTL("Cassian wants to see a shiny rock Pokémon. Show one to him!"),
		:RewardString => _INTL("Cassian relation up, and a gift.")
	}

end
