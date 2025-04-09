module QuestModule
  
  # First Main Quest
  MainQuest1 = {
    :ID => "1",
    :Name => "Prologue",
    :QuestGiver => "Prof. Maple",
    :Stage1 => "Head outside",
	:Stage2 => "Find Melly in Route 1",
	:Stage3 => "Go back to your Gym",
    :Location1 => "Outside",
	:Location2 => "Route 1",
	:Location3 => "Your Gym",
    :QuestDescription => "Begin your journey by visiting the Gym and meeting important people!",
    :RewardString => ""
  }
  
  # Chapter 1
  MainQuest2 = {
    :ID => "5",
    :Name => "Chapter 1 : Becoming a Gym Leader",
    :QuestGiver => "Prof. Maple",
    :Stage1 => "Reach the Pokémon League",
	:Stage2 => "Obtain the badge",
	:Stage3 => "Win the rank up battle",
	:Stage4 => "Go back to your town and speak to Maple",
    :Location1 => "Center Town",
	:Location2 => "Pokémon League",
	:Location3 => "Pokémon League",
	:Location4 => "Maple's lab",
    :QuestDescription => "Travel to the Pokémon League to become a true Gym Leader!",
    :RewardString => ""
  }
  
  # Jon's Glasses
  ItemQuest1 = {
    :ID => "2",
    :Name => "Find the glasses",
    :QuestGiver => "Jon",
    :Stage1 => "Find the glasses.",
	:Stage2 => "Give the glasses to Jon.",
	:Location1 => "\tn",
    :Location2 => "Prof. Maple's lab",
    :QuestDescription => "Jon in Prof. Maple's lab lost his glasses while investigating the seism somewhere in the city. Find it and return it to him.",
    :RewardString => "A reward from Jon"
  }
  
  # Jeremy's Notebook
  ItemQuest2 = {
    :ID => "3",
    :Name => "Find the notebook",
    :QuestGiver => "Jeremy",
    :Stage1 => "Find the notebook.",
	:Stage2 => "Give the notebook to Jeremy.",
	:Location1 => "Green Lush Forest",
    :Location2 => "\tn's Pokemon Center",
    :QuestDescription => "Jeremy in the Pokemon Center lost his notebook somewhere in the Green Lush Forest. Find it and return it to him.",
    :RewardString => "A reward from Jeremy"
  }
  
  # The croagunks in route 1
  BattleQuest1 = {
    :ID => "4",
    :Name => "Reclaim a bag from wild Pokémons (rec. lvl: 15 or more)",
    :QuestGiver => "Henry",
    :Stage1 => "Defeat the wild Croagunks (lvl 15+).",
	:Stage2 => "Pick up the bag.",
	:Stage3 => "Give the bag to Henry",
	:Location1 => "Route 1",
	:Location2 => "Route 1",
	:Location3 => "Route 1",
    :QuestDescription => "Some wild Pokémons have stolen a bag from Henry. Take it back from them!",
    :RewardString => "A reward from Henry"
  }
  
  

end
