module QuestModule
  
  # Chapter 1
  MainQuest1 = {
    :ID => "1",
    :Name => "Chapter 1: Beginning your journey",
    :QuestGiver => "Prof Maple",
    :Stage1 => "Head outside",
	:Stage2 => "Find Melly in Route 1",
	:Stage3 => "Go back to your Gym",
    :Location1 => "Outside",
	:Location2 => "Route 1",
	:Location3 => "Your Gym",
    :QuestDescription => "Begin your journey by visiting the Gym and meeting important people!",
    :RewardString => ""
  }
  
  # Chapter 2
  MainQuest2 = {
    :ID => "5",
    :Name => "Chapter 2: Becoming a Gym Leader",
    :QuestGiver => "Prof Maple",
    :Stage1 => "Reach the Pokémon League",
	:Stage2 => "Obtain the badge",
	:Stage3 => "Win the rank up battle",
	:Stage4 => "Speak to Prof Maple",
    :Location1 => "Center Town",
	:Location2 => "Pokémon League",
	:Location3 => "Pokémon League",
	:Location4 => "Pokémon Lab",
    :QuestDescription => "Travel to the Pokémon League to become a true Gym Leader!",
    :RewardString => ""
  }
  
  # Chapter 3
  MainQuest3 = {
    :ID => "8",
    :Name => "Ch.3 : First week as a Gym leader",
    :QuestGiver => "Prof Maple",
    :Stage1 => "Go to sleep",
	:Stage2 => "Speak to Prof Maple",
	:Stage3 => "Finish the first week",
    :Location1 => "Pokemon Lab (upstairs)",
	:Location2 => "Your Gym",
	:Location3 => "/",
    :QuestDescription => "Learn the ropes of being a Gym Leader by opening the Gym for your first week !",
    :RewardString => ""
  }
  
  # Chapter 4
  MainQuest4 = {
    :ID => "9",
    :Name => "Ch.4 : Get to rank 2",
    :QuestGiver => "Prof Maple",
    :Stage1 => "Complete Sub-goals (0/3)",
	:Stage2 => "Complete Sub-goals (1/3)",
	:Stage3 => "Complete Sub-goals (2/3)",
	:Stage4 => "Win the rank up battle",
	:Stage5 => "Report back to Maple",
    :Location1 => "/",
	:Location2 => "/",
	:Location3 => "/",
	:Location4 => "Pokémon league",
	:Location5 => "/",
    :QuestDescription => "Progress as a Gym leader and get to rank 2!",
    :RewardString => ""
  }
  
  MainQuest4SubA = {
    :ID => "10",
    :Name => "Sub-Goal: Get to fame level 3",
    :QuestGiver => "Prof Maple",
    :Stage1 => "Get to fame level 3",
    :Location1 => "/",
    :QuestDescription => "Gain fame to let your Gym be recognized by getting to fame level 3!",
    :RewardString => ""
  }
  
  MainQuest4SubB = {
    :ID => "11",
    :Name => "Sub-Goal: Get Camosack badge",
    :QuestGiver => "Prof Maple",
    :Stage1 => "Get Camosack Gym's badge",
    :Location1 => "Camosack Gym",
    :QuestDescription => "Travel to Camosack through Green Lush Forest and routes 7 & 8 to earn a new badge!",
    :RewardString => ""
  }
  
  MainQuest4SubC = {
    :ID => "12",
    :Name => "Sub-Goal: Free the Daycare",
    :QuestGiver => "Prof Maple",
    :Stage1 => "Gain access to the Daycare",
    :Location1 => "/",
    :QuestDescription => 'Complete the city task \n"Clearing - Town exteriors" to get access to the Daycare.',
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
    :Location2 => "Pokémon Lab",
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
    :Name => "Reclaim the bag (rec. lvl: 15+)",
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
  
  # Team absolution kidnapping in Geodude Pit
  BattleQuest2 = {
    :ID => "5",
    :Name => "Free the Milcery (rec. lvl: 12+)",
    :QuestGiver => "Martha",
    :Stage1 => "Take Milcery from them!",
	:Stage2 => "Go back to Martha",
	:Location1 => "Geodude Pit",
	:Location2 => "Geodude Pit",
    :QuestDescription => "Some strange looking persons stole Martha's Milcery. Confront them and take it back!",
    :RewardString => "???"
  }
  
  # Abandonned scarf route 3 to route 5
  ItemQuest3 = {
    :ID => "6",
    :Name => "Find the scarf's owner",
    :QuestGiver => "None",
    :Stage1 => "Find the scarf's owner",
	:Location1 => "???",
    :QuestDescription => "You found a scarf lost by someone. Where can it's owner be? The scarf is partially covered by sand...",
    :RewardString => "???"
  }
  
  # Show a MimeJr to the scientist in Central Twon PC
  PokemonQuest1 = {
    :ID => "7",
    :Name => "Show a MimeJr",
    :QuestGiver => "Scientist",
    :Stage1 => "Show a MimeJr to the scientist",
	:Location1 => "Central Town PC",
    :QuestDescription => "A scientist inside the Central Town pokémon Center need to study a MimeJr for a few minutes. Go capture one and show it to her.",
    :RewardString => "Some growth medecines (Protein etc...)"
  }
  
  

end
