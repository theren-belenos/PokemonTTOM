def moveCamera(x,y)
  $game_map.display_x = x*$game_map.REAL_RES_X
  $game_map.display_y = y*$game_map.REAL_RES_Y
end


########################################################
#
#   ChallengerEncounterV1
#   Pseudo-event when a challenger comes to the base Gym
#
########################################################
def challengerEncounterV1(stars, trainer) #name, trainerClass, className, textbefore, textwin, maxlvl
  name = trainer[0]
  trainerClass = trainer[1]
  className = trainer[2]
  textbefore = trainer[3]
  textwin = trainer[4]
  maxlvl = trainer[5]
  case pbGet(37)
  
  # Skip animation = 0 : show all
  ###############################
  when 0
    pbToneChangeAll(Tone.new(0, 0, 0), 8)
    challengerEvent = $game_map.events[10]
    comeBackChances = getComeBackChances
    try = 0
    loop do
      $town.dayTrainers[0] +=1
      challengerEvent.character_name = className
      challengerEvent.turn_up
      $game_map.start_scroll(2,24,6)
      message = (try == 0) ? _INTL("A challenger appeared!") : _INTL("The challenger tries again!")
      pbMessage(_INTL(message))
      pbTipCard(trainerClass)
      alreadyBattled = $town.trainersKnown[$town.rank][stars].count(trainer)
      $town.trainersKnown[$town.rank][stars].push(trainer)
      pbWait(0.5)
      
      # Melly battle
      pbMoveRoute(challengerEvent, [4,4,4,4,4,4,4,17], true)
      $game_map.start_scroll(8,7,4)
      pbWait(2)
      pbMessage(_INTL("Melly battling..."))
      odds = getWinningChances(1,stars)
      if rand(100.0) < odds
        $town.dayTrainers[stars] +=1
        $town.dayTrainers[8] +=1
        $town.victoriesCount[1] +=1
        $town.dayMoney += getChallengerMoney(stars,maxlvl)
        pbMessage(_INTL("<b>\\c[9]Melly won!!</b>\\c[0]"))
        pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] Hehe~"))
        if $game_switches[64]
          $game_map.start_scroll(2,7,4)
          pbMoveRoute(challengerEvent, [1,1,1,1,1,1,1], true)
          pbWait(2)
          challengerEvent.character_name = ""
          pbMessage(_INTL("Marley isn't here... the challenger won't come back!"))
          break
        else
          $game_map.start_scroll(2,4,4)
          pbMoveRoute(challengerEvent, [1,1,1,1,17], true)
          pbWait(1.25)
          pbMoveRoute($game_map.events[3], [18], true)
          pbMessage(_INTL("Marley talks... \\|..."))
          pbMoveRoute($game_map.events[3], [16], true)
          $game_map.start_scroll(2,3,4)
          pbMoveRoute(challengerEvent, [1,1,1], true)
          pbWait(0.75)
          pbScrollMapTo(10,30,0)
          challengerEvent.moveto(10,30)
          challengerEvent.turn_up
          challengerEvent.character_name = ""
          chance = try < 2 ? comeBackChances[try] : comeBackChances[2]
          if rand(100.0) < chance
            try += 1
            pbToneChangeAll(Tone.new(-255, -255, -255), 8)
            pbWait(0.5)
            pbScrollMapTo(10,6,0)
            pbToneChangeAll(Tone.new(0, 0, 0), 8)
            next
          else
            pbToneChangeAll(Tone.new(-255, -255, -255), 8)
            pbWait(0.5)
            pbScrollMapTo(10,6,0)
            pbMessage(_INTL("The challenger didn't come back..."))
            break
          end
        end
      else
        pbMessage(_INTL("Melly lost!"))
      end
      
      # Samy Battle
      $game_map.start_scroll(8,5,4)
      pbMoveRoute(challengerEvent, [4,2,4,4,4,4])
      pbWait(1.5)
      if $town.rank > 2
        pbMoveRoute(challengerEvent, [18], true)
        pbMessage(_INTL("Samy battling..."))
        odds = getWinningChances(2,stars)
        if rand(100.0) < odds
          $town.dayTrainers[stars] +=1
          $town.dayTrainers[9] +=1
          $town.victoriesCount[2] +=1
          $town.dayMoney += getChallengerMoney(stars,maxlvl)
          pbMessage(_INTL("<b><c3=BDA46A,736440>Samy won!!</b></c3>"))
          pbMessage(_INTL("<b><c3=BDA46A,736440>Samy:</b></c3> Aha!"))
          if $game_switches[64]
            $game_map.start_scroll(2,13,4)
            pbMoveRoute(challengerEvent, [1,1,1,1,3,1,1,1,1,1,1,1,1,1], true)
            pbWait(4)
            challengerEvent.character_name = ""
            pbMessage(_INTL("Marley isn't here... the challenger won't come back!"))
            break
          else
            $game_map.start_scroll(2,10,4)
            pbMoveRoute(challengerEvent, [1,1,1,1,3,1,1,1,1,1,1,17], true)
            pbWait(3)
            pbMoveRoute($game_map.events[3], [18], true)
            pbMessage(_INTL("Marley talks..."))
            pbMoveRoute($game_map.events[3], [16], true)
            $game_map.start_scroll(2,3,4)
            pbMoveRoute(challengerEvent, [1,1,1], true)
            pbWait(0.75)
            pbScrollMapTo(10,30,0)
            challengerEvent.moveto(10,30)
            challengerEvent.turn_up
            challengerEvent.character_name = ""
            chance = try < 2 ? comeBackChances[try] : comeBackChances[2]
            if rand(100.0) < chance
              try += 1
              pbToneChangeAll(Tone.new(-255, -255, -255), 8)
              pbWait(0.5)
              pbToneChangeAll(Tone.new(0, 0, 0), 8)
              next
            else
              pbToneChangeAll(Tone.new(-255, -255, -255), 8)
              pbWait(0.5)
              pbScrollMapTo(10,6,0)
              pbMessage(_INTL("The challenger didn't come back..."))
              break
            end
          end
        else
          pbMessage(_INTL("Samy lost!"))
        end
      end
      
      # Player battle
      $game_map.start_scroll(8,12,4)
      pbMoveRoute(challengerEvent, [4,4,3,4,4,4,4,4,4,4,4,4,4,17], true)
      pbWait(3.5)
      pbMessage(textbefore)
      pbMoveRoute(challengerEvent, [3,3,3,3,3,17], false)
      pbMoveRoute($game_player, [2,2,2,2,2,18],true)
      pbWait(1.5)
      pbScrollMapTo(9,6,4)
      pbMessage(_INTL("Battle start!"))
      setGymBattleRules
      if(TrainerBattle.start(trainerClass,name,$town.rank))
        $town.dayTrainers[stars] +=1
        $town.dayMoney += getChallengerMoney(stars,maxlvl)
        $town.victoriesCount[5] +=1
        pbMoveRoute(challengerEvent, [2,2,2,2,2], false)
        pbMoveRoute($game_player, [3,3,3,3,3],true)
        pbWait(1.5)
        pbMessage(_INTL("You won the battle!"))
      else
        $town.dayMoney -= getLostMoney
        $town.victoriesCount[0] +=1
        pbMoveRoute(challengerEvent, [2,2,2,2,2], false)
        pbMoveRoute($game_player, [3,3,3,3,3],true)
        pbWait(1.5)
        pbMessage(_INTL(textwin))
        showLostMoney
        challengerVictory(trainer, stars)
      end
      pbMoveRoute(challengerEvent, [1,1,1,1,1,1,1,1], true)
      pbWait(3)
      challengerEvent.character_name = ""
      challengerEvent.moveto(10,30)
      break
    end
    
    
  # Skip animation = 1 : skip movements
  #####################################
  when 1
    pbScrollMapTo(10,30,0)
    challengerEvent = $game_map.events[10]
    comeBackChances = getComeBackChances
    try = 0
    loop do
      pbWait(0.2)
      pbToneChangeAll(Tone.new(0, 0, 0), 8)
      $town.dayTrainers[0] +=1
      challengerEvent.character_name = className
      challengerEvent.turn_up
      message = (try == 0) ? _INTL("A challenger appeared!") : _INTL("The challenger tries again!")
      pbMessage(_INTL(message))
      pbTipCard(trainerClass)
      alreadyBattled = $town.trainersKnown[$town.rank][stars].count(trainer)
      $town.trainersKnown[$town.rank][stars].push(trainer)
      
      # Melly battle
      pbToneChangeAll(Tone.new(-255, -255, -255), 3)
      pbWait(0.2)
      challengerEvent.moveto(10,23)
      pbScrollMapTo(10,23,0)
      pbWait(0.2)
      pbToneChangeAll(Tone.new(0, 0, 0), 3)
      challengerEvent.turn_left
      pbMessage(_INTL("Melly battling... \\| ..."))
      odds = getWinningChances(1,stars)
      if rand(100.0) < odds
        $town.dayTrainers[stars] +=1
        $town.dayTrainers[8] +=1
        $town.victoriesCount[1] +=1
        $town.dayMoney += getChallengerMoney(stars,maxlvl)
        pbMessage(_INTL("<b>\\c[9]Melly won!!</b>\\c[0]"))
        pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] Hehe~"))
        pbToneChangeAll(Tone.new(-255, -255, -255), 3)
        pbWait(0.2)
        if $game_switches[64]
          pbScrollMapTo(10,30,0)
          challengerEvent.moveto(10,30)
          challengerEvent.turn_up
          challengerEvent.character_name = ""
          pbMessage(_INTL("Marley isn't here... the challenger won't come back!"))
          break
        else
          pbScrollMapTo(10,27,0)
          challengerEvent.moveto(10,27)
          pbWait(0.2)
          pbToneChangeAll(Tone.new(0, 0, 0), 3)
          challengerEvent.turn_left
          $game_map.events[3].turn_right
          pbMessage(_INTL("Marley talks... \\|..."))
          $game_map.events[3].turn_down
          pbToneChangeAll(Tone.new(-255, -255, -255), 3)
          pbWait(0.2)
          pbScrollMapTo(10,30,0)
          challengerEvent.moveto(10,30)
          challengerEvent.turn_up
          challengerEvent.character_name = ""
          puts comeBackChances
          chance = (try < 2) ? comeBackChances[try] : comeBackChances[2]
          if rand(100.0) < chance
            try += 1
            next
          else
            pbWait(0.5)
            pbMessage(_INTL("The challenger didn't come back..."))
            break
          end
        end
      else
        pbMessage(_INTL("Melly lost!"))
        pbToneChangeAll(Tone.new(-255, -255, -255), 3)
        pbWait(0.2)
      end
      
      # Samy Battle
      if $town.rank > 2
        pbScrollMapTo(9,18,0)
        challengerEvent.moveto(9,18)
        pbWait(0.2)
        pbToneChangeAll(Tone.new(0, 0, 0), 3)
        challengerEvent.turn_right
        pbMessage(_INTL("Samy battling... \\| ..."))
        odds = getWinningChances(2,stars)
        if rand(100.0) < odds
          $town.dayTrainers[stars] +=1
          $town.dayTrainers[9] +=1
          $town.victoriesCount[2] +=1
          $town.dayMoney += getChallengerMoney(stars,maxlvl)
          pbMessage(_INTL("<b><c3=BDA46A,736440>Samy won!!</b></c3>"))
          pbMessage(_INTL("<b><c3=BDA46A,736440>Samy:</b></c3> Aha!"))
          pbToneChangeAll(Tone.new(-255, -255, -255), 3)
          pbWait(0.2)
          if $game_switches[64]
            pbScrollMapTo(10,30,0)
            challengerEvent.moveto(10,30)
            challengerEvent.turn_up
            challengerEvent.character_name = ""
            pbMessage(_INTL("Marley isn't here... the challenger won't come back!"))
            break
          else
            pbScrollMapTo(10,27,0)
            challengerEvent.moveto(10,27)
            pbWait(0.2)
            pbToneChangeAll(Tone.new(0, 0, 0), 3)
            challengerEvent.turn_left
            $game_map.events[3].turn_right
            pbMessage(_INTL("Marley talks... \\|..."))
            $game_map.events[3].turn_down
            pbToneChangeAll(Tone.new(-255, -255, -255), 3)
            pbWait(0.2)
            pbScrollMapTo(10,30,0)
            challengerEvent.moveto(10,30)
            challengerEvent.turn_up
            challengerEvent.character_name = ""
            chance = try < 2 ? comeBackChances[try] : comeBackChances[2]
            if rand(100.0) < chance
              try += 1
              next
            else
              pbWait(0.5)
              pbMessage(_INTL("The challenger didn't come back..."))
              break
            end
          end
        else
          pbMessage(_INTL("Samy lost!"))
        end
      end
      
      # Player battle
      challengerEvent.moveto(15,6)
      challengerEvent.turn_left
      $game_player.moveto(4,6)
      pbScrollMapTo(9,6,0)
      pbWait(0.2)
      pbToneChangeAll(Tone.new(0, 0, 0), 3)
      pbMessage(textbefore)
      pbMessage(_INTL("Battle start!"))
      setGymBattleRules
      if(TrainerBattle.start(trainerClass,name,$town.rank))
        $town.dayTrainers[stars] +=1
        $town.victoriesCount[5] +=1
        $town.dayMoney += getChallengerMoney(stars,maxlvl)
        pbMoveRoute(challengerEvent, [2,2,2,2,2], false)
        pbMoveRoute($game_player, [3,3,3,3,3],true)
        pbWait(1.5)
        pbMessage(_INTL("You won the battle!"))
      else
        $town.dayMoney -= getLostMoney
        $town.victoriesCount[0] +=1
        pbMoveRoute(challengerEvent, [2,2,2,2,2], false)
        pbMoveRoute($game_player, [3,3,3,3,3],true)
        pbWait(1.5)
        pbMessage(_INTL(textwin))
        showLostMoney
        challengerVictory(trainer, stars)
      end
      pbToneChangeAll(Tone.new(-255, -255, -255), 2)
      pbWait(0.3)
      challengerEvent.moveto(10,30)
      challengerEvent.turn_up
      challengerEvent.character_name = ""
      pbWait(0.5)
      break
    end
    
    
  # Skip animation = 2 : skip all (text only)
  #####################################
  else
    challengerEvent = $game_map.events[10]
    challengerEvent.moveto(15,6)
    challengerEvent.turn_left
    $game_player.moveto(4,6)
    pbScrollMapTo(9,6,0)
    comeBackChances = getComeBackChances
    try = 0
    loop do
      $town.dayTrainers[0] +=1
      challengerEvent.character_name = className
      message = (try == 0) ? _INTL("A challenger appeared!") : _INTL("The challenger tries again!")
      pbMessage(_INTL(message))
      pbTipCard(trainerClass)
      alreadyBattled = $town.trainersKnown[$town.rank][stars].count(trainer)
      $town.trainersKnown[$town.rank][stars].push(trainer)
      
      # Melly battle
      odds = getWinningChances(1,stars)
      if rand(100.0) < odds
        $town.dayTrainers[stars] +=1
        $town.dayTrainers[8] +=1
        $town.victoriesCount[1] +=1
        $town.dayMoney += getChallengerMoney(stars,maxlvl)
        pbMessage(_INTL("<b>\\c[9]Melly won!!</b>\\c[0]"))
        pbMessage(_INTL("<b>\\c[9]Melly:</b>\\c[0] Hehe~"))
        pbWait(0.2)
        if $game_switches[64]
          challengerEvent.character_name = ""
          pbMessage(_INTL("Marley isn't here... the challenger won't come back!"))
          break
        else
          pbMessage(_INTL("Marley talks..."))
          pbScrollMapTo(10,30,0)
          challengerEvent.moveto(10,30)
          challengerEvent.turn_up
          challengerEvent.character_name = ""
          chance = try < 2 ? comeBackChances[try] : comeBackChances[2]
          if rand(100.0) < chance
            try += 1
            next
          else
            pbWait(0.2)
            pbMessage(_INTL("The challenger didn't come back..."))
            break
          end
        end
      else
        pbMessage(_INTL("Melly lost!"))
        pbWait(0.2)
      end
      
      # Samy Battle
      if $town.rank > 2
        odds = getWinningChances(2,stars)
        if rand(100.0) < odds
          $town.dayTrainers[stars] +=1
          $town.dayTrainers[9] +=1
          $town.victoriesCount[2] +=1
          $town.dayMoney += getChallengerMoney(stars,maxlvl)
          pbMessage(_INTL("<b><c3=BDA46A,736440>Samy won!!</b></c3>"))
          pbMessage(_INTL("<b><c3=BDA46A,736440>Samy:</b></c3> Aha!"))
          pbWait(0.2)
          if $game_switches[64]
            challengerEvent.character_name = ""
            pbMessage(_INTL("Marley isn't here... the challenger won't come back!"))
            break
          else
            pbMessage(_INTL("Marley talks... \\|..."))
            pbScrollMapTo(10,30,0)
            challengerEvent.moveto(10,30)
            challengerEvent.turn_up
            challengerEvent.character_name = ""
            chance = try < 2 ? comeBackChances[try] : comeBackChances[2]
            if rand(100.0) < chance
              try += 1
              next
            else
              pbWait(0.2)
              pbMessage(_INTL("The challenger didn't come back..."))
              break
            end
          end
        else
          pbMessage(_INTL("Samy lost!"))
          pbWait(0.2)
        end
      end
      
      # Player battle
      pbToneChangeAll(Tone.new(0, 0, 0), 0)
      pbMessage(textbefore)
      pbMessage(_INTL("Battle start!"))
      setGymBattleRules
      if(TrainerBattle.start(trainerClass,name,$town.rank))
        $town.dayTrainers[stars] +=1
        $town.victoriesCount[5] +=1
        $town.dayMoney += getChallengerMoney(stars,maxlvl)
        pbMessage(_INTL("You won the battle!"))
      else
        $town.dayMoney -= getLostMoney
        $town.victoriesCount[0] +=1
        pbMessage(_INTL(textwin))
        showLostMoney
        challengerVictory(trainer, stars)
      end
      pbToneChangeAll(Tone.new(-255, -255, -255), 2)
      pbWait(0.3)
      challengerEvent.character_name = ""
      pbWait(0.5)
      break
    end
  end      
end

def getTrainer(stars)
  rank = $town.rank
  trainerList = $town.challengersTree[rank][stars]
  puts "trainerList"
  puts trainerList
  flag = false
  while flag == false do
    puts "trainerList.length"
    puts trainerList.length
    index = rand(trainerList.length)
    puts "index"
    puts index
    trainer = trainerList[index]
    puts trainer
    if not($town.noRepeatTrainers.include?(trainer))
      $town.noRepeatTrainers.push(trainer)
      flag = true
    end
  end
  echoln "$town.trainersKnown[rank][stars]"
  echoln $town.trainersKnown[rank][stars]
  alreadyBattled = $town.trainersKnown[rank][stars].count(trainer)
  echoln "alreadyBattled"
  echoln alreadyBattled
  if alreadyBattled < 2
    $town.challengersTree[rank][stars].delete_at(index)
  end
  return trainer
end

def challengerVictory(trainer, stars)
  $town.challengersTree[$town.rank][stars].reject{|item| item == trainer}
end
   
def determineStars
  odds = $town.getStarsOdds
  n = rand(100.0)
  puts "random number:"
  puts n
  p = odds[1]
  stars = 1
  loop do
    puts "proba"
    puts p
    if n > p
      stars += 1
      p += odds[stars]
    else
      return stars
    end
  end
end  
  
def workDay
  FollowingPkmn.toggle_off
  pbToneChangeAll(Tone.new(0, 0, 0), 1)
  pbWait(1)
  $town.dayTrainers = [0,0,0,0,0,0,0,0,0,0,0,0,0]
  $town.noRepeatTrainers = []
  $town.dayMoney = 0
  minmax = $town.getDailyTrainers
  puts minmax
  trainersToday = rand(minmax[0]..minmax[1])
  pbToneChangeAll(Tone.new(-255, -255, -255), 8)
  pbMessage(_INTL("Waiting for the first challenger..."))
  pbWait(1)
  for i in 1..trainersToday
    stars = determineStars
    trainer = getTrainer(stars)
    echo trainer
    pbSet(36,trainer[0])
    challengerEncounterV1(stars, trainer)
    pbToneChangeAll(Tone.new(-255, -255, -255), 8)
    pbMessage(_INTL("Waiting for the next challenger..."))
    pbWait(0.5)
    pbScrollMapTo(9,6,0)
  end
  pbToneChangeAll(Tone.new(0, 0, 0), 8)
  pbMessage(_INTL("The day ends!"))
  pbTipCard(:DAYRECAP1,:DAYRECAP2,:DAYRECAP3)
  $town.endWorkDay
  FollowingPkmn.toggle_on
end
  