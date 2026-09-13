def initializeTrainersKnown
  ret = Array.new()
  for i in 0..13
    ret[i] = Array.new()
    for j in 0..7
      ret[i][j] = Array.new()
    end
  end
  return ret
end
    
def initializeRank1
  ret = Array.new()
  ret[0] = []
  ret[1] = [
      [ "Ferdinand",
        :RICHBOY, 
        "npc_1s_richboy", 
        _INTL("This should be a formality for someone like me."),
        _INTL("As expected!"),
        10],
      [ "Maria",
        :LADY, 
        "npc_1s_lady", 
        _INTL("My little Camille wants to challenge you too! Has she come yet?"),
        _INTL("My Daughter will be so proud of his mommy!!!"),
        10],
      [ "Théo",
        :BUGCATCHER, 
        "npc_1s_bugcatcher", 
        _INTL("Bug Pokémons are SO COOL!!!!"),
        _INTL("I TOLD YOU THEY'RE SO COOL!"),
        8],
      [ "Camille",
        :SCHOOLGIRL, 
        "npc_1s_schoolgirl", 
        _INTL("My mom promised me that if I won, I would get a Galarian Ponyta!!!"),
        _INTL("I'M SO HAPPY!!! THANK YOU!!!!"),
        10],
      [ "Ellie",
        :POKEKID, 
        "npc_1s_pokekid", 
        _INTL("Let's go guys! We can do it!"),
        _INTL("Yes, Yes, Yes!!! We dit it!!!"),
        8],
      [ "Anton",
        :TOURISTMALE, 
        "npc_1s_touristmale", 
        _INTL("The land is beautiful. I wish I had visited this city before the earthquake."),
        _INTL("A pleasant end for a pleasant stay!"),
        10],
      [ "Allan",
        :POKEFANMALE, 
        "npc_1s_pokefanmale", 
        _INTL("Fear the power of the wool!"),
        _INTL("The wool always win... I Guess!"),
        9],
      [ "Lily",
        :TUBERGIRL, 
        "npc_1s_tubergirl", 
        _INTL("Alomomola is cute and strong! We will show you!"),
        _INTL("Yeah!!! Our first badge! I'm so happy!"),
        11],
      [ "Vanessa",
        :SCHOOLGIRL, 
        "npc_1s_schoolgirl", 
        _INTL("I love rats! I love every kind of rats!"),
        _INTL("I will write a song about this glorious victory!"),
        8],
      [ "Ao",
        :IDOL, 
        "npc_1s_idol", 
        _INTL("Someone told me that an arena fight requires the same passion as going on stage! So here I am!"),
        _INTL("I feel a burning passion!"),
        9],
      [ "Jason",
        :YOUNGSTER, 
        "npc_1s_youngster", 
        _INTL("I can't believe the Gym finaly reopened!!!"),
        _INTL("I won??? I really won ???"),
        8],
      [ "Billy",
        :CAMPERBOY, 
        "npc_1s_camperboy", 
        _INTL("My scout group told me I should begin to get some badges!"),
        _INTL("What do you mean 'Not this kind of badge'???"),
        8]
      ]*3
  ret[2] = [
      [ "Sasuke",
        :NINJABOY, 
        "npc_2s_ninjaboy", 
        _INTL("I will show you the power of my justu!!!"),
        _INTL("I will become the darker ninja of all time!"),
        12],
      [ "Bud",
        :BUGMANIAC, 
        "npc_2s_bugmaniac", 
        _INTL("I'm here for the badge!"),
        _INTL("Yes! Thanks for the Badge!"),
        13],
      [ "Laura",
        :SWIMMERFEMALE, 
        "npc_2s_swimmerfemale", 
       _INTL( "The rougher the sea, the more exciting the swimming! I think it's the same for Pokemon battles!"),
        _INTL("Feel the tempest!"),
        11]
      ]*3
  ret[3] = [] 
  ret[4] = []   
  ret[5] = []   
  ret[6] = []   
  ret[7] = []  
  return ret
end

def initializeRank2
  ret = Array.new()
  ret[0] = []
  ret[1] = [
        [ "Ferdinand",
        :RICHBOY, 
        "npc_1s_richboy", 
        _INTL("Happy to see me?"),
        _INTL("I can't afford a defeat..."),
        16],
        [ "Lucy",
        :CAMPERGIRL, 
        "npc_1s_campergirl", 
        _INTL("I was taught how to navigate the forest!"),
        _INTL("I don't exactly know how but i'm sure it helped me win!"),
        14],
        [ "Théo",
        :BUGCATCHER, 
        "npc_1s_bugcatcher", 
        _INTL("Some of my pokemons evolved! They are even more amazing!!!!"),
        _INTL("SO COOL!!!!"),
        14],
        [ "Yvette",
        :FUNOLDLADY, 
        "npc_1s_funoldlady", 
        _INTL("I still use the same Pokémon as when I was young!"),
        _INTL("I'm faster than I look! Isn't it?"),
        15],
        [ "Lucas",
        :TUBERBOY, 
        "npc_1s_tuberboy", 
        _INTL("Do you know what's more fun than playing in mud? Battling juste after!"),
        _INTL("Another glorious victory for MUD BOY!!!"),
        14],
        [ "Regis",
        :RICHBOY, 
        "npc_1s_richboy", 
        _INTL("My familly became rich with our wonderfull steel!"),
        _INTL("Hehehe, our steel is the most precious in this world!"),
        15],
        [ "Isa",
        :SCHOOLGIRL, 
        "npc_1s_schoolgirl", 
        _INTL("Most of my friends are jealous of my Pokémon!"),
        _INTL("And now, I understand why!"),
        15],
        [ "Brian",
        :YOUNGSTER, 
        "npc_1s_youngster", 
        _INTL("I'm such a BADASS! I'm here to fight!"),
        _INTL("Yeah!"),
        15],
        [ "John",
        :RICHBOY, 
        "npc_1s_richboy", 
        _INTL("I'm here to fight an elite trainer!"),
        _INTL("I am the elite!"),
        16],
        [ "Berny",
        :TOURISTMALE, 
        "npc_1s_touristmale", 
        _INTL("Is this the tourist office?"),
        _INTL("What a strange tourist office!"),
        16],
        [ "Alexandria",
        :TOURISTFEMALE, 
        "npc_1s_touristfemale", 
        _INTL("I lost my husband... He were looking for the tourist office... Anyway, let's fight!"),
        _INTL("I love fighting local Gym leader during our trip! Thank you!"),
        15],
        [ "Artemis",
        :CAMPERGIRL, 
        "npc_1s_campergirl", 
        _INTL("Did you know you can locate yourself by looking at the moon???"),
        _INTL("Look to la luna! Haha!"),
        13],
        [ "Roger",
        :FUNOLDMAN, 
        "npc_1s_funoldman", 
        _INTL("I'm ready for a spooky fight!"),
        _INTL("I always answer 'trick'!"),
        17]
  ]*3
  ret[2] = [
        [ "Levi",
        :FISHERMAN, 
        "npc_2s_fisherman", 
        _INTL("Look at this! My boy just evolved!"),
        _INTL("MAGNIFICENT!!!"),
        20],
        [ "David",
        :POKEMANIAC, 
        "npc_2s_pokemaniac", 
        _INTL("Hey! What's your favorite starter?"),
        _INTL("Mine is Froakie!"),
        18],
        [ "M.Stanson",
        :GENTLEMAN, 
        "npc_2s_gentleman", 
        _INTL("Let's battle with elegance."),
        _INTL("An elegante victory!"),
        19],
        [ "Josie",
        :MAID, 
        "npc_2s_maid", 
        _INTL("Are you the one who ordered a combat maid?"),
        _INTL("We hope you enjoyed our services!"),
        18],
        [ "Lysa",
        :PUNKTRAINERFEMALE, 
        "npc_2s_punktrainerfemale", 
        _INTL("Let me show you the way of the pillow!"),
        _INTL("Let's celebrate with a nap!"),
        20]
  ]*3
  ret[3] = [
        [ "???",
        :DELINQUENT, 
        "npc_3s_delinquent", 
        _INTL("I'm coming for you!"),
        _INTL("You deserved it!"),
        22],
        [ "Bozo",
        :FIREBREATHER, 
        "npc_3s_firebreather", 
        _INTL("WE WILL HAVE SO MUCH FUN!"),
        _INTL("Isn't that FUN???"),
        19]
  ]*3 
  ret[4] = []   
  ret[5] = []   
  ret[6] = []   
  ret[7] = []  
  return ret
end

def initializeRank3
  ret = Array.new()
  ret[0] = []
  ret[1] = [
        [ "Norman",
        :YOUNGSTER, 
        "npc_1s_youngster", 
        _INTL("What's better than a good old basic gym battle?"),
        _INTL("Is this normal ?"),
        20],
        [ "Jason",
        :YOUNGSTER, 
        "npc_1s_youngster", 
        _INTL("I'm stronger now! One of my pokemon just evolved!"),
        _INTL("I WON CAUSE I'M COOL !!!"),
        21],
        [ "Morgane",
        :IDOL, 
        "npc_1s_idol", 
        _INTL("Yes, i'm cool. I know it."),
        _INTL("The coolest won !"),
        22],
        [ "Vanessa",
        :SCHOOLGIRL, 
        "npc_1s_schoolgirl", 
        _INTL("I still love Rats!"),
        _INTL("A Ratical victory! Héhé, Ratical, do you get it?"),
        20],
        [ "Philibert",
        :RICHBOY, 
        "npc_1s_richboy", 
        _INTL("My personnal coach tell me Torkoal is really strong allongside a Ivysaur!"),
        _INTL("As expected once again!"),
        22],
        [ "Lilou",
        :PRESCHOOLERGIRL, 
        "npc_1s_preschoolergirl", 
        _INTL("My big bro teachs me a very cool strat and i'm pretty sure i understood everything!"),
        _INTL("IT WORKS!!!"),
        19],
        [ "Jeremy",
        :POKEKID, 
        "npc_1s_pokekid", 
        _INTL("I told my dad i wanted a cute pokemon but i insisted i need a pokemon to protect me..."),
        _INTL("But i still like him!"),
        22],
        [ "Dan",
        :POKEFANMALE, 
        "npc_1s_pokefanmale", 
        _INTL("I LOST MY SON JEREMY. DO YOU SEE HIM???"),
        _INTL("JEREMY WHERE ARE YOU???"),
        20]
  ]*3
  ret[2] = [
        [ "Lysa",
        :PUNKTRAINERFEMALE, 
        "npc_2s_punktrainerfemale", 
        _INTL("The way of the pillow has no end!"),
        _INTL("A good night's sleep will help you forget this defeat."),
        25],
        [ "George",
        :BELLHOP, 
        "npc_2s_bellhop", 
        _INTL("I promise that ALL our products are healthy!"),
        _INTL("Fries with that?"),
        23],
        [ "Jake",
        :PAINTER, 
        "npc_2s_painter", 
        _INTL("I want to picture the union between the ground and the sky!"),
        _INTL("This battle has greatly inspired me. Thank you!"),
        23],
        [ "Noémie",
        :LASS, 
        "npc_2s_lass", 
        _INTL("I'm from Pastoria, close to the Great Marsh. Let me introduce local Pokémon!"),
        _INTL("You should visit us!"),
        22],
        [ "John",
        :POKEMONBREEDERMALE, 
        "npc_2s_pokemonbreedermale", 
        _INTL("I'm a caretaker at first but a fighter noneless!"),
        _INTL("And a even better fighter!"),
        24],
        [ "Sakura",
        :KIMONOGIRL, 
        "npc_2s_kimonogirl", 
        _INTL("Do not fear love sweet child!"),
        _INTL("Just ask her out!"),
        25],
        [ "Hubert",
        :GENTLEMAN, 
        "npc_2s_gentleman", 
        _INTL("Let me teach you some élégance!"),
        _INTL("Did you take notes? You should..."),
        24]
  ]*3
  ret[3] = [
        [ "Louisa",
        :DANCER, 
        "npc_3s_dancer", 
        _INTL("My Favorite Pokémon? I don't have one."),
        _INTL("I SWEAR I DON'T!"),
        26],
        [ "Barry",
        :DELINQUENT, 
        "npc_3s_delinquent", 
        _INTL("I got a very smart strategy!"),
        _INTL("Hahahaha! It works!!!"),
        25],
        [ "MacKing",
        :JOGGER, 
        "npc_3s_jogger", 
        _INTL("I'm... FAST!!!"),
        _INTL("I speedrun winning!"),
        26],
        [ "Timéo",
        :BIKER, 
        "npc_3s_biker", 
        _INTL("Fear me!"),
        _INTL("Another victory for the dark side!"),
        25],
        [ "Phil",
        :BUTLER, 
        "npc_3s_butler", 
        _INTL("A good trainer use Pokémon in battle and in everyday life!"),
        _INTL("Not bad right?"),
        26]
  ]*3 
  ret[4] = []   
  ret[5] = []   
  ret[6] = []   
  ret[7] = []  
  return ret
end

def initializeRank4
  ret = Array.new()
  ret[0] = []
  ret[1] = []
  ret[2] = []
  ret[3] = [] 
  ret[4] = []   
  ret[5] = []   
  ret[6] = []   
  ret[7] = []  
  return ret
end

def initializeRank5
  ret = Array.new()
  ret[0] = []
  ret[1] = []
  ret[2] = []
  ret[3] = [] 
  ret[4] = []   
  ret[5] = []   
  ret[6] = []   
  ret[7] = []  
  return ret
end

def initializeRank6
  ret = Array.new()
  ret[0] = []
  ret[1] = []
  ret[2] = []
  ret[3] = [] 
  ret[4] = []   
  ret[5] = []   
  ret[6] = []   
  ret[7] = []  
  return ret
end

def initializeRank7
  ret = Array.new()
  ret[0] = []
  ret[1] = []
  ret[2] = []
  ret[3] = [] 
  ret[4] = []   
  ret[5] = []   
  ret[6] = []   
  ret[7] = []  
  return ret
end

def initializeRank8
  ret = Array.new()
  ret[0] = []
  ret[1] = []
  ret[2] = []
  ret[3] = [] 
  ret[4] = []   
  ret[5] = []   
  ret[6] = []   
  ret[7] = []  
  return ret
end

def initializeRank9
  ret = Array.new()
  ret[0] = []
  ret[1] = []
  ret[2] = []
  ret[3] = [] 
  ret[4] = []   
  ret[5] = []   
  ret[6] = []   
  ret[7] = []  
  return ret
end

def initializeRank10
  ret = Array.new()
  ret[0] = []
  ret[1] = []
  ret[2] = []
  ret[3] = [] 
  ret[4] = []   
  ret[5] = []   
  ret[6] = []   
  ret[7] = []  
  return ret
end

def initializeRank11
  ret = Array.new()
  ret[0] = []
  ret[1] = []
  ret[2] = []
  ret[3] = [] 
  ret[4] = []   
  ret[5] = []   
  ret[6] = []   
  ret[7] = []  
  return ret
end

def initializeRank12
  ret = Array.new()
  ret[0] = []
  ret[1] = []
  ret[2] = []
  ret[3] = [] 
  ret[4] = []   
  ret[5] = []   
  ret[6] = []   
  ret[7] = []  
  return ret
end

def initializeRank13
  ret = Array.new()
  ret[0] = []
  ret[1] = []
  ret[2] = []
  ret[3] = [] 
  ret[4] = []   
  ret[5] = []   
  ret[6] = []   
  ret[7] = []  
  return ret
end
      
def initializeChallengersTree
  ret = Array.new()
  ret[0] = [[],[],[],[],[],[],[],[]]
  ret[1] = initializeRank1
  ret[2] = initializeRank2
  ret[3] = initializeRank3
  ret[4] = initializeRank4
  ret[5] = initializeRank5
  ret[6] = initializeRank6
  ret[7] = initializeRank7
  ret[8] = initializeRank8
  ret[9] = initializeRank9
  ret[10] = initializeRank10
  ret[11] = initializeRank11
  ret[12] = initializeRank12
  ret[13] = initializeRank13
  return ret
end
      
def initializeAll
 $town.trainersKnown = initializeTrainersKnown
 $town.challengersTree = initializeChallengersTree
end

def initializeTrainersOfRank1
  $town.challengersTree[1] = initializeRank1
end

def initializeTrainersOfRank2
  $town.challengersTree[2] = initializeRank2
end