def getStarterSpecies
  type = $town.type
  list = [:PIDGEY,:PORYGON,:HELIOPTILE,:BUNEARY,:MINCCINO,:BUNNELBY,:STUFFUL,:IGGLYBUFF,:SMOLIV] if type == "Normal"
  list = [:BULBASAUR,:CHIKORITA,:TREECKO,:TURTWIG,:SNIVY,:CHESPIN,:ROWLET,:GROOKEY,:SPRIGATITO] if type == "Grass"
  list = [:CHARMANDER,:CYNDAQUIL,:TORCHIC,:CHIMCHAR,:TEPIG,:FENNEKIN,:LITTEN,:SCORBUNNY,:FUECOCO] if type == "Fire"
  list = [:SQUIRTLE,:TOTODILE,:MUDKIP,:PIPLUP,:OSHAWOTT,:FROAKIE,:POPPLIO,:SOBBLE,:QUAXLY] if type == "Water"
  list = [:PICHU,:HELIOPTILE,:ELECTRIKE,:SHINX,:TYNAMO,:MAREEP,:GRUBBIN,:TOXEL,:PAWMI] if type == "Electric"
  list = [:STUFFUL,:RIOLU,:TORCHIC,:CHIMCHAR,:TEPIG,:CHESPIN,:JANGMOO,:PAWMI,:QUAXLY] if type == "Fighting"
  list = [:BULBASAUR,:ZUBAT,:BUDEW,:CROAGUNK,:VENIPEDE,:NIDORANmA,:GASTLY,:TOXEL,:NIDORANfE] if type == "Poison"
  list = [:CUBONE,:SWINUB,:MUDKIP,:TURTWIG,:SANDILE,:GIBLE,:BUNNELBY,:NIDORANmA,:NIDORANfE] if type == "Ground"
  list = [:CHARMANDER,:TOGEPI,:STARLY,:COMBEE,:BAGON,:FLETCHLING,:PIDGEY,:ROOKIDEE,:ZUBAT] if type == "Flying"
  list = [:ABRA,:SLOWPOKE,:BELDUM,:RALTS,:SOLOSIS,:FENNEKIN,:BLIPBUG,:HATENNA,:GOTHITA] if type == "Psychic"
  list = [:VENIPEDE,:PINECO,:GRUBBIN,:COMBEE,:SEWADDLE,:SNOM,:WIMPOD,:SIZZLIPEDE,:BLIPBUG] if type == "Bug"
  list = [:RHYHORN,:LARVITAR,:ARON,:TYRUNT,:ROGGENROLA,:AMAURA,:ROCKRUFF,:ROLYCOLY,:NACLI] if type == "Rock"
  list = [:GASTLY,:MISDREAVUS,:SHUPPET,:DUSKULL,:LITWICK,:HONEDGE,:ROWLET,:DREEPY,:FUECOCO] if type == "Ghost"
  list = [:SNORUNT,:SNEASEL,:SPHEAL,:SNOVER,:VANILLITE,:AMAURA,:SWINUB,:SNOM,:FRIGIBAX] if type == "Ice"
  list = [:DRATINI,:TYRUNT,:BAGON,:GIBLE,:DEINO,:GOOMY,:JANGMOO,:DREEPY,:FRIGIBAX] if type == "Dragon"
  list = [:LARVITAR,:HOUNDOUR,:ZORUA,:SNEASLER,:PANCHAM,:FROAKIE,:LITTEN,:IMPIDIMP,:SPRIGATITO] if type == "Dark"
  list = [:HONEDGE,:PINECO,:BELDUM,:PIPLUP,:FERROSEED,:RIOLU,:PAWNIARD,:ROOKIDEE,:TINKATINK] if type == "Steel"
  list = [:CLEFFA,:TOGEPI,:RALTS,:FLABEBE,:AZURILL,:IGGLYBUFF,:POPPLIO,:IMPIDIMP,:TINKATINK] if type == "Fairy"
  return list[pbGet(7)-1]
end

################################################################
#
#     Leveling up relations
#
##############################################################

def initializeStartersEggsToGive
  ret = {
    "Normal" => [:PORYGON, :BUNEARY, :MINCCINO, :IGGLYBUFF, :SMOLIV, :STUFFUL],
    "Grass" => [:CHIKORITA, :TREECKO, :SNIVY, :GROOKEY, :ROWLET, :SPRIGATITO],
    "Fire" => [:CYNDAQUIL, :SCORBUNNY, :FENNEKIN, :FUECOCO, :TORCHIC, :CHIMCHAR],
    "Water" => [:SQUIRTLE, :TOTODILE, :OSHAWOTT, :SOBBLE, :PIPLUP, :FROAKIE],
    "Electric" => [:PICHU, :ELECTRIKE, :SHINX, :TYNAMO, :MAREEP, :HELIOPTILE],
    "Fighting" => [:TEPIG, :PAWMI, :JANGMOO, :CHESPIN, :RIOLU, :QUAXLY],
    "Poison" => [:BUDEW, :CROAGUNK, :TOXEL, :BULBASAUR, :ZUBAT, :NIDORANfE],
    "Ground" => [:CUBONE, :SANDILE, :MUDKIP, :BUNNELBY, :SWINUB, :TURTWIG],
    "Flying" => [:FLETCHLING, :PIDGEY, :COMBEE, :ROOKIDEE, :STARLY, :CHARMANDER],
    "Psychic" => [:ABRA, :SLOWPOKE, :SOLOSIS, :HATENNA, :GOTHITA, :BELDUM],
    "Bug" => [:VENIPEDE, :SEWADDLE, :WIMPOD, :SIZZLIPEDE, :BLIPBUG, :GRUBBIN],
    "Rock" => [:RHYHORN, :ROGGENROLA, :ROCKRUFF, :ROLYCOLY, :NACLI, :TYRUNT],
    "Ghost" => [:GASTLY, :MISDREAVUS, :SHUPPET, :DUSKULL, :LITWICK, :DREEPY],
    "Ice" => [:SNORUNT, :SPHEAL, :SNOVER, :VANILLITE, :SNOM, :AMAURA],
    "Dragon" => [:DRATINI, :BAGON, :GIBLE, :DEINO, :GOOMY, :FRIGIBAX],
    "Dark" => [:HOUNDOUR, :ZORUA, :LARVITAR, :LITTEN, :PANCHAM, :SNEASEL],
    "Steel" => [:FERROSEED, :PAWNIARD, :ARON, :PINECO, :HONEDGE, :TINKATINK],
    "Fairy" => [:CLEFFA, :FLABEBE, :AZURILL, :IMPIDIMP, :RALTS, :POPPLIO]
    }
  return ret
end
  

def rewardsGeneral(lvl, name)
  pbPlayLevelUpSE
  pbMessage(_INTL("Your relation with {1} reached a new heart level!", name))
  if lvl == 6
    pbMessage(_INTL("Your relation is now maxed, at 6 hearts! Congratulations!"))
  elsif lvl == 1
    pbMessage(_INTL("Your relation is now at 1 heart! Keep going!"))
  else
    pbMessage(_INTL("Your relation is now at {1} hearts! Keep going!", lvl))
  end
end


#   Maple
#######################################################################
def rewardsMaple(lvl)
  rewardsGeneral(lvl, _INTL("Prof. Maple"))
  pbMessage(_INTL("<b>\\c[10]Maple:</b>\\c[0] You're always so kind with me \\pn, thank you!"))
  pbMessage(_INTL("<b>\\c[10]Maple:</b>\\c[0] Here, take this egg as a token of my gratitude!"))
  togepi = $town.giveStarter($town.type)
  typetxt = pbGetMessageFromHash(MessageTypes::TYPE_NAMES, $town.type)
  if togepi && $town.type != "Fairy"
    pbMessage(_INTL("<b>\\c[10]Maple:</b>\\c[0] This time it's not a new {1} starter.", typetxt))
    pbMessage(_INTL("<b>\\c[10]Maple:</b>\\c[0] You already got all that I have"))
    pbMessage(_INTL("<b>\\c[10]Maple:</b>\\c[0] So I'm giving you my favorite Pokémon!"))
  else
    pbMessage(_INTL("<b>\\c[10]Maple:</b>\\c[0] This egg contains a {1} starter that you don't already have.", typetxt))
    pbMessage(_INTL("<b>\\c[10]Maple:</b>\\c[0] Take good care of it!"))
  end
  pbMessage(_INTL("<b>\\c[10]Maple:</b>\\c[0] See you soon!"))
end

def upMapleRelation(number)
  limit = 15
  completedQuests = getCompletedQuests
  limit += 10 if completedQuests.include?(("MapleQuest1").to_sym) 
  limit += 10 if completedQuests.include?(("MapleQuest2").to_sym) 
  limit += 10 if completedQuests.include?(("MapleQuest3").to_sym) 
  limit += 10 if completedQuests.include?(("MapleQuest4").to_sym) 
  limit += 5 if completedQuests.include?(("MapleQuest5").to_sym) 
  oldlvl = pbGetSocialLinkBond(:PROFMAPLE)
  if oldlvl >= 60
    pbMessage(_INTL("Your relationship with Maple is maxed out! I can't go higher!"))
  elsif oldlvl >= limit
    pbMessage(_INTL("You've reached the current limit of your relationship with Maple"))
    pbMessage(_INTL("Complete his current quests to improve it further."))
  else
    number = limit-oldlvl if (oldlvl+number) >= limit
    pbGainSocialLinkBond(:PROFMAPLE, number)
    newlvl = pbGetSocialLinkBond(:PROFMAPLE)/10
    pbSet(201,newlvl)
    if newlvl > oldlvl/10
      rewardsMaple(newlvl)
    end
    if (oldlvl+number) >= limit && (oldlvl+number) < 60
      pbMessage(_INTL("You've reached the current limit of your relationship with Maple"))
      pbMessage(_INTL("Complete his current quest to improve it further."))
    end 
  end
end


#   Marley
#######################################################################
def rewardsMarley(lvl)
  rewardsGeneral(lvl, "Marley")
  pbMessage(_INTL("<b>\\c[3]Marley:</b>\\c[0] Hey \\pn, I think you have more shiny energy inside you now."))
  pbMessage(_INTL("<b>\\c[3]Marley:</b>\\c[0] I'm sure you'll see more shinies now!"))
  chances = [1,2,4,6,8,12,16]
  pbMessage(_INTL("You shiny chances grew from {1} to {2} out of 512!", chances[lvl-1], chances[lvl]))
  percent = (100 * (chances[lvl].to_f / 512.0)).round(3)
  pbMessage(_INTL("You now have roughly {1}% chances that any Pokémon is a shiny!", percent.to_s))
  pbMessage(_INTL("<b>\\c[3]Marley:</b>\\c[0] See you around!"))
  
end

def upMarleyRelation(number)
  limit = 15
  completedQuests = getCompletedQuests
  limit += 10 if completedQuests.include?(("MarleyQuest1").to_sym) 
  limit += 10 if completedQuests.include?(("MarleyQuest2").to_sym) 
  limit += 10 if completedQuests.include?(("MarleyQuest3").to_sym) 
  limit += 10 if completedQuests.include?(("MarleyQuest4").to_sym) 
  limit += 5 if completedQuests.include?(("MarleyQuest5").to_sym) 
  oldlvl = pbGetSocialLinkBond(:MARLEY)
  if oldlvl >= 60
    pbMessage(_INTL("Your relationship with Marley is maxed out! I can't go higher!"))
  elsif oldlvl >= limit
    pbMessage(_INTL("You've reached the current limit of your relationship with Marley"))
    pbMessage(_INTL("Complete his current quest to improve it further."))
  else
    number = limit-oldlvl if oldlvl+number >= limit
    pbGainSocialLinkBond(:MARLEY, number)
    newlvl = pbGetSocialLinkBond(:MARLEY)/10
    pbSet(202,newlvl)
    if newlvl > oldlvl/10
      rewardsMarley(newlvl)
    end
    if oldlvl+number >= limit && (oldlvl+number) < 60
      pbMessage(_INTL("You've reached the current limit of your relationship with Marley"))
      pbMessage(_INTL("Complete his current quest to improve it further."))
    end  
  end
end






#   Melly
#######################################################################
def rewardsMelly(lvl)
  rewardsGeneral(lvl, "Melly")
  pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] Th-thank you for being always so nice with me \\pn!"))
  pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] I really l-like spending time with y-you!"))
  if pbGet(100) > 200
    pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] I-I will do my best to be b-better at the League, I promise you!"))
    pbPlayLevelUpSE
    pbMessage(_INTL("Melly's chances to win in the League improved!"))
    pbMessage(_INTL("Speak to Marley for detailed winning percentages."))
    pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] And e-ehm..., p-please accept this!"))
    type = ($town.type == "Ghost") ? "Normal" : "Ghost"
    togepi = $town.giveStarter(type)
    if togepi
      pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] S-sorry I can't give you more {1} starters."), type)
      pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] You already got a-all the ones I have"))
      pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] So I'm giving you th-this egg that Maple gave me earlier!"))
    else
      pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] Now that I-I'm technically the {1} Leader, I can g-give {1} starters!", type))
      pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] Th-this egg contains a {1} starter that y-you don't already have.", type))
      pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] T-take good care of it!"))
    end
  else
    pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] I will do my best to be better at the Gym, I promise you!"))
    pbPlayLevelUpSE
    pbMessage(_INTL("Melly's chances to win in the Gym improved!"))
    pbMessage(_INTL("Speak to Marley for detailed winning percentages."))
  end
  pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] S-see ya!"))
end

def upMellyRelation(number)
  type = $town.type
  sym = ("MELLY"+type).to_sym
  limit = 15
  completedQuests = getCompletedQuests
  limit += 10 if completedQuests.include?(("MellyQuest1").to_sym) 
  limit += 10 if completedQuests.include?(("MellyQuest2").to_sym) 
  limit += 10 if completedQuests.include?(("MellyQuest3").to_sym) 
  limit += 10 if completedQuests.include?(("MellyQuest4").to_sym) 
  limit += 5 if completedQuests.include?(("MellyQuest5").to_sym) 
  oldlvl = pbGetSocialLinkBond(sym)
  if oldlvl >= 60
    pbMessage(_INTL("Your relationship with Melly is maxed out! I can't go higher!"))
  elsif oldlvl >= limit
    pbMessage(_INTL("You've reached the current limit of your relationship with Melly"))
    pbMessage(_INTL("Complete his current quest to improve it further."))
  else
    number = limit-oldlvl if oldlvl+number >= limit
    pbGainSocialLinkBond(sym, number)
    newlvl = pbGetSocialLinkBond(sym)/10
    pbSet(204,newlvl)
    if newlvl > oldlvl/10
      rewardsMelly(newlvl)
    end
    if oldlvl+number >= limit && (oldlvl+number) < 60
      pbMessage(_INTL("You've reached the current limit of your relationship with Melly"))
      pbMessage(_INTL("Complete his current quest to improve it further."))
    end  
  end
end


#   Samy
#######################################################################
def rewardsSamy(lvl)
  rewardsGeneral(lvl, "Samy")
  pbMessage(_INTL("<b><c3=BDA46A,736440>Samy:</b></c3> Heh! You're really a nice kid \\pn, I'm glad I joined you."))
  if pbGet(100) > 200
    pbMessage(_INTL("<b><c3=BDA46A,736440>Samy:</b></c3> I'll improve my performances as an Elite 4 member, rest assured! Haha!"))
    pbPlayLevelUpSE
    pbMessage(_INTL("Samy's chances to win in the League improved!"))
    pbMessage(_INTL("Speak to Marley for detailed winning percentages."))
    pbMessage(_INTL("<b><c3=BDA46A,736440>Samy:</b></c3> And I also wanted to give you this!"))
    type = ($town.type == "Fire" || $town.type == "Fairy" || $town.type == "Steel") ? "Normal" : "Fire"
    togepi = $town.giveStarter(type)
    if togepi
      pbMessage(_INTL("<b><c3=BDA46A,736440>Samy:</b></c3> I can't give you more {1} starters tho!"), type)
      pbMessage(_INTL("<b><c3=BDA46A,736440>Samy:</b></c3> You already got all the ones that I can give!"))
      pbMessage(_INTL("<b><c3=BDA46A,736440>Samy:</b></c3> So I'm giving you this egg that Maple gave me earlier!"))
    else
      pbMessage(_INTL("<b><c3=BDA46A,736440>Samy:</b></c3> I can give {1} starters now that I'm the glorious {1} Leader! haha!", type))
      pbMessage(_INTL("<b><c3=BDA46A,736440>Samy:</b></c3> This egg contains a {1} starter that you don't already have.", type))
      pbMessage(_INTL("<b><c3=BDA46A,736440>Samy:</b></c3> Take good care of it!"))
    end
  else
    pbMessage(_INTL("<b><c3=BDA46A,736440>Samy:</b></c3> I'll improve my performances at the Gym, rest assured! Haha!"))
    pbPlayLevelUpSE
    pbMessage(_INTL("Samy's chances to win in the Gym improved!"))
    pbMessage(_INTL("Speak to Marley for detailed winning percentages."))
  end
  pbMessage(_INTL("<b><c3=BDA46A,736440>Samy:</b></c3> See ya champ!!"))
end

def upSamyRelation(number)
  limit = 15
  completedQuests = getCompletedQuests
  limit += 10 if completedQuests.include?(("SamyQuest1").to_sym) 
  limit += 10 if completedQuests.include?(("SamyQuest2").to_sym) 
  limit += 10 if completedQuests.include?(("SamyQuest3").to_sym) 
  limit += 10 if completedQuests.include?(("SamyQuest4").to_sym) 
  limit += 5 if completedQuests.include?(("SamyQuest5").to_sym) 
  oldlvl = pbGetSocialLinkBond(:SAMY)
  if oldlvl >= 60
    pbMessage(_INTL("Your relationship with Samy is maxed out! I can't go higher!"))
  elsif oldlvl >= limit
    pbMessage(_INTL("You've reached the current limit of your relationship with Samy"))
    pbMessage(_INTL("Complete his current quest to improve it further."))
  else
    number = limit-oldlvl if oldlvl+number >= limit
    pbGainSocialLinkBond(:SAMY, number)
    newlvl = pbGetSocialLinkBond(:SAMY)/10
    pbSet(205,newlvl)
    if newlvl > oldlvl/10
      rewardsSamy(newlvl)
    end
    if oldlvl+number >= limit && (oldlvl+number) < 60
      pbMessage(_INTL("You've reached the current limit of your relationship with Samy"))
      pbMessage(_INTL("Complete his current quest to improve it further."))
    end  
  end
end



#   Kiana
#######################################################################
def rewardsKiana(lvl)
  rewardsGeneral(lvl, "Kiana")
  pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] Hmpf! I must admit you're kinda ok to be with."))
  pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] Don't think you're so cool either though!"))
  pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] You're okay... But far from my level of course!"))
  if pbGet(100) > 200
    pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] Don't worry, I will improve at the League."))
    pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] Without me we would be a ridiculous Elite 4 anyway!"))
    pbPlayLevelUpSE
    pbMessage(_INTL("Kiana's chances to win in the League improved!"))
    pbMessage(_INTL("Speak to Marley for detailed winning percentages"))
    type = ($town.type == "Dark") ? "Normal" : "Dark"
    pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] And e-ehm..., it's not like I want to give you a gift..."))
    pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] I-it's just because I'm the {1} Leader now!!", type))
    pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] S-so shut it and accept this!"))
    togepi = $town.giveStarter(type)
    if togepi
      pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] I can't give you more {1} starters..."), type)
      pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] You already got all the ones I have"))
      pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] So I'm giving you this egg that Maple gave me earlier."))
      pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] B-but be happy that I still wanted to give you something!!"))
    else
      pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] This egg contains a {1} starter that you don't already have.", type))
      pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] Th-this is only to promote the {1} type, nothing more!!", type))
      pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] You better take good care of it!"))
    end
  else
    pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] Don't worry, I will improve at the Gym."))
    pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] Without me we would be a ridiculous group of Gym trainers anyway!"))
    pbPlayLevelUpSE
    pbMessage(_INTL("Kiana's chances to win in the Gym improved!"))
    pbMessage(_INTL("Speak to Marley for detailed winning percentages."))
  end
  pbMessage(_INTL("<b>\\c[4]Kiana:</b>\\c[0] Good day to you!"))
end

def upKianaRelation(number)
  type = $town.type
  sym = ("KIANA"+type).to_sym
  limit = 15
  completedQuests = getCompletedQuests
  limit += 10 if completedQuests.include?(("KianaQuest1").to_sym) 
  limit += 10 if completedQuests.include?(("KianaQuest2").to_sym) 
  limit += 10 if completedQuests.include?(("KianaQuest3").to_sym) 
  limit += 10 if completedQuests.include?(("KianaQuest4").to_sym) 
  limit += 5 if completedQuests.include?(("KianaQuest5").to_sym) 
  oldlvl = pbGetSocialLinkBond(sym)
  if oldlvl >= 60
    pbMessage(_INTL("Your relationship with Kiana is maxed out! I can't go higher!"))
  elsif oldlvl >= limit
    pbMessage(_INTL("You've reached the current limit of your relationship with Kiana"))
    pbMessage(_INTL("Complete his current quest to improve it further."))
  else
    number = limit-oldlvl if oldlvl+number >= limit
    pbGainSocialLinkBond(sym, number)
    newlvl = pbGetSocialLinkBond(sym)/10
    pbSet(206,newlvl)
    if newlvl > oldlvl/10
      rewardsKiara(newlvl)
    end
    if oldlvl+number >= limit && (oldlvl+number) < 60
      pbMessage(_INTL("You've reached the current limit of your relationship with Kiana"))
      pbMessage(_INTL("Complete his current quest to improve it further."))
    end  
  end
end



#   Rival
#######################################################################
def rewardsRival(lvl)
  rewardsGeneral(lvl, "Rival")
  pbMessage(_INTL("<b>\\c[2]\\rn:</b>\\c[0] Eh! Gotta admit, you're kinda cool to hang out with."))
  pbMessage(_INTL("<b>\\c[2]\\rn:</b>\\c[0] Our duo is unstoppable now, don't you think?"))
  if pbGet(100) > 200
    pbMessage(_INTL("<b>\\c[2]\\rn:</b>\\c[0] I will improve as the Elite 4 best member, you'll see!"))
    pbPlayLevelUpSE
    pbMessage(_INTL("\\rn chances to win in the League improved!"))
    pbMessage(_INTL("Speak to Marley for detailed winning percentages"))
    pbMessage(_INTL("<b>\\c[2]\\rn:</b>\\c[0] Hey, I have something for you pal!"))
    type = ($town.type == "Poison") ? "Normal" : "Poison"
    togepi = $town.giveStarter(type)
    if togepi
      pbMessage(_INTL("<b>\\c[2]\\rn:</b>\\c[0] I wanted to give you another {1} starters...", type))
      pbMessage(_INTL("<b>\\c[2]\\rn:</b>\\c[0] But you already have all the ones that I can give you now. Sorry!"))
      pbMessage(_INTL("<b>\\c[2]\\rn:</b>\\c[0] As a compensation I'm giving you this egg that Maple gave me earlier."))
      pbMessage(_INTL("<b>\\c[2]\\rn:</b>\\c[0] It contains his favorite Pokémon I think."))
    else
      pbMessage(_INTL("<b>\\c[2]\\rn:</b>\\c[0] You know I'm the {1} Leader right?", type))
      pbMessage(_INTL("<b>\\c[2]\\rn:</b>\\c[0] Th egg contains a {1} starter that you don't already have.", type))
      pbMessage(_INTL("<b>\\c[2]\\rn:</b>\\c[0] You're welcome!"))
    end
  else
    pbMessage(_INTL("<b>\\c[2]\\rn:</b>\\c[0] I will improve as the Gym best trainer, you'll see!"))
    pbPlayLevelUpSE
    pbMessage(_INTL("\\rn's chances to win in the Gym improved!"))
    pbMessage(_INTL("Speak to Marley for detailed winning percentages"))
  end
  pbMessage(_INTL("<b>\\c[2]\\rn:</b>\\c[0] See ya!"))
end

def upRivalRelation(number)
  type = $town.type
  sym = ("RIVAL"+type).to_sym
  limit = 35
  completedQuests = getCompletedQuests
  limit += 10 if completedQuests.include?(("RivalQuest1").to_sym) 
  limit += 10 if completedQuests.include?(("RivalQuest2").to_sym) 
  limit += 5 if completedQuests.include?(("RivalQuest3").to_sym)  
  oldlvl = pbGetSocialLinkBond(sym)
  if oldlvl >= 60
    pbMessage(_INTL("Your relationship with \\rn is maxed out! I can't go higher!"))
  elsif oldlvl >= limit
    pbMessage(_INTL("You've reached the current limit of your relationship with \\rn"))
    pbMessage(_INTL("Complete his current quest to improve it further."))
  else
    number = limit-oldlvl if oldlvl+number >= limit
    pbGainSocialLinkBond(sym, number)
    newlvl = pbGetSocialLinkBond(sym)/10
    pbSet(207,newlvl)
    if newlvl > oldlvl/10
      rewardsRival(newlvl)
    end
    if oldlvl+number >= limit && (oldlvl+number) < 60
      pbMessage(_INTL("You've reached the current limit of your relationship with \\rn"))
      pbMessage(_INTL("Complete his current quest to improve it further."))
    end  
  end
end



#   Nurses
#######################################################################
def rewardsNurses(lvl)
  rewardsGeneral(lvl, _INTL("the Nurses"))
  pbMessage(_INTL("<b>\\c[5]Nurse:</b>\\c[0] You're really a sweetheart \\pn, we love you!"))
  pbMessage(_INTL("<b>\\c[5]Nurse:</b>\\c[0] Here, we can improve your life vial to help you during your travels."))
  pbMessage(_INTL("Your life vial can now be used {1} times!", lvl+1))
  pbMessage(_INTL("<b>\\c[5]Nurse:</b>\\c[0] Stay safe during your travels!"))
  pbSet(78,lvl+1)
  pbSet(77, pbGet(78))
end

def upNursesRelation(number)
  limit = 15
  completedQuests = getCompletedQuests
  limit += 10 if completedQuests.include?(("NursesQuest1").to_sym) 
  limit += 10 if completedQuests.include?(("NursesQuest2").to_sym) 
  limit += 10 if completedQuests.include?(("NursesQuest3").to_sym) 
  limit += 10 if completedQuests.include?(("NursesQuest4").to_sym) 
  limit += 5 if completedQuests.include?(("NursesQuest5").to_sym) 
  oldlvl = pbGetSocialLinkBond(:NURSES)
  if oldlvl >= 60
    pbMessage(_INTL("Your relationship with the Nurses is maxed out! I can't go higher!"))
  elsif oldlvl >= limit
    pbMessage(_INTL("You've reached the current limit of your relationship with the Nurses"))
    pbMessage(_INTL("Complete his current quest to improve it further."))
  else
    number = limit-oldlvl if oldlvl+number >= limit
    pbGainSocialLinkBond(:NURSES, number)
    newlvl = pbGetSocialLinkBond(:NURSES)/10
    pbSet(203,newlvl)
    if newlvl > oldlvl/10
      rewardsNurses(newlvl)
    end
    if oldlvl+number >= limit && (oldlvl+number) < 60
      pbMessage(_INTL("You've reached the current limit of your relationship with the Nurses"))
      pbMessage(_INTL("Complete his current quest to improve it further."))
    end 
  end
end


#   Madame S
#######################################################################
def rewardsMadameS(lvl)
  rewardsGeneral(lvl, "Madame S")
  pbMessage(_INTL("<b>\\c[11]Madame S:</b>\\c[0] You're always so sweet with me \\pn, thank you!"))
  pbMessage(_INTL("<b>\\c[11]Madame S:</b>\\c[0] Let me explain you how to pour more love to your Pokémon."))
  pbMessage(_INTL("Madame S tell you about various techniques to get closer to your Pokémon"))
  pbMessage(_INTL("Pokémon relationship and egg hatch speed increased from {1}% to {2}% !", 100+50*lvl,100+50*(lvl+1)))
  pbMessage(_INTL("<b>\\c[11]Madame S:</b>\\c[0] Keep spreading love sweetie!"))
end

def upMadameSRelation(number)
  limit = 15
  completedQuests = getCompletedQuests
  limit += 10 if completedQuests.include?(("MadameSQuest1").to_sym) 
  limit += 10 if completedQuests.include?(("MadameSQuest2").to_sym) 
  limit += 10 if completedQuests.include?(("MadameSQuest3").to_sym) 
  limit += 10 if completedQuests.include?(("MadameSQuest4").to_sym) 
  limit += 5 if completedQuests.include?(("MadameSQuest5").to_sym) 
  oldlvl = pbGetSocialLinkBond(:MADAMES)
  if oldlvl >= 60
    pbMessage(_INTL("Your relationship with Madame S is maxed out! I can't go higher!"))
  elsif oldlvl >= limit
    pbMessage(_INTL("You've reached the current limit of your relationship with Madame S"))
    pbMessage(_INTL("Complete her current quest to improve it further."))
  else
    number = limit-oldlvl if oldlvl+number >= limit
    pbGainSocialLinkBond(:MADAMES, number)
    newlvl = pbGetSocialLinkBond(:MADAMES)/10
    pbSet(209,newlvl)
    if newlvl > oldlvl/10
      rewardsMadameS(newlvl)
    end
    if oldlvl+number >= limit && (oldlvl+number) < 60
      pbMessage(_INTL("You've reached the current limit of your relationship with Madame S"))
      pbMessage(_INTL("Complete her current quest to improve it further."))
    end 
  end
end

#   Tom
#######################################################################
def rewardsTom(lvl)
  rewardsGeneral(lvl, "Tom")
  pbMessage(_INTL("<b>\\c[2]Tom:</b>\\c[0] You're a good friend \\pn, a really good one!"))
  pbMessage(_INTL("<b>\\c[2]Tom:</b>\\c[0] Here, take this egg as a proof of our friendship!"))
  type = (type == "Steel" || type == "Fairy") ? "Fire" : "Steel"
  togepi = $town.giveStarter(type)
  if lvl = 1
    pbMessage(_INTL("<b>\\c[2]Tom:</b>\\c[0] The {1} Leader is technically Aristarque, the Champion.", type))
    pbMessage(_INTL("<b>\\c[2]Tom:</b>\\c[0] But he doesn't seem to care about new trainers..."))
    pbMessage(_INTL("<b>\\c[2]Tom:</b>\\c[0] So I'm the one responsible for the {1} starters.", type))
    pbMessage(_INTL("<b>\\c[2]Tom:</b>\\c[0] The egg I just gave you contains a {1} starter!", type))
    elsif togepi
    pbMessage(_INTL("<b>\\c[2]Tom:</b>\\c[0] This time it's not a new {1} starter.", type))
    pbMessage(_INTL("<b>\\c[2]Tom:</b>\\c[0] You already got all that I have."))
    pbMessage(_INTL("<b>\\c[2]Tom:</b>\\c[0] So I'm giving you an egg Maple gave me earlier!"))
  else
    pbMessage(_INTL("<b>\\c[2]Tom:</b>\\c[0] As I already said I'm the one responsible for the {1} starters.", type))
    pbMessage(_INTL("<b>\\c[2]Tom:</b>\\c[0] This egg contains a {1} starter that you don't already have.", type))
  end
  pbMessage(_INTL("<b>\\c[2]Tom:</b>\\c[0] See you around!"))
end

def upTomRelation(number)
  type = $town.type
  if (type == "Steel" || type == "Fairy")
    type = "FIRE" 
  else 
    type = ""
  end
  sym = ("TOM"+type).to_sym
  limit = 35
  completedQuests = getCompletedQuests
  limit += 10 if completedQuests.include?(("TomQuest1").to_sym) 
  limit += 10 if completedQuests.include?(("TomQuest2").to_sym) 
  limit += 5 if completedQuests.include?(("TomQuest3").to_sym)  
  oldlvl = pbGetSocialLinkBond(sym)
  if oldlvl >= 60
    pbMessage(_INTL("Your relationship with Tom is maxed out! I can't go higher!"))
  elsif oldlvl >= limit
    pbMessage(_INTL("You've reached the current limit of your relationship with Maple"))
    pbMessage(_INTL("Complete his current quest to improve it further."))
  else
    number = limit-oldlvl if oldlvl+number >= limit
    pbGainSocialLinkBond(sym, number)
    newlvl = pbGetSocialLinkBond(sym)/10
    pbSet(208,newlvl)
    if newlvl > oldlvl/10
      rewardsTom(newlvl,true)
    end
    if oldlvl+number >= limit && (oldlvl+number) < 60
      pbMessage(_INTL("You've reached the current limit of your relationship with Maple"))
      pbMessage(_INTL("Complete his current quest to improve it further."))
    end
  end
end

#   Normal Leader (NL)
#######################################################################
def rewardsNL(lvl)
  rewardsGeneral(lvl, _INTL("the Normal Leader"))
  pbMessage(_INTL("The Normal Leader shows you an image with a smile on it."))
  pbMessage(_INTL("They then gives you an egg!"))
  $town.giveStarter("Normal")
  pbMessage(_INTL("The Normal Leader waves at you!"))
end

def upNLRelation(number)
  type = $town.type
  sym = ("NL"+type).to_sym
  limit = 15
  completedQuests = getCompletedQuests
  limit += 10 if completedQuests.include?(("NLQuest1").to_sym) 
  limit += 10 if completedQuests.include?(("NLQuest2").to_sym) 
  limit += 10 if completedQuests.include?(("NLQuest3").to_sym) 
  limit += 10 if completedQuests.include?(("NLQuest4").to_sym) 
  limit += 5 if completedQuests.include?(("NLQuest5").to_sym) 
  oldlvl = pbGetSocialLinkBond(sym)
  if oldlvl >= 60
    pbMessage(_INTL("Your relationship with the Normal Leader is maxed out! I can't go higher!"))
  elsif oldlvl >= limit
    pbMessage(_INTL("You've reached the current limit of your relationship with the Normal Leader"))
    pbMessage(_INTL("Complete his current quest to improve it further."))
  else
    number = limit-oldlvl if oldlvl+number >= limit
    pbGainSocialLinkBond(sym, number)
    newlvl = pbGetSocialLinkBond(sym)/10
    pbSet(212,newlvl)
    if newlvl > oldlvl/10
      rewardsNL(newlvl)
    end
    if oldlvl+number >= limit && (oldlvl+number) < 60
      pbMessage(_INTL("You've reached the current limit of your relationship with the Normal Leader"))
      pbMessage(_INTL("Complete his current quest to improve it further."))
    end 
  end
end

#   Kathleen (Bug Leader)
#######################################################################
def rewardsKathleen(lvl)
  rewardsGeneral(lvl, "Kathleen")
  pbMessage(_INTL("<b><c3=98ff98,1b621b>Kathleen:</b></c> Hey \\pn, I think we've became great friends no?"))
  pbMessage(_INTL("<b><c3=98ff98,1b621b>Kathleen:</b></c> I love gifting things to my great friends, take this egg!"))
  togepi = $town.giveStarter("Bug")
  if togepi
    pbMessage(_INTL("<b><c3=98ff98,1b621b>Kathleen:</b></c> This time it's not a new Bug starter."))
    pbMessage(_INTL("<b><c3=98ff98,1b621b>Kathleen:</b></c> You already got all that I have"))
    pbMessage(_INTL("<b><c3=98ff98,1b621b>Kathleen:</b></c> So I'm giving you my favorite Pokémon!"))
  else
    pbMessage(_INTL("<b><c3=98ff98,1b621b>Kathleen:</b></c> This egg contains a Bug starter that you don't already have."))
    pbMessage(_INTL("<b><c3=98ff98,1b621b>Kathleen:</b></c> Take good care of it!"))
  end
  pbMessage(_INTL("<b><c3=98ff98,1b621b>Kathleen:</b></c> See ya!"))
end

def upKathleenRelation(number)
  limit = 15
  completedQuests = getCompletedQuests
  limit += 10 if completedQuests.include?(("KathleenQuest1").to_sym) 
  limit += 10 if completedQuests.include?(("KathleenQuest2").to_sym) 
  limit += 10 if completedQuests.include?(("KathleenQuest3").to_sym) 
  limit += 10 if completedQuests.include?(("KathleenQuest4").to_sym) 
  limit += 5 if completedQuests.include?(("KathleenQuest5").to_sym) 
  oldlvl = pbGetSocialLinkBond(:KATHLEEN)
  if oldlvl >= 60
    pbMessage(_INTL("Your relationship with Kathleen is maxed out! I can't go higher!"))
  elsif oldlvl >= limit
    pbMessage(_INTL("You've reached the current limit of your relationship with Kathleen"))
    pbMessage(_INTL("Complete his current quest to improve it further."))
  else
    number = limit-oldlvl if oldlvl+number >= limit
    pbGainSocialLinkBond(:KATHLEEN, number)
    newlvl = pbGetSocialLinkBond(:KATHLEEN)/10
    pbSet(210,newlvl)
    if newlvl > oldlvl/10
      rewardsKathleen(newlvl)
    end
    if oldlvl+number >= limit && (oldlvl+number) < 60
      pbMessage(_INTL("You've reached the current limit of your relationship with Kathleen"))
      pbMessage(_INTL("Complete his current quest to improve it further."))
    end  
  end
end

#   Cassian (Rock Leader)
#######################################################################
def rewardsCassian(lvl)
  rewardsGeneral(lvl, "Cassian")
  pbMessage(_INTL("<b>\\c[7]Cassian:</b>\\c[0] Hey \\pn, I really value our relationship!"))
  pbMessage(_INTL("<b>\\c[7]Cassian:</b>\\c[0] Why don't you take this egg as a token of friendship!"))
  togepi = $town.giveStarter("Rock")
  if togepi
    pbMessage(_INTL("<b>\\c[7]Cassian:</b>\\c[0] This time it's not a new Rock starter."))
    pbMessage(_INTL("<b>\\c[7]Cassian:</b>\\c[0] You already got all that I have"))
    pbMessage(_INTL("<b>\\c[7]Cassian:</b>\\c[0] So I'm giving you my favorite Pokémon!"))
  else
    pbMessage(_INTL("<b>\\c[7]Cassian:</b>\\c[0] This egg contains a Rock starter that you don't already have."))
    pbMessage(_INTL("<b>\\c[7]Cassian:</b>\\c[0] Take good care of it!"))
  end
  pbMessage(_INTL("<b>\\c[7]Cassian:</b>\\c[0] See you soon!"))
end

def upCassianRelation(number)
  limit = 15
  completedQuests = getCompletedQuests
  limit += 10 if completedQuests.include?(("CassianQuest1").to_sym) 
  limit += 10 if completedQuests.include?(("CassianQuest2").to_sym) 
  limit += 10 if completedQuests.include?(("CassianQuest3").to_sym) 
  limit += 10 if completedQuests.include?(("CassianQuest4").to_sym) 
  limit += 5 if completedQuests.include?(("CassianQuest5").to_sym) 
  oldlvl = pbGetSocialLinkBond(:CASSIAN)
  if oldlvl >= 60
    pbMessage(_INTL("Your relationship with Cassian is maxed out! I can't go higher!"))
  elsif oldlvl >= limit
    pbMessage(_INTL("You've reached the current limit of your relationship with Cassian"))
    pbMessage(_INTL("Complete his current quest to improve it further."))
  else
    number = limit-oldlvl if oldlvl+number >= limit
    pbGainSocialLinkBond(:CASSIAN, number)
    newlvl = pbGetSocialLinkBond(:CASSIAN)/10
    pbSet(211,newlvl)
    if newlvl > oldlvl/10
      rewardsCassian(newlvl)
    end
    if oldlvl+number >= limit && (oldlvl+number) < 60
      pbMessage(_INTL("You've reached the current limit of your relationship with Cassian"))
      pbMessage(_INTL("Complete his current quest to improve it further."))
    end  
  end
end

#   Nikodim (Grass Leader) TODO 
#######################################################################
def rewardsNikodim(lvl)
  rewardsGeneral(lvl, "Nikodim")
  pbMessage(_INTL("<b>\\c[3]Nikodim:</b>\\c[0] You're always so kind with me \\pn, thank you!"))
  pbMessage(_INTL("<b>\\c[3]Nikodim:</b>\\c[0] Here, take this egg as a token of my gratitude!"))
  togepi = $town.giveStarter("Grass")
  if togepi
    pbMessage(_INTL("<b>\\c[3]Nikodim:</b>\\c[0] This time it's not a new Grass starter."))
    pbMessage(_INTL("<b>\\c[3]Nikodim:</b>\\c[0] You already got all that I have"))
    pbMessage(_INTL("<b>\\c[3]Nikodim:</b>\\c[0] So I'm giving you my favorite Pokémon!"))
  else
    pbMessage(_INTL("<b>\\c[3]Nikodim:</b>\\c[0] This egg contains a Grass starter that you don't already have."))
    pbMessage(_INTL("<b>\\c[3]Nikodim:</b>\\c[0] Take good care of it!"))
  end
  pbMessage(_INTL("<b>\\c[3]Nikodim:</b>\\c[0] See you soon!"))
end

def upNikodimRelation(number)
  oldlvl = pbGetSocialLinkBond(:NIKODIM)/10
  pbGainSocialLinkBond(:NIKODIM, number)
  newlvl = pbGetSocialLinkBond(:NIKODIM)/10
  pbSet(212,newlvl)
  if newlvl > oldlvl
    rewardsNikodim(newlvl)
  end
end



#####################################################################
#
#       Gifts
#
######################################################################


#   Items
#######################################################################
def generallyHated?(item)
  hatedList = [:ENERGYPOWDER,:ENERGYROOT,:HEALPOWDER,:FRESHWATER,:ODDKEYSTONE,
  :BLACKSLUDGE,:FLOATSTONE,:LAGGINGTAIL,:ODDINCENSE,:POTION,:ORANBERRY,
  :CHERRIBERRY,:CHESTOBERRY,:PECHABERRY,:RAWSTBERRY,:LEPPABERRY,:ASPEARBERRY,
  :PERSIMBERRY,:AWAKENING,:ANTIDOTE,:BURNHEAL,:PARALYZEHEAL,:ICEHEAL,:REPEL]
  return hatedList.include?(item)
end

def generallyLiked?(item)
  likedList = [:BERRYJUICE,:BIGMALASADA,:FULLRESTORE,
  :LUMBERRY,:LAVACOOKIE,:MAXELIXIR,:MOOMOOMILK,
  :OLDGATEAU,:RARECANDY,:SHALOURSABLE,:BEASTBALL,:ULTRABALL,
  :ABILITYCAPSULE,:NUGGET,:HEARTSCALE,:PEARLSTRING,:RELICCROWN,:ASSAULTVEST,
  :CHOICEBAND,:CHOICESCARF,:CHOICESPECS,:EVIOLITE,:FOCUSSASH,:LEFTOVERS,
  :LIFEORB,:LIGHTCLAY,:ROCKYHELMET,:WEAKNESSPOLICY]
  return likedList.include?(item)
end
 
def generallyLoved?(item)
  lovedList = [:MAXREVIVE,:MASTERBALL,:SACREDASH,:ABILITYPATCH, :BIGNUGGET,
  :SHINYCHARM,:SOOTHEBELL,:CASTELIACONE,:LUMIOSEGALETTE,:SWEETHEART]
  return lovedList.include?(item)
end


#   Giving gifts
#######################################################################
def giftMaple
  item = pbChooseGift
  return if item.nil?
  $bag.remove(item)
  gain = 1
  gain = 0 if generallyHated?(item)
  gain = 2 if generallyLiked?(item)
  gain = 3 if generallyLoved?(item)
  hated = [:ADAMANTMINT,:BOLDMINT,:BRAVEMINT,:CALMMINT,:CAREFULMINT,
           :GENTLEMINT,:HASTYMINT,:IMPISHMINT,:JOLLYMINT,:LAXMINT,
           :LONELYMINT,:MILDMINT,:MODESTMINT,:NAIVEMINT,:NAUGHTYMINT,
           :QUIETMINT,:RASHMINT,:RELAXEDMINT,:SASSYMINT,:SERIOUSMINT,
           :TIMIDMINT]
  neutral = [:ODDKEYSTONE]
  liked = [:EXPCANDYM,:EXPCANDYL,:ULTRABALL,:ARMORFOSSIL,:CLAWFOSSIL,:COVERFOSSIL,:DOMEFOSSIL,:HELIXFOSSIL,
  :PLUMEFOSSIL,:ROOTFOSSIL,:SKULLFOSSIL,:COMETSHARD]
  loved = [:EXPCANDYXL,:ABILITYCAPSULE]
  gain = 0 if hated.include?(item)
  gain = 1 if neutral.include?(item)
  gain = 2 if liked.include?(item)
  gain = 3 if loved.include?(item)
  case gain
  when 0
    text = _INTL("<b>\\c[10]Maple:</b>\\c[0] Erm... It's the thought that counts...")
  when 1
    text = _INTL("<b>\\c[10]Maple:</b>\\c[0] Thank you for this!")
  when 2
    text = _INTL("<b>\\c[10]Maple:</b>\\c[0] Why thank you! I really like this!")
  else
    text = _INTL("<b>\\c[10]Maple:</b>\\c[0] Oh my! This is brilliant! I can't thank you enough!")
  end
  pbMessage(text)
  pbPlayLevelUpSE if gain > 0
  upMapleRelation(gain) if gain > 0
  pbMessage(_INTL("Your relation with Maple doesn't change...")) if gain == 0
  $town.weeklyGifts.push("Maple")
end

def giftMarley
  item = pbChooseGift
  return if item.nil?
  $bag.remove(item)
  gain = 1
  gain = 0 if generallyHated?(item)
  gain = 2 if generallyLiked?(item)
  gain = 3 if generallyLoved?(item)
  hated = [:FULLINCENSE,:LAXINCENSE,:LUCKINCENSE,:ODDINCENSE,:PUREINCENSE,
           :ROCKINCENSE,:ROSEINCENSE,:SEAINCENSE,:WAVEINCENSE]
  neutral = [:FRESHWATER]
  liked = [:AMULETCOIN,:BIGPEARL,:COMETSHARD,:KINGSROCK,:LEMONADE,:METRONOME,
           :NUGGET,:RELICCOPPER,:RELICSILVER,:RELICGOLD,:SHINYSTONE,:SMOOTHROCK,
           :STARPIECE,:STARDUST]
  loved = [:BIGNUGGET,:BLACKGLASSES,:RELICCROWN]
  gain = 0 if hated.include?(item)
  gain = 1 if neutral.include?(item)
  gain = 2 if liked.include?(item)
  gain = 3 if loved.include?(item)
  case gain
  when 0
    text = _INTL("<b>\\c[3]Marley:</b>\\c[0] Huh? What's this? You want me to throw it out, boss?")
  when 1
    text = _INTL("<b>\\c[3]Marley:</b>\\c[0] Hey! Thank you boss!")
  when 2
    text = _INTL("<b>\\c[3]Marley:</b>\\c[0] Heya! That's cool! Thank you a lot!")
  else
    text = _INTL("<b>\\c[3]Marley:</b>\\c[0] Heyoooooh! For me, boss, you sure? That's so cool, thank you very much!")
  end
  pbMessage(text)
  pbPlayLevelUpSE if gain > 0
  upMarleyRelation(gain) if gain > 0
  pbMessage(_INTL("Your relation with Marley doesn't change...")) if gain == 0
  $town.weeklyGifts.push('Marley')
end

def giftNurses
  item = pbChooseGift
  return if item.nil?
  $bag.remove(item)
  gain = 1
  gain = 0 if generallyHated?(item)
  gain = 2 if generallyLiked?(item)
  gain = 3 if generallyLoved?(item)
  hated = []
  neutral = [:POTION,:ENERGYPOWDER,:ENERGYROOT,:HEALPOWDER,:FRESHWATER]
  liked = [:HYPERPOTION,:MAXPOTION,:REVIVE,:MAXETHER,:LUCKYPUNCH,:LUCKYEGG]
  loved = [:FULLRESTORE,:MAXREVIVE,:OVALSTONE]
  gain = 0 if hated.include?(item)
  gain = 1 if neutral.include?(item)
  gain = 2 if liked.include?(item)
  gain = 3 if loved.include?(item)
  case gain
  when 0
    text = _INTL("<b>\\c[5]Nurse:</b>\\c[0] ...well, sweetie, let's talk about something else right?")
  when 1
    text = _INTL("<b>\\c[5]Nurse:</b>\\c[0] Thank you sweetie!")
  when 2
    text = _INTL("<b>\\c[5]Nurse:</b>\\c[0] Oh! Thank you sweetie that's really nice!")
  else
    text = _INTL("<b>\\c[5]Nurse:</b>\\c[0] Wow! Aren't you sweet with us? That's really nice of you sweetie we love this!")
  end
  pbMessage(text)
  pbPlayLevelUpSE if gain > 0
  upNursesRelation(gain) if gain > 0
  pbMessage(_INTL("Your relation with the nurses doesn't change...")) if gain == 0
  $town.weeklyGifts.push('Nurses')
end

def giftMadameS
  item = pbChooseGift
  return if item.nil?
  $bag.remove(item)
  gain = 1
  gain = 0 if generallyHated?(item)
  gain = 2 if generallyLiked?(item)
  gain = 3 if generallyLoved?(item)
  hated = [:ROSELIBERRY, :IRONPLATE, :METALCOAT, :STEELGEM, :BLACKSLUDGE,
  :POISONBARB, :POISONGEM, :TOXICPLATE, :TOXICORB]
  neutral = [:ORANBERRY,:CHERRIBERRY,:CHESTOBERRY,:PECHABERRY,
  :RAWSTBERRY,:LEPPABERRY,:ASPEARBERRY, :PERSIMBERRY]
  liked = [:DIREHIT, :GUARDSPEC, :BEACHGLASS, :FAIRYGEM, :ICESTONE, 
  :BRIGHTPOWDER, :DESTINYKNOT, :PIXIEPLATE, :SOFTSAND, :SUNSTONE,
  :BABIRIBERRY, :KEBIABERRY]
  loved = [:BIGPEARL, :OVALCHARM, :PEARLSTRING, :STARDUST, :SOOTHEBELL, :HEATROCK]
  gain = 0 if hated.include?(item)
  gain = 1 if neutral.include?(item)
  gain = 2 if liked.include?(item)
  gain = 3 if loved.include?(item)
  case gain
  when 0
    text = _INTL("<b>\\c[11]Madame S:</b>\\c[0] ...you're lucky I love you, sweetie, 'cause I can't figure out why you would give me this...")
  when 1
    text = _INTL("<b>\\c[11]Madame S:</b>\\c[0] Thank you sweetie!")
  when 2
    text = _INTL("<b>\\c[11]Madame S:</b>\\c[0] Hey! Thank you sweetie, you know me well!")
  else
    text = _INTL("<b>\\c[11]Madame S:</b>\\c[0] Wow! You're definitely the sweetest! I hope it's not because you want something from me!")
  end
  pbMessage(text)
  pbPlayLevelUpSE if gain > 0
  upMadameSRelation(gain) if gain > 0
  pbMessage(_INTL("Your relation with Madame S doesn't change...")) if gain == 0
  $town.weeklyGifts.push('MadameS')
end

def giftMelly
  item = pbChooseGift
  return if item.nil?
  $bag.remove(item)
  gain = 1
  gain = 0 if generallyHated?(item)
  gain = 2 if generallyLiked?(item)
  gain = 3 if generallyLoved?(item)
  hated = [:EVERSTONE,:EVIOLITE,:MENTALHERB,:WEAKNESSPOLICY,:REDNECTAR,:YELLOWNECTAR]
  neutral = [:ASSAULTVEST]
  liked = [:BIGPEARL,:DAWNSTONE,:EXPCANDYS,:EXPCANDYM,:EXPCANDYL,:FLUFFYTAIL,
           :FULLINCENSE,:LAXINCENSE,:LUCKINCENSE,:ODDINCENSE,:PUREINCENSE,
           :ROCKINCENSE,:ROSEINCENSE,:SEAINCENSE,:WAVEINCENSE,:HONEY,:LOVEBALL,
           :PEARL,:POKEDOLL,:POKETOY,:PRETTYFEATHER,:PRISMSCALE,:SACHET,
           :WHIPPEDDREAM,:PINKNECTAR,:PURPLENECTAR]
  loved = [:SWEETHEART,:EXPCANDYXL,:HEARTSCALE,:PEARLSTRING,:RARECANDY]
  gain = 0 if hated.include?(item)
  gain = 1 if neutral.include?(item)
  gain = 2 if liked.include?(item)
  gain = 3 if loved.include?(item)
  case gain
  when 0
    text = _INTL("<b>\\c[9]Melly:</b>\\c[0] E-erm, why are you giving me this? ...")
  when 1
    text = _INTL("<b>\\c[9]Melly:</b>\\c[0] O-oh thank you {1}, that's nice!", $player.name)
  when 2
    text = _INTL("<b>\\c[9]Melly:</b>\\c[0] Eeeh? For me? {1} you're too nice with me!", $player.name)
  else
    text = _INTL("<b>\\c[9]Melly:</b>\\c[0] EEEEEH?? That's for me?? No no no {1} I can't accept it! Y-you're... you're too nice with me!", $player.name)
  end
  pbMessage(text)
  pbPlayLevelUpSE if gain > 0
  upMellyRelation(gain) if gain > 0
  pbMessage(_INTL("Your relation with Melly doesn't change...")) if gain == 0
  $town.weeklyGifts.push('Melly')
end

def giftSamy 
  item = pbChooseGift
  return if item.nil?
  $bag.remove(item)
  gain = 1
  gain = 0 if generallyHated?(item)
  gain = 2 if generallyLiked?(item)
  gain = 3 if generallyLoved?(item)
  hated = [:ESCAPEROPE, :HEATROCK, :SUNSTONE]
  neutral = []
  liked = [:HONEY, :SHOALSALT, :SHOALSHELL, :HARDSTONE, :ROCKINCENSE]
  loved = [:DUSKBALL, :ROCKYHELMET, :SMOOTHROCK, :LAGGINGTAIL]
  gain = 0 if hated.include?(item)
  gain = 1 if neutral.include?(item)
  gain = 2 if liked.include?(item)
  gain = 3 if loved.include?(item)
  case gain
  when 0
    text = _INTL("<b><c3=BDA46A,736440>Samy:</b></c3> Huh? No offense but why on earth would to give me that? ...")
  when 1
    text = _INTL("<b><c3=BDA46A,736440>Samy:</b></c3> Hey! Thank you for this!")
  when 2
    text = _INTL("<b><c3=BDA46A,736440>Samy:</b></c3> Wow thank you young Leader, it's really cool!")
  else
    text = _INTL("<b><c3=BDA46A,736440>Samy:</b></c3> Wow! That's for me?! You're really spoiling me there hahah! Thanks a lot!")
  end
  pbMessage(text)
  pbPlayLevelUpSE if gain > 0
  upSamyRelation(gain) if gain > 0
  pbMessage(_INTL("Your relation with Samy doesn't change...")) if gain == 0
  $town.weeklyGifts.push('Samy')
end

def giftKiana #todo
  item = pbChooseGift
  return if item.nil?
  $bag.remove(item)
  gain = 1
  gain = 0 if generallyHated?(item)
  gain = 2 if generallyLiked?(item)
  gain = 3 if generallyLoved?(item)
  hated = []
  neutral = []
  liked = []
  loved = []
  gain = 0 if hated.include?(item)
  gain = 1 if neutral.include?(item)
  gain = 2 if liked.include?(item)
  gain = 3 if loved.include?(item)
  case gain
  when 0
    text = _INTL("<b>\\c[4]Kiana:</b>\\c[0] What? Take that ugly thing out of my sight!")
  when 1
    text = _INTL("<b>\\c[4]Kiana:</b>\\c[0] Oh erm, thank you... It's nice...")
  when 2
    text = _INTL("<b>\\c[4]Kiana:</b>\\c[0] What? For me? ... ...I must admit it's really nice from you. ... Th-thank you.")
  else
    text = _INTL("<b>\\c[4]Kiana:</b>\\c[0] For me???? Really?? Weeeeeeeeeee! Heheh!!! ... ... ahem ! Eeeh. S-sorry for this. Th-thank you a lot...")
  end
  pbMessage(text)
  pbPlayLevelUpSE if gain > 0
  upKianaRelation(gain) if gain > 0
  pbMessage(_INTL("Your relation with Kiana doesn't change...")) if gain == 0
  $town.weeklyGifts.push('Kiana')
end

def giftRival #todo
  item = pbChooseGift
  return if item.nil?
  $bag.remove(item)
  gain = 1
  gain = 0 if generallyHated?(item)
  gain = 2 if generallyLiked?(item)
  gain = 3 if generallyLoved?(item)
  hated = []
  neutral = []
  liked = []
  loved = []
  gain = 0 if hated.include?(item)
  gain = 1 if neutral.include?(item)
  gain = 2 if liked.include?(item)
  gain = 3 if loved.include?(item)
  case gain
  when 0
    text = _INTL("<b>\\c[2]\\rn:</b>\\c[0] Tsk! What do you think you're doing? Get lost!")
  when 1
    text = _INTL("<b>\\c[2]\\rn:</b>\\c[0] Eh? Hmm thank you, appreciate it.")
  when 2
    text = _INTL("<b>\\c[2]\\rn:</b>\\c[0] Hey, I must say, that's kinda cool. Thank you pal.")
  else
    text = _INTL("<b>\\c[2]\\rn:</b>\\c[0] What? Are you sure you want to give me that? ... Okay well thanks a lot. You're not so bad after all...")
  end
  pbMessage(text)
  pbPlayLevelUpSE if gain > 0
  upRivalRelation(gain) if gain > 0
  pbMessage(_INTL("Your relation with \\rn doesn't change...")) if gain == 0
  $town.weeklyGifts.push('Rival')
end

def giftNL
  item = pbChooseGift
  return if item.nil?
  $bag.remove(item)
  gain = 1
  gain = 0 if generallyHated?(item)
  gain = 2 if generallyLiked?(item)
  gain = 3 if generallyLoved?(item)
  hated = [:BLACKBELT, :FIGHTINGGEM, :FISTPLATE, :CHILANBERRY]
  neutral = []
  liked = [:CHOPLEBERRY, :NORMALGEM, :SILKSCARF]
  loved = []
  gain = 0 if hated.include?(item)
  gain = 1 if neutral.include?(item)
  gain = 2 if liked.include?(item)
  gain = 3 if loved.include?(item)
  case gain
  when 0
    text = _INTL("The Normal Leader shows you a drawing of a sad looking face")
  when 1
    text = _INTL("The Normal Leader shows you a drawing of a smiling face.")
  when 2
    text = _INTL("The Normal Leader shows you a drawing of a really happy face!")
  else
    text = _INTL("The Normal Leader shows you a drawing of really happy face and jumps of joy!")
  end
  pbMessage(text)
  pbPlayLevelUpSE if gain > 0
  upNLRelation(gain) if gain > 0
  pbMessage(_INTL("Your relation with the Normal Leader doesn't change...")) if gain == 0
  $town.weeklyGifts.push('NL')
end




def giftKathleen
  item = pbChooseGift
  return if item.nil?
  $bag.remove(item)
  gain = 1
  gain = 0 if generallyHated?(item)
  gain = 2 if generallyLiked?(item)
  gain = 3 if generallyLoved?(item)
  hated = [:CHARCOAL, :FIREGEM, :FLAMEPLATE, :HARDSTONE, :ROCKGEM, :ROCKINCENSE,
  :STONEPLATE, :FLYINGGEM, :SHARPBEAK, :SKYPLATE, :TANGABERRY]
  neutral = []
  liked = [:OCCABERRY, :CHARTIBERRY, :COBABERRY, :BUGGEM, :INSECTPLATE, :NETBALL,
  :SILVERPOWDER]
  loved = []
  gain = 0 if hated.include?(item)
  gain = 1 if neutral.include?(item)
  gain = 2 if liked.include?(item)
  gain = 3 if loved.include?(item)
  case gain
  when 0
    text = _INTL("<b>Kathleen:</b> Erm... Thank you \\pn, I mean it's... something?")
  when 1
    text = _INTL("<b>Kathleen:</b> Hey, thank you \\pn you're nice!")
  when 2
    text = _INTL("<b>Kathleen:</b> Wowie! Thanks a lot \\pn you're really nice with me!")
  else
    text = _INTL("<b>Kathleen:</b> Wowie!! Is this really for me?? You're really a great friend \pn!")
  end
  pbMessage(text)
  pbPlayLevelUpSE if gain > 0
  upKathleenRelation(gain) if gain > 0
  pbMessage(_INTL("Your relation with Kathleen doesn't change...")) if gain == 0
  $town.weeklyGifts.push('Kathleen')
end


def giftCassian
  item = pbChooseGift
  return if item.nil?
  $bag.remove(item)
  gain = 1
  gain = 0 if generallyHated?(item)
  gain = 2 if generallyLiked?(item)
  gain = 3 if generallyLoved?(item)
  hated = [:DIVEBALL,:DOUSEDIVE,:MYSTICWATER,:NETBALL,:SEAINCENSE,:SPLASHPLATE,
  :WATERGEM,:WATERMEMORY,:WATERSTONE,:WAVEINCENSE,:GRASSGEM,:GRASSMEMORY, 
  :MEADOWPLATE,:MIRACLESEED,:ROSEINCENSE,:BLACKBELT,:FIGHTINGGEM,:FIGHTINGMEMORY,
  :FISTPLATE,:IRONPLATE,:METALCOAT,:STEELGEM,:STEELMEMORY,:EARTHPLATE,
  :GROUNDGEM,:GROUNDMEMORY,:SOFTSAND,:CHARTIBERRY]
  neutral = []
  liked = [:ABSORBULB,:PASSHOBERRY,:RINDOBERRY,:CHOPLEBERRY,:BABIRIBERRY,
  :SHUCABERRY,:HARDSTONE,:ROCKGEM,:ROCKINCENSE,:ROCKMEMORY,:STONEPLATE,:DAWNSTONE,
  :DUSKSTONE,:FIRESTONE,:ICESTONE,:LEAFSTONE,:MOONSTONE,:SUNSTONE,
  :THUNDERSTONE,:WATERSTONE]
  loved = [:SHINYSTONE]
  gain = 0 if hated.include?(item)
  gain = 1 if neutral.include?(item)
  gain = 2 if liked.include?(item)
  gain = 3 if loved.include?(item)
  case gain
  when 0
    text = _INTL("<b>Cassian:</b>\\pn you're a good kid, but... why would you give me that?")
  when 1
    text = _INTL("<b>Cassian:</b> Thank you dear colleague!")
  when 2
    text = _INTL("<b>Cassian:</b> Wow! Thanks a lot \\pn, I really like that!")
  else
    text = _INTL("<b>Cassian:</b> What?? My, \\pn, I don't know what to say... You shouldn't have, it's too much! Thanks a lot!!")
  end
  pbMessage(text)
  pbPlayLevelUpSE if gain > 0
  upCassianRelation(gain) if gain > 0
  pbMessage(_INTL("Your relation with Cassian doesn't change...")) if gain == 0
  $town.weeklyGifts.push('Cassian')
end








###################################
##
#         TODO
##
###################################
def giftTom
  item = pbChooseGift
  return if item.nil?
  $bag.remove(item)
  gain = 1
  gain = 0 if generallyHated?(item)
  gain = 2 if generallyLiked?(item)
  gain = 3 if generallyLoved?(item)
  hated = []
  neutral = []
  liked = []
  loved = [:ABILITYPATCH,:ABILITYCAPSULE]
  gain = 0 if hated.include?(item)
  gain = 1 if neutral.include?(item)
  gain = 2 if liked.include?(item)
  gain = 3 if loved.include?(item)
  case gain
  when 0
    text = _INTL("Erm... It's the thought that counts...")
  when 1
    text = _INTL("Thank you for this!")
  when 2
    text = _INTL("Why thank you! I really like this!")
  else
    text = _INTL("Oh my! This is brilliant! I can't thank you enough!")
  end
  pbMessage(text)
  pbPlayLevelUpSE if gain > 0
  upTomRelation(gain) if gain > 0
  pbMessage(_INTL("Your relation with Tom doesn't change...")) if gain == 0
  $town.weeklyGifts.push('Tom')
end