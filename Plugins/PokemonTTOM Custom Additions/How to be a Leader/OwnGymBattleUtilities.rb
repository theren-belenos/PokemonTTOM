def selectAblePkmnWithType(screen, type, text, taken)
  typemaj = type.upcase
  return screen.pbChooseAblePokemonWithTextNoRepeat(
                  proc { |pkmn| !pkmn.egg? && pkmn.hp > 0 && pkmn.hasType?(typemaj)},
                  false,
                  text,
                  taken
                  )
end

def hasTypedEvolutions?(pkmn,type)
  puts "pkmn = "
  puts pkmn
  puts "species ="
  puts pkmn.species
  typeid = GameData::Type.get(type).id
  ret = false
  GameData::Species.get(pkmn.species).get_evolutions(true).each do |evo|
    evospec = GameData::Species.get(evo[0])
    if (GameData::Type.get(evospec.types[0]).id == typeid || (evospec.types.length == 2 && GameData::Type.get(evospec.types[1]).id == typeid))
      ret = true
    end
    GameData::Species.get(evo[0]).get_evolutions(true).each do |evo2|
      evospec = GameData::Species.get(evo2[0])
      if (GameData::Type.get(evospec.types[0]).id == typeid || (evospec.types.length == 2 && GameData::Type.get(evospec.types[1]).id == typeid))
        ret = true
      end
    end
  end
  return ret
end

def selectAce(screen, type, taken)
  typemaj = type.upcase
  return screen.pbChooseAblePokemonWithTextNoRepeat(
                  proc { |pkmn| !pkmn.egg? && pkmn.hp > 0 && (hasTypedEvolutions?(pkmn, typemaj) || pkmn.hasType?(typemaj))},
                  false,
                  _INTL("Select your Ace Pokémon!"),
                  taken
                  )
end

def buildGymBattleParty(rankup = false)
  pbFadeOutIn do
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    arraycount = [1,1,2,2,3,3,3,4,4,4,4,5,5,5,5]
    pkmncount = arraycount[$town.rank]
    pkmncount = arraycount[$town.rank+1] if rankup
    type = $town.type
    rep = selectAblePkmnWithType(screen,type,_INTL("Select your Leading Pokémon!"),[])
    if rep == -1
      return false
    else
      team = [$player.party[rep]]
      taken = [rep]
      helptext = _INTL("Choose another (not ace) Pokémon!")
      while team.length < pkmncount
        rep = selectAblePkmnWithType(screen, type, helptext, taken)
        if rep == -1
          if team.length == 1
            text = _INTL("Do you really want to use only 1 pokémon (it will be your ace) ?")
          else
            text = _INTL("Do you really want to use only") + " " + team.length.to_s + " " + _INTL("pokémons (the last selected will be your ace) ?")
          end
          if pbConfirmMessage(text) 
            pbSet(35,team)
            return true
          else
            return false if pbConfirmMessage(_INTL("Stop the team creation?"))
          end
        else
          team.push($player.party[rep])
          taken.push(rep)
        end
      end
      rep = selectAce(screen, type, taken)
      if rep == -1
        if team.length == 1
          text = _INTL("Do you really want to use only 1 pokémon (it will be your ace) ?")
        else
          text = _INTL("Do you really want to use only ") + team.length.to_s + _INTL(" pokémons (the last selected will be your ace) ?")
        end
        if pbConfirmMessage(text) 
          pbSet(35,team)
          return true
        else
          return false if pbConfirmMessage(_INTL("Stop the team creation?"))
        end
      else
        team.push($player.party[rep])
        pbSet(35,team)
        return true
      end
    end
  end
end


def selectThreePinkOrPurplePkmn
  pbFadeOutIn do
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    taken = []	
    while taken.length < 3
      rep = screen.pbChooseAblePokemonWithTextNoDouble(
                      proc { |pkmn| GameData::Species.get(pkmn.species).color == :Pink || GameData::Species.get(pkmn.species).color == :Purple }, 
                      false, 
                      _INTL("Select 3 pink or purple Pokémons"), 
                      taken)
      puts rep
      return false if rep == -1
      taken.push(rep)
    end
    return true
  end  
end

def selectPinkOrPurpleShiny
  pbFadeOutIn do
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    taken = []	
    rep = screen.pbChooseAblePokemonWithTextNoDouble(
                      proc { |pkmn| (GameData::Species.get(pkmn.species).color == :Pink || GameData::Species.get(pkmn.species).color == :Purple) && pkmn.shiny? }, 
                      false, 
                      _INTL("Select a shiny pink or purple Pokémon"), 
                      taken)
    return false if rep == -1
    return true
  end  
end

def selectUndergroundShiny
  pbFadeOutIn do
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    taken = []	
    rep = screen.pbChooseAblePokemonWithTextNoDouble(
                      proc { |pkmn| GameData::Species.get(pkmn.species).habitat == :Cave && pkmn.shiny? }, 
                      false, 
                      _INTL("Select a shiny Pokémon living in caves"), 
                      taken)
    return false if rep == -1
    return true
  end  
end

def selectPinkOrPurpleShiny
  pbFadeOutIn do
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    taken = []	
    rep = screen.pbChooseAblePokemonWithTextNoDouble(
                      proc { |pkmn| GameData::Species.get(pkmn.species).habitat == :Cave && pkmn.shiny? }, 
                      false, 
                      _INTL("Select a shiny pink or purple Pokémon"), 
                      taken)
    return false if rep == -1
    return true
  end  
end

def selectTwoBabyPkmn
  pbFadeOutIn do
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    taken = []	
    while taken.length < 2
      rep = screen.pbChooseAblePokemonWithTextNoDouble(
                      proc { |pkmn| !pkmn.egg? && pkmn.isBaby? }, 
                      false, 
                      _INTL("Select 2 baby Pokémons"), 
                      taken)
      puts rep
      return false if rep == -1
      taken.push(rep)
    end
    return true
  end  
end

def selectThirdStageLowlvlBugPkmn
  pbFadeOutIn do
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    taken = []	
    rep = screen.pbChooseAblePokemonWithTextNoDouble(
                      proc { 
                          |pkmn| !pkmn.egg? && 
                          pkmn.hasType?("BUG") && 
                          pkmn.level < 16 && 
                          (pkmn.species == :BEAUTIFLY || pkmn.species == :DUSTOX || pkmn.species == :BUTTERFREE || 
                          pkmn.species == :BEEDRILL || pkmn.species == :VIVILLON) 
                      }, 
                      false, 
                      _INTL("Select a third stage evolution bug Pokémon less than lvl 16"), 
                      taken)
    return false if rep == -1
    return true
  end  
end


def selectThreeBugPkmn
  pbFadeOutIn do
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    taken = []	
    while taken.length < 3
      rep = screen.pbChooseAblePokemonWithTextNoDouble(
                      proc { |pkmn| !pkmn.egg? && pkmn.hasType?("BUG")}, 
                      false, 
                      _INTL("Select 3 Bug Pokémons"), 
                      taken)
      puts rep
      return false if rep == -1
      taken.push(rep)
    end
    return true
  end  
end

def selectBugPoisonPkmn
  pbFadeOutIn do
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    taken = []	
    rep = screen.pbChooseAblePokemonWithTextNoDouble(
                      proc { |pkmn| !pkmn.egg? && pkmn.hasType?("BUG") && pkmn.hasType?("POISON")}, 
                      false, 
                      _INTL("Select a Bug/Poison Pokémon!"), 
                      taken)
    return false if rep == -1
    return true
  end  
end

def selectOwnTypeShiny
  pbFadeOutIn do
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    taken = []	
    type = (($town.type).upcase).to_sym
    rep = screen.pbChooseAblePokemonWithTextNoDouble(
                      proc { |pkmn| !pkmn.egg? && pkmn.hasType?(type) && pkmn.shiny?}, 
                      false, 
                      _INTL("Select a") + " " + type.to_s + " " + _INTL("Pokémon"), 
                      taken)
    return false if rep == -1
    return true
  end  
end

def selectPkmnWithHealingMove
  pbFadeOutIn do
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    taken = []	
    type = (($town.type).upcase).to_sym
    rep = screen.pbChooseAblePokemonWithTextNoDouble(
                      proc { |pkmn| !pkmn.egg? && pkmn.hasHealingMove?}, 
                      false, 
                      _INTL("Select a Pokémon with a healing move"), 
                      taken)
    return false if rep == -1
    return true
  end  
end

def selectPkmnWithHealingAbility
  pbFadeOutIn do
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    taken = []	
    type = (($town.type).upcase).to_sym
    rep = screen.pbChooseAblePokemonWithTextNoDouble(
                      proc { |pkmn| !pkmn.egg? && pkmn.hasHealingAbility?}, 
                      false, 
                      _INTL("Select a Pokémon with a healing ability"), 
                      taken)
    return false if rep == -1
    return true
  end  
end

def selectPkmnShinyHealer
  pbFadeOutIn do
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    taken = []	
    type = (($town.type).upcase).to_sym
    rep = screen.pbChooseAblePokemonWithTextNoDouble(
                      proc { |pkmn| !pkmn.egg? && pkmn.shiny? && (pkmn.hasHealingMove? || pkmn.hasHealingAbility?)}, 
                      false, 
                      _INTL("Select a shiny healer !"), 
                      taken)
    return false if rep == -1
    return true
  end  
end

def setBag(rankup = false)
  bagrank = $town.rank
  bagrank +=1 if rankup
  case bagrank
  when 0, 1
    setBattleRule("tempBag", [:POTION])
  when 2
    setBattleRule("tempBag", [:POTION,2])
  when 3
    setBattleRule("tempBag", [:SUPERPOTION,2])
  when 4
    setBattleRule("tempBag", [:SUPERPOTION,2,:FULLHEAL,1])
  when 5
    setBattleRule("tempBag", [:SUPERPOTION,2,:FULLHEAL,2])
  when 6
    setBattleRule("tempBag", [:SUPERPOTION,1,:HYPERPOTION,1,FULLHEAL,2])
  when 7
    setBattleRule("tempBag", [:HYPERPOTION,2,FULLHEAL,1])
  when 8
    setBattleRule("tempBag", [:HYPERPOTION,2,FULLHEAL,2])
  when 9
    setBattleRule("tempBag", [:HYPERPOTION,1,:MAXPOTION,1,FULLHEAL,2])
  when 10
    setBattleRule("tempBag", [:MAXPOTION,2,FULLHEAL,1])
  when 11
    setBattleRule("tempBag", [:MAXPOTION,2,FULLHEAL,2])
  when 12
    setBattleRule("tempBag", [:FULLRESTORE,2])
  when 13
    setBattleRule("tempBag", [:FULLRESTORE,3,:REVIVE,1])
  else
    setBattleRule("tempBag", [:POTION])
  end
end

def setGymBattleRules(rankup = false)
  savedParty = pbGet(35)
  count = savedParty.length
  actualrank = $town.rank
  actualrank += 1 if rankup
  actualParty = []
  levels = [13,13,20,25,30,35,40,45,50,55,60,65,70,85]
  levelsace = [15,15,22,27,32,37,42,47,52,57,62,67,72,90]
  lvl = levels[actualrank]
  lvlace = levelsace[actualrank]
  i = 0
  while i < count
    pkmn = savedParty[i].clone
    i += 1
    if i == count
      pkmn.level = lvlace if pkmn.level > lvlace
    else
      pkmn.level = lvl if pkmn.level > lvl
    end
    pkmn.calc_stats
    actualParty.push(pkmn)
  end
  setBattleRule("tempParty",actualParty)
  setBattleRule("noExp")
  setBattleRule("noMoney")
  setBattleRule("setStyle")
  setBattleRule("canLose") unless rankup
  setBattleRule("double") if pbGet(41) == 2
  setBag(rankup)
end

def getWinningChancesFromRating(rating)
  if rating < 1
    return 0
  else
    case rating
    when 1
      return 0.01
    when 2
      return 0.1
    when 3
      return 1
    when 4
      return 2
    when 5..23
      return (rating-4)*5
    when 24
      return 98
    when 25
      return 99
    when 26
      return 99.9
    when 27
      return 99.99
    else
      return 100
    end
  end
end

def getWinningChances(trainer, stars)
  
  # Star rank difficulties
  difficulties = [0,0,5,9,12,15,17,19]
  relationbonus = [0,2,4,7,11,15,20]
  
  # Trainer power (depending on relationship)
  case trainer
  when 1
    base = 12
    name = "MELLY"+$town.type
    relationlevel = (pbGetSocialLinkBond(name.to_sym)/10).floor()
  when 2
    base = 13
    name = "SAMY"
    relationlevel = (pbGetSocialLinkBond(name.to_sym)/10).floor()
  when 3
    base = 15
    name = "KIANA"
    relationlevel = (pbGetSocialLinkBond(name.to_sym)/10).floor()
  when 4
    base = 18
    name = "RIVAL"
    relationlevel = (pbGetSocialLinkBond(name.to_sym)/10).floor()
  else
    return 0
  end
  
  # Main calculation
  rating = 1 + base + relationbonus[relationlevel] - $town.rank - difficulties[stars]

  # Returning, with call from the other function to get actual percentages
  puts "trainer = " + trainer.to_s + "; stars = " + stars.to_s
  puts rating
  return getWinningChancesFromRating(rating)
end
    
def getChallengerMoney(stars, lvlmax)
  puts "lvlmax:"
  puts lvlmax
  puts "stars:"
  puts stars
  famelist = [0,1,3,5,8,12,18,25]
  fame = famelist[stars]
  coeff = 1
  coeff += 0.1 if $town.buildings[18] == 2
  puts "fame:"
  puts fame
  puts "coeff:"
  puts coeff
  puts (4 * fame * lvlmax * coeff).floor().to_s
  return (4 * fame * lvlmax * coeff).floor()
end

def getLostMoney
  multiplier = [0, 4, 8, 12, 16, 20, 24, 32, 40, 50, 60, 70, 80, 100]
  acelvl = [0, 15, 22, 27, 32, 37, 42, 47, 52, 57, 62, 67, 72, 90]
  rank = $town.rank
  coeff = 1
  coeff += 0.1 if $town.buildings[18] == 2
  return (multiplier[rank] * acelvl[rank] * coeff).floor()
end

def showLostMoney
  text = _INTL("The Gym gives $")
  text << getLostMoney.to_s
  text << " "
  text << _INTL("to the challenger!")
  pbMessage(text)
end

def getComeBackChances
  return [0,0,0,0,0,0,0] if $game_switches[64] == true
  ret = [50,20,0,0,0,0,0]
  ret[0] += 20 if $town.buildings[8] == 2
  ret[1] += 15 if $town.buildings[31] == 2
  if $town.buildings[85] == 2
    for i in 0..6
      ret[i] += 10
    end
  end
  return ret
end
    