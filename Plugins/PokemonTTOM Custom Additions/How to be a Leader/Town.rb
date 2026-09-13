#===============================================================================
# Town class
#===============================================================================
class Town
  # @return [Symbol] the town's name
  attr_reader   :name
  # @return [Integer] the town's fame
  attr_reader   :fame
  # @return [Integer] the town's rank
  attr_reader   :rank
  # @return [Integer] the town's funds
  attr_accessor :funds
  # @return [Array[Integer]] what are the workers doing
  attr_accessor :workers
  # @return [Integer] the town's number of workers
  attr_accessor :totalworkers
  # @return [Array<Integer>] state of town constructions
  attr_reader   :buildings
  # @return [Symbol] the gym's type
  attr_reader   :type
  # @return [Integer] the current week
  attr_reader   :week
  # @return [Integer] the current weekday code
  attr_reader   :weekday
  # @return [Array[Array[Array[String, String, Integer]]]] already encountered trainers at the gym
  attr_accessor   :trainersKnown
  # @return [Array[Array[Array[String, String, Integer]]]] all the challengers names and types
  attr_accessor   :challengersTree
  # @return [Array] an array counting victories (and defeats) at the Gym
  attr_accessor   :victoriesCount
  # @return [Array] an array describing trainers encountered this day
  attr_accessor   :dayTrainers
  # @return [Array] an array to stop challengers coming twice after battling player
  attr_accessor   :noRepeatTrainers
  # @return [Integer] money earned or lost this day
  attr_accessor   :dayMoney
  # @return [Integer] passive fame earned each week
  attr_accessor   :passiveFame
  # @return [Integer] passive funds earned each week
  attr_accessor   :passiveFunds
  # @return [Array] an array saving gifts given this week
  attr_accessor   :weeklyGifts
  # @return [Hash[Type]=> [Array]]] an hash giving for each type the list of starters egg not yet given
  attr_accessor   :startersEggsToGive
	# @return [Array] an array to track urbanist variant bought
  attr_accessor   :urbanist
  
  
  def initialize(type)
    @name                  = "Townie"
    @fame                  = 0
    @rank                  = 0
    @funds                 = 1000
    @workers               = [-1,-1,-1,-1,-1]
    @totalworkers          = 1
    @buildings             = [0] * 103
    @type                  = type
    @week                  = 0
    @weekday               = 0
    @buildings[0]          = 2
    @buildings[1]          = 2
    @buildings[2]          = 2
    @buildings[3]          = 3
    @buildings[4]          = 1
    @buildings[5]          = 2
    @trainersKnown         = initializeTrainersKnown
    @challengersTree       = initializeChallengersTree
    @victoriesCount        = [0,0,0,0,0,0] 
    @noRepeatTrainers      = []
    @dayTrainers           = [0,0,0,0,0,0,0,0,0,0,0]
    @dayMoney              = 0
    @passiveFunds          = 0
    @passiveFame           = 0
    @weeklyGifts           = []
    @startersEggsToGive    = initializeStartersEggsToGive 
		@urbanist = [0]*100
  end
  
  #=============================================================================

  def name=(value)
    validate value => String
    return if @name == value
    @name = value
  end
  
  def get_town_name
    return @town.name
  end
  
  def fame=(value)
    return if @fame == value
    @fame = value
  end
  
  def rank=(value)
    return if @rank == value
    @rank = value
  end
  
  def funds=(value)
    return if @funds == value
    @funds = value
  end
  
  def workers=(value)
    return if @workers == value
    @workers = value
  end
  
  def totalworkers=(value)
    return if @totalworkers == value
    @totalworkers = value
  end
  
  def type=(value)
    validate value => String
    return if @type == value
    @type = value
  end
  
  def week=(value)
    return if @week == value
    @week = value
  end
  
  def weekday=(value)
    return if @weekday == value
    @weekday = value
  end
  
  def getCurrentDay
    case @weekday
      when 0
        day = _INTL("Weekend") 
      when 1, 2, 3
        day = _INTL("Monday") 
      when 4, 5, 6
        day = _INTL("Tuesday") 
      when 7, 8, 9
        day = _INTL("Wednesday") 
      when 10, 11, 12
        day = _INTL("Thursday") 
      else 
        day = _INTL("Friday")
      end
    return [day, @week, (@weekday-1)%3]
  end
  
  def daysWork
    workrecap = []
    for i in 0..4
      index = @workers[i]
      if index > -1
        @buildings[index] += 1
        alreadyworkedon = false
        workrecap.length.times do |i|
          if workrecap[i][0] == index
            workrecap[i][2] += 1 
            alreadyworkedon = true
          end
        end
        workrecap << [index, (@buildings[index] - 1), @buildings[index]] if !alreadyworkedon
        if @buildings[index] == (getBuildingData(index)[1] + 1)
          build(index)
        end
      end
    end
    
    puts workrecap
    
    # Préparation du message
    ret = ""
    workrecap.length.times do |i|
      puts "workrecap " + i.to_s 
      puts workrecap[i]
      data = getBuildingData(workrecap[i][0])
      ret << data[0]
      ret << "\n"
      ret << _INTL("Progression:")
      ret << " "
      ret << (workrecap[i][1] - 1).to_s
      ret << " --> "
      ret << (workrecap[i][2] - 1).to_s
      ret << " / "
      ret << data[1].to_s
      if workrecap[i][2] > data[1]
        ret << " "
        ret << "<b>"
        ret << _INTL("Finished!")
        ret << "</b>" 
      end
      ret << "\n"
    end
    @workers = [-1,-1,-1,-1,-1]
    return ret
  end
  
  def build(index)
    case index
    
    # Fame 0 : nothing (tuto/story)
  
    # Fame 1
    when 7 # Store 1-1
      pbSet(28,1)
    when 8 # Welcoming 1
      $game_switches[64] = true
    when 9 # Interiors 2
      pbSet(39,2)
      @passiveFame += 2
    when 10 # Lab 2
      pbSet(33,2)
      @passiveFunds += 500
    when 11 # PJ House
      $game_switches[81] = true
      $player.has_running_shoes = true
    #when 12 : nothing (Clearing House 1)
    when 13 # Clearing exteriors
      pbSet(27,1)
      completeQuest(:MainQuest4C)
      advanceQuestToStage(:MainQuest4,(getCurrentStage(:MainQuest4)+1))
    #when 14 : nothing (Clearing Academy)
      
    # Fame 5
    when 15 # Store 2-1
      pbSet(32,1)
    when 16 # Store 1-2
      pbSet(28,2)
    when 17 # Trainer 2
      if getCurrentStage(:MainQuestCh3C) == 2
        completeQuest(:MainQuestCh3C)
        advanceQuestToStage(:MainQuestCh3,(getCurrentStage(:MainQuestCh3)+1))
      else
        advanceQuestToStage(:MainQuestCh3C,2)
      end
    when 18 # Leader room 2
      pbSet(40,2)
      @passiveFame += 2
    when 19 # Lab 3
      pbSet(33,3)
      @passiveFunds += 1000
    when 20 # Double battle
      pbSet(41,1)
    when 21 # House 1 (Melly)
      $game_switches[80] = true
      @totalworkers += 1
      l = "Your Gym or her House"
      id = ("MELLY"+$town.type).to_sym
      pbSetSocialLinkLocation(id,l)
      upMellyRelation(2)
    #when 22 : nothing (Clearing Block 1)
    when 23 # Exteriors 2
      pbSet(27,2)
      @passiveFunds += 1000
    when 24 # Bicycle
      $game_switches[105] = true
    when 25 # Academy
      $game_switches[77] = true
      @passiveFunds += 1500
      @passiveFame += 3
    #when 26 : nothing (Clearing Safari)
    when 27 # Selfcare 1
      pbSet(29,1)
      @passiveFunds += 500
    
    # Fame 10
    when 28 # Store 3-1
      pbSet(42,1)
    when 29 # Store 2-2
      pbSet(32,2)
    when 30 # Store 1-3
      pbSet(28,3)
    when 31 # Welcoming 2
      $game_switches[64] = true
    when 32 # Exteriors 2
      @passiveFame += 3
    when 33 # PC Mezzanine
      pbSet(31,2)
      @passiveFunds += 1000
    when 34 # Lab 4  
      pbSet(33,4)
      @passiveFunds += 2000
    when 35 # Block 1
      $game_switches[74] = true
      l = _INTL("Your Gym or his Flat")
      pbSetSocialLinkLocation(:SAMY,l)
      upSamyRelation(2)
    #when 36: nothing (clearing house 2)
    when 37 # Parc Safari
      pbSet(43,1)
      $game_switches[69] = true
    #when 38: nothing (clearing clothes shop)
    #when 39: nothing (clearing casino)
    #when 40: nothing (clearing harbor)
    
    # Fame 20
    
    end
  end
  
  def passTime(times=1)
    if @weekday == 0 || @weekday == 8 || times > 5
      unassigned = $town.totalworkers
      $town.workers.length.times do |i|
        if $town.workers[i] > -1
						unassigned -= 1
        end
      end
      if unassigned > 0
        lefttodo = false
        limits = [6,14,27,40,54,70,85,97] 
        case $town.calculateFameLvl
        when 0
          limit=limits[0]
        when 1..4
          limit=limits[1]
        when 5..9
          limit=limits[2]
        when 10..19
          limit=limits[3]
        when 20..29
          limit=limits[4]
        when 30..49
          limit=limits[5]
        when 50..69
          limit=limits[6]
        else
          limit=limits[7]
        end
        for index in 0..limit
          lefttodo = true if not finished?(index)
        end
        if lefttodo
          pbMessage(_INTL("Some workers aren't assigned to a task!"))
          if pbConfirmMessage(_INTL("Open the Town Reconstruction?"))
            pbFadeOutIn do
              scene = PokemonRegionMap_Scene.new(1, false)
              screen = PokemonRegionMapScreen.new(scene)
              ret = screen.pbStartFlyScreen(true)
            end
          end
        end
      end
    end
    @weekday = (@weekday+times)%16
    @weekday = 8  if @weekday == 7
    @weekday = 10  if @weekday == 9
    @weekday = 0  if @weekday == 15
    if @weekday == 1 || (@weekday == 2 && times > 1)
      @week += 1 
      @weeklyGifts = []
    end
    time = getCurrentDay
    text = '\\w[]\\wm\\l[3]<ac><fs=32>' 
    text << _INTL("Week")
    text << " "
    text << time[1].to_s
    text << '</fs>\n\n'
    text << _INTL(time[0])
    if @weekday > 0
      text << ', '
      case (@weekday -1)%3
      when 0
        texttimeday = _INTL("Morning")
      when 1
        texttimeday = _INTL("Afternoon")
      when 2
        texttimeday = _INTL("Evening")
      end
      text << texttimeday
    end
    text << '</ac>'
    pbMessage(text)
    if @weekday == 8
      UnrealTime.advance_to(14,0,0)
      $game_switches[63] = false
    elsif times > 5
      $game_switches[63] = true
    elsif @weekday > 0
      case (@weekday -1)%3
      when 0
        UnrealTime.advance_to(9,0,0)
      when 1
        UnrealTime.advance_to(14,0,0)
      when 2
        UnrealTime.advance_to(21,0,0)
      end
      $game_switches[63] = true
    else
      UnrealTime.advance_to(21,0,0)
      @funds += @passiveFunds
      limits = [0,25,54,100,169,268,406,594,844,1169,1584,2106,2694,4999]
      currentlvl = calculateFameLvl
      famefornextlvl = calculateFloorFame(currentlvl+1)
      fametoadd = [limits[@rank] - @fame, @passiveFame].min
      @fame += fametoadd
      famelvlup(currentlvl+1) if @fame >= famefornextlvl && fametoadd > 0
      if @fame == limits[@rank] && fametoadd > 0
        # fame limit reached
        case @rank
          when 1
            completeQuest(:MainQuest4A)
            advanceQuestToStage(:MainQuest4,(getCurrentStage(:MainQuest4)+1))
          when 2
            completeQuest(:MainQuestCh3A)
            advanceQuestToStage(:MainQuestCh3,(getCurrentStage(:MainQuestCh3)+1))
          when 3
            completeQuest(:MainQuestCh4A)
            advanceQuestToStage(:MainQuestCh4,(getCurrentStage(:MainQuestCh4)+1))
          else
            pbMessage("Unknown rank")
        end
        if @rank < 13
          pbMessage(_INTL("You reached this rank fame limit."))
          pbMessage(_INTL("To further improve your fame, you need to rank up!"))
        else
          pbMessage(_INTL("You reached the fame limit of the game!"))
          pbMessage(_INTL("Congratulations and thank you for playing!"))
        end
      end
      $game_switches[63] = false
    end 
  end
  
  def isMorning?
    return (@weekday -1)%3 == 0
  end
    
  def tasksDone
    ret = 0
    for i in 0..99
      ret += 1 if @buildings[i] == (getBuildingData(i)[1] + 1)
    end
    return ret
  end
  
  def calculateFameForUp(famelvl)
    return 50 if famelvl > 85
    return (0.5*famelvl+8).floor() 
  end
    
  def calculateFloorFame(famelvl)
    return 2440 + 50*(famelvl-85) if famelvl > 85
    return (0.25*(famelvl*famelvl+30*famelvl+1)).floor()
  end
  
  def calculateFameLvl
    return 100 if @fame == 4999
    return ((Math.sqrt(896+16*(@fame+0.5))-30)/2).floor()
  end
  
  def getDayTotalFame
    ret = 0
    ret += @dayTrainers[1]
    ret += @dayTrainers[2] * 3
    ret += @dayTrainers[3] * 5
    ret += @dayTrainers[4] * 8
    ret += @dayTrainers[5] * 12
    ret += @dayTrainers[6] * 18
    ret += @dayTrainers[7] * 25
    return ret
  end
  
  def famelvlup(lvl)
    $town.funds += $town.rank*500
    $player.money += $town.rank*500
    case lvl
    when 2
      $bag.add(:GREATBALL, 5)
    when 3, 8
      $bag.add(:ABILITYCAPSULE)
    when 4
      $bag.add(:SUPERPOTION, 5)
    when 6
      $bag.add(:RARECANDY, 3)
    when 7
      $bag.add(:HEALTHFEATHER)
      $bag.add(:MUSCLEFEATHER)
      $bag.add(:RESISTFEATHER)
      $bag.add(:GENIUSFEATHER)
      $bag.add(:CLEVERFEATHER)
      $bag.add(:SWIFTFEATHER)
    when 9
      $bag.add(:ULTRABALL,3)
    end
  end
  
  def endWorkDay
    limits = [0,25,54,100,169,268,406,594,844,1169,1584,2106,2694,4999]
    currentlvl = calculateFameLvl
    famefornextlvl = calculateFloorFame(currentlvl+1)
    fametoadd = [limits[@rank] - @fame, getDayTotalFame].min
    @fame += fametoadd
    famelvlup(currentlvl+1) if @fame >= famefornextlvl && fametoadd > 0
    if @fame == limits[@rank] && fametoadd > 0
      # fame limit reached
      case @rank
        when 1
          completeQuest(:MainQuest4A)
          advanceQuestToStage(:MainQuest4,(getCurrentStage(:MainQuest4)+1))
        when 2
          completeQuest(:MainQuestCh3A)
          advanceQuestToStage(:MainQuestCh3,(getCurrentStage(:MainQuestCh3)+1))
        when 3
            completeQuest(:MainQuestCh4A)
            advanceQuestToStage(:MainQuestCh4,(getCurrentStage(:MainQuestCh4)+1))
        else
          pbMessage("Unknown rank")
      end
      if @rank < 13
        pbMessage(_INTL("You reached this rank fame limit."))
        pbMessage(_INTL("To further improve your fame, you need to rank up!"))
      else
        pbMessage(_INTL("You reached the fame limit of the game!"))
        pbMessage(_INTL("Congratulations and thank you for playing!"))
      end
    end
    
    if @dayMoney > 0
      @funds += (@dayMoney * 0.75).floor()
      $player.money = ($player.money + @dayMoney * 0.25).ceil()
    else
      @funds += @dayMoney
    end
  end
  
  def otherRewards(famelvl)
    case famelvl
    when 1,5,10,20,30,50,70
      return _INTL("<al><c3=FFD700,DAA520><b>New City tasks tier unlocked!</b></c3>")
    when 2 
      return _INTL("<al>You got 5 Great Balls!")
    when 3, 8
      return _INTL("<al>You got an ability capsule!")
    when 4
      return _INTL("<al>You got 5 Super potions!")
    when 6
      return _INTL("<al>You got 3 rare candies!")
    when 7
      return _INTL("<al>You got 1 of each feather!")
    when 9
      return _INTL("<al>You got 3 ultra balls!")
    else
      return _INTL("No special rewards")
    end
  end
      
  def getDailyTrainers
    ret = [0,2]
    famelvl = calculateFameLvl
    case famelvl
    when 1..4
      ret[0] = 1
      ret[1] = 2
    when 5..14
      ret[0] = 1
      ret[1] = 3
    when 15..34
      ret[0] = 2
      ret[1] = 3
    when 35..59
      ret[0] = 2
      ret[1] = 4
    when 60..89
      ret[0] = 3
      ret[1] = 4
    else
      ret[0] = 3
      ret[1] = 5
    end
    return ret
  end
  
  def getStarsOdds
    onestar = [0,80,65,40,20,10,0,0,0,0,0,0,0,0,0,0]
    twostar = [0,20,25,35,45,40,30,20,10,0,0,0,0,0,0,0]
    threestar = [0,0,10,25,30,40,50,45,35,20,15,0,0,0]
    fourstar = [0,0,0,0,5,10,20,35,45,55,45,45,30,20]
    fivestar = [0,0,0,0,0,0,0,0,10,25,40,55,70,80]
    sixstar = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    sevenstar = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    if @buildings[70] == 3
      threestar[11] = 10
      fourstar[11] = 30
      fivestar[11] = 50
      sixstars[11] = 10
      threestar[10] = 15
      fourstar[10] = 45
      fivestar[10] = 35
      sixstars[10] = 5
      if buildings[90] == 3
        fourstars[13] = 15
        fivestar[13] = 45
        sixstars[13] = 25
        sevenstars[13] = 15
        fourstar[12] = 20
        fivestar[12] = 50
        sixstars[12] = 20
        sevenstars[12] = 10
      else
        fourstar[13] = 20
        fivestar[13] = 50
        sixstars[13] = 30
        fourstar[12] = 25
        fivestar[12] = 60
        sixstars[12] = 15
      end
    end
    ret = [0,0,0,0,0,0,0,0]
    ret[1] = onestar[@rank]
    ret[2] = twostar[@rank]
    ret[3] = threestar[@rank]
    ret[4] = fourstar[@rank]
    ret[5] = fivestar[@rank]
    ret[6] = sixstar[@rank]
    ret[7] = sevenstar[@rank]
    return ret
  end
  
      
  def getRewardText(famelvl)
    ret = [otherRewards(famelvl),"0","0"]
    case famelvl
    when 1
      ret[1] = "1"
    when 5
      ret[2] = "3"
    when 15
      ret[1] = "2"
    when 35
      ret[2] = "4"
    when 60
      ret[1] = "3"
    when 90
      ret[2] = "5"
    end
    return ret
  end
  
  def giveStarter(type)
    puts @startersEggsToGive[type]
    while true
      if @startersEggsToGive[type].length < 1
        pbMEPlay('Egg get')
        pbGenerateEgg(:TOGEPI)
        return true
      else
        n = rand(0..@startersEggsToGive[type].length-1)
        pkmn = @startersEggsToGive[type][n]
        puts "Obtenu :"
        puts pkmn
        @startersEggsToGive[type].delete_at(n)
        next if $player.owned?(pkmn)
        pbMEPlay('Egg get')
        pbGenerateEgg(pkmn)
        return false
      end
    end
  end
    
  # Conversion des saves antérieures au rework de la progression (0.1.5)
  def convertSave
    
    pbMessage("Début de la conversion...")
    
    # Fame
    puts @fame
    case @fame
    when 6..8
      @fame += 2
    when 9..16
      @fame += 3
    when 17..55
      @fame += 4
    else
    end
    pbMessage("Montant de points de fame corrigé")
    
    # Buildings
    @workers = [-1,-1,-1,-1,-1]
    
    # Index
    @buildings[27] = @buildings[26]
	  @buildings[26] = @buildings[25]
	  @buildings[25] = @buildings[24]
	  @buildings[24] = @buildings[23]
	  @buildings[23] = @buildings[22]
	  @buildings[22] = @buildings[21]
	  @buildings[21] = @buildings[20]
	  @buildings[20] = @buildings[19]
	  @buildings[19] = 0
    
    # Fame 0
    @buildings[0] = 2
    @buildings[1] = 2
    @buildings[2] = 2
    @buildings[3] = 3
    @buildings[4] = 3 if @buildings[4] == 2
    @buildings[5] = 2
    
    # Fame 1
    @buildings[7] = 1 if @buildings[7] == 2
    @buildings[8] = 1 if @buildings[8] == 2
    @buildings[14] = 3 if @buildings[14] == 2
    
    # Fame 5
    @buildings[15] = 3 if @buildings[15] == 2
    @buildings[16] = 1 if @buildings[16] == 2
    @buildings[17] = 1 if @buildings[17] == 2
    @buildings[20] = 1 if @buildings[20] == 2
    @buildings[22] = 1 if @buildings[22] == 2
    @buildings[23] = 3 if @buildings[23] == 2
    @buildings[24] = 1 if @buildings[24] == 2
    @buildings[25] = 4 if @buildings[25] == 2
    @buildings[26] = 3 if @buildings[26] == 2
    
    pbMessage("Variables de construction de la ville ajustées")
    
    # Fame et fonds passifs
    @passiveFame = 0
    @passivefunds = 0
    @passiveFame += 2 if @buildings[9] == 2 
    @passiveFunds += 500 if @buildings[10] == 2
    @passiveFame += 2 if @buildings[18] == 2 
    @passiveFunds += 1000 if @buildings[23] == 3 
    @passiveFame += 3 if @buildings[25] == 4 
    @passiveFunds += 1500 if @buildings[25] == 4 
    @passiveFunds += 500 if @buildings[27] == 2 
    
    pbMessage("Fame & Fonds passifs hebdo ajustés")
    
    # Maple et autres
    pbMessage("Corrections mineures effectuées")
    
    pbMessage("Conversion terminée")
    
  end
    
  def finished?(index)
    data = getBuildingData(index)
    return @buildings[index] > data[1]
  end
  
  # DEBUG PURPOSE
  def validateBuildings(inf, sup)
    for index in 0..inf
      if !finished?(index)
        @buildings[index] = getBuildingData(index)[1] + 1
        build(index)
        puts "building "
        puts index
        puts " built"
      end
    end
    for index in (inf+1)..sup
      @buildings[index] = getBuildingData(index)[1] + 1
      build(index)
      puts "building "
      puts index
      puts " built"
    end
  end
  
  def getBuildingData(index)
    data = 
    [
      # Fame 0 (index de 0 à 6)
      [_INTL("Gym Trainer 1"), 0, 0, []],      
      [_INTL("Gym Interiors 1"), 1, 0, []],
      [_INTL("Leader Room 1"), 1, 0, []],
      [_INTL("Gym Exteriors 1"), 2, 0, []],
      [_INTL("Pokémon Center 1"), 1, 0, []],
      [_INTL("Pokémon Lab 1"), 1, 0, []],
      [_INTL("Clearing - Your House"), 1, 0, []],
      
      # Fame 1 (index de 7 à 14)
      [_INTL("Dept. Store 1-1"), 0, 1, []],
      [_INTL("Welcoming 1"), 0, 1, []],
      [_INTL("Gym Interiors 2"), 1, 1.5, [1]],
      [_INTL("Pokémon Lab 2"), 1, 2, [5]],
      [_INTL("Your House"), 1, 2, [6]],
      [_INTL("Clearing - House 1"), 1, 0, []],
      [_INTL("Clearing - Town Exteriors"), 1, 0, []],
      [_INTL("Clearing - Academy"), 2, 0, []],
      
      # Fame 5 (index de 15 à 27)
      [_INTL("Dept. Store 2-1"), 2, 2, [7]],
      [_INTL("Dept. Store 1-2"), 0, 2, [7]],
      [_INTL("Gym Trainer 2"), 0, 1.5, []],
      [_INTL("Leader Room 2"), 1, 2, [2]],
      [_INTL("Pokémon Lab 3"), 1, 2, [10]],
      [_INTL("Double Team"), 0, 3, []],
      [_INTL("House 1"), 1, 2, [12]],
      [_INTL("Clearing - Block 1"), 2, 0, [12]],
      [_INTL("Town Exteriors 2"), 2, 3, [13]],
      [_INTL("Bike Seller"), 0, 2, [13]],
      [_INTL("Academy"), 3, 5, [14]],
      [_INTL("Clearing - Safari Park"), 2, 0, []],
      [_INTL("Selfcare Market 1"), 1, 1, []],
      
      # Fame 10 (index de 28 à 40)
      [_INTL("Dept. Store 3-1"), 2, 4, [15]],
      [_INTL("Dept. Store 2-2"), 0, 4, [15]],
      [_INTL("Dept. Store 1-3"), 0, 4, [16]],
      [_INTL("Welcoming 2"), 0, 5, [8]],
      [_INTL("Gym Exteriors 2"), 2, 5, [3]],
      [_INTL("Pokémon Center 2"), 1, 3, [4]],
      [_INTL("Pokémon Lab 4"), 1, 2, [19]],
      [_INTL("Block 1"), 2, 8, [22]],
      [_INTL("Clearing - House 2"), 1, 0, [22]],
      [_INTL("Safari Park 1"), 3, 10, [26]],
      [_INTL("Clearing - Selfcare market 2"), 1, 0, [27]],
      [_INTL("Clearing - Casino"), 2, 0, []],
      [_INTL("Clearing - Harbor"), 2, 0, []],
      
      # Fame 20 (index de 41 à 54)
      [_INTL("Dept. Store 4-1"), 2, 6, [28]],
      [_INTL("Dept. Store 3-2"), 0, 6, [28]],
      [_INTL("Dept. Store 2-3"), 0, 6, [29]],
      [_INTL("Dept. Store 1-4"), 0, 6, [30]],
      [_INTL("Gym Trainer 3"), 0, 4, [17]],
      [_INTL("Leader Room 3"), 1, 5, [18]],
      [_INTL("House 2"), 1, 2, [36]],
      [_INTL("Clearing - Block 2"), 2, 0, [36]],
      [_INTL("Town Exteriors 3"), 5, 20, [23]],
      [_INTL("Safari Park 2"), 3, 5, [37]],
      [_INTL("Selfcare Market 2"), 1, 5, [38]],
      [_INTL("Casino 1"), 2, 10, [39]],
      [_INTL("Harbor"), 3, 15, [40]],
      [_INTL("Clearing - Battle Café"), 2, 0, []],
      
      # Fame 30 (index de 55 à 70)
      [_INTL("Dept. Store 5-1"), 2, 8, [41]],
      [_INTL("Dept. Store 4-2"), 0, 8, [41]],
      [_INTL("Dept. Store 3-3"), 0, 8, [42]],
      [_INTL("Dept. Store 2-4"), 0, 8, [43]],
      [_INTL("Dept. Store 1-5"), 0, 8, [44]],
      [_INTL("Welcoming 3"), 0, 15, [31]],
      [_INTL("Gym Interiors 3"), 8, 50, [45, 46, 32]],
      [_INTL("Pokémon Center 3"), 1, 10, [33, 34]],
      [_INTL("Block 2"), 2, 8, [48]],
      [_INTL("Clearing - House 3"), 1, 0, [48]],
      [_INTL("Museum"), 2, 15, [25, 37]],
      [_INTL("Safari Park 3"), 3, 5, [50]],
      [_INTL("Clearing - Grand Hotel"), 0, 5, []],
      [_INTL("Casino 2"), 2, 10, [52]],
      [_INTL("Battle Café"), 3, 20, [54]],
      [_INTL("Clearing - Battle Restaurant"), 3, 0, [54]],
      
      # Fame 50 (index de 71 à 85)
      [_INTL("Dept. Store Rooftop"), 5, 12, [55]],
      [_INTL("Dept. Store 5-2"), 0, 12, [55]],
      [_INTL("Dept. Store 4-3"), 0, 12, [56]],
      [_INTL("Dept. Store 3-4"), 0, 12, [57]],
      [_INTL("Dept. Store 2-5"), 0, 12, [58]],
      [_INTL("Dept. Store 1-6"), 0, 12, [59]],
      [_INTL("Trainer 4"), 0, 20, [45]],
      [_INTL("Invitations 1"), 0, 50, []],
      [_INTL("House 3"), 1, 2, [64]],
      [_INTL("Clearing - House 4"), 1, 0, [64]],
      [_INTL("Safari Park 4"), 3, 5, [66]],
      [_INTL("Grand Hotel"), 15, 100, [65, 67, 68, 53, 69]],
      [_INTL("Casino 3"), 2, 15, [68]],
      [_INTL("Clearing - Radio Tower"), 0, 8, []],
      [_INTL("Battle Restaurant"), 5, 50, [70]],
      
      # Fame 70 (index a partir de 86)
      [_INTL("Dept. Store Basement"), 10, 20, [71]],
      [_INTL("Dept. Store 5-3"), 0, 20, [72]],
      [_INTL("Dept. Store 4-4"), 0, 20, [73]],
      [_INTL("Dept. Store 2-6"), 0, 20, [75]],
      [_INTL("Dept. Store 1-7"), 0, 20, [76]],
      [_INTL("Gym Exteriors 3"), 20, 250, []],
      [_INTL("Invitations 2"), 0, 150, [78]],
      [_INTL("House 4"), 1, 2, [80]],
      [_INTL("Town Exteriors 4"), 10, 200, [80, 49]],
      [_INTL("Safari Park 5"), 3, 5, [81]],
      [_INTL("Lighthouse"), 8, 40, [53]],
      [_INTL("Radio Tower"), 16, 100, [84]],
      ["MissingNoA", 0, 0, []],
      ["MissingNoB", 0, 0, []]
    ]
    return data[index]
  end
  
  #==========================================================================
  # Town modifications considering the town actual development
  #==========================================================================
  def build_town
  
    # "cheat" values pour skins alternatifs :
    #@buildings[0] : labo
    #@buildings[1] : lampadaires
    #@buildings[2] : pavage port
		#@buildings[3] : dept store TODO
    #@buildings[5] : fleurs
		#@buildings[54] : terrasse café
		#@buildings[70] : terrasse resto
    
    # Gestion skins alternatifs du labo
    if @buildings[0] > 2
      
      offset = @buildings[0] - 2
      
      # layer 1
      for j in 6..9 do
        for i in 5..10 do
          if ($game_map.get_tile(i, j, 1) > 0)
            $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)+24+offset*48)
          end
        end
      end
      
      # layer 2
      for j in 4..5 do
        for i in 5..10 do
          if ($game_map.get_tile(i, j, 2) > 0)
            $game_map.set_tile(i, j, 2, $game_map.get_tile(i, j, 2)+24+offset*48)
          end
        end
      end
    end
    
    # Gestion skins lampadaires
    if @buildings[1] > 2
      
      offset = @buildings[1] - 2
      
      # coordonnées du sommet de chaque lampadaire
      lamplist = [[29,5],[34,5],[4,11],[14,11],[27,11],[34,11],[2,16],[34,18],
      [8,26],[29,37],[22,41],[29,43],[14,47],[17,55],[28,55],[7,62],
      [14,66],[17,66],[28,66],[34,70],[9,72],[34,76],[28,81],[31,86],[9,90],
      [15,93],[3,98]]
      
      lamplist.each do |lamp|
        i = lamp[0]
        j = lamp[1]
        if ($game_map.get_tile(i, j, 1) > 0)
          $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)+offset*24)
          $game_map.set_tile(i, j+1, 1, $game_map.get_tile(i, j+1, 1)+offset*24)
          $game_map.set_tile(i, j+2, 1, $game_map.get_tile(i, j+2, 1)+offset*24)
        end
      end
    end
    
    # Gestion skins alternatifs du pavage du port
    if @buildings[2] > 2
      
      offset = @buildings[2] - 2
      
      # layer 1
      for j in 98..104 do
        for i in 17..43 do
          $game_map.set_tile(i, j, 0, $game_map.get_tile(i, j, 0)+offset*16)
        end
      end
      for j in 105..107 do
        for i in 17..42 do
          $game_map.set_tile(i, j, 0, $game_map.get_tile(i, j, 0)+offset*16)
        end
      end
      for j in 108..118 do
        for i in 17..26 do
          $game_map.set_tile(i, j, 0, $game_map.get_tile(i, j, 0)+offset*16)
        end
      end
      for j in 115..116 do
        for i in 27..36 do
          $game_map.set_tile(i, j, 0, $game_map.get_tile(i, j, 0)+offset*16)
        end
      end
    end
		
		# Gestion skins alternatifs du centre commercial
    if @buildings[3] > 3
      
      offset = @buildings[3] - 3
      
      # layer 2
      for j in 4..11 do
        for i in 34..42 do
          if ($game_map.get_tile(i, j, 2) > 0)
            $game_map.set_tile(i, j, 2, $game_map.get_tile(i, j, 2)+offset*88)
          end
        end
      end
      
      # layer 2
			for i in 37..39 do
				if ($game_map.get_tile(i, 9, 1) > 0)
					$game_map.set_tile(i, 9, 1, $game_map.get_tile(i, j, 1)+offset*88)
				end
			end
    end
		
		# Gestion fleurs alternatives
    if @buildings[5] > 2
      
      offset = @buildings[5] - 2
			puts offset
      
      # coordonnées de chaque fleur
      flowerlist = [[29,1],[29,2],[29,3],[3,6],[12,7],[19,9],[16,12],[16,13],[17,12],
      [17,13],[18,12],[18,13],[24,12],[24,13],[25,12],[25,13],[26,12],[26,13],
      [2,13],[3,13],[36,12],[36,13],[40,12],[40,13],[5,24],[6,24],[7,24],
      [39,24],[40,24],[25,25],[26,25],[28,30],[28,31],[28,32],[28,33],[28,34],
      [16,45],[17,45],[18,45],[19,45],[12,49],[13,49],[12,55],[13,55],[14,55],
      [25,62],[25,63],[26,62],[26,63],[9,66],[9,67],[9,68],[9,69],[9,70],
      [14,84],[27,84],[8,92],[31,93],[32,93],[5,104],[5,105],[6,104],
      [6,105],[11,104],[11,105],[12,104],[12,105]]
      
      flowerlist.each do |flower|
        i = flower[0]
        j = flower[1]
        echo $game_map.get_tile(i, j, 1)
        if ($game_map.get_tile(i, j, 1) > 0)
          $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)-offset*56)
        end
      end
    end
    
    # Gestion skins alternatifs du pavage du café
    if @buildings[54] > 3
      
      offset = @buildings[54] - 3
      
      # layer 1
      for j in 47..49 do
        for i in 16..22 do
          $game_map.set_tile(i, j, 0, $game_map.get_tile(i, j, 0)+32+offset*16)
        end
      end
    end
    
    # Gestion skins alternatifs du pavage du resto
    if @buildings[70] > 3
      
      offset = @buildings[70] - 3
      
      # layer 0
      for j in 43..53 do
        for i in 34..42 do
          $game_map.set_tile(i, j, 0, $game_map.get_tile(i, j, 0)+32+offset*16)
        end
      end
    end
    
    #=========================================================================
    # PC (note : spot already cleaned at the start of the game (tuto) and construction started
    #=========================================================================
    
    # Gestion skins alternatifs
    if @buildings[4] > 2
      
      offset = @buildings[4] - 2
      
      # layer 1
      for j in 16..22 do
        for i in 11..17 do
          if ($game_map.get_tile(i, j, 1) > 0)
            $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)+offset*56)
          end
        end
      end
      
      # layer 2
      for j in 17..19 do
        if ($game_map.get_tile(17, j, 2) > 0)
          $game_map.set_tile(17, j, 2, $game_map.get_tile(17, j, 2)+offset*56)
        end
      end
      for i in 13..15 do
        if ($game_map.get_tile(i, 21, 2) > 0)
          $game_map.set_tile(i, 21, 2, $game_map.get_tile(i, 21, 2)+offset*56)
        end
      end
    end
    
    if @buildings[4] < 2
     
      # Layers 2 and 3 cleanup (11 ; 16) -> (17 ; 21)
      for k in 1..2 do
        for j in 16..21 do
          for i in 11..17 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
      end
      
      # Layer 1 : grey background
      for j in 18..21 do
        for i in 12 ..16 do
          $game_map.set_tile(i, j, 0, 384+2137)
        end
      end
      
      # Layer 2 : white borders
      $game_map.set_tile(12, 18, 1, 384+428)
      $game_map.set_tile(13, 18, 1, 384+429)
      $game_map.set_tile(14, 18, 1, 384+429)
      $game_map.set_tile(15, 18, 1, 384+429)
      $game_map.set_tile(16, 18, 1, 384+431)
      $game_map.set_tile(12, 19, 1, 384+436)
      $game_map.set_tile(16, 19, 1, 384+439)
      $game_map.set_tile(12, 20, 1, 384+436)
      $game_map.set_tile(16, 20, 1, 384+439)
      $game_map.set_tile(12, 21, 1, 384+452)
      $game_map.set_tile(13, 21, 1, 384+453)
      $game_map.set_tile(14, 21, 1, 384+453)
      $game_map.set_tile(15, 21, 1, 384+453)
      $game_map.set_tile(16, 21, 1, 384+455)
      
      # Layer 3 : mini walls
      $game_map.set_tile(12, 17, 2, 384+6313)
      $game_map.set_tile(13, 17, 2, 384+6314)
      $game_map.set_tile(14, 17, 2, 384+6314)
      $game_map.set_tile(15, 17, 2, 384+6314)
      $game_map.set_tile(16, 17, 2, 384+6315)
      $game_map.set_tile(12, 18, 2, 384+6321)
      $game_map.set_tile(13, 18, 2, 384+6322)
      $game_map.set_tile(14, 18, 2, 384+6322)
      $game_map.set_tile(15, 18, 2, 384+6322)
      $game_map.set_tile(16, 18, 2, 384+6323)
      $game_map.set_tile(12, 19, 2, 384+6329)
      $game_map.set_tile(16, 19, 2, 384+6331)
      $game_map.set_tile(12, 20, 2, 384+6337)
      $game_map.set_tile(13, 20, 2, 384+6338)
      $game_map.set_tile(14, 20, 2, 384+6338)
      $game_map.set_tile(15, 20, 2, 384+6338)
      $game_map.set_tile(16, 20, 2, 384+6339)
      $game_map.set_tile(12, 21, 2, 384+6345)
      $game_map.set_tile(13, 21, 2, 384+6346)
      $game_map.set_tile(14, 21, 2, 384+6346)
      $game_map.set_tile(15, 21, 2, 384+6346)
      $game_map.set_tile(16, 21, 2, 384+6347)
      
      # Layer 3 : cones
      $game_map.set_tile(11, 20, 2, 384+6156)
      $game_map.set_tile(11, 21, 2, 384+6164)
      $game_map.set_tile(17, 20, 1, 384+6156)
      $game_map.set_tile(17, 21, 1, 384+6164)

    end
  
    #=========================================================================
    # PJ House ( 6 & 11 )
    #=========================================================================
    # Gestion skins alternatifs
    if @buildings[11] > 2
      
      offset = @buildings[11] - 2
      puts "offset"
      puts offset
      for k in 1..2 do
        for j in 16..21 do
          for i in 3..7 do
            if ($game_map.get_tile(i, j, k) > 0)
              $game_map.set_tile(i, j, k, $game_map.get_tile(i, j, k)+offset*48)
            end
          end
        end
      end
    end
    
    if @buildings[11] < 2
      
      # Layers 2 and 3 cleanup (3 ; 16) -> (8 ; 21)
      for k in 1..2 do
        for j in 16..21 do
          for i in 3..8 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
      end
      
      if @buildings[6] < 2
      
        # cracked ground
        $game_map.set_tile(4, 18, 0, 384+6005)
        $game_map.set_tile(5, 18, 0, 384+6006)
        $game_map.set_tile(6, 18, 0, 384+6005)
        $game_map.set_tile(7, 18, 0, 384+6006)
        $game_map.set_tile(4, 19, 0, 384+6013)
        $game_map.set_tile(5, 19, 0, 384+6014)
        $game_map.set_tile(6, 19, 0, 384+6013)
        $game_map.set_tile(7, 19, 0, 384+6014)
        $game_map.set_tile(4, 20, 0, 384+6005)
        $game_map.set_tile(5, 20, 0, 384+6006)
        $game_map.set_tile(6, 20, 0, 384+6005)
        $game_map.set_tile(7, 20, 0, 384+6006)
        $game_map.set_tile(4, 21, 0, 384+6013)
        $game_map.set_tile(5, 21, 0, 384+6014)
        $game_map.set_tile(6, 21, 0, 384+6013)
        $game_map.set_tile(7, 21, 0, 384+6014)
        
        
        # "little dot" rocks
        $game_map.set_tile(7, 19, 2, 384+1606)
        $game_map.set_tile(4, 21, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(4, 18, 2, 384+1661)
        $game_map.set_tile(7, 18, 2, 384+1661)
        $game_map.set_tile(5, 21, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(4, 20, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(5, 18, 2, 384+1651)
        $game_map.set_tile(6, 18, 2, 384+1652)
        $game_map.set_tile(5, 19, 2, 384+1659)
        $game_map.set_tile(6, 19, 2, 384+1660)
        
        $game_map.set_tile(6, 20, 2, 384+1651)
        $game_map.set_tile(7, 20, 2, 384+1652)
        $game_map.set_tile(6, 21, 2, 384+1659)
        $game_map.set_tile(7, 21, 2, 384+1660)
        
        # big rocks
        
        # construction hole
        
      else
        
        # Layer 1 : grey background
        for j in 18..21 do
          for i in 4 ..7 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(4, 18, 1, 384+428)
        $game_map.set_tile(5, 18, 1, 384+429)
        $game_map.set_tile(6, 18, 1, 384+429)
        $game_map.set_tile(7, 18, 1, 384+431)
        $game_map.set_tile(4, 19, 1, 384+436)
        $game_map.set_tile(7, 19, 1, 384+439)
        $game_map.set_tile(4, 20, 1, 384+436)
        $game_map.set_tile(7, 20, 1, 384+439)
        $game_map.set_tile(4, 21, 1, 384+452)
        $game_map.set_tile(5, 21, 1, 384+453)
        $game_map.set_tile(6, 21, 1, 384+453)
        $game_map.set_tile(7, 21, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(4, 17, 2, 384+6313)
        $game_map.set_tile(5, 17, 2, 384+6314)
        $game_map.set_tile(6, 17, 2, 384+6314)
        $game_map.set_tile(7, 17, 2, 384+6315)
        $game_map.set_tile(4, 18, 2, 384+6321)
        $game_map.set_tile(5, 18, 2, 384+6322)
        $game_map.set_tile(6, 18, 2, 384+6322)
        $game_map.set_tile(7, 18, 2, 384+6323)
        $game_map.set_tile(4, 19, 2, 384+6329)
        $game_map.set_tile(7, 19, 2, 384+6331)
        $game_map.set_tile(4, 20, 2, 384+6337)
        $game_map.set_tile(5, 20, 2, 384+6338)
        $game_map.set_tile(6, 20, 2, 384+6338)
        $game_map.set_tile(7, 20, 2, 384+6339)
        $game_map.set_tile(4, 21, 2, 384+6345)
        $game_map.set_tile(5, 21, 2, 384+6346)
        $game_map.set_tile(6, 21, 2, 384+6346)
        $game_map.set_tile(7, 21, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(3, 20, 2, 384+6156)
        $game_map.set_tile(3, 21, 2, 384+6164)
        $game_map.set_tile(8, 20, 2, 384+6156)
        $game_map.set_tile(8, 21, 2, 384+6164)
        
      end
    end
  
  
    #=========================================================================
    # NPC House 1 ( 12 & 21 )
    #=========================================================================
    # Gestion skins alternatifs
    if @buildings[21] > 2
      
      offset = @buildings[21] - 2
      puts "offset"
      puts offset
      for j in 17..19 do
        $game_map.set_tile(18, j, 1, $game_map.get_tile(18, j, 1)+16+offset*32)
      end
      
      for j in 16..19 do
        for i in 19..22 do
          if ($game_map.get_tile(i, j, 1) > 0)
            $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)+16+offset*32)
          end
        end
      end
      
      for j in 17..19 do
        $game_map.set_tile(23, j, 2, $game_map.get_tile(23, j, 2)+16+offset*32)
      end
    end
    
    if @buildings[21] < 2
     
      # Layers 2 and 3 cleanup (18 ; 16) -> (22 ; 21)
      for k in 1..2 do
        for j in 16..21 do
          for i in 18..22 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
      end
      
      for j in 17..19 do
        for i in 23..28 do
          $game_map.set_tile(i, j, 2, 0)
        end
      end
      
      $game_map.set_tile(23, 19, 1, 0)
      $game_map.set_tile(23, 20, 1, 0)
      $game_map.set_tile(23, 21, 1, 0)
      
      if @buildings[12] < 2
        
        # cracked ground
        $game_map.set_tile(19, 18, 0, 384+6005)
        $game_map.set_tile(20, 18, 0, 384+6006)
        $game_map.set_tile(21, 18, 0, 384+6005)
        $game_map.set_tile(22, 18, 0, 384+6006)
        $game_map.set_tile(19, 19, 0, 384+6013)
        $game_map.set_tile(20, 19, 0, 384+6014)
        $game_map.set_tile(21, 19, 0, 384+6013)
        $game_map.set_tile(22, 19, 0, 384+6014)
        $game_map.set_tile(19, 20, 0, 384+6005)
        $game_map.set_tile(20, 20, 0, 384+6006)
        $game_map.set_tile(21, 20, 0, 384+6005)
        $game_map.set_tile(22, 20, 0, 384+6006)
        $game_map.set_tile(19, 21, 0, 384+6013)
        $game_map.set_tile(20, 21, 0, 384+6014)
        $game_map.set_tile(21, 21, 0, 384+6013)
        $game_map.set_tile(22, 21, 0, 384+6014)
        
        
        # "little dot" rocks
        $game_map.set_tile(20, 21, 2, 384+1606)
        $game_map.set_tile(21, 18, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(19, 21, 2, 384+1661)
        $game_map.set_tile(22, 18, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(21, 19, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(19, 18, 2, 384+1651)
        $game_map.set_tile(20, 18, 2, 384+1652)
        $game_map.set_tile(19, 19, 2, 384+1659)
        $game_map.set_tile(20, 19, 2, 384+1660)
        
        $game_map.set_tile(21, 20, 2, 384+1651)
        $game_map.set_tile(22, 20, 2, 384+1652)
        $game_map.set_tile(21, 21, 2, 384+1659)
        $game_map.set_tile(22, 21, 2, 384+1660)
        
        # big rocks
        
        # construction hole
        
      else
        
        # Layer 1 : grey background
        for j in 18..21 do
          for i in 19 ..22 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(19, 18, 1, 384+428)
        $game_map.set_tile(20, 18, 1, 384+429)
        $game_map.set_tile(21, 18, 1, 384+429)
        $game_map.set_tile(22, 18, 1, 384+431)
        $game_map.set_tile(19, 19, 1, 384+436)
        $game_map.set_tile(22, 19, 1, 384+439)
        $game_map.set_tile(19, 20, 1, 384+436)
        $game_map.set_tile(22, 20, 1, 384+439)
        $game_map.set_tile(19, 21, 1, 384+452)
        $game_map.set_tile(20, 21, 1, 384+453)
        $game_map.set_tile(21, 21, 1, 384+453)
        $game_map.set_tile(22, 21, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(19, 17, 2, 384+6313)
        $game_map.set_tile(20, 17, 2, 384+6314)
        $game_map.set_tile(21, 17, 2, 384+6314)
        $game_map.set_tile(22, 17, 2, 384+6315)
        $game_map.set_tile(19, 18, 2, 384+6321)
        $game_map.set_tile(20, 18, 2, 384+6322)
        $game_map.set_tile(21, 18, 2, 384+6322)
        $game_map.set_tile(22, 18, 2, 384+6323)
        $game_map.set_tile(19, 19, 2, 384+6329)
        $game_map.set_tile(22, 19, 2, 384+6331)
        $game_map.set_tile(19, 20, 2, 384+6337)
        $game_map.set_tile(20, 20, 2, 384+6338)
        $game_map.set_tile(21, 20, 2, 384+6338)
        $game_map.set_tile(22, 20, 2, 384+6339)
        $game_map.set_tile(19, 21, 2, 384+6345)
        $game_map.set_tile(20, 21, 2, 384+6346)
        $game_map.set_tile(21, 21, 2, 384+6346)
        $game_map.set_tile(22, 21, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(18, 20, 2, 384+6156)
        $game_map.set_tile(18, 21, 2, 384+6164)
      
      end
    end
  
  
    #=========================================================================
    # Academy ( 14 & 25 )
    #=========================================================================
    # Gestion skins alternatifs
    if @buildings[25] > 4
      
      offset = @buildings[25] - 4
      
      # layer 1
      for j in 31..35 do
        for i in 12..18 do
          if ($game_map.get_tile(i, j, 1) > 0)
            $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)+64+offset*80)
          end
        end
      end
      for j in 31..35 do
        for i in 19..26 do
          if ($game_map.get_tile(i, j, 1) > 0)
            $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)+32+offset*80)
          end
        end
      end
      
      # layer 2
      for j in 32..35 do
        if ($game_map.get_tile(11, j, 2) > 0)
          $game_map.set_tile(11, j, 2, $game_map.get_tile(11, j, 2)+64+offset*80)
        end
      end
    end
    
    if @buildings[25] < 4
     
      # Layers 2 and 3 cleanup (12 ; 31) -> (26 ; 38)
      for k in 1..2 do
        for j in 31..38 do
          for i in 12..26 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
      end
      
      for i in 16..19 do
        $game_map.set_tile(i, 39, 1, 0)
      end
      for j in 31..35 do
        $game_map.set_tile(11, j, 2, 0)
      end
      
      for j in 27..29 do
        for i in 17..23 do
          $game_map.set_tile(i, j, 1, 0)
        end
      end
      
      for j in 24..29 do
        for i in 12..29 do
          $game_map.set_tile(i, j, 2, 0)
        end
      end
      
      for j in 35..39 do
        for i in 26..29 do
          $game_map.set_tile(i, j, 2, 0)
        end
      end
      
      if @buildings[14] < 3
        
        # cracked ground
        $game_map.set_tile(12, 32, 0, 384+6005)
        $game_map.set_tile(13, 32, 0, 384+6006)
        $game_map.set_tile(14, 32, 0, 384+6005)
        $game_map.set_tile(15, 32, 0, 384+6006)
        $game_map.set_tile(16, 32, 0, 384+6005)
        $game_map.set_tile(17, 32, 0, 384+6006)
        $game_map.set_tile(18, 32, 0, 384+6005)
        $game_map.set_tile(19, 32, 0, 384+6006)
        $game_map.set_tile(20, 32, 0, 384+6005)
        $game_map.set_tile(21, 32, 0, 384+6006)
        $game_map.set_tile(22, 32, 0, 384+6005)
        $game_map.set_tile(23, 32, 0, 384+6006)
        $game_map.set_tile(24, 32, 0, 384+6005)
        $game_map.set_tile(25, 32, 0, 384+6006)
        $game_map.set_tile(26, 32, 0, 384+6005)
        $game_map.set_tile(12, 33, 0, 384+6013)
        $game_map.set_tile(13, 33, 0, 384+6014)
        $game_map.set_tile(14, 33, 0, 384+6013)
        $game_map.set_tile(15, 33, 0, 384+6014)
        $game_map.set_tile(16, 33, 0, 384+6013)
        $game_map.set_tile(17, 33, 0, 384+6014)
        $game_map.set_tile(18, 33, 0, 384+6013)
        $game_map.set_tile(19, 33, 0, 384+6014)
        $game_map.set_tile(20, 33, 0, 384+6013)
        $game_map.set_tile(21, 33, 0, 384+6014)
        $game_map.set_tile(22, 33, 0, 384+6013)
        $game_map.set_tile(23, 33, 0, 384+6014)
        $game_map.set_tile(24, 33, 0, 384+6013)
        $game_map.set_tile(25, 33, 0, 384+6014)
        $game_map.set_tile(26, 33, 0, 384+6013)
        $game_map.set_tile(12, 34, 0, 384+6005)
        $game_map.set_tile(13, 34, 0, 384+6006)
        $game_map.set_tile(14, 34, 0, 384+6005)
        $game_map.set_tile(15, 34, 0, 384+6006)
        $game_map.set_tile(16, 34, 0, 384+6005)
        $game_map.set_tile(17, 34, 0, 384+6006)
        $game_map.set_tile(18, 34, 0, 384+6005)
        $game_map.set_tile(19, 34, 0, 384+6006)
        $game_map.set_tile(20, 34, 0, 384+6005)
        $game_map.set_tile(21, 34, 0, 384+6006)
        $game_map.set_tile(22, 34, 0, 384+6005)
        $game_map.set_tile(23, 34, 0, 384+6006)
        $game_map.set_tile(24, 34, 0, 384+6005)
        $game_map.set_tile(25, 34, 0, 384+6006)
        $game_map.set_tile(26, 34, 0, 384+6005)
        $game_map.set_tile(12, 35, 0, 384+6013)
        $game_map.set_tile(13, 35, 0, 384+6014)
        $game_map.set_tile(14, 35, 0, 384+6013)
        $game_map.set_tile(15, 35, 0, 384+6014)
        $game_map.set_tile(16, 35, 0, 384+6013)
        $game_map.set_tile(17, 35, 0, 384+6014)
        $game_map.set_tile(18, 35, 0, 384+6013)
        $game_map.set_tile(19, 35, 0, 384+6014)
        $game_map.set_tile(20, 35, 0, 384+6013)
        $game_map.set_tile(21, 35, 0, 384+6014)
        $game_map.set_tile(22, 35, 0, 384+6013)
        $game_map.set_tile(23, 35, 0, 384+6014)
        $game_map.set_tile(24, 35, 0, 384+6013)
        $game_map.set_tile(25, 35, 0, 384+6014)
        $game_map.set_tile(26, 35, 0, 384+6013)
        $game_map.set_tile(12, 36, 0, 384+6005)
        $game_map.set_tile(13, 36, 0, 384+6006)
        $game_map.set_tile(14, 36, 0, 384+6005)
        $game_map.set_tile(15, 36, 0, 384+6006)
        $game_map.set_tile(16, 36, 0, 384+6005)
        $game_map.set_tile(17, 36, 0, 384+6006)
        $game_map.set_tile(18, 36, 0, 384+6005)
        $game_map.set_tile(19, 36, 0, 384+6006)
        $game_map.set_tile(20, 36, 0, 384+6005)
        $game_map.set_tile(21, 36, 0, 384+6006)
        $game_map.set_tile(22, 36, 0, 384+6005)
        $game_map.set_tile(23, 36, 0, 384+6006)
        $game_map.set_tile(24, 36, 0, 384+6005)
        $game_map.set_tile(25, 36, 0, 384+6006)
        $game_map.set_tile(26, 36, 0, 384+6005)
        $game_map.set_tile(12, 37, 0, 384+6013)
        $game_map.set_tile(13, 37, 0, 384+6014)
        $game_map.set_tile(14, 37, 0, 384+6013)
        $game_map.set_tile(15, 37, 0, 384+6014)
        $game_map.set_tile(16, 37, 0, 384+6013)
        $game_map.set_tile(17, 37, 0, 384+6014)
        $game_map.set_tile(18, 37, 0, 384+6013)
        $game_map.set_tile(19, 37, 0, 384+6014)
        $game_map.set_tile(20, 37, 0, 384+6013)
        $game_map.set_tile(21, 37, 0, 384+6014)
        $game_map.set_tile(22, 37, 0, 384+6013)
        $game_map.set_tile(23, 37, 0, 384+6014)
        $game_map.set_tile(24, 37, 0, 384+6013)
        $game_map.set_tile(25, 37, 0, 384+6014)
        $game_map.set_tile(26, 37, 0, 384+6013)
        
        # "little dot" rocks
        $game_map.set_tile(17, 36, 2, 384+1606)
        $game_map.set_tile(21, 35, 2, 384+1606)
        $game_map.set_tile(23, 37, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(14, 32, 2, 384+1661)
        $game_map.set_tile(21, 32, 2, 384+1661)
        $game_map.set_tile(26, 31, 2, 384+1661)
        $game_map.set_tile(15, 37, 2, 384+1661)
        $game_map.set_tile(24, 37, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(12, 37, 2, 384+1658)
        $game_map.set_tile(18, 32, 2, 384+1658)
        $game_map.set_tile(18, 37, 2, 384+1658)
        $game_map.set_tile(21, 34, 2, 384+1658)
        $game_map.set_tile(26, 36, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(12, 33, 2, 384+1651)
        $game_map.set_tile(13, 33, 2, 384+1652)
        $game_map.set_tile(12, 34, 2, 384+1659)
        $game_map.set_tile(13, 34, 2, 384+1660)
        
        $game_map.set_tile(16, 32, 2, 384+1651)
        $game_map.set_tile(17, 32, 2, 384+1652)
        $game_map.set_tile(16, 33, 2, 384+1659)
        $game_map.set_tile(17, 33, 2, 384+1660)
        
        $game_map.set_tile(20, 36, 2, 384+1651)
        $game_map.set_tile(21, 36, 2, 384+1652)
        $game_map.set_tile(20, 37, 2, 384+1659)
        $game_map.set_tile(21, 37, 2, 384+1660)
        
        $game_map.set_tile(25, 34, 2, 384+1651)
        $game_map.set_tile(26, 34, 2, 384+1652)
        $game_map.set_tile(25, 35, 2, 384+1659)
        $game_map.set_tile(26, 35, 2, 384+1660)
        
        # big rocks
        $game_map.set_tile(18, 33, 2, 384+1613)
        $game_map.set_tile(19, 33, 2, 384+1614)
        $game_map.set_tile(18, 34, 2, 384+1621)
        $game_map.set_tile(19, 34, 2, 384+1622)
        $game_map.set_tile(20, 34, 2, 384+1623)
        $game_map.set_tile(18, 35, 2, 384+1629)
        $game_map.set_tile(19, 35, 2, 384+1630)
        $game_map.set_tile(20, 35, 2, 384+1631)
        $game_map.set_tile(18, 36, 2, 384+1637)
        $game_map.set_tile(19, 36, 2, 384+1638)
        
        # construction hole
        $game_map.set_tile(13, 33, 1, 384+6044)
        $game_map.set_tile(14, 33, 1, 384+6045)
        $game_map.set_tile(15, 33, 1, 384+6046)
        $game_map.set_tile(16, 33, 1, 384+6047)
        $game_map.set_tile(13, 34, 1, 384+6052)
        $game_map.set_tile(14, 34, 1, 384+6053)
        $game_map.set_tile(15, 34, 1, 384+6054)
        $game_map.set_tile(16, 34, 1, 384+6055)
        $game_map.set_tile(13, 35, 1, 384+6060)
        $game_map.set_tile(14, 35, 1, 384+6061)
        $game_map.set_tile(15, 35, 1, 384+6062)
        $game_map.set_tile(16, 35, 1, 384+6063)
        $game_map.set_tile(13, 36, 1, 384+6068)
        $game_map.set_tile(14, 36, 1, 384+6069)
        $game_map.set_tile(15, 36, 1, 384+6070)
        $game_map.set_tile(16, 36, 1, 384+6071)
        
        $game_map.set_tile(22, 32, 1, 384+6044)
        $game_map.set_tile(23, 32, 1, 384+6045)
        $game_map.set_tile(24, 32, 1, 384+6046)
        $game_map.set_tile(25, 32, 1, 384+6047)
        $game_map.set_tile(22, 33, 1, 384+6052)
        $game_map.set_tile(23, 33, 1, 384+6053)
        $game_map.set_tile(24, 33, 1, 384+6054)
        $game_map.set_tile(25, 33, 1, 384+6055)
        $game_map.set_tile(22, 34, 1, 384+6060)
        $game_map.set_tile(23, 34, 1, 384+6061)
        $game_map.set_tile(24, 34, 1, 384+6062)
        $game_map.set_tile(25, 34, 1, 384+6063)
        $game_map.set_tile(22, 35, 1, 384+6068)
        $game_map.set_tile(23, 35, 1, 384+6069)
        $game_map.set_tile(24, 35, 1, 384+6070)
        $game_map.set_tile(25, 35, 1, 384+6071)
        
        
      else
        
        # Layer 1 : grey background
        for j in 32..37 do
          for i in 12 ..26 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(12, 32, 1, 384+428)
        $game_map.set_tile(13, 32, 1, 384+429)
        $game_map.set_tile(14, 32, 1, 384+429)
        $game_map.set_tile(15, 32, 1, 384+429)
        $game_map.set_tile(16, 32, 1, 384+429)
        $game_map.set_tile(17, 32, 1, 384+429)
        $game_map.set_tile(18, 32, 1, 384+429)
        $game_map.set_tile(19, 32, 1, 384+429)
        $game_map.set_tile(20, 32, 1, 384+429)
        $game_map.set_tile(21, 32, 1, 384+429)
        $game_map.set_tile(22, 32, 1, 384+429)
        $game_map.set_tile(23, 32, 1, 384+429)
        $game_map.set_tile(24, 32, 1, 384+429)
        $game_map.set_tile(25, 32, 1, 384+429)
        $game_map.set_tile(26, 32, 1, 384+431)
        $game_map.set_tile(12, 33, 1, 384+436)
        $game_map.set_tile(26, 33, 1, 384+439)
        $game_map.set_tile(12, 34, 1, 384+436)
        $game_map.set_tile(26, 34, 1, 384+439)
        $game_map.set_tile(12, 35, 1, 384+436)
        $game_map.set_tile(26, 35, 1, 384+439)
        $game_map.set_tile(12, 36, 1, 384+436)
        $game_map.set_tile(26, 36, 1, 384+439)
        $game_map.set_tile(12, 37, 1, 384+452)
        $game_map.set_tile(13, 37, 1, 384+453)
        $game_map.set_tile(14, 37, 1, 384+453)
        $game_map.set_tile(15, 37, 1, 384+453)
        $game_map.set_tile(16, 37, 1, 384+453)
        $game_map.set_tile(17, 37, 1, 384+453)
        $game_map.set_tile(18, 37, 1, 384+453)
        $game_map.set_tile(19, 37, 1, 384+453)
        $game_map.set_tile(20, 37, 1, 384+453)
        $game_map.set_tile(21, 37, 1, 384+453)
        $game_map.set_tile(22, 37, 1, 384+453)
        $game_map.set_tile(23, 37, 1, 384+453)
        $game_map.set_tile(24, 37, 1, 384+453)
        $game_map.set_tile(25, 37, 1, 384+453)
        $game_map.set_tile(26, 37, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(12, 31, 2, 384+6313)
        $game_map.set_tile(13, 31, 2, 384+6314)
        $game_map.set_tile(14, 31, 2, 384+6314)
        $game_map.set_tile(15, 31, 2, 384+6314)
        $game_map.set_tile(16, 31, 2, 384+6314)
        $game_map.set_tile(17, 31, 2, 384+6314)
        $game_map.set_tile(18, 31, 2, 384+6314)
        $game_map.set_tile(19, 31, 2, 384+6314)
        $game_map.set_tile(20, 31, 2, 384+6314)
        $game_map.set_tile(21, 31, 2, 384+6314)
        $game_map.set_tile(22, 31, 2, 384+6314)
        $game_map.set_tile(23, 31, 2, 384+6314)
        $game_map.set_tile(24, 31, 2, 384+6314)
        $game_map.set_tile(25, 31, 2, 384+6314)
        $game_map.set_tile(26, 31, 2, 384+6315)
        $game_map.set_tile(12, 32, 2, 384+6321)
        $game_map.set_tile(13, 32, 2, 384+6322)
        $game_map.set_tile(14, 32, 2, 384+6322)
        $game_map.set_tile(15, 32, 2, 384+6322)
        $game_map.set_tile(16, 32, 2, 384+6322)
        $game_map.set_tile(17, 32, 2, 384+6322)
        $game_map.set_tile(18, 32, 2, 384+6322)
        $game_map.set_tile(19, 32, 2, 384+6322)
        $game_map.set_tile(20, 32, 2, 384+6322)
        $game_map.set_tile(21, 32, 2, 384+6322)
        $game_map.set_tile(22, 32, 2, 384+6322)
        $game_map.set_tile(23, 32, 2, 384+6322)
        $game_map.set_tile(24, 32, 2, 384+6322)
        $game_map.set_tile(25, 32, 2, 384+6322)
        $game_map.set_tile(26, 32, 2, 384+6323)
        $game_map.set_tile(12, 33, 2, 384+6329)
        $game_map.set_tile(26, 33, 2, 384+6331)
        $game_map.set_tile(12, 34, 2, 384+6329)
        $game_map.set_tile(26, 34, 2, 384+6331)
        $game_map.set_tile(12, 35, 2, 384+6329)
        $game_map.set_tile(26, 35, 2, 384+6331)
        $game_map.set_tile(12, 36, 2, 384+6337)
        $game_map.set_tile(13, 36, 2, 384+6338)
        $game_map.set_tile(14, 36, 2, 384+6338)
        $game_map.set_tile(15, 36, 2, 384+6338)
        $game_map.set_tile(16, 36, 2, 384+6338)
        $game_map.set_tile(17, 36, 2, 384+6338)
        $game_map.set_tile(18, 36, 2, 384+6338)
        $game_map.set_tile(19, 36, 2, 384+6338)
        $game_map.set_tile(20, 36, 2, 384+6338)
        $game_map.set_tile(21, 36, 2, 384+6338)
        $game_map.set_tile(22, 36, 2, 384+6338)
        $game_map.set_tile(23, 36, 2, 384+6338)
        $game_map.set_tile(24, 36, 2, 384+6338)
        $game_map.set_tile(25, 36, 2, 384+6338)
        $game_map.set_tile(26, 36, 2, 384+6339)
        $game_map.set_tile(12, 37, 2, 384+6345)
        $game_map.set_tile(13, 37, 2, 384+6346)
        $game_map.set_tile(14, 37, 2, 384+6346)
        $game_map.set_tile(15, 37, 2, 384+6346)
        $game_map.set_tile(16, 37, 2, 384+6346)
        $game_map.set_tile(17, 37, 2, 384+6346)
        $game_map.set_tile(18, 37, 2, 384+6346)
        $game_map.set_tile(19, 37, 2, 384+6346)
        $game_map.set_tile(20, 37, 2, 384+6346)
        $game_map.set_tile(21, 37, 2, 384+6346)
        $game_map.set_tile(22, 37, 2, 384+6346)
        $game_map.set_tile(23, 37, 2, 384+6346)
        $game_map.set_tile(24, 37, 2, 384+6346)
        $game_map.set_tile(25, 37, 2, 384+6346)
        $game_map.set_tile(26, 37, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(11, 36, 2, 384+6156)
        $game_map.set_tile(11, 37, 2, 384+6164)
        $game_map.set_tile(27, 36, 2, 384+6156)
        $game_map.set_tile(27, 37, 2, 384+6164)
        
      end
    end
  
  
    #=========================================================================
    # Block 1 ( 22 & 35 )
    #=========================================================================
    # Gestion skins alternatifs
    if @buildings[35] > 3
      
      offset = @buildings[35] - 3
      puts "offset"
      puts offset
      
      for j in 32..40 do
        for i in 36..41 do
          if ($game_map.get_tile(i, j, 1) > 0)
            $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)+offset*80)
          end
        end
      end
      
      for i in 39..41 do
        $game_map.set_tile(i, 39, 2, $game_map.get_tile(i, 39, 2)+offset*80)
      end
    end
    
    if @buildings[35] < 3
     
      # Layers 2 and 3 cleanup (36 ; 32) -> (41 ; 40)
      for k in 1..2 do
        for j in 32..40 do
          for i in 36..41 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
      end
      
      for j in 30..40 do
        $game_map.set_tile(42, j, 1, 0)
      end
     
      for j in 26..28 do
        for i in 35..41 do
          $game_map.set_tile(i, j, 2, 0)
        end
      end
      
      if @buildings[22] < 3
        
        # cracked ground
        $game_map.set_tile(36, 36, 0, 384+6005)
        $game_map.set_tile(37, 36, 0, 384+6006)
        $game_map.set_tile(38, 36, 0, 384+6005)
        $game_map.set_tile(39, 36, 0, 384+6006)
        $game_map.set_tile(40, 36, 0, 384+6005)
        $game_map.set_tile(41, 36, 0, 384+6006)
        $game_map.set_tile(36, 37, 0, 384+6013)
        $game_map.set_tile(37, 37, 0, 384+6014)
        $game_map.set_tile(38, 37, 0, 384+6013)
        $game_map.set_tile(39, 37, 0, 384+6014)
        $game_map.set_tile(40, 37, 0, 384+6013)
        $game_map.set_tile(41, 37, 0, 384+6014)
        $game_map.set_tile(36, 38, 0, 384+6005)
        $game_map.set_tile(37, 38, 0, 384+6006)
        $game_map.set_tile(38, 38, 0, 384+6005)
        $game_map.set_tile(39, 38, 0, 384+6006)
        $game_map.set_tile(40, 38, 0, 384+6005)
        $game_map.set_tile(41, 38, 0, 384+6006)
        $game_map.set_tile(36, 39, 0, 384+6013)
        $game_map.set_tile(37, 39, 0, 384+6014)
        $game_map.set_tile(38, 39, 0, 384+6013)
        $game_map.set_tile(39, 39, 0, 384+6014)
        $game_map.set_tile(40, 39, 0, 384+6013)
        $game_map.set_tile(41, 39, 0, 384+6014)
        
        # "little dot" rocks
        $game_map.set_tile(37, 38, 2, 384+1606)
        $game_map.set_tile(40, 37, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(36, 39, 2, 384+1661)
        $game_map.set_tile(39, 36, 2, 384+1661)
        $game_map.set_tile(41, 36, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(36, 37, 2, 384+1658)
        $game_map.set_tile(39, 38, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(37, 36, 2, 384+1651)
        $game_map.set_tile(38, 36, 2, 384+1652)
        $game_map.set_tile(37, 37, 2, 384+1659)
        $game_map.set_tile(38, 37, 2, 384+1660)
        
        $game_map.set_tile(40, 38, 2, 384+1651)
        $game_map.set_tile(41, 38, 2, 384+1652)
        $game_map.set_tile(40, 39, 2, 384+1659)
        $game_map.set_tile(41, 39, 2, 384+1660)
        
      else
              
        # Layer 1 : grey background
        for j in 36..39 do
          for i in 36 ..41 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(36, 36, 1, 384+428)
        $game_map.set_tile(37, 36, 1, 384+429)
        $game_map.set_tile(38, 36, 1, 384+429)
        $game_map.set_tile(39, 36, 1, 384+429)
        $game_map.set_tile(40, 36, 1, 384+429)
        $game_map.set_tile(41, 36, 1, 384+431)
        $game_map.set_tile(36, 37, 1, 384+436)
        $game_map.set_tile(41, 37, 1, 384+439)
        $game_map.set_tile(36, 38, 1, 384+436)
        $game_map.set_tile(41, 38, 1, 384+439)
        $game_map.set_tile(36, 39, 1, 384+452)
        $game_map.set_tile(37, 39, 1, 384+453)
        $game_map.set_tile(38, 39, 1, 384+453)
        $game_map.set_tile(39, 39, 1, 384+453)
        $game_map.set_tile(40, 39, 1, 384+453)
        $game_map.set_tile(41, 39, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(36, 35, 2, 384+6313)
        $game_map.set_tile(37, 35, 2, 384+6314)
        $game_map.set_tile(38, 35, 2, 384+6314)
        $game_map.set_tile(39, 35, 2, 384+6314)
        $game_map.set_tile(40, 35, 2, 384+6314)
        $game_map.set_tile(41, 35, 2, 384+6315)
        $game_map.set_tile(36, 36, 2, 384+6321)
        $game_map.set_tile(37, 36, 2, 384+6322)
        $game_map.set_tile(38, 36, 2, 384+6322)
        $game_map.set_tile(39, 36, 2, 384+6322)
        $game_map.set_tile(40, 36, 2, 384+6322)
        $game_map.set_tile(41, 36, 2, 384+6323)
        $game_map.set_tile(36, 37, 2, 384+6329)
        $game_map.set_tile(41, 37, 2, 384+6331)
        $game_map.set_tile(36, 38, 2, 384+6337)
        $game_map.set_tile(37, 38, 2, 384+6338)
        $game_map.set_tile(38, 38, 2, 384+6338)
        $game_map.set_tile(39, 38, 2, 384+6338)
        $game_map.set_tile(40, 38, 2, 384+6338)
        $game_map.set_tile(41, 38, 2, 384+6339)
        $game_map.set_tile(36, 39, 2, 384+6345)
        $game_map.set_tile(37, 39, 2, 384+6346)
        $game_map.set_tile(38, 39, 2, 384+6346)
        $game_map.set_tile(39, 39, 2, 384+6346)
        $game_map.set_tile(40, 39, 2, 384+6346)
        $game_map.set_tile(41, 39, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(35, 38, 2, 384+6156)
        $game_map.set_tile(35, 39, 2, 384+6164)
        $game_map.set_tile(42, 38, 1, 384+6156)
        $game_map.set_tile(42, 39, 1, 384+6164)

      end
    end
  
  
    #=========================================================================
    # Safari ( 26 & 37 )
    #=========================================================================
    if @buildings[37] < 4
     
      # Layers 2 and 3 cleanup (5 ; 107) -> (12 ; 116)
      for k in 1..2 do
        for j in 107..116 do
          for i in 5..12 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
      end
      
      if @buildings[26] < 3
        
        # cracked ground
        $game_map.set_tile(5, 109, 0, 384+6005)
        $game_map.set_tile(6, 109, 0, 384+6006)
        $game_map.set_tile(7, 109, 0, 384+6005)
        $game_map.set_tile(8, 109, 0, 384+6006)
        $game_map.set_tile(9, 109, 0, 384+6005)
        $game_map.set_tile(10, 109, 0, 384+6006)
        $game_map.set_tile(11, 109, 0, 384+6005)
        $game_map.set_tile(12, 109, 0, 384+6006)
        $game_map.set_tile(5, 110, 0, 384+6013)
        $game_map.set_tile(6, 110, 0, 384+6014)
        $game_map.set_tile(7, 110, 0, 384+6013)
        $game_map.set_tile(8, 110, 0, 384+6014)
        $game_map.set_tile(9, 110, 0, 384+6013)
        $game_map.set_tile(10, 110, 0, 384+6014)
        $game_map.set_tile(11, 110, 0, 384+6013)
        $game_map.set_tile(12, 110, 0, 384+6014)
        $game_map.set_tile(5, 111, 0, 384+6005)
        $game_map.set_tile(6, 111, 0, 384+6006)
        $game_map.set_tile(7, 111, 0, 384+6005)
        $game_map.set_tile(8, 111, 0, 384+6006)
        $game_map.set_tile(9, 111, 0, 384+6005)
        $game_map.set_tile(10, 111, 0, 384+6006)
        $game_map.set_tile(11, 111, 0, 384+6005)
        $game_map.set_tile(12, 111, 0, 384+6006)
        $game_map.set_tile(5, 112, 0, 384+6013)
        $game_map.set_tile(6, 112, 0, 384+6014)
        $game_map.set_tile(7, 112, 0, 384+6013)
        $game_map.set_tile(8, 112, 0, 384+6014)
        $game_map.set_tile(9, 112, 0, 384+6013)
        $game_map.set_tile(10, 112, 0, 384+6014)
        $game_map.set_tile(11, 112, 0, 384+6013)
        $game_map.set_tile(12, 112, 0, 384+6014)
        $game_map.set_tile(5, 113, 0, 384+6005)
        $game_map.set_tile(6, 113, 0, 384+6006)
        $game_map.set_tile(7, 113, 0, 384+6005)
        $game_map.set_tile(8, 113, 0, 384+6006)
        $game_map.set_tile(9, 113, 0, 384+6005)
        $game_map.set_tile(10, 113, 0, 384+6006)
        $game_map.set_tile(11, 113, 0, 384+6005)
        $game_map.set_tile(12, 113, 0, 384+6006)
        $game_map.set_tile(5, 114, 0, 384+6013)
        $game_map.set_tile(6, 114, 0, 384+6014)
        $game_map.set_tile(7, 114, 0, 384+6013)
        $game_map.set_tile(8, 114, 0, 384+6014)
        $game_map.set_tile(9, 114, 0, 384+6013)
        $game_map.set_tile(10, 114, 0, 384+6014)
        $game_map.set_tile(11, 114, 0, 384+6013)
        $game_map.set_tile(12, 114, 0, 384+6014)
        $game_map.set_tile(5, 115, 0, 384+6005)
        $game_map.set_tile(6, 115, 0, 384+6006)
        $game_map.set_tile(7, 115, 0, 384+6005)
        $game_map.set_tile(8, 115, 0, 384+6006)
        $game_map.set_tile(9, 115, 0, 384+6005)
        $game_map.set_tile(10, 115, 0, 384+6006)
        $game_map.set_tile(11, 115, 0, 384+6005)
        $game_map.set_tile(12, 115, 0, 384+6006)
        
        # "little dot" rocks
        $game_map.set_tile(5, 109, 2, 384+1606)
        $game_map.set_tile(6, 114, 2, 384+1606)
        $game_map.set_tile(8, 110, 2, 384+1606)
        $game_map.set_tile(9, 110, 2, 384+1606)
        $game_map.set_tile(10, 110, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(5, 111, 2, 384+1661)
        $game_map.set_tile(5, 115, 2, 384+1661)
        $game_map.set_tile(9, 114, 2, 384+1661)
        $game_map.set_tile(10, 109, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(5, 113, 2, 384+1658)
        $game_map.set_tile(6, 112, 2, 384+1658)
        $game_map.set_tile(7, 109, 2, 384+1658)
        $game_map.set_tile(10, 115, 2, 384+1658)
        $game_map.set_tile(11, 109, 2, 384+1658)
        $game_map.set_tile(11, 113, 2, 384+1658)
        $game_map.set_tile(12, 113, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(6, 110, 2, 384+1651)
        $game_map.set_tile(7, 110, 2, 384+1652)
        $game_map.set_tile(6, 111, 2, 384+1659)
        $game_map.set_tile(7, 111, 2, 384+1660)
        
        $game_map.set_tile(11, 110, 2, 384+1651)
        $game_map.set_tile(12, 110, 2, 384+1652)
        $game_map.set_tile(11, 111, 2, 384+1659)
        $game_map.set_tile(12, 111, 2, 384+1660)
        
        $game_map.set_tile(11, 114, 2, 384+1651)
        $game_map.set_tile(12, 114, 2, 384+1652)
        $game_map.set_tile(11, 115, 2, 384+1659)
        $game_map.set_tile(12, 115, 2, 384+1660)
        
        # big rocks
        $game_map.set_tile(8, 111, 2, 384+1613)
        $game_map.set_tile(9, 111, 2, 384+1614)
        $game_map.set_tile(8, 112, 2, 384+1621)
        $game_map.set_tile(9, 112, 2, 384+1622)
        $game_map.set_tile(10, 112, 2, 384+1623)
        $game_map.set_tile(8, 113, 2, 384+1629)
        $game_map.set_tile(9, 113, 2, 384+1630)
        $game_map.set_tile(10, 113, 2, 384+1631)
        $game_map.set_tile(8, 114, 2, 384+1637)
        $game_map.set_tile(9, 114, 2, 384+1638)
        
      else
        
        # Layer 1 : grey background
        for j in 109..115 do
          for i in 5 ..12 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(5, 109, 1, 384+428)
        $game_map.set_tile(6, 109, 1, 384+429)
        $game_map.set_tile(7, 109, 1, 384+429)
        $game_map.set_tile(8, 109, 1, 384+429)
        $game_map.set_tile(9, 109, 1, 384+429)
        $game_map.set_tile(10, 109, 1, 384+429)
        $game_map.set_tile(11, 109, 1, 384+429)
        $game_map.set_tile(12, 109, 1, 384+431)
        $game_map.set_tile(5, 110, 1, 384+436)
        $game_map.set_tile(12, 110, 1, 384+439)
        $game_map.set_tile(5, 111, 1, 384+436)
        $game_map.set_tile(12, 111, 1, 384+439)
        $game_map.set_tile(5, 112, 1, 384+436)
        $game_map.set_tile(12, 112, 1, 384+439)
        $game_map.set_tile(5, 113, 1, 384+436)
        $game_map.set_tile(12, 113, 1, 384+439)
        $game_map.set_tile(5, 114, 1, 384+436)
        $game_map.set_tile(12, 114, 1, 384+439)
        $game_map.set_tile(5, 115, 1, 384+452)
        $game_map.set_tile(6, 115, 1, 384+453)
        $game_map.set_tile(7, 115, 1, 384+453)
        $game_map.set_tile(8, 115, 1, 384+453)
        $game_map.set_tile(9, 115, 1, 384+453)
        $game_map.set_tile(10, 115, 1, 384+453)
        $game_map.set_tile(11, 115, 1, 384+453)
        $game_map.set_tile(12, 115, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(5, 108, 2, 384+6313)
        $game_map.set_tile(6, 108, 2, 384+6314)
        $game_map.set_tile(7, 108, 2, 384+6314)
        $game_map.set_tile(8, 108, 2, 384+6314)
        $game_map.set_tile(9, 108, 2, 384+6314)
        $game_map.set_tile(10, 108, 2, 384+6314)
        $game_map.set_tile(11, 108, 2, 384+6314)
        $game_map.set_tile(12, 108, 2, 384+6315)
        $game_map.set_tile(5, 109, 2, 384+6321)
        $game_map.set_tile(6, 109, 2, 384+6322)
        $game_map.set_tile(7, 109, 2, 384+6322)
        $game_map.set_tile(8, 109, 2, 384+6322)
        $game_map.set_tile(9, 109, 2, 384+6322)
        $game_map.set_tile(10, 109, 2, 384+6322)
        $game_map.set_tile(11, 109, 2, 384+6322)
        $game_map.set_tile(12, 109, 2, 384+6323)
        $game_map.set_tile(5, 110, 2, 384+6329)
        $game_map.set_tile(12, 110, 2, 384+6331)
        $game_map.set_tile(5, 111, 2, 384+6329)
        $game_map.set_tile(12, 111, 2, 384+6331)
        $game_map.set_tile(5, 112, 2, 384+6329)
        $game_map.set_tile(12, 112, 2, 384+6331)
        $game_map.set_tile(5, 113, 2, 384+6329)
        $game_map.set_tile(12, 113, 2, 384+6331)
        $game_map.set_tile(5, 114, 2, 384+6337)
        $game_map.set_tile(6, 114, 2, 384+6338)
        $game_map.set_tile(7, 114, 2, 384+6338)
        $game_map.set_tile(8, 114, 2, 384+6338)
        $game_map.set_tile(9, 114, 2, 384+6338)
        $game_map.set_tile(10, 114, 2, 384+6338)
        $game_map.set_tile(11, 114, 2, 384+6338)
        $game_map.set_tile(12, 114, 2, 384+6339)
        $game_map.set_tile(5, 115, 2, 384+6345)
        $game_map.set_tile(6, 115, 2, 384+6346)
        $game_map.set_tile(7, 115, 2, 384+6346)
        $game_map.set_tile(8, 115, 2, 384+6346)
        $game_map.set_tile(9, 115, 2, 384+6346)
        $game_map.set_tile(10, 115, 2, 384+6346)
        $game_map.set_tile(11, 115, 2, 384+6346)
        $game_map.set_tile(12, 115, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(4, 108, 2, 384+6156)
        $game_map.set_tile(4, 109, 2, 384+6164)
        $game_map.set_tile(4, 114, 2, 384+6156)
        $game_map.set_tile(4, 115, 2, 384+6164)
        $game_map.set_tile(13, 108, 2, 384+6156)
        $game_map.set_tile(13, 109, 2, 384+6164)
        $game_map.set_tile(13, 114, 2, 384+6156)
        $game_map.set_tile(13, 115, 2, 384+6164)

      end
    end
  
  
    #=========================================================================
    # Cloth shop & market ( 27 & 38 & 51 )
    #=========================================================================
    # Gestion skins alternatifs stands marché
    if @buildings[27] > 2
      
      offset = @buildings[27] - 2
      
      # layer 1
      for j in 34..36 do
        for i in 3..5 do
          $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)+offset*24)
        end
      end
      for j in 39..41 do
        for i in 3..5 do
          $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)+offset*24)
        end
      end
      for j in 36..38 do
        for i in 8..10 do
          $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)+offset*24)
        end
      end
      for j in 41..43 do
        for i in 8..10 do
          $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)+offset*24)
        end
      end
    end
    
    # Gestion skins alternatifs magasin d'habits
    if @buildings[51] > 2
      
      offset = @buildings[51] - 2
      puts "offset"
      puts offset
      
      for j in 25..28 do
        for i in 3..6 do
          if ($game_map.get_tile(i, j, 1) > 0)
            $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)+16+offset*32)
          end
        end
      end
    end
    
    if @buildings[27] < 2
      # Booths cleanup
      for j in 34..42 do
        for i in 3..6 do
          $game_map.set_tile(i, j, 1, 0)
        end
      end
      
      for j in 36..44 do
        for i in 8..11 do
          $game_map.set_tile(i, j, 1, 0)
        end
      end
    end
    
    
    if @buildings[51] < 2
     
      # Layers 2 and 3 cleanup (3 ; 25) -> (6 ; 30) et.
      for k in 1..2 do
        for j in 25..30 do
          for i in 3..6 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
      end
      
      for j in 25..30 do
        $game_map.set_tile(2, j, 1, 0)
        $game_map.set_tile(7, j, 1, 0)
      end
      
      if @buildings[38] < 2
        
        # cracked ground
        $game_map.set_tile(2, 26, 0, 384+6005)
        $game_map.set_tile(3, 26, 0, 384+6006)
        $game_map.set_tile(4, 26, 0, 384+6005)
        $game_map.set_tile(5, 26, 0, 384+6006)
        $game_map.set_tile(6, 26, 0, 384+6005)
        $game_map.set_tile(2, 27, 0, 384+6013)
        $game_map.set_tile(3, 27, 0, 384+6014)
        $game_map.set_tile(4, 27, 0, 384+6013)
        $game_map.set_tile(5, 27, 0, 384+6014)
        $game_map.set_tile(6, 27, 0, 384+6013)
        $game_map.set_tile(2, 28, 0, 384+6005)
        $game_map.set_tile(3, 28, 0, 384+6006)
        $game_map.set_tile(4, 28, 0, 384+6005)
        $game_map.set_tile(5, 28, 0, 384+6006)
        $game_map.set_tile(6, 28, 0, 384+6005)
        $game_map.set_tile(2, 29, 0, 384+6013)
        $game_map.set_tile(3, 29, 0, 384+6014)
        $game_map.set_tile(4, 29, 0, 384+6013)
        $game_map.set_tile(5, 29, 0, 384+6014)
        $game_map.set_tile(6, 29, 0, 384+6013)
        
        
        # "little dot" rocks
        $game_map.set_tile(6, 28, 2, 384+1606) #cetait 4340
        
        # little grey rocks
        $game_map.set_tile(2, 26, 1, 384+1661)
        $game_map.set_tile(2, 26, 2, 384+1029) #tree fix
        
        # little brown rocks
        $game_map.set_tile(6, 29, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(5, 26, 2, 384+1651)
        $game_map.set_tile(6, 26, 2, 384+1652)
        $game_map.set_tile(5, 27, 2, 384+1659)
        $game_map.set_tile(6, 27, 2, 384+1660)
        
        # big rocks
        
        # construction hole
        $game_map.set_tile(2, 26, 1, 384+6044)
        $game_map.set_tile(3, 26, 1, 384+6045)
        $game_map.set_tile(4, 26, 1, 384+6046)
        $game_map.set_tile(5, 26, 1, 384+6047)
        $game_map.set_tile(2, 27, 1, 384+6052)
        $game_map.set_tile(3, 27, 1, 384+6053)
        $game_map.set_tile(4, 27, 1, 384+6054)
        $game_map.set_tile(5, 27, 1, 384+6055)
        $game_map.set_tile(2, 28, 1, 384+6060)
        $game_map.set_tile(3, 28, 1, 384+6061)
        $game_map.set_tile(4, 28, 1, 384+6062)
        $game_map.set_tile(5, 28, 1, 384+6063)
        $game_map.set_tile(2, 29, 1, 384+6068)
        $game_map.set_tile(3, 29, 1, 384+6069)
        $game_map.set_tile(4, 29, 1, 384+6070)
        $game_map.set_tile(5, 29, 1, 384+6071)
        
      else
        
        # Layer 1 : grey background
        for j in 26..29 do
          for i in 2 ..6 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
           
        # Layer 2 : white borders
        $game_map.set_tile(2, 26, 1, 384+428)
        $game_map.set_tile(3, 26, 1, 384+429)
        $game_map.set_tile(4, 26, 1, 384+429)
        $game_map.set_tile(5, 26, 1, 384+429)
        $game_map.set_tile(6, 26, 1, 384+431)
        $game_map.set_tile(2, 27, 1, 384+436)
        $game_map.set_tile(6, 27, 1, 384+439)
        $game_map.set_tile(2, 28, 1, 384+436)
        $game_map.set_tile(6, 28, 1, 384+439)
        $game_map.set_tile(2, 29, 0, 384+452) #layer 1 fix
        $game_map.set_tile(3, 29, 1, 384+453)
        $game_map.set_tile(4, 29, 1, 384+453)
        $game_map.set_tile(5, 29, 1, 384+453)
        $game_map.set_tile(6, 29, 1, 384+455)
        
        # Layer 2 : Tree fix
        $game_map.set_tile(2, 25, 1, 384+1005)
        $game_map.set_tile(2, 26, 2, 384+1013)
        
        $game_map.set_tile(2, 27, 1, 384+1005)
        $game_map.set_tile(2, 28, 1, 384+1013)
        
        $game_map.set_tile(2, 29, 1, 384+1005)
        $game_map.set_tile(2, 30, 1, 384+1013)
        
        # Layer 3 : mini walls
        $game_map.set_tile(2, 25, 2, 384+6313)
        $game_map.set_tile(3, 25, 2, 384+6314)
        $game_map.set_tile(4, 25, 2, 384+6314)
        $game_map.set_tile(5, 25, 2, 384+6314)
        $game_map.set_tile(6, 25, 2, 384+6315)
        $game_map.set_tile(2, 26, 1, 384+6321)
        $game_map.set_tile(3, 26, 2, 384+6322)
        $game_map.set_tile(4, 26, 2, 384+6322)
        $game_map.set_tile(5, 26, 2, 384+6322)
        $game_map.set_tile(6, 26, 2, 384+6323)
        $game_map.set_tile(2, 27, 2, 384+6329)
        $game_map.set_tile(6, 27, 2, 384+6331)
        $game_map.set_tile(2, 28, 2, 384+6337)
        $game_map.set_tile(3, 28, 2, 384+6338)
        $game_map.set_tile(4, 28, 2, 384+6338)
        $game_map.set_tile(5, 28, 2, 384+6338)
        $game_map.set_tile(6, 28, 2, 384+6339)
        $game_map.set_tile(2, 29, 2, 384+6345)
        $game_map.set_tile(3, 29, 2, 384+6346)
        $game_map.set_tile(4, 29, 2, 384+6346)
        $game_map.set_tile(5, 29, 2, 384+6346)
        $game_map.set_tile(6, 29, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(7, 25, 2, 384+6156)
        $game_map.set_tile(7, 26, 2, 384+6164)
        $game_map.set_tile(7, 28, 1, 384+6156)
        $game_map.set_tile(7, 29, 1, 384+6164)

      end
    end
  
  
    #=========================================================================
    # Gym exteriors ( 32 & 91 ) 
    #=========================================================================
    
    if @buildings[91] == 21
    
      #cleanup
        for j in 3..7 do
          for i in 18 ..27 do
            $game_map.set_tile(i, j, 2, 0)
          end
        end
        
        $game_map.set_tile(23, 8, 2, 0)
        $game_map.set_tile(23, 9, 2, 0)
        
        for j in 5..9 do
          for i in 18 ..27 do
            $game_map.set_tile(i, j, 1, 0)
          end
        end
      
        $game_map.set_tile(27, 3, 2, 384+13487) 
        $game_map.set_tile(15, 0, 1, 384+13378)
        $game_map.set_tile(16, 0, 1, 384+13379)  
        $game_map.set_tile(17, 0, 1, 384+13380)
        $game_map.set_tile(18, 0, 1, 384+13381)  
        $game_map.set_tile(19, 0, 1, 384+13382)
        $game_map.set_tile(20, 0, 1, 384+13383) 
        $game_map.set_tile(21, 0, 1, 384+13488)
        $game_map.set_tile(22, 0, 1, 384+13489)  
        $game_map.set_tile(23, 0, 1, 384+13490)
        $game_map.set_tile(24, 0, 1, 384+13491)  
        $game_map.set_tile(25, 0, 1, 384+13492)
        $game_map.set_tile(26, 0, 1, 384+13493)  
        $game_map.set_tile(27, 0, 1, 384+13494)
        $game_map.set_tile(27, 4, 2, 384+13495)  
        
        $game_map.set_tile(15, 1, 1, 384+13386)
        $game_map.set_tile(16, 1, 1, 384+13387)  
        $game_map.set_tile(17, 1, 1, 384+13388)
        $game_map.set_tile(18, 1, 1, 384+13389)  
        $game_map.set_tile(19, 1, 1, 384+13390)
        $game_map.set_tile(20, 1, 1, 384+13391)
        $game_map.set_tile(21, 1, 1, 384+13496)
        $game_map.set_tile(22, 1, 1, 384+13497)  
        $game_map.set_tile(23, 1, 1, 384+13498)
        $game_map.set_tile(24, 1, 1, 384+13499)  
        $game_map.set_tile(25, 1, 1, 384+13500)
        $game_map.set_tile(26, 1, 1, 384+13501)  
        $game_map.set_tile(27, 1, 1, 384+13502)
        $game_map.set_tile(27, 5, 2, 384+13503)  
        
        $game_map.set_tile(15, 2, 1, 384+13394)
        $game_map.set_tile(16, 2, 1, 384+13395)  
        $game_map.set_tile(17, 2, 1, 384+13396)
        $game_map.set_tile(18, 2, 1, 384+13397)  
        $game_map.set_tile(19, 2, 1, 384+13398)
        $game_map.set_tile(20, 2, 1, 384+13399)
        $game_map.set_tile(21, 2, 1, 384+13504)
        $game_map.set_tile(22, 2, 1, 384+13505)  
        $game_map.set_tile(23, 2, 1, 384+13506)
        $game_map.set_tile(24, 2, 1, 384+13507)  
        $game_map.set_tile(25, 2, 1, 384+13508)
        $game_map.set_tile(26, 2, 1, 384+13509)  
        $game_map.set_tile(27, 2, 1, 384+13510)
        $game_map.set_tile(27, 6, 2, 384+13511)  
        
        $game_map.set_tile(15, 3, 1, 384+13402)
        $game_map.set_tile(16, 3, 1, 384+13403)  
        $game_map.set_tile(17, 3, 1, 384+13404)
        $game_map.set_tile(18, 3, 1, 384+13405)  
        $game_map.set_tile(19, 3, 1, 384+13406)
        $game_map.set_tile(20, 3, 1, 384+13407) 
        $game_map.set_tile(21, 3, 1, 384+13512)
        $game_map.set_tile(22, 3, 1, 384+13513)  
        $game_map.set_tile(23, 3, 1, 384+13514)
        $game_map.set_tile(24, 3, 1, 384+13515)  
        $game_map.set_tile(25, 3, 1, 384+13516)
        $game_map.set_tile(26, 3, 1, 384+13517)  
        $game_map.set_tile(27, 3, 1, 384+13518)
        $game_map.set_tile(27, 7, 2, 384+13519)  
        
        $game_map.set_tile(15, 4, 1, 384+13410)
        $game_map.set_tile(16, 4, 1, 384+13411)  
        $game_map.set_tile(17, 4, 1, 384+13412)
        $game_map.set_tile(18, 4, 1, 384+13413)  
        $game_map.set_tile(19, 4, 1, 384+13414)
        $game_map.set_tile(20, 4, 1, 384+13415) 
        $game_map.set_tile(21, 4, 1, 384+13520)
        $game_map.set_tile(22, 4, 1, 384+13521)  
        $game_map.set_tile(23, 4, 1, 384+13522)
        $game_map.set_tile(24, 4, 1, 384+13523)  
        $game_map.set_tile(25, 4, 1, 384+13524)
        $game_map.set_tile(26, 4, 1, 384+13525)  
        $game_map.set_tile(27, 4, 1, 384+13526)
        $game_map.set_tile(28, 4, 1, 384+13527)  
        
        $game_map.set_tile(15, 5, 1, 384+13418)
        $game_map.set_tile(16, 5, 1, 384+13419)  
        $game_map.set_tile(17, 5, 1, 384+13420)
        $game_map.set_tile(18, 5, 1, 384+13421)  
        $game_map.set_tile(19, 5, 1, 384+13422)
        $game_map.set_tile(20, 5, 1, 384+13423)  
        $game_map.set_tile(21, 5, 1, 384+13528)
        $game_map.set_tile(22, 5, 1, 384+13529)  
        $game_map.set_tile(23, 5, 1, 384+13530)
        $game_map.set_tile(24, 5, 1, 384+13531)  
        $game_map.set_tile(25, 5, 1, 384+13532)
        $game_map.set_tile(26, 5, 1, 384+13533)  
        $game_map.set_tile(27, 5, 1, 384+13534)
        $game_map.set_tile(28, 5, 1, 384+13535)  
        
        $game_map.set_tile(15, 6, 1, 384+13426)
        $game_map.set_tile(16, 6, 1, 384+13427)  
        $game_map.set_tile(17, 6, 1, 384+13428)
        $game_map.set_tile(18, 6, 1, 384+13429)  
        $game_map.set_tile(19, 6, 1, 384+13430)
        $game_map.set_tile(20, 6, 1, 384+13431)  
        $game_map.set_tile(21, 6, 1, 384+13536)
        $game_map.set_tile(22, 6, 1, 384+13537)  
        $game_map.set_tile(23, 6, 1, 384+13538)
        $game_map.set_tile(24, 6, 1, 384+13539)  
        $game_map.set_tile(25, 6, 1, 384+13540)
        $game_map.set_tile(26, 6, 1, 384+13541)  
        $game_map.set_tile(27, 6, 1, 384+13542)
        $game_map.set_tile(28, 6, 1, 384+13543)  
        
        $game_map.set_tile(15, 7, 1, 384+13434)
        $game_map.set_tile(16, 7, 1, 384+13435)  
        $game_map.set_tile(17, 7, 1, 384+13436)
        $game_map.set_tile(18, 7, 1, 384+13437)  
        $game_map.set_tile(19, 7, 1, 384+13438)
        $game_map.set_tile(20, 7, 1, 384+13439)  
        $game_map.set_tile(21, 7, 1, 384+13544)
        $game_map.set_tile(22, 7, 1, 384+13545)  
        $game_map.set_tile(23, 7, 1, 384+13546)
        $game_map.set_tile(24, 7, 1, 384+13547)  
        $game_map.set_tile(25, 7, 1, 384+13548)
        $game_map.set_tile(26, 7, 1, 384+13549)  
        $game_map.set_tile(27, 7, 1, 384+13550)
        $game_map.set_tile(28, 7, 1, 384+13551)  
        
        $game_map.set_tile(15, 8, 1, 384+13442) 
        $game_map.set_tile(16, 8, 1, 384+13443)  
        $game_map.set_tile(17, 8, 1, 384+13444)
        $game_map.set_tile(18, 8, 1, 384+13445)  
        $game_map.set_tile(19, 8, 1, 384+13446)
        $game_map.set_tile(20, 8, 1, 384+13447)  
        $game_map.set_tile(21, 8, 1, 384+13552)
        $game_map.set_tile(22, 8, 1, 384+13553)  
        $game_map.set_tile(23, 8, 1, 384+13554)
        $game_map.set_tile(24, 8, 1, 384+13555)  
        $game_map.set_tile(25, 8, 1, 384+13556)
        $game_map.set_tile(26, 8, 1, 384+13557)  
        $game_map.set_tile(27, 8, 1, 384+13558) 
        $game_map.set_tile(28, 8, 1, 384+13559) 
        
        $game_map.set_tile(16, 9, 1, 384+13451)
        $game_map.set_tile(17, 9, 1, 384+13452)  
        $game_map.set_tile(18, 9, 1, 384+13453)
        $game_map.set_tile(19, 9, 1, 384+13454)  
        $game_map.set_tile(20, 9, 1, 384+13455)
        $game_map.set_tile(21, 9, 1, 384+13560)  
        $game_map.set_tile(22, 9, 1, 384+13561)
        $game_map.set_tile(23, 9, 1, 384+13562)  
        $game_map.set_tile(24, 9, 1, 384+13563)
        $game_map.set_tile(25, 9, 1, 384+13564)  
        $game_map.set_tile(26, 9, 1, 384+13565)
        $game_map.set_tile(27, 9, 1, 384+13566)  
        $game_map.set_tile(28, 9, 1, 384+13567) 
        
        $game_map.set_tile(16, 10, 1, 384+13459) 
        $game_map.set_tile(17, 10, 1, 384+13460)
        $game_map.set_tile(18, 10, 1, 384+13461)  
        $game_map.set_tile(19, 10, 1, 384+13462)
        $game_map.set_tile(20, 10, 1, 384+13463)  
        $game_map.set_tile(21, 10, 1, 384+13568)
        $game_map.set_tile(22, 10, 1, 384+13569)  
        $game_map.set_tile(23, 10, 1, 384+13570)
        $game_map.set_tile(24, 10, 1, 384+13571)  
        $game_map.set_tile(25, 10, 1, 384+13572)
        $game_map.set_tile(26, 10, 1, 384+13573)  
        $game_map.set_tile(27, 10, 1, 384+13574)
        $game_map.set_tile(28, 10, 1, 384+13575)
  
        $game_map.set_tile(17, 11, 1, 384+13468)
        $game_map.set_tile(18, 11, 1, 384+13469)  
        $game_map.set_tile(19, 11, 1, 384+13470)
        $game_map.set_tile(20, 11, 1, 384+13471)  
        $game_map.set_tile(21, 11, 1, 384+13576)
        $game_map.set_tile(22, 11, 1, 384+13577)  
        $game_map.set_tile(23, 11, 1, 384+13578)
        $game_map.set_tile(24, 11, 1, 384+13579)  
        $game_map.set_tile(25, 11, 1, 384+13580)
        $game_map.set_tile(26, 11, 1, 384+13581)  
        $game_map.set_tile(27, 11, 1, 384+13582)
        $game_map.set_tile(28, 11, 1, 384+13583)
        
        $game_map.set_tile(20, 8, 2, 384+13584)  
        $game_map.set_tile(21, 8, 2, 384+13585)
        $game_map.set_tile(22, 8, 2, 384+13586)
        
    else
      if @buildings[32] == 3
        
        #cleanup
        for j in 3..7 do
          for i in 18 ..27 do
            $game_map.set_tile(i, j, 2, 0)
          end
        end
        
        for j in 5..9 do
          for i in 18 ..27 do
            $game_map.set_tile(i, j, 1, 0)
          end
        end
      
        case $town.type
        when "Bug"
          offset = 0
        when "Dark"
          offset = 1
        when "Dragon"
          offset = 2
        when "Electric"
          offset = 3
        when "Fairy"
          offset = 4
        when "Fighting"
          offset = 5
        when "Fire"
          offset = 6
        when "Flying"
          offset = 7
        when "Ghost"
          offset = 8
        when "Grass"
          offset = 9
        when "Ground"
          offset = 10
        when "Ice"
          offset = 11
        when "Normal"
          offset = 12
        when "Poison"
          offset = 13
        when "Psychic"
          offset = 14
        when "Rock"
          offset = 15
        when "Steel"
          offset = 16
        else
          offset = 17
        end
          
        $game_map.set_tile(17, 6, 1, 384+7431)
        $game_map.set_tile(17, 7, 1, 384+7439)  
          
        $game_map.set_tile(19, 3, 2, 384+7449+offset*64)
        $game_map.set_tile(20, 3, 2, 384+7450+offset*64)
        $game_map.set_tile(21, 3, 2, 384+7451+offset*64)
        $game_map.set_tile(22, 3, 2, 384+7452+offset*64)
        $game_map.set_tile(23, 3, 2, 384+7453+offset*64)
        $game_map.set_tile(18, 4, 2, 384+7456+offset*64)
        $game_map.set_tile(19, 4, 2, 384+7457+offset*64)
        $game_map.set_tile(20, 4, 2, 384+7458+offset*64)
        $game_map.set_tile(21, 4, 2, 384+7459+offset*64)
        $game_map.set_tile(22, 4, 2, 384+7460+offset*64)
        $game_map.set_tile(23, 4, 2, 384+7461+offset*64)
        $game_map.set_tile(24, 4, 2, 384+7462+offset*64)
        $game_map.set_tile(18, 5, 1, 384+7464+offset*64)
        $game_map.set_tile(19, 5, 1, 384+7465+offset*64)
        $game_map.set_tile(20, 5, 1, 384+7466+offset*64)
        $game_map.set_tile(21, 5, 1, 384+7467+offset*64)
        $game_map.set_tile(22, 5, 1, 384+7468+offset*64)
        $game_map.set_tile(23, 5, 1, 384+7469+offset*64)
        $game_map.set_tile(24, 5, 1, 384+7470+offset*64)
        $game_map.set_tile(25, 5, 1, 384+7471+offset*64)
        $game_map.set_tile(18, 6, 1, 384+7472+offset*64)
        $game_map.set_tile(19, 6, 1, 384+7473+offset*64)
        $game_map.set_tile(20, 6, 1, 384+7474+offset*64)
        $game_map.set_tile(21, 6, 1, 384+7475+offset*64)
        $game_map.set_tile(22, 6, 1, 384+7476+offset*64)
        $game_map.set_tile(23, 6, 1, 384+7477+offset*64)
        $game_map.set_tile(24, 6, 1, 384+7478+offset*64)
        $game_map.set_tile(25, 6, 1, 384+7479+offset*64)
        $game_map.set_tile(18, 7, 1, 384+7480+offset*64)
        $game_map.set_tile(19, 7, 1, 384+7481+offset*64)
        $game_map.set_tile(20, 7, 1, 384+7482+offset*64)
        $game_map.set_tile(21, 7, 1, 384+7483+offset*64)
        $game_map.set_tile(22, 7, 1, 384+7484+offset*64)
        $game_map.set_tile(23, 7, 1, 384+7485+offset*64)
        $game_map.set_tile(24, 7, 1, 384+7486+offset*64)
        $game_map.set_tile(25, 7, 1, 384+7487+offset*64)
        $game_map.set_tile(18, 8, 1, 384+7488+offset*64)
        $game_map.set_tile(19, 8, 1, 384+7489+offset*64)
        $game_map.set_tile(20, 8, 1, 384+7490+offset*64)
        $game_map.set_tile(21, 8, 1, 384+7491+offset*64)
        $game_map.set_tile(22, 8, 1, 384+7492+offset*64)
        $game_map.set_tile(23, 8, 1, 384+7493+offset*64)
        $game_map.set_tile(24, 8, 1, 384+7494+offset*64)
        $game_map.set_tile(25, 8, 1, 384+7495+offset*64)
        $game_map.set_tile(19, 9, 1, 384+7497+offset*64)
        $game_map.set_tile(20, 9, 1, 384+7498+offset*64)
        $game_map.set_tile(21, 9, 1, 384+7499+offset*64)
        $game_map.set_tile(22, 9, 1, 384+7500+offset*64)
        $game_map.set_tile(23, 9, 1, 384+7501+offset*64)
        $game_map.set_tile(24, 9, 1, 384+7502+offset*64)  
          
        $game_map.set_tile(20, 7, 2, 384+7442+offset*64)
        $game_map.set_tile(21, 7, 2, 384+7443+offset*64)
        $game_map.set_tile(22, 7, 2, 384+7444+offset*64)
        
      end
    end
  
    #=========================================================================
    # NPC House 2 ( 36 & 47 )
    #=========================================================================
    
    # Gestion skins alternatifs
    if @buildings[47] > 2
      
      offset = @buildings[47] - 2
      puts "offset"
      puts offset
      
      for j in 56..59 do
        for i in 11..14 do
          if ($game_map.get_tile(i, j, 1) > 0)
            $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)+16+offset*32)
          end
        end
      end
      
      $game_map.set_tile(10, 57, 1, $game_map.get_tile(10, 57, 1)+16+offset*32)
      $game_map.set_tile(10, 58, 1, $game_map.get_tile(10, 58, 1)+16+offset*32)
      
      $game_map.set_tile(15, 57, 2, $game_map.get_tile(15, 57, 2)+16+offset*32)
      $game_map.set_tile(15, 58, 2, $game_map.get_tile(15, 58, 2)+16+offset*32)
      $game_map.set_tile(15, 59, 2, $game_map.get_tile(15, 59, 2)+16+offset*32)
      
      for i in 10..13 do
        $game_map.set_tile(i, 59, 2, $game_map.get_tile(i, 59, 2)+16+offset*32)
      end
    end
    
    if @buildings[47] < 2
     
      # Layers 2 and 3 cleanup (11 ; 56) -> (15 ; 61) & (9 ; 54) -> (15 ; 61)
      for j in 56..61 do
        for i in 11..15 do
          $game_map.set_tile(i, j, 1, 0)
        end
      end
      
      for j in 54..61 do
        for i in 9..15 do
          $game_map.set_tile(i, j, 2, 0)
        end
      end
      
      $game_map.set_tile(10, 57, 1, 0)
      $game_map.set_tile(10, 58, 1, 0)
      $game_map.set_tile(10, 59, 2, 0)
      $game_map.set_tile(10, 60, 2, 0)
      $game_map.set_tile(10, 61, 2, 0)
      
      $game_map.set_tile(15, 55, 1, 0)
      
      if @buildings[36] < 2
        
        # cracked ground
        $game_map.set_tile(11, 58, 0, 384+6005)
        $game_map.set_tile(12, 58, 0, 384+6006)
        $game_map.set_tile(13, 58, 0, 384+6005)
        $game_map.set_tile(14, 58, 0, 384+6006)
        $game_map.set_tile(11, 59, 0, 384+6013)
        $game_map.set_tile(12, 59, 0, 384+6014)
        $game_map.set_tile(13, 59, 0, 384+6013)
        $game_map.set_tile(14, 59, 0, 384+6014)
        $game_map.set_tile(11, 60, 0, 384+6005)
        $game_map.set_tile(12, 60, 0, 384+6006)
        $game_map.set_tile(13, 60, 0, 384+6005)
        $game_map.set_tile(14, 60, 0, 384+6006)
        
        
        # "little dot" rocks
        $game_map.set_tile(14, 60, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(13, 60, 2, 384+1661)
        $game_map.set_tile(14, 58, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(12, 58, 2, 384+1658)
        $game_map.set_tile(13, 59, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(11, 59, 2, 384+1651)
        $game_map.set_tile(12, 59, 2, 384+1652)
        $game_map.set_tile(11, 60, 2, 384+1659)
        $game_map.set_tile(12, 60, 2, 384+1660)
      
      else
        
        # Layer 1 : grey background
        for j in 58..60 do
          for i in 11..14 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(11, 58, 1, 384+428)
        $game_map.set_tile(12, 58, 1, 384+429)
        $game_map.set_tile(13, 58, 1, 384+429)
        $game_map.set_tile(14, 58, 1, 384+431)
        $game_map.set_tile(11, 59, 1, 384+436)
        $game_map.set_tile(14, 59, 1, 384+439)
        $game_map.set_tile(11, 60, 1, 384+452)
        $game_map.set_tile(12, 60, 1, 384+453)
        $game_map.set_tile(13, 60, 1, 384+453)
        $game_map.set_tile(14, 60, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(11, 57, 2, 384+6313)
        $game_map.set_tile(12, 57, 2, 384+6314)
        $game_map.set_tile(13, 57, 2, 384+6314)
        $game_map.set_tile(14, 57, 2, 384+6315)
        $game_map.set_tile(11, 58, 2, 384+6321)
        $game_map.set_tile(12, 58, 2, 384+6322)
        $game_map.set_tile(13, 58, 2, 384+6322)
        $game_map.set_tile(14, 58, 2, 384+6323)
        $game_map.set_tile(11, 59, 2, 384+6337)
        $game_map.set_tile(12, 59, 2, 384+6338)
        $game_map.set_tile(13, 59, 2, 384+6338)
        $game_map.set_tile(14, 59, 2, 384+6339)
        $game_map.set_tile(11, 60, 2, 384+6345)
        $game_map.set_tile(12, 60, 2, 384+6346)
        $game_map.set_tile(13, 60, 2, 384+6346)
        $game_map.set_tile(14, 60, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(15, 59, 2, 384+6156)
        $game_map.set_tile(15, 60, 2, 384+6164)
        
      end      
    end
  
  
    #=========================================================================
    # Casino ( 39 & 52 )
    #=========================================================================
    if @buildings[52] < 3
     
      # Layers 2 and 3 cleanup (35 ; 17) -> (41 ; 22)
      for k in 1..2 do
        for j in 17..22 do
          for i in 35..41 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
      end
      
      $game_map.set_tile(42, 19, 1, 0)
      $game_map.set_tile(42, 20, 1, 0)
      $game_map.set_tile(42, 21, 1, 0)
      $game_map.set_tile(42, 22, 1, 0)
      
      if @buildings[39] < 3
        
        # cracked ground
        $game_map.set_tile(35, 18, 0, 384+6005)
        $game_map.set_tile(36, 18, 0, 384+6006)
        $game_map.set_tile(37, 18, 0, 384+6005)
        $game_map.set_tile(38, 18, 0, 384+6006)
        $game_map.set_tile(39, 18, 0, 384+6005)
        $game_map.set_tile(40, 18, 0, 384+6006)
        $game_map.set_tile(41, 18, 0, 384+6005)
        $game_map.set_tile(35, 19, 0, 384+6013)
        $game_map.set_tile(36, 19, 0, 384+6014)
        $game_map.set_tile(37, 19, 0, 384+6013)
        $game_map.set_tile(38, 19, 0, 384+6014)
        $game_map.set_tile(39, 19, 0, 384+6013)
        $game_map.set_tile(40, 19, 0, 384+6014)
        $game_map.set_tile(41, 19, 0, 384+6013)
        $game_map.set_tile(35, 20, 0, 384+6005)
        $game_map.set_tile(36, 20, 0, 384+6006)
        $game_map.set_tile(37, 20, 0, 384+6005)
        $game_map.set_tile(38, 20, 0, 384+6006)
        $game_map.set_tile(39, 20, 0, 384+6005)
        $game_map.set_tile(40, 20, 0, 384+6006)
        $game_map.set_tile(41, 20, 0, 384+6005)
        $game_map.set_tile(35, 21, 0, 384+6013)
        $game_map.set_tile(36, 21, 0, 384+6014)
        $game_map.set_tile(37, 21, 0, 384+6013)
        $game_map.set_tile(38, 21, 0, 384+6014)
        $game_map.set_tile(39, 21, 0, 384+6013)
        $game_map.set_tile(40, 21, 0, 384+6014)
        $game_map.set_tile(41, 21, 0, 384+6013)
        
        
        # "little dot" rocks
        $game_map.set_tile(35, 18, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(37, 18, 2, 384+1661)
        $game_map.set_tile(41, 21, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(36, 19, 2, 384+1658)
        $game_map.set_tile(41, 20, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(35, 20, 2, 384+1651)
        $game_map.set_tile(36, 20, 2, 384+1652)
        $game_map.set_tile(35, 21, 2, 384+1659)
        $game_map.set_tile(36, 21, 2, 384+1660)
        
        $game_map.set_tile(40, 18, 2, 384+1651)
        $game_map.set_tile(41, 18, 2, 384+1652)
        $game_map.set_tile(40, 19, 2, 384+1659)
        $game_map.set_tile(41, 19, 2, 384+1660)
        
        # big rocks
        
        # construction hole
        $game_map.set_tile(37, 18, 1, 384+6044)
        $game_map.set_tile(38, 18, 1, 384+6045)
        $game_map.set_tile(39, 18, 1, 384+6046)
        $game_map.set_tile(40, 18, 1, 384+6047)
        $game_map.set_tile(37, 19, 1, 384+6052)
        $game_map.set_tile(38, 19, 1, 384+6053)
        $game_map.set_tile(39, 19, 1, 384+6054)
        $game_map.set_tile(40, 19, 1, 384+6055)
        $game_map.set_tile(37, 20, 1, 384+6060)
        $game_map.set_tile(38, 20, 1, 384+6061)
        $game_map.set_tile(39, 20, 1, 384+6062)
        $game_map.set_tile(40, 20, 1, 384+6063)
        $game_map.set_tile(37, 21, 1, 384+6068)
        $game_map.set_tile(38, 21, 1, 384+6069)
        $game_map.set_tile(39, 21, 1, 384+6070)
        $game_map.set_tile(40, 21, 1, 384+6071)
        
      else
        
        # Layer 1 : grey background (12 ; 18) -> (16 ; 21)
        for j in 18..21 do
          for i in 35 ..41 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(35, 18, 1, 384+428)
        $game_map.set_tile(36, 18, 1, 384+429)
        $game_map.set_tile(37, 18, 1, 384+429)
        $game_map.set_tile(38, 18, 1, 384+429)
        $game_map.set_tile(39, 18, 1, 384+429)
        $game_map.set_tile(40, 18, 1, 384+429)
        $game_map.set_tile(41, 18, 1, 384+431)
        $game_map.set_tile(35, 19, 1, 384+436)
        $game_map.set_tile(41, 19, 1, 384+439)
        $game_map.set_tile(35, 20, 1, 384+436)
        $game_map.set_tile(41, 20, 1, 384+439)
        $game_map.set_tile(35, 21, 1, 384+452)
        $game_map.set_tile(36, 21, 1, 384+453)
        $game_map.set_tile(37, 21, 1, 384+453)
        $game_map.set_tile(38, 21, 1, 384+453)
        $game_map.set_tile(39, 21, 1, 384+453)
        $game_map.set_tile(40, 21, 1, 384+453)
        $game_map.set_tile(41, 21, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(35, 17, 2, 384+6313)
        $game_map.set_tile(36, 17, 2, 384+6314)
        $game_map.set_tile(37, 17, 2, 384+6314)
        $game_map.set_tile(38, 17, 2, 384+6314)
        $game_map.set_tile(39, 17, 2, 384+6314)
        $game_map.set_tile(40, 17, 2, 384+6314)
        $game_map.set_tile(41, 17, 2, 384+6315)
        $game_map.set_tile(35, 18, 2, 384+6321)
        $game_map.set_tile(36, 18, 2, 384+6322)
        $game_map.set_tile(37, 18, 2, 384+6322)
        $game_map.set_tile(38, 18, 2, 384+6322)
        $game_map.set_tile(39, 18, 2, 384+6322)
        $game_map.set_tile(40, 18, 2, 384+6322)
        $game_map.set_tile(41, 18, 2, 384+6323)
        $game_map.set_tile(35, 19, 2, 384+6329)
        $game_map.set_tile(41, 19, 2, 384+6331)
        $game_map.set_tile(35, 20, 2, 384+6337)
        $game_map.set_tile(36, 20, 2, 384+6338)
        $game_map.set_tile(37, 20, 2, 384+6338)
        $game_map.set_tile(38, 20, 2, 384+6338)
        $game_map.set_tile(39, 20, 2, 384+6338)
        $game_map.set_tile(40, 20, 2, 384+6338)
        $game_map.set_tile(41, 20, 2, 384+6339)
        $game_map.set_tile(35, 21, 2, 384+6345)
        $game_map.set_tile(36, 21, 2, 384+6346)
        $game_map.set_tile(37, 21, 2, 384+6346)
        $game_map.set_tile(38, 21, 2, 384+6346)
        $game_map.set_tile(39, 21, 2, 384+6346)
        $game_map.set_tile(40, 21, 2, 384+6346)
        $game_map.set_tile(41, 21, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(34, 20, 2, 384+6156)
        $game_map.set_tile(34, 21, 2, 384+6164)
        $game_map.set_tile(42, 20, 1, 384+6156)
        $game_map.set_tile(42, 21, 1, 384+6164)
        
      end
    end
  
  
    #=========================================================================
    # Docks ( 40 & 53 & 96 )
    #=========================================================================
    
     # Gestion skins alternatifs
    if @buildings[53] > 4
      
      offset = @buildings[53] - 4
      puts "offset"
      puts offset
      
      for j in 99..106 do
        for i in 29..39 do
          if ($game_map.get_tile(i, j, 1) > 0)
            $game_map.set_tile(i, j, 1, $game_map.get_tile(i, j, 1)+offset*112)
          end
        end
      end
      
      for j in 102..104 do
        for i in 29..30 do
          if ($game_map.get_tile(i, j, 2) > 0)
            $game_map.set_tile(i, j, 2, $game_map.get_tile(i, j, 2)+offset*112)
          end
        end
      end
      
      for i in 33..35 do
        $game_map.set_tile(i, 98, 2, $game_map.get_tile(i, 98, 2)+offset*112)
        $game_map.set_tile(i, 105, 2, $game_map.get_tile(i, 105, 2)+offset*112)
      end
       
      $game_map.set_tile(38, 104, 2, $game_map.get_tile(38, 104, 2)+offset*112)
    end
    
    if @buildings[40] < 3
     
      #=======================================================================
      # Docks access
      #=======================================================================
      $game_map.set_tile(16, 100, 2, 384+6156)
      $game_map.set_tile(16, 101, 2, 384+6164)
      
      $game_map.set_tile(16, 99, 1, 384+6157)
      $game_map.set_tile(16, 100, 1, 384+6165)
      
      #=======================================================================
      # Docks objects
      #=======================================================================
      for j in 97..107 do
        for i in 18..42 do
          $game_map.set_tile(i, j, 2, 0)
        end
      end
      
      #=======================================================================
      # Dock house wrecked
      #=======================================================================
      
      # Layers 2 and 3 cleanup (29 ; 99) -> (38 ; 106)
        for k in 1..2 do
          for j in 99..106 do
            for i in 29..38 do
              $game_map.set_tile(i, j, k, 0)
            end
          end
        end
      
      # cracked ground
      $game_map.set_tile(30, 101, 0, 384+6005)
      $game_map.set_tile(31, 101, 0, 384+6006)
      $game_map.set_tile(32, 101, 0, 384+6005)
      $game_map.set_tile(33, 101, 0, 384+6006)
      $game_map.set_tile(34, 101, 0, 384+6005)
      $game_map.set_tile(35, 101, 0, 384+6006)
      $game_map.set_tile(36, 101, 0, 384+6005)
      $game_map.set_tile(37, 101, 0, 384+6006)
      $game_map.set_tile(38, 101, 0, 384+6005)
      $game_map.set_tile(30, 102, 0, 384+6013)
      $game_map.set_tile(31, 102, 0, 384+6014)
      $game_map.set_tile(32, 102, 0, 384+6013)
      $game_map.set_tile(33, 102, 0, 384+6014)
      $game_map.set_tile(34, 102, 0, 384+6013)
      $game_map.set_tile(35, 102, 0, 384+6014)
      $game_map.set_tile(36, 102, 0, 384+6013)
      $game_map.set_tile(37, 102, 0, 384+6014)
      $game_map.set_tile(38, 102, 0, 384+6013)
      $game_map.set_tile(30, 103, 0, 384+6005)
      $game_map.set_tile(31, 103, 0, 384+6006)
      $game_map.set_tile(32, 103, 0, 384+6005)
      $game_map.set_tile(33, 103, 0, 384+6006)
      $game_map.set_tile(34, 103, 0, 384+6005)
      $game_map.set_tile(35, 103, 0, 384+6006)
      $game_map.set_tile(36, 103, 0, 384+6005)
      $game_map.set_tile(37, 103, 0, 384+6006)
      $game_map.set_tile(38, 103, 0, 384+6005)
      $game_map.set_tile(30, 104, 0, 384+6013)
      $game_map.set_tile(31, 104, 0, 384+6014)
      $game_map.set_tile(32, 104, 0, 384+6013)
      $game_map.set_tile(33, 104, 0, 384+6014)
      $game_map.set_tile(34, 104, 0, 384+6013)
      $game_map.set_tile(35, 104, 0, 384+6014)
      $game_map.set_tile(36, 104, 0, 384+6013)
      $game_map.set_tile(37, 104, 0, 384+6014)
      $game_map.set_tile(38, 104, 0, 384+6013)
      $game_map.set_tile(30, 105, 0, 384+6005)
      $game_map.set_tile(31, 105, 0, 384+6006)
      $game_map.set_tile(32, 105, 0, 384+6005)
      $game_map.set_tile(33, 105, 0, 384+6006)
      $game_map.set_tile(34, 105, 0, 384+6005)
      $game_map.set_tile(35, 105, 0, 384+6006)
      $game_map.set_tile(36, 105, 0, 384+6005)
      $game_map.set_tile(37, 105, 0, 384+6006)
      $game_map.set_tile(38, 105, 0, 384+6005)
      
      
      # "little dot" rocks
      $game_map.set_tile(32, 103, 2, 384+1606)
      $game_map.set_tile(38, 102, 2, 384+1606)
      
      # little grey rocks
      $game_map.set_tile(30, 105, 2, 384+1661)
      $game_map.set_tile(38, 101, 2, 384+1661)
      
      # little brown rocks
      $game_map.set_tile(31, 104, 2, 384+1658)
      $game_map.set_tile(32, 101, 2, 384+1658)
      $game_map.set_tile(33, 102, 2, 384+1658)
      $game_map.set_tile(38, 103, 2, 384+1658)
      
      # middle rocks
      $game_map.set_tile(30, 101, 2, 384+1651)
      $game_map.set_tile(31, 101, 2, 384+1652)
      $game_map.set_tile(30, 102, 2, 384+1659)
      $game_map.set_tile(31, 102, 2, 384+1660)
      
      $game_map.set_tile(32, 104, 2, 384+1651)
      $game_map.set_tile(33, 104, 2, 384+1652)
      $game_map.set_tile(32, 105, 2, 384+1659)
      $game_map.set_tile(33, 105, 2, 384+1660)
      
      $game_map.set_tile(37, 104, 2, 384+1651)
      $game_map.set_tile(38, 104, 2, 384+1652)
      $game_map.set_tile(37, 105, 2, 384+1659)
      $game_map.set_tile(38, 105, 2, 384+1660)
      
      # big rocks
      
      # construction hole
      $game_map.set_tile(34, 101, 1, 384+6044)
      $game_map.set_tile(35, 101, 1, 384+6045)
      $game_map.set_tile(36, 101, 1, 384+6046)
      $game_map.set_tile(37, 101, 1, 384+6047)
      $game_map.set_tile(34, 102, 1, 384+6052)
      $game_map.set_tile(35, 102, 1, 384+6053)
      $game_map.set_tile(36, 102, 1, 384+6054)
      $game_map.set_tile(37, 102, 1, 384+6055)
      $game_map.set_tile(34, 103, 1, 384+6060)
      $game_map.set_tile(35, 103, 1, 384+6061)
      $game_map.set_tile(36, 103, 1, 384+6062)
      $game_map.set_tile(37, 103, 1, 384+6063)
      $game_map.set_tile(34, 104, 1, 384+6068)
      $game_map.set_tile(35, 104, 1, 384+6069)
      $game_map.set_tile(36, 104, 1, 384+6070)
      $game_map.set_tile(37, 104, 1, 384+6071)
      
      #=======================================================================
      # Boat
      #=======================================================================
      # Layers 2 and 3 cleanup (18 ; 108) -> (25 ; 115)
      for j in 107..111 do
        for i in 29..44 do
          $game_map.set_tile(i, j, 2, 0)
        end
      end

      for j in 112..114 do
        for i in 29..44 do
          $game_map.set_tile(i, j, 1, 0)
        end
      end
        
      for j in 114..115 do
        for i in 30..32 do
          $game_map.set_tile(i, j, 2, 0)
        end
      end
    
      #=======================================================================
      # Lighthouse wrecked
      #=======================================================================
      # Layers 2 and 3 cleanup (18 ; 108) -> (25 ; 115)
        for k in 1..2 do
          for j in 108..115 do
            for i in 18..25 do
              $game_map.set_tile(i, j, k, 0)
            end
          end
        end
        
        for i in 18..25 do
          $game_map.set_tile(i, 116, 1, 0)
        end
          
        for j in 105..107 do
          for i in 19..23 do
            $game_map.set_tile(i, j, 1, 0)
          end
        end
      
      # cracked ground
      $game_map.set_tile(18, 108, 0, 384+6005)
      $game_map.set_tile(19, 108, 0, 384+6006)
      $game_map.set_tile(20, 108, 0, 384+6005)
      $game_map.set_tile(21, 108, 0, 384+6006)
      $game_map.set_tile(22, 108, 0, 384+6005)
      $game_map.set_tile(23, 108, 0, 384+6006)
      $game_map.set_tile(24, 108, 0, 384+6005)
      $game_map.set_tile(18, 109, 0, 384+6013)
      $game_map.set_tile(19, 109, 0, 384+6014)
      $game_map.set_tile(20, 109, 0, 384+6013)
      $game_map.set_tile(21, 109, 0, 384+6014)
      $game_map.set_tile(22, 109, 0, 384+6013)
      $game_map.set_tile(23, 109, 0, 384+6014)
      $game_map.set_tile(24, 109, 0, 384+6013)
      $game_map.set_tile(18, 110, 0, 384+6005)
      $game_map.set_tile(19, 110, 0, 384+6006)
      $game_map.set_tile(20, 110, 0, 384+6005)
      $game_map.set_tile(21, 110, 0, 384+6006)
      $game_map.set_tile(22, 110, 0, 384+6005)
      $game_map.set_tile(23, 110, 0, 384+6006)
      $game_map.set_tile(24, 110, 0, 384+6005)
      $game_map.set_tile(18, 111, 0, 384+6013)
      $game_map.set_tile(19, 111, 0, 384+6014)
      $game_map.set_tile(20, 111, 0, 384+6013)
      $game_map.set_tile(21, 111, 0, 384+6014)
      $game_map.set_tile(22, 111, 0, 384+6013)
      $game_map.set_tile(23, 111, 0, 384+6014)
      $game_map.set_tile(24, 111, 0, 384+6013)
      $game_map.set_tile(18, 112, 0, 384+6005)
      $game_map.set_tile(19, 112, 0, 384+6006)
      $game_map.set_tile(20, 112, 0, 384+6005)
      $game_map.set_tile(21, 112, 0, 384+6006)
      $game_map.set_tile(22, 112, 0, 384+6005)
      $game_map.set_tile(23, 112, 0, 384+6006)
      $game_map.set_tile(24, 112, 0, 384+6005)
      $game_map.set_tile(18, 113, 0, 384+6013)
      $game_map.set_tile(19, 113, 0, 384+6014)
      $game_map.set_tile(20, 113, 0, 384+6013)
      $game_map.set_tile(21, 113, 0, 384+6014)
      $game_map.set_tile(22, 113, 0, 384+6013)
      $game_map.set_tile(23, 113, 0, 384+6014)
      $game_map.set_tile(24, 113, 0, 384+6013)
      $game_map.set_tile(18, 114, 0, 384+6005)
      $game_map.set_tile(19, 114, 0, 384+6006)
      $game_map.set_tile(20, 114, 0, 384+6005)
      $game_map.set_tile(21, 114, 0, 384+6006)
      $game_map.set_tile(22, 114, 0, 384+6005)
      $game_map.set_tile(23, 114, 0, 384+6006)
      $game_map.set_tile(24, 114, 0, 384+6005)
      $game_map.set_tile(18, 115, 0, 384+6013)
      $game_map.set_tile(19, 115, 0, 384+6014)
      $game_map.set_tile(20, 115, 0, 384+6013)
      $game_map.set_tile(21, 115, 0, 384+6014)
      $game_map.set_tile(22, 115, 0, 384+6013)
      $game_map.set_tile(23, 115, 0, 384+6014)
      $game_map.set_tile(24, 115, 0, 384+6013)
      $game_map.set_tile(18, 116, 0, 384+6005)
      $game_map.set_tile(19, 116, 0, 384+6006)
      $game_map.set_tile(20, 116, 0, 384+6005)
      $game_map.set_tile(21, 116, 0, 384+6006)
      $game_map.set_tile(22, 116, 0, 384+6005)
      $game_map.set_tile(23, 116, 0, 384+6006)
      $game_map.set_tile(24, 116, 0, 384+6005)
      
      
      # "little dot" rocks
      $game_map.set_tile(18, 114, 2, 384+1606)
      $game_map.set_tile(21, 113, 2, 384+1606)
      $game_map.set_tile(24, 108, 2, 384+1606)
      $game_map.set_tile(24, 116, 2, 384+1606)
      
      # little grey rocks
      $game_map.set_tile(19, 113, 2, 384+1661)
      $game_map.set_tile(23, 108, 2, 384+1661)
      $game_map.set_tile(24, 112, 2, 384+1661)
      
      # little brown rocks
      $game_map.set_tile(18, 112, 2, 384+1658)
      $game_map.set_tile(19, 111, 2, 384+1658)
      $game_map.set_tile(20, 116, 2, 384+1658)
      $game_map.set_tile(21, 108, 2, 384+1658)
      $game_map.set_tile(22, 116, 2, 384+1658)
      $game_map.set_tile(24, 109, 2, 384+1658)
      $game_map.set_tile(24, 111, 2, 384+1658)
      $game_map.set_tile(24, 114, 2, 384+1658)
      
      # middle rocks
      $game_map.set_tile(18, 109, 2, 384+1651)
      $game_map.set_tile(19, 109, 2, 384+1652)
      $game_map.set_tile(18, 110, 2, 384+1659)
      $game_map.set_tile(19, 110, 2, 384+1660)
      
      $game_map.set_tile(19, 114, 2, 384+1651)
      $game_map.set_tile(20, 114, 2, 384+1652)
      $game_map.set_tile(19, 115, 2, 384+1659)
      $game_map.set_tile(20, 115, 2, 384+1660)
      
      $game_map.set_tile(22, 113, 2, 384+1651)
      $game_map.set_tile(23, 113, 2, 384+1652)
      $game_map.set_tile(22, 114, 2, 384+1659)
      $game_map.set_tile(23, 114, 2, 384+1660)
      
      # big rocks
      
      # construction hole
      $game_map.set_tile(20, 109, 1, 384+6044)
      $game_map.set_tile(21, 109, 1, 384+6045)
      $game_map.set_tile(22, 109, 1, 384+6046)
      $game_map.set_tile(23, 109, 1, 384+6047)
      $game_map.set_tile(20, 110, 1, 384+6052)
      $game_map.set_tile(21, 110, 1, 384+6053)
      $game_map.set_tile(22, 110, 1, 384+6054)
      $game_map.set_tile(23, 110, 1, 384+6055)
      $game_map.set_tile(20, 111, 1, 384+6060)
      $game_map.set_tile(21, 111, 1, 384+6061)
      $game_map.set_tile(22, 111, 1, 384+6062)
      $game_map.set_tile(23, 111, 1, 384+6063)
      $game_map.set_tile(20, 112, 1, 384+6068)
      $game_map.set_tile(21, 112, 1, 384+6069)
      $game_map.set_tile(22, 112, 1, 384+6070)
      $game_map.set_tile(23, 112, 1, 384+6071)

    else
    
      if @buildings[53] < 4
        
        # Layers 2 and 3 cleanup (29 ; 99) -> (38 ; 106)
        for k in 1..2 do
          for j in 99..106 do
            for i in 29..38 do
              $game_map.set_tile(i, j, k, 0)
            end
          end
        end
        
        # Layer 1 : grey background 
        for j in 101..105 do
          for i in 30 ..38 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(30, 101, 1, 384+428)
        $game_map.set_tile(31, 101, 1, 384+429)
        $game_map.set_tile(32, 101, 1, 384+429)
        $game_map.set_tile(33, 101, 1, 384+429)
        $game_map.set_tile(34, 101, 1, 384+429)
        $game_map.set_tile(35, 101, 1, 384+429)
        $game_map.set_tile(36, 101, 1, 384+429)
        $game_map.set_tile(37, 101, 1, 384+429)
        $game_map.set_tile(38, 101, 1, 384+431)
        $game_map.set_tile(30, 102, 1, 384+436)
        $game_map.set_tile(38, 102, 1, 384+439)
        $game_map.set_tile(30, 103, 1, 384+436)
        $game_map.set_tile(38, 103, 1, 384+439)
        $game_map.set_tile(30, 104, 1, 384+436)
        $game_map.set_tile(38, 104, 1, 384+439)
        $game_map.set_tile(30, 105, 1, 384+452)
        $game_map.set_tile(31, 105, 1, 384+453)
        $game_map.set_tile(32, 105, 1, 384+453)
        $game_map.set_tile(33, 105, 1, 384+453)
        $game_map.set_tile(34, 105, 1, 384+453)
        $game_map.set_tile(35, 105, 1, 384+453)
        $game_map.set_tile(36, 105, 1, 384+453)
        $game_map.set_tile(37, 105, 1, 384+453)
        $game_map.set_tile(38, 105, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(30, 100, 2, 384+6313)
        $game_map.set_tile(31, 100, 2, 384+6314)
        $game_map.set_tile(32, 100, 2, 384+6314)
        $game_map.set_tile(33, 100, 2, 384+6314)
        $game_map.set_tile(34, 100, 2, 384+6314)
        $game_map.set_tile(35, 100, 2, 384+6314)
        $game_map.set_tile(36, 100, 2, 384+6314)
        $game_map.set_tile(37, 100, 2, 384+6314)
        $game_map.set_tile(38, 100, 2, 384+6315)
        $game_map.set_tile(30, 101, 2, 384+6321)
        $game_map.set_tile(31, 101, 2, 384+6322)
        $game_map.set_tile(32, 101, 2, 384+6322)
        $game_map.set_tile(33, 101, 2, 384+6322)
        $game_map.set_tile(34, 101, 2, 384+6322)
        $game_map.set_tile(35, 101, 2, 384+6322)
        $game_map.set_tile(36, 101, 2, 384+6322)
        $game_map.set_tile(37, 101, 2, 384+6322)
        $game_map.set_tile(38, 101, 2, 384+6323)
        $game_map.set_tile(30, 102, 2, 384+6329)
        $game_map.set_tile(38, 102, 2, 384+6331)
        $game_map.set_tile(30, 103, 2, 384+6329)
        $game_map.set_tile(38, 103, 2, 384+6331)
        $game_map.set_tile(30, 104, 2, 384+6337)
        $game_map.set_tile(31, 104, 2, 384+6338)
        $game_map.set_tile(32, 104, 2, 384+6338)
        $game_map.set_tile(33, 104, 2, 384+6338)
        $game_map.set_tile(34, 104, 2, 384+6338)
        $game_map.set_tile(35, 104, 2, 384+6338)
        $game_map.set_tile(36, 104, 2, 384+6338)
        $game_map.set_tile(37, 104, 2, 384+6338)
        $game_map.set_tile(38, 104, 2, 384+6339)
        $game_map.set_tile(30, 105, 2, 384+6345)
        $game_map.set_tile(31, 105, 2, 384+6346)
        $game_map.set_tile(32, 105, 2, 384+6346)
        $game_map.set_tile(33, 105, 2, 384+6346)
        $game_map.set_tile(34, 105, 2, 384+6346)
        $game_map.set_tile(35, 105, 2, 384+6346)
        $game_map.set_tile(36, 105, 2, 384+6346)
        $game_map.set_tile(37, 105, 2, 384+6346)
        $game_map.set_tile(38, 105, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(29, 104, 2, 384+6156)
        $game_map.set_tile(29, 105, 2, 384+6164)
        $game_map.set_tile(39, 104, 2, 384+6156)
        $game_map.set_tile(39, 105, 2, 384+6164)
        
        #=======================================================================
        # Boat
        #=======================================================================
        # Layers 2 and 3 cleanup (18 ; 108) -> (25 ; 115)
        for j in 107..111 do
          for i in 29..44 do
            $game_map.set_tile(i, j, 2, 0)
          end
        end
  
        for j in 112..114 do
          for i in 29..44 do
            $game_map.set_tile(i, j, 1, 0)
          end
        end
          
        for j in 114..115 do
          for i in 30..32 do
            $game_map.set_tile(i, j, 2, 0)
          end
        end
        
      end
  
        
      #=======================================================================
      # Lighthouse
      #=======================================================================
      if @buildings[96] < 9
        
        # Layers 2 and 3 cleanup (18 ; 108) -> (25 ; 115)
        for k in 1..2 do
          for j in 108..115 do
            for i in 18..25 do
              $game_map.set_tile(i, j, k, 0)
            end
          end
        end
        
        for i in 18..25 do
          $game_map.set_tile(i, 116, 1, 0)
        end
          
        for j in 105..107 do
          for i in 19..23 do
            $game_map.set_tile(i, j, 1, 0)
          end
        end
        
        # Layer 1 : grey background (12 ; 18) -> (16 ; 21)
        for j in 108..116 do
          for i in 18..24 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(18, 108, 1, 384+428)
        $game_map.set_tile(19, 108, 1, 384+429)
        $game_map.set_tile(20, 108, 1, 384+429)
        $game_map.set_tile(21, 108, 1, 384+429)
        $game_map.set_tile(22, 108, 1, 384+429)
        $game_map.set_tile(23, 108, 1, 384+429)
        $game_map.set_tile(24, 108, 1, 384+431)
        $game_map.set_tile(18, 109, 1, 384+436)
        $game_map.set_tile(24, 109, 1, 384+439)
        $game_map.set_tile(18, 110, 1, 384+436)
        $game_map.set_tile(24, 110, 1, 384+439)
        $game_map.set_tile(18, 111, 1, 384+436)
        $game_map.set_tile(24, 111, 1, 384+439)
        $game_map.set_tile(18, 112, 1, 384+436)
        $game_map.set_tile(24, 112, 1, 384+439)
        $game_map.set_tile(18, 113, 1, 384+436)
        $game_map.set_tile(24, 113, 1, 384+439)
        $game_map.set_tile(18, 114, 1, 384+436)
        $game_map.set_tile(24, 114, 1, 384+439)
        $game_map.set_tile(18, 115, 1, 384+436)
        $game_map.set_tile(24, 115, 1, 384+439)
        $game_map.set_tile(18, 116, 1, 384+452)
        $game_map.set_tile(19, 116, 1, 384+453)
        $game_map.set_tile(20, 116, 1, 384+453)
        $game_map.set_tile(21, 116, 1, 384+453)
        $game_map.set_tile(22, 116, 1, 384+453)
        $game_map.set_tile(23, 116, 1, 384+453)
        $game_map.set_tile(24, 116, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(18, 107, 2, 384+6313)
        $game_map.set_tile(19, 107, 2, 384+6314)
        $game_map.set_tile(20, 107, 2, 384+6314)
        $game_map.set_tile(21, 107, 2, 384+6314)
        $game_map.set_tile(22, 107, 2, 384+6314)
        $game_map.set_tile(23, 107, 2, 384+6314)
        $game_map.set_tile(24, 107, 2, 384+6315)
        $game_map.set_tile(18, 108, 2, 384+6321)
        $game_map.set_tile(19, 108, 2, 384+6322)
        $game_map.set_tile(20, 108, 2, 384+6322)
        $game_map.set_tile(21, 108, 2, 384+6322)
        $game_map.set_tile(22, 108, 2, 384+6322)
        $game_map.set_tile(23, 108, 2, 384+6322)
        $game_map.set_tile(24, 108, 2, 384+6323)
        $game_map.set_tile(18, 109, 2, 384+6329)
        $game_map.set_tile(24, 109, 2, 384+6331)
        $game_map.set_tile(18, 110, 2, 384+6329)
        $game_map.set_tile(24, 110, 2, 384+6331)
        $game_map.set_tile(18, 111, 2, 384+6329)
        $game_map.set_tile(24, 111, 2, 384+6331)
        $game_map.set_tile(18, 112, 2, 384+6329)
        $game_map.set_tile(24, 112, 2, 384+6331)
        $game_map.set_tile(18, 113, 2, 384+6329)
        $game_map.set_tile(24, 113, 2, 384+6331)
        $game_map.set_tile(18, 114, 2, 384+6329)
        $game_map.set_tile(24, 114, 2, 384+6331)
        $game_map.set_tile(18, 115, 2, 384+6337)
        $game_map.set_tile(19, 115, 2, 384+6338)
        $game_map.set_tile(20, 115, 2, 384+6338)
        $game_map.set_tile(21, 115, 2, 384+6338)
        $game_map.set_tile(22, 115, 2, 384+6338)
        $game_map.set_tile(23, 115, 2, 384+6338)
        $game_map.set_tile(24, 115, 2, 384+6339)
        $game_map.set_tile(18, 116, 2, 384+6345)
        $game_map.set_tile(19, 116, 2, 384+6346)
        $game_map.set_tile(20, 116, 2, 384+6346)
        $game_map.set_tile(21, 116, 2, 384+6346)
        $game_map.set_tile(22, 116, 2, 384+6346)
        $game_map.set_tile(23, 116, 2, 384+6346)
        $game_map.set_tile(24, 116, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(17, 107, 2, 384+6156)
        $game_map.set_tile(17, 108, 2, 384+6164)
        $game_map.set_tile(17, 115, 2, 384+6156)
        $game_map.set_tile(17, 116, 2, 384+6164)
        $game_map.set_tile(25, 107, 2, 384+6156)
        $game_map.set_tile(25, 108, 2, 384+6164)
        $game_map.set_tile(25, 115, 2, 384+6156)
        $game_map.set_tile(25, 116, 2, 384+6164)
    
      end
    end
  
  
    #=========================================================================
    # NPC House 3 ( 64 & 79 )
    #=========================================================================
    if @buildings[79] < 2
     
      # Layers 2 and 3 cleanup (36 ; 64) -> (39 ; 68)
      for k in 1..2 do
        for j in 64..68 do
          for i in 36..39 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
      end
      
      $game_map.set_tile(35, 64, 1, 0)
      $game_map.set_tile(35, 65, 1, 0)
      $game_map.set_tile(37, 63, 1, 0)
      $game_map.set_tile(38, 63, 1, 0)
      $game_map.set_tile(39, 63, 1, 0)
      $game_map.set_tile(40, 66, 1, 0)
      $game_map.set_tile(40, 67, 1, 0)
      $game_map.set_tile(40, 68, 1, 0)
      $game_map.set_tile(40, 67, 2, 0)
      $game_map.set_tile(40, 68, 2, 0)
      
      if @buildings[64] < 2
        
        # cracked ground
        $game_map.set_tile(36, 65, 0, 384+6005)
        $game_map.set_tile(37, 65, 0, 384+6006)
        $game_map.set_tile(38, 65, 0, 384+6005)
        $game_map.set_tile(39, 65, 0, 384+6006)
        $game_map.set_tile(36, 66, 0, 384+6013)
        $game_map.set_tile(37, 66, 0, 384+6014)
        $game_map.set_tile(38, 66, 0, 384+6013)
        $game_map.set_tile(39, 66, 0, 384+6014)
        $game_map.set_tile(36, 67, 0, 384+6005)
        $game_map.set_tile(37, 67, 0, 384+6006)
        $game_map.set_tile(38, 67, 0, 384+6005)
        $game_map.set_tile(39, 67, 0, 384+6006)
        
        
        # "little dot" rocks
        $game_map.set_tile(39, 65, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(36, 65, 2, 384+1661)
        $game_map.set_tile(38, 66, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(37, 65, 2, 384+1658)
        $game_map.set_tile(39, 67, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(36, 66, 2, 384+1651)
        $game_map.set_tile(37, 66, 2, 384+1652)
        $game_map.set_tile(36, 67, 2, 384+1659)
        $game_map.set_tile(37, 67, 2, 384+1660)
        
      else
        
        # Layer 1 : grey background
        for j in 66..68 do
            for i in 36..39 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(36, 66, 1, 384+428)
        $game_map.set_tile(37, 66, 1, 384+429)
        $game_map.set_tile(38, 66, 1, 384+429)
        $game_map.set_tile(39, 66, 1, 384+431)
        $game_map.set_tile(36, 67, 1, 384+436)
        $game_map.set_tile(39, 67, 1, 384+439)
        $game_map.set_tile(36, 68, 1, 384+452)
        $game_map.set_tile(37, 68, 1, 384+453)
        $game_map.set_tile(38, 68, 1, 384+453)
        $game_map.set_tile(39, 68, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(36, 65, 2, 384+6313)
        $game_map.set_tile(37, 65, 2, 384+6314)
        $game_map.set_tile(38, 65, 2, 384+6314)
        $game_map.set_tile(39, 65, 2, 384+6315)
        $game_map.set_tile(36, 66, 2, 384+6321)
        $game_map.set_tile(37, 66, 2, 384+6322)
        $game_map.set_tile(38, 66, 2, 384+6322)
        $game_map.set_tile(39, 66, 2, 384+6323)
        $game_map.set_tile(36, 67, 2, 384+6337)
        $game_map.set_tile(37, 67, 2, 384+6338)
        $game_map.set_tile(38, 67, 2, 384+6338)
        $game_map.set_tile(39, 67, 2, 384+6339)
        $game_map.set_tile(36, 68, 2, 384+6345)
        $game_map.set_tile(37, 68, 2, 384+6346)
        $game_map.set_tile(38, 68, 2, 384+6346)
        $game_map.set_tile(39, 68, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(40, 67, 1, 384+6156)
        $game_map.set_tile(40, 68, 1, 384+6164)
        
      end    
    end
  
  
    #=========================================================================
    # Battle café ( 54 & 69 )
    #=========================================================================
    if @buildings[69] < 4
     
      # Layers 2 and 3 cleanup (24 ; 44) -> (29 ; 50)
      for k in 1..2 do
        for j in 44..50 do
          for i in 24..28 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
      end
      
      for j in 44..48 do
        $game_map.set_tile(23, j, 2, 0)
      end
      
      for j in 47..50 do
        $game_map.set_tile(29, j, 1, 0)
        $game_map.set_tile(29, j, 2, 0)
      end
     
      for j in 46..48 do
        for i in 16..22 do
          $game_map.set_tile(i, j, 2, 0)
        end
      end
      
      if @buildings[54] < 3
        
        # cracked ground
        $game_map.set_tile(24, 46, 0, 384+6005)
        $game_map.set_tile(25, 46, 0, 384+6006)
        $game_map.set_tile(26, 46, 0, 384+6005)
        $game_map.set_tile(27, 46, 0, 384+6006)
        $game_map.set_tile(28, 46, 0, 384+6005)
        $game_map.set_tile(24, 47, 0, 384+6013)
        $game_map.set_tile(25, 47, 0, 384+6014)
        $game_map.set_tile(26, 47, 0, 384+6013)
        $game_map.set_tile(27, 47, 0, 384+6014)
        $game_map.set_tile(28, 47, 0, 384+6013)
        $game_map.set_tile(24, 48, 0, 384+6005)
        $game_map.set_tile(25, 48, 0, 384+6006)
        $game_map.set_tile(26, 48, 0, 384+6005)
        $game_map.set_tile(27, 48, 0, 384+6006)
        $game_map.set_tile(28, 48, 0, 384+6005)
        $game_map.set_tile(24, 49, 0, 384+6013)
        $game_map.set_tile(25, 49, 0, 384+6014)
        $game_map.set_tile(26, 49, 0, 384+6013)
        $game_map.set_tile(27, 49, 0, 384+6014)
        $game_map.set_tile(28, 49, 0, 384+6013)
        
        
        # "little dot" rocks
        $game_map.set_tile(26, 48, 2, 384+1606)
        $game_map.set_tile(28, 46, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(24, 46, 2, 384+1661)
        $game_map.set_tile(28, 49, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(25, 47, 2, 384+1658)
        $game_map.set_tile(28, 48, 2, 384+1658)
        $game_map.set_tile(19, 49, 2, 384+1658)
        $game_map.set_tile(16, 48, 2, 384+1658)
        $game_map.set_tile(21, 47, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(24, 48, 2, 384+1651)
        $game_map.set_tile(25, 48, 2, 384+1652)
        $game_map.set_tile(24, 49, 2, 384+1659)
        $game_map.set_tile(25, 49, 2, 384+1660)
        
        $game_map.set_tile(26, 46, 2, 384+1651)
        $game_map.set_tile(27, 46, 2, 384+1652)
        $game_map.set_tile(26, 47, 2, 384+1659)
        $game_map.set_tile(27, 47, 2, 384+1660)
        
      else
        
        # Layer 1 : grey background
        for j in 46..49 do
          for i in 24 ..28 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(24, 46, 1, 384+428)
        $game_map.set_tile(25, 46, 1, 384+429)
        $game_map.set_tile(26, 46, 1, 384+429)
        $game_map.set_tile(27, 46, 1, 384+429)
        $game_map.set_tile(28, 46, 1, 384+431)
        $game_map.set_tile(24, 47, 1, 384+436)
        $game_map.set_tile(28, 47, 1, 384+439)
        $game_map.set_tile(24, 48, 1, 384+436)
        $game_map.set_tile(28, 48, 1, 384+439)
        $game_map.set_tile(24, 49, 1, 384+452)
        $game_map.set_tile(25, 49, 1, 384+453)
        $game_map.set_tile(26, 49, 1, 384+453)
        $game_map.set_tile(27, 49, 1, 384+453)
        $game_map.set_tile(28, 49, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(24, 45, 2, 384+6313)
        $game_map.set_tile(25, 45, 2, 384+6314)
        $game_map.set_tile(26, 45, 2, 384+6314)
        $game_map.set_tile(27, 45, 2, 384+6314)
        $game_map.set_tile(28, 45, 2, 384+6315)
        $game_map.set_tile(24, 46, 2, 384+6321)
        $game_map.set_tile(25, 46, 2, 384+6322)
        $game_map.set_tile(26, 46, 2, 384+6322)
        $game_map.set_tile(27, 46, 2, 384+6322)
        $game_map.set_tile(28, 46, 2, 384+6323)
        $game_map.set_tile(24, 47, 2, 384+6329)
        $game_map.set_tile(28, 47, 2, 384+6331)
        $game_map.set_tile(24, 48, 2, 384+6337)
        $game_map.set_tile(25, 48, 2, 384+6338)
        $game_map.set_tile(26, 48, 2, 384+6338)
        $game_map.set_tile(27, 48, 2, 384+6338)
        $game_map.set_tile(28, 48, 2, 384+6339)
        $game_map.set_tile(24, 49, 2, 384+6345)
        $game_map.set_tile(25, 49, 2, 384+6346)
        $game_map.set_tile(26, 49, 2, 384+6346)
        $game_map.set_tile(27, 49, 2, 384+6346)
        $game_map.set_tile(28, 49, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(14, 48, 2, 384+6156)
        $game_map.set_tile(14, 49, 2, 384+6164)
        $game_map.set_tile(29, 48, 2, 384+6156)
        $game_map.set_tile(29, 49, 2, 384+6164)
       
      end
    end
    
    
    #=========================================================================
    # Block 2 ( 47 & 63 )
    #=========================================================================
    if @buildings[63] < 3
     
      # Layers 2 and 3 cleanup (3 ; 71) -> (9 ; 78)
      for k in 1..2 do
        for j in 72..78 do
          for i in 3..8 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
        for j in 75..78 do
          $game_map.set_tile(9, j, k, 0)
        end
      end
      
      $game_map.set_tile(3, 70, 2, 0)
      $game_map.set_tile(8, 70, 1, 0)
      $game_map.set_tile(3, 71, 2, 0)
      $game_map.set_tile(4, 71, 2, 0)
      $game_map.set_tile(5, 71, 2, 0)
      $game_map.set_tile(6, 71, 1, 0)
      $game_map.set_tile(7, 71, 1, 0)
      $game_map.set_tile(8, 71, 1, 0)
      $game_map.set_tile(3, 72, 1, 384+1036) #tree fix
      
      if @buildings[47] < 3
        
        # cracked ground
        $game_map.set_tile(3, 74, 0, 384+6005)
        $game_map.set_tile(4, 74, 0, 384+6006)
        $game_map.set_tile(5, 74, 0, 384+6005)
        $game_map.set_tile(6, 74, 0, 384+6006)
        $game_map.set_tile(7, 74, 0, 384+6005)
        $game_map.set_tile(8, 74, 0, 384+6006)
        $game_map.set_tile(3, 75, 0, 384+6013)
        $game_map.set_tile(4, 75, 0, 384+6014)
        $game_map.set_tile(5, 75, 0, 384+6013)
        $game_map.set_tile(6, 75, 0, 384+6014)
        $game_map.set_tile(7, 75, 0, 384+6013)
        $game_map.set_tile(8, 75, 0, 384+6014)
        $game_map.set_tile(3, 76, 0, 384+6005)
        $game_map.set_tile(4, 76, 0, 384+6006)
        $game_map.set_tile(5, 76, 0, 384+6005)
        $game_map.set_tile(6, 76, 0, 384+6006)
        $game_map.set_tile(7, 76, 0, 384+6005)
        $game_map.set_tile(8, 76, 0, 384+6006)
        $game_map.set_tile(3, 77, 0, 384+6013)
        $game_map.set_tile(4, 77, 0, 384+6014)
        $game_map.set_tile(5, 77, 0, 384+6013)
        $game_map.set_tile(6, 77, 0, 384+6014)
        $game_map.set_tile(7, 77, 0, 384+6013)
        $game_map.set_tile(8, 77, 0, 384+6014)
        
        # "little dot" rocks
        $game_map.set_tile(5, 76, 2, 384+1606)
        $game_map.set_tile(8, 75, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(4, 77, 2, 384+1661)
        $game_map.set_tile(7, 74, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(3, 75, 2, 384+1658)
        $game_map.set_tile(6, 77, 2, 384+1658)
        $game_map.set_tile(7, 76, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(4, 74, 2, 384+1651)
        $game_map.set_tile(5, 74, 2, 384+1652)
        $game_map.set_tile(4, 75, 2, 384+1659)
        $game_map.set_tile(5, 75, 2, 384+1660)
        
      else
              
        # Layer 1 : grey background
        for j in 74..77 do
          for i in 3..8 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(3, 74, 1, 384+428)
        $game_map.set_tile(4, 74, 1, 384+429)
        $game_map.set_tile(5, 74, 1, 384+429)
        $game_map.set_tile(6, 74, 1, 384+429)
        $game_map.set_tile(7, 74, 1, 384+429)
        $game_map.set_tile(8, 74, 1, 384+431)
        $game_map.set_tile(3, 75, 1, 384+436)
        $game_map.set_tile(8, 75, 1, 384+439)
        $game_map.set_tile(3, 76, 1, 384+436)
        $game_map.set_tile(8, 76, 1, 384+439)
        $game_map.set_tile(3, 77, 1, 384+452)
        $game_map.set_tile(4, 77, 1, 384+453)
        $game_map.set_tile(5, 77, 1, 384+453)
        $game_map.set_tile(6, 77, 1, 384+453)
        $game_map.set_tile(7, 77, 1, 384+453)
        $game_map.set_tile(8, 77, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(3, 73, 2, 384+6313)
        $game_map.set_tile(4, 73, 2, 384+6314)
        $game_map.set_tile(5, 73, 2, 384+6314)
        $game_map.set_tile(6, 73, 2, 384+6314)
        $game_map.set_tile(7, 73, 2, 384+6314)
        $game_map.set_tile(8, 73, 2, 384+6315)
        $game_map.set_tile(3, 74, 2, 384+6321)
        $game_map.set_tile(4, 74, 2, 384+6322)
        $game_map.set_tile(5, 74, 2, 384+6322)
        $game_map.set_tile(6, 74, 2, 384+6322)
        $game_map.set_tile(7, 74, 2, 384+6322)
        $game_map.set_tile(8, 74, 2, 384+6323)
        $game_map.set_tile(3, 75, 2, 384+6329)
        $game_map.set_tile(8, 75, 2, 384+6331)
        $game_map.set_tile(3, 76, 2, 384+6337)
        $game_map.set_tile(4, 76, 2, 384+6338)
        $game_map.set_tile(5, 76, 2, 384+6338)
        $game_map.set_tile(6, 76, 2, 384+6338)
        $game_map.set_tile(7, 76, 2, 384+6338)
        $game_map.set_tile(8, 76, 2, 384+6339)
        $game_map.set_tile(3, 77, 2, 384+6345)
        $game_map.set_tile(4, 77, 2, 384+6346)
        $game_map.set_tile(5, 77, 2, 384+6346)
        $game_map.set_tile(6, 77, 2, 384+6346)
        $game_map.set_tile(7, 77, 2, 384+6346)
        $game_map.set_tile(8, 77, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(2, 76, 1, 384+6156)
        $game_map.set_tile(2, 77, 1, 384+6164)
        $game_map.set_tile(9, 76, 1, 384+6156)
        $game_map.set_tile(9, 77, 1, 384+6164)
    
      end
    end
    
    #=========================================================================
    # Hotel ( 67 & 82 )
    #=========================================================================
    if @buildings[82] < 16
     
      # Layers 2 and 3 cleanup (17 ; 73) -> (25 ; 85)
      for k in 1..2 do
        for j in 73..85 do
          for i in 17..25 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
      end
      
      for j in 79..85 do
        $game_map.set_tile(15, j, 2, 0)
      end
      
      for j in 73..85 do
        $game_map.set_tile(16, j, 2, 0)
      end
          
      for j in 79..85 do
        $game_map.set_tile(26, j, 1, 0)
      end
      
      $game_map.set_tile(20, 72, 1, 0)
      $game_map.set_tile(21, 72, 1, 0)
      
      for j in 69..75 do
        for i in 17..28 do
          $game_map.set_tile(i, j, 2, 0)
        end
      end
      
      if @buildings[67] < 6
        
        # cracked ground
        $game_map.set_tile(16, 77, 0, 384+6005)
        $game_map.set_tile(17, 77, 0, 384+6006)
        $game_map.set_tile(18, 77, 0, 384+6005)
        $game_map.set_tile(19, 77, 0, 384+6006)
        $game_map.set_tile(20, 77, 0, 384+6005)
        $game_map.set_tile(21, 77, 0, 384+6006)
        $game_map.set_tile(22, 77, 0, 384+6005)
        $game_map.set_tile(23, 77, 0, 384+6006)
        $game_map.set_tile(24, 77, 0, 384+6005)
        $game_map.set_tile(25, 77, 0, 384+6006)
        $game_map.set_tile(16, 78, 0, 384+6013)
        $game_map.set_tile(17, 78, 0, 384+6014)
        $game_map.set_tile(18, 78, 0, 384+6013)
        $game_map.set_tile(19, 78, 0, 384+6014)
        $game_map.set_tile(20, 78, 0, 384+6013)
        $game_map.set_tile(21, 78, 0, 384+6014)
        $game_map.set_tile(22, 78, 0, 384+6013)
        $game_map.set_tile(23, 78, 0, 384+6014)
        $game_map.set_tile(24, 78, 0, 384+6013)
        $game_map.set_tile(25, 78, 0, 384+6014)
        $game_map.set_tile(16, 79, 0, 384+6005)
        $game_map.set_tile(17, 79, 0, 384+6006)
        $game_map.set_tile(18, 79, 0, 384+6005)
        $game_map.set_tile(19, 79, 0, 384+6006)
        $game_map.set_tile(20, 79, 0, 384+6005)
        $game_map.set_tile(21, 79, 0, 384+6006)
        $game_map.set_tile(22, 79, 0, 384+6005)
        $game_map.set_tile(23, 79, 0, 384+6006)
        $game_map.set_tile(24, 79, 0, 384+6005)
        $game_map.set_tile(25, 79, 0, 384+6006)
        $game_map.set_tile(16, 80, 0, 384+6013)
        $game_map.set_tile(17, 80, 0, 384+6014)
        $game_map.set_tile(18, 80, 0, 384+6013)
        $game_map.set_tile(19, 80, 0, 384+6014)
        $game_map.set_tile(20, 80, 0, 384+6013)
        $game_map.set_tile(21, 80, 0, 384+6014)
        $game_map.set_tile(22, 80, 0, 384+6013)
        $game_map.set_tile(23, 80, 0, 384+6014)
        $game_map.set_tile(24, 80, 0, 384+6013)
        $game_map.set_tile(25, 80, 0, 384+6014)
        $game_map.set_tile(16, 81, 0, 384+6005)
        $game_map.set_tile(17, 81, 0, 384+6006)
        $game_map.set_tile(18, 81, 0, 384+6005)
        $game_map.set_tile(19, 81, 0, 384+6006)
        $game_map.set_tile(20, 81, 0, 384+6005)
        $game_map.set_tile(21, 81, 0, 384+6006)
        $game_map.set_tile(22, 81, 0, 384+6005)
        $game_map.set_tile(23, 81, 0, 384+6006)
        $game_map.set_tile(24, 81, 0, 384+6005)
        $game_map.set_tile(25, 81, 0, 384+6006)
        $game_map.set_tile(16, 82, 0, 384+6013)
        $game_map.set_tile(17, 82, 0, 384+6014)
        $game_map.set_tile(18, 82, 0, 384+6013)
        $game_map.set_tile(19, 82, 0, 384+6014)
        $game_map.set_tile(20, 82, 0, 384+6013)
        $game_map.set_tile(21, 82, 0, 384+6014)
        $game_map.set_tile(22, 82, 0, 384+6013)
        $game_map.set_tile(23, 82, 0, 384+6014)
        $game_map.set_tile(24, 82, 0, 384+6013)
        $game_map.set_tile(25, 82, 0, 384+6014)
        $game_map.set_tile(16, 83, 0, 384+6005)
        $game_map.set_tile(17, 83, 0, 384+6006)
        $game_map.set_tile(18, 83, 0, 384+6005)
        $game_map.set_tile(19, 83, 0, 384+6006)
        $game_map.set_tile(20, 83, 0, 384+6005)
        $game_map.set_tile(21, 83, 0, 384+6006)
        $game_map.set_tile(22, 83, 0, 384+6005)
        $game_map.set_tile(23, 83, 0, 384+6006)
        $game_map.set_tile(24, 83, 0, 384+6005)
        $game_map.set_tile(25, 83, 0, 384+6006)
        $game_map.set_tile(16, 84, 0, 384+6013)
        $game_map.set_tile(17, 84, 0, 384+6014)
        $game_map.set_tile(18, 84, 0, 384+6013)
        $game_map.set_tile(19, 84, 0, 384+6014)
        $game_map.set_tile(20, 84, 0, 384+6013)
        $game_map.set_tile(21, 84, 0, 384+6014)
        $game_map.set_tile(22, 84, 0, 384+6013)
        $game_map.set_tile(23, 84, 0, 384+6014)
        $game_map.set_tile(24, 84, 0, 384+6013)
        $game_map.set_tile(25, 84, 0, 384+6014)
        
        # "little dot" rocks
        $game_map.set_tile(17, 77, 2, 384+1606)
        $game_map.set_tile(17, 79, 2, 384+1606)
        $game_map.set_tile(19, 83, 2, 384+1606)
        $game_map.set_tile(24, 79, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(17, 84, 2, 384+1661)
        $game_map.set_tile(18, 77, 2, 384+1661)
        $game_map.set_tile(22, 78, 2, 384+1661)
        $game_map.set_tile(25, 80, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(16, 79, 2, 384+1658)
        $game_map.set_tile(16, 83, 2, 384+1658)
        $game_map.set_tile(19, 81, 2, 384+1658)
        $game_map.set_tile(22, 84, 2, 384+1658)
        $game_map.set_tile(23, 77, 2, 384+1658)
        $game_map.set_tile(25, 82, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(17, 81, 2, 384+1651)
        $game_map.set_tile(18, 81, 2, 384+1652)
        $game_map.set_tile(17, 82, 2, 384+1659)
        $game_map.set_tile(18, 82, 2, 384+1660)
        
        $game_map.set_tile(23, 83, 2, 384+1651)
        $game_map.set_tile(24, 83, 2, 384+1652)
        $game_map.set_tile(23, 84, 2, 384+1659)
        $game_map.set_tile(24, 84, 2, 384+1660)
        
        $game_map.set_tile(24, 77, 2, 384+1651)
        $game_map.set_tile(25, 77, 2, 384+1652)
        $game_map.set_tile(24, 78, 2, 384+1659)
        $game_map.set_tile(25, 78, 2, 384+1660)
        
        # big rocks
        $game_map.set_tile(19, 77, 2, 384+1613)
        $game_map.set_tile(20, 77, 2, 384+1614)
        $game_map.set_tile(19, 78, 2, 384+1621)
        $game_map.set_tile(20, 78, 2, 384+1622)
        $game_map.set_tile(21, 78, 2, 384+1623)
        $game_map.set_tile(19, 79, 2, 384+1629)
        $game_map.set_tile(20, 79, 2, 384+1630)
        $game_map.set_tile(21, 79, 2, 384+1631)
        $game_map.set_tile(19, 80, 2, 384+1637)
        $game_map.set_tile(20, 80, 2, 384+1638)
        
        # construction hole
        $game_map.set_tile(20, 79, 1, 384+6044)
        $game_map.set_tile(21, 79, 1, 384+6045)
        $game_map.set_tile(22, 79, 1, 384+6046)
        $game_map.set_tile(23, 79, 1, 384+6047)
        $game_map.set_tile(20, 80, 1, 384+6052)
        $game_map.set_tile(21, 80, 1, 384+6053)
        $game_map.set_tile(22, 80, 1, 384+6054)
        $game_map.set_tile(23, 80, 1, 384+6055)
        $game_map.set_tile(20, 81, 1, 384+6060)
        $game_map.set_tile(21, 81, 1, 384+6061)
        $game_map.set_tile(22, 81, 1, 384+6062)
        $game_map.set_tile(23, 81, 1, 384+6063)
        $game_map.set_tile(20, 82, 1, 384+6068)
        $game_map.set_tile(21, 82, 1, 384+6069)
        $game_map.set_tile(22, 82, 1, 384+6070)
        $game_map.set_tile(23, 82, 1, 384+6071)
        
      else
              
        # Layer 1 : grey background
        for j in 77..84 do
          for i in 16..25 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(16, 77, 1, 384+428)
        $game_map.set_tile(17, 77, 1, 384+429)
        $game_map.set_tile(18, 77, 1, 384+429)
        $game_map.set_tile(19, 77, 1, 384+429)
        $game_map.set_tile(20, 77, 1, 384+429)
        $game_map.set_tile(21, 77, 1, 384+429)
        $game_map.set_tile(22, 77, 1, 384+429)
        $game_map.set_tile(23, 77, 1, 384+429)
        $game_map.set_tile(24, 77, 1, 384+429)
        $game_map.set_tile(25, 77, 1, 384+431)
        $game_map.set_tile(16, 78, 1, 384+436)
        $game_map.set_tile(25, 78, 1, 384+439)
        $game_map.set_tile(16, 79, 1, 384+436)
        $game_map.set_tile(25, 79, 1, 384+439)
        $game_map.set_tile(16, 80, 1, 384+436)
        $game_map.set_tile(25, 80, 1, 384+439)
        $game_map.set_tile(16, 81, 1, 384+436)
        $game_map.set_tile(25, 81, 1, 384+439)
        $game_map.set_tile(16, 82, 1, 384+436)
        $game_map.set_tile(25, 82, 1, 384+439)
        $game_map.set_tile(16, 83, 1, 384+436)
        $game_map.set_tile(25, 83, 1, 384+439)
        $game_map.set_tile(16, 84, 1, 384+452)
        $game_map.set_tile(17, 84, 1, 384+453)
        $game_map.set_tile(18, 84, 1, 384+453)
        $game_map.set_tile(19, 84, 1, 384+453)
        $game_map.set_tile(20, 84, 1, 384+453)
        $game_map.set_tile(21, 84, 1, 384+453)
        $game_map.set_tile(22, 84, 1, 384+453)
        $game_map.set_tile(23, 84, 1, 384+453)
        $game_map.set_tile(24, 84, 1, 384+453)
        $game_map.set_tile(25, 84, 1, 384+455)
        
        # Layer 2 : Tree fix
        $game_map.set_tile(16, 76, 1, 384+1005)
        $game_map.set_tile(16, 77, 1, 384+1013)
        
        $game_map.set_tile(16, 78, 1, 384+1005)
        $game_map.set_tile(16, 79, 1, 384+1013)
        
        $game_map.set_tile(16, 80, 1, 384+1005)
        $game_map.set_tile(16, 81, 1, 384+1013)
        
        # Layer 3 : mini walls
        $game_map.set_tile(16, 76, 2, 384+6313)
        $game_map.set_tile(17, 76, 2, 384+6314)
        $game_map.set_tile(18, 76, 2, 384+6314)
        $game_map.set_tile(19, 76, 2, 384+6314)
        $game_map.set_tile(20, 76, 2, 384+6314)
        $game_map.set_tile(21, 76, 2, 384+6314)
        $game_map.set_tile(22, 76, 2, 384+6314)
        $game_map.set_tile(23, 76, 2, 384+6314)
        $game_map.set_tile(24, 76, 2, 384+6314)
        $game_map.set_tile(25, 76, 2, 384+6315)
        $game_map.set_tile(16, 77, 2, 384+6321)
        $game_map.set_tile(17, 77, 2, 384+6322)
        $game_map.set_tile(18, 77, 2, 384+6322)
        $game_map.set_tile(19, 77, 2, 384+6322)
        $game_map.set_tile(20, 77, 2, 384+6322)
        $game_map.set_tile(21, 77, 2, 384+6322)
        $game_map.set_tile(22, 77, 2, 384+6322)
        $game_map.set_tile(23, 77, 2, 384+6322)
        $game_map.set_tile(24, 77, 2, 384+6322)
        $game_map.set_tile(25, 77, 2, 384+6323)
        $game_map.set_tile(16, 78, 2, 384+6329)
        $game_map.set_tile(25, 78, 2, 384+6331)
        $game_map.set_tile(16, 79, 2, 384+6329)
        $game_map.set_tile(25, 79, 2, 384+6331)
        $game_map.set_tile(16, 80, 2, 384+6329)
        $game_map.set_tile(25, 80, 2, 384+6331)
        $game_map.set_tile(16, 81, 2, 384+6329)
        $game_map.set_tile(25, 81, 2, 384+6331)
        $game_map.set_tile(16, 82, 2, 384+6329)
        $game_map.set_tile(25, 82, 2, 384+6331)
        $game_map.set_tile(16, 83, 2, 384+6337)
        $game_map.set_tile(17, 83, 2, 384+6338)
        $game_map.set_tile(18, 83, 2, 384+6338)
        $game_map.set_tile(19, 83, 2, 384+6338)
        $game_map.set_tile(20, 83, 2, 384+6338)
        $game_map.set_tile(21, 83, 2, 384+6338)
        $game_map.set_tile(22, 83, 2, 384+6338)
        $game_map.set_tile(23, 83, 2, 384+6338)
        $game_map.set_tile(24, 83, 2, 384+6338)
        $game_map.set_tile(25, 83, 2, 384+6339)
        $game_map.set_tile(16, 84, 2, 384+6345)
        $game_map.set_tile(17, 84, 2, 384+6346)
        $game_map.set_tile(18, 84, 2, 384+6346)
        $game_map.set_tile(19, 84, 2, 384+6346)
        $game_map.set_tile(20, 84, 2, 384+6346)
        $game_map.set_tile(21, 84, 2, 384+6346)
        $game_map.set_tile(22, 84, 2, 384+6346)
        $game_map.set_tile(23, 84, 2, 384+6346)
        $game_map.set_tile(24, 84, 2, 384+6346)
        $game_map.set_tile(25, 84, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(15, 83, 1, 384+6156)
        $game_map.set_tile(15, 84, 1, 384+6164)
        $game_map.set_tile(26, 83, 1, 384+6156)
        $game_map.set_tile(26, 84, 1, 384+6164)
  
      end
    end
    
    #=========================================================================
    # NPC House 4 ( 80 & 93 )
    #=========================================================================
    if @buildings[93] < 2
     
      # Layers 2 and 3 cleanup (3 ; 88) -> (6 ; 92)
      for k in 1..2 do
        for j in 89..92 do
          for i in 3..6 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
      end
      
      $game_map.set_tile(2, 89, 2, 0)
      $game_map.set_tile(2, 90, 2, 0)
      
      $game_map.set_tile(7, 90, 1, 0)
      $game_map.set_tile(7, 91, 1, 0)
      $game_map.set_tile(7, 92, 1, 0)
      
      $game_map.set_tile(3, 87, 2, 0)
      $game_map.set_tile(4, 87, 2, 0)
      $game_map.set_tile(5, 87, 2, 0)
      $game_map.set_tile(6, 87, 2, 0)
      $game_map.set_tile(2, 88, 2, 0)
      $game_map.set_tile(3, 88, 2, 0)
      $game_map.set_tile(4, 88, 1, 0)
      $game_map.set_tile(5, 88, 1, 0)
      $game_map.set_tile(6, 88, 2, 0)
      $game_map.set_tile(7, 91, 2, 0)
      $game_map.set_tile(7, 92, 2, 0)
      
      if @buildings[80] < 2
        
        # cracked ground
        $game_map.set_tile(3, 89, 0, 384+6005)
        $game_map.set_tile(4, 89, 0, 384+6006)
        $game_map.set_tile(5, 89, 0, 384+6005)
        $game_map.set_tile(6, 89, 0, 384+6006)
        $game_map.set_tile(3, 90, 0, 384+6013)
        $game_map.set_tile(4, 90, 0, 384+6014)
        $game_map.set_tile(5, 90, 0, 384+6013)
        $game_map.set_tile(6, 90, 0, 384+6014)
        $game_map.set_tile(3, 91, 0, 384+6005)
        $game_map.set_tile(4, 91, 0, 384+6006)
        $game_map.set_tile(5, 91, 0, 384+6005)
        $game_map.set_tile(6, 91, 0, 384+6006)
        
        # "little dot" rocks
        $game_map.set_tile(3, 91, 2, 384+1606)
        $game_map.set_tile(5, 91, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(3, 89, 2, 384+1661)
        $game_map.set_tile(6, 91, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(4, 90, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(5, 89, 2, 384+1651)
        $game_map.set_tile(6, 89, 2, 384+1652)
        $game_map.set_tile(5, 90, 2, 384+1659)
        $game_map.set_tile(6, 90, 2, 384+1660)
        
      else
              
        # Layer 1 : grey background
        for j in 89..91 do
          for i in 3..6 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(3, 89, 1, 384+428)
        $game_map.set_tile(4, 89, 1, 384+429)
        $game_map.set_tile(5, 89, 1, 384+429)
        $game_map.set_tile(6, 89, 1, 384+431)
        $game_map.set_tile(3, 90, 1, 384+436)
        $game_map.set_tile(6, 90, 1, 384+439)
        $game_map.set_tile(3, 91, 1, 384+452)
        $game_map.set_tile(4, 91, 1, 384+453)
        $game_map.set_tile(5, 91, 1, 384+453)
        $game_map.set_tile(6, 91, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(3, 88, 2, 384+6313)
        $game_map.set_tile(4, 88, 2, 384+6314)
        $game_map.set_tile(5, 88, 2, 384+6314)
        $game_map.set_tile(6, 88, 2, 384+6315)
        $game_map.set_tile(3, 89, 2, 384+6321)
        $game_map.set_tile(4, 89, 2, 384+6322)
        $game_map.set_tile(5, 89, 2, 384+6322)
        $game_map.set_tile(6, 89, 2, 384+6323)
        $game_map.set_tile(3, 90, 2, 384+6337)
        $game_map.set_tile(4, 90, 2, 384+6338)
        $game_map.set_tile(5, 90, 2, 384+6338)
        $game_map.set_tile(6, 90, 2, 384+6339)
        $game_map.set_tile(3, 91, 2, 384+6345)
        $game_map.set_tile(4, 91, 2, 384+6346)
        $game_map.set_tile(5, 91, 2, 384+6346)
        $game_map.set_tile(6, 91, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(2, 90, 1, 384+6156)
        $game_map.set_tile(2, 91, 1, 384+6164)
        $game_map.set_tile(7, 90, 1, 384+6156)
        $game_map.set_tile(7, 91, 1, 384+6164)
        
      end
    end
    
    #=========================================================================
    # Battle resto ( 70 & 85 )
    #=========================================================================
    if @buildings[85] < 6
     
      # Layers 2 and 3 cleanup (35 ; 50) -> (40 ; 56)
      for k in 1..2 do
        for j in 50..56 do
          for i in 35..40 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
      end
      
      for j in 42..47 do
        for i in 34..42 do
          $game_map.set_tile(i, j, 2, 0)
        end
      end
      
      for j in 48..53 do
        for i in 34..42 do
          $game_map.set_tile(i, j, 1, 0)
        end
      end
      
      for j in 51..55 do
        $game_map.set_tile(34, j, 2, 0)
      end
        
      for j in 52..56 do
        $game_map.set_tile(41, j, 2, 0)
      end
      
      if @buildings[70] < 4
        
        # cracked ground
        $game_map.set_tile(35, 52, 0, 384+6005)
        $game_map.set_tile(36, 52, 0, 384+6006)
        $game_map.set_tile(37, 52, 0, 384+6005)
        $game_map.set_tile(38, 52, 0, 384+6006)
        $game_map.set_tile(39, 52, 0, 384+6005)
        $game_map.set_tile(40, 52, 0, 384+6006)
        $game_map.set_tile(41, 52, 0, 384+6005)
        $game_map.set_tile(35, 53, 0, 384+6013)
        $game_map.set_tile(36, 53, 0, 384+6014)
        $game_map.set_tile(37, 53, 0, 384+6013)
        $game_map.set_tile(38, 53, 0, 384+6014)
        $game_map.set_tile(39, 53, 0, 384+6013)
        $game_map.set_tile(40, 53, 0, 384+6014)
        $game_map.set_tile(41, 53, 0, 384+6013)
        $game_map.set_tile(35, 54, 0, 384+6005)
        $game_map.set_tile(36, 54, 0, 384+6006)
        $game_map.set_tile(37, 54, 0, 384+6005)
        $game_map.set_tile(38, 54, 0, 384+6006)
        $game_map.set_tile(39, 54, 0, 384+6005)
        $game_map.set_tile(40, 54, 0, 384+6006)
        $game_map.set_tile(41, 54, 0, 384+6005)
        $game_map.set_tile(35, 55, 0, 384+6013)
        $game_map.set_tile(36, 55, 0, 384+6014)
        $game_map.set_tile(37, 55, 0, 384+6013)
        $game_map.set_tile(38, 55, 0, 384+6014)
        $game_map.set_tile(39, 55, 0, 384+6013)
        $game_map.set_tile(40, 55, 0, 384+6014)
        $game_map.set_tile(41, 55, 0, 384+6013)
        
        # "little dot" rocks
        $game_map.set_tile(35, 52, 2, 384+1606)
        $game_map.set_tile(41, 55, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(36, 52, 2, 384+1661)
        $game_map.set_tile(39, 55, 2, 384+1661)
        $game_map.set_tile(41, 52, 2, 384+1661)
        $game_map.set_tile(35, 48, 2, 384+1661)
        $game_map.set_tile(37, 45, 2, 384+1661)
        $game_map.set_tile(41, 47, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(36, 53, 2, 384+1658)
        $game_map.set_tile(40, 54, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(35, 54, 2, 384+1651)
        $game_map.set_tile(36, 54, 2, 384+1652)
        $game_map.set_tile(35, 55, 2, 384+1659)
        $game_map.set_tile(36, 55, 2, 384+1660)
        
        $game_map.set_tile(39, 52, 2, 384+1651)
        $game_map.set_tile(40, 52, 2, 384+1652)
        $game_map.set_tile(39, 53, 1, 384+1659)
        $game_map.set_tile(40, 53, 2, 384+1660)
        
        # big rocks
        $game_map.set_tile(37, 52, 2, 384+1613)
        $game_map.set_tile(38, 52, 2, 384+1614)
        $game_map.set_tile(37, 53, 2, 384+1621)
        $game_map.set_tile(38, 53, 2, 384+1622)
        $game_map.set_tile(39, 53, 2, 384+1623)
        $game_map.set_tile(37, 54, 2, 384+1629)
        $game_map.set_tile(38, 54, 2, 384+1630)
        $game_map.set_tile(39, 54, 2, 384+1631)
        $game_map.set_tile(37, 55, 2, 384+1637)
        $game_map.set_tile(38, 55, 2, 384+1638)
        
      else
        
        # Layer 1 : grey background
        for j in 52..56 do
          for i in 35..41 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(35, 52, 1, 384+428)
        $game_map.set_tile(36, 52, 1, 384+429)
        $game_map.set_tile(37, 52, 1, 384+429)
        $game_map.set_tile(38, 52, 1, 384+429)
        $game_map.set_tile(39, 52, 1, 384+429)
        $game_map.set_tile(40, 52, 1, 384+429)
        $game_map.set_tile(41, 52, 1, 384+431)
        $game_map.set_tile(35, 53, 1, 384+436)
        $game_map.set_tile(41, 53, 1, 384+439)
        $game_map.set_tile(35, 54, 1, 384+436)
        $game_map.set_tile(41, 54, 1, 384+439)
        $game_map.set_tile(35, 55, 1, 384+436)
        $game_map.set_tile(41, 55, 1, 384+439)
        $game_map.set_tile(35, 56, 1, 384+452)
        $game_map.set_tile(36, 56, 1, 384+453)
        $game_map.set_tile(37, 56, 1, 384+453)
        $game_map.set_tile(38, 56, 1, 384+453)
        $game_map.set_tile(39, 56, 1, 384+453)
        $game_map.set_tile(40, 56, 1, 384+453)
        $game_map.set_tile(41, 56, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(35, 51, 2, 384+6313)
        $game_map.set_tile(36, 51, 2, 384+6314)
        $game_map.set_tile(37, 51, 2, 384+6314)
        $game_map.set_tile(38, 51, 2, 384+6314)
        $game_map.set_tile(39, 51, 2, 384+6314)
        $game_map.set_tile(40, 51, 2, 384+6314)
        $game_map.set_tile(41, 51, 2, 384+6315)
        $game_map.set_tile(35, 52, 2, 384+6321)
        $game_map.set_tile(36, 52, 2, 384+6322)
        $game_map.set_tile(37, 52, 2, 384+6322)
        $game_map.set_tile(38, 52, 2, 384+6322)
        $game_map.set_tile(39, 52, 2, 384+6322)
        $game_map.set_tile(40, 52, 2, 384+6322)
        $game_map.set_tile(41, 52, 2, 384+6323)
        $game_map.set_tile(35, 53, 2, 384+6329)
        $game_map.set_tile(41, 53, 2, 384+6331)
        $game_map.set_tile(35, 54, 2, 384+6329)
        $game_map.set_tile(41, 54, 2, 384+6331)
        $game_map.set_tile(35, 55, 2, 384+6337)
        $game_map.set_tile(36, 55, 2, 384+6338)
        $game_map.set_tile(37, 55, 2, 384+6338)
        $game_map.set_tile(38, 55, 2, 384+6338)
        $game_map.set_tile(39, 55, 2, 384+6338)
        $game_map.set_tile(40, 55, 2, 384+6338)
        $game_map.set_tile(41, 55, 2, 384+6339)
        $game_map.set_tile(35, 56, 2, 384+6345)
        $game_map.set_tile(36, 56, 2, 384+6346)
        $game_map.set_tile(37, 56, 2, 384+6346)
        $game_map.set_tile(38, 56, 2, 384+6346)
        $game_map.set_tile(39, 56, 2, 384+6346)
        $game_map.set_tile(40, 56, 2, 384+6346)
        $game_map.set_tile(41, 56, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(34, 55, 2, 384+6156)
        $game_map.set_tile(34, 56, 2, 384+6164)
       
      end
    end
    
    #=========================================================================
    # Radio Tower ( 84 & 97 )
    #=========================================================================
    if @buildings[97] < 17
     
      # Layers 2 and 3 cleanup (32 ; 84) -> (41 ; 93)
      for k in 1..2 do
        for j in 84..93 do
          for i in 32..41 do
            $game_map.set_tile(i, j, k, 0)
          end
        end
      end
      $game_map.set_tile(41, 84, 1, 384+1035) #tree fix
      
      
      $game_map.set_tile(36, 79, 2, 0)
      $game_map.set_tile(37, 79, 2, 0)
      $game_map.set_tile(38, 79, 2, 0)
      $game_map.set_tile(37, 80, 2, 0)
      $game_map.set_tile(38, 80, 2, 0)
      $game_map.set_tile(39, 81, 2, 0)
      $game_map.set_tile(40, 81, 2, 0)
      $game_map.set_tile(40, 82, 2, 0)
      $game_map.set_tile(40, 83, 2, 0)
      
      for j in 81..83 do
        for i in 34..38 do
          $game_map.set_tile(i, j, 1, 0)
        end
      end
      $game_map.set_tile(39, 82, 1, 0)
      $game_map.set_tile(39, 83, 1, 0)
      
      
      $game_map.set_tile(37, 77, 2, 0)
      $game_map.set_tile(37, 78, 2, 0)
      $game_map.set_tile(36, 80, 1, 0)
      
      $game_map.set_tile(42, 88, 1, 0)
      $game_map.set_tile(42, 89, 1, 0)
      $game_map.set_tile(42, 90, 1, 0)
      $game_map.set_tile(42, 91, 1, 0)
      $game_map.set_tile(42, 92, 1, 0)
      $game_map.set_tile(42, 93, 1, 0)
      
      if @buildings[84] < 9
        
        # cracked ground
        $game_map.set_tile(33, 85, 0, 384+6005)
        $game_map.set_tile(34, 85, 0, 384+6006)
        $game_map.set_tile(35, 85, 0, 384+6005)
        $game_map.set_tile(36, 85, 0, 384+6006)
        $game_map.set_tile(37, 85, 0, 384+6005)
        $game_map.set_tile(38, 85, 0, 384+6006)
        $game_map.set_tile(39, 85, 0, 384+6005)
        $game_map.set_tile(40, 85, 0, 384+6006)
        $game_map.set_tile(41, 85, 0, 384+6005)
        $game_map.set_tile(33, 86, 0, 384+6013)
        $game_map.set_tile(34, 86, 0, 384+6014)
        $game_map.set_tile(35, 86, 0, 384+6013)
        $game_map.set_tile(36, 86, 0, 384+6014)
        $game_map.set_tile(37, 86, 0, 384+6013)
        $game_map.set_tile(38, 86, 0, 384+6014)
        $game_map.set_tile(39, 86, 0, 384+6013)
        $game_map.set_tile(40, 86, 0, 384+6014)
        $game_map.set_tile(41, 86, 0, 384+6013)
        $game_map.set_tile(33, 87, 0, 384+6005)
        $game_map.set_tile(34, 87, 0, 384+6006)
        $game_map.set_tile(35, 87, 0, 384+6005)
        $game_map.set_tile(36, 87, 0, 384+6006)
        $game_map.set_tile(37, 87, 0, 384+6005)
        $game_map.set_tile(38, 87, 0, 384+6006)
        $game_map.set_tile(39, 87, 0, 384+6005)
        $game_map.set_tile(40, 87, 0, 384+6006)
        $game_map.set_tile(41, 87, 0, 384+6005)
        $game_map.set_tile(33, 88, 0, 384+6013)
        $game_map.set_tile(34, 88, 0, 384+6014)
        $game_map.set_tile(35, 88, 0, 384+6013)
        $game_map.set_tile(36, 88, 0, 384+6014)
        $game_map.set_tile(37, 88, 0, 384+6013)
        $game_map.set_tile(38, 88, 0, 384+6014)
        $game_map.set_tile(39, 88, 0, 384+6013)
        $game_map.set_tile(40, 88, 0, 384+6014)
        $game_map.set_tile(41, 88, 0, 384+6013)
        $game_map.set_tile(33, 89, 0, 384+6005)
        $game_map.set_tile(34, 89, 0, 384+6006)
        $game_map.set_tile(35, 89, 0, 384+6005)
        $game_map.set_tile(36, 89, 0, 384+6006)
        $game_map.set_tile(37, 89, 0, 384+6005)
        $game_map.set_tile(38, 89, 0, 384+6006)
        $game_map.set_tile(39, 89, 0, 384+6005)
        $game_map.set_tile(40, 89, 0, 384+6006)
        $game_map.set_tile(41, 89, 0, 384+6005)
        $game_map.set_tile(33, 90, 0, 384+6013)
        $game_map.set_tile(34, 90, 0, 384+6014)
        $game_map.set_tile(35, 90, 0, 384+6013)
        $game_map.set_tile(36, 90, 0, 384+6014)
        $game_map.set_tile(37, 90, 0, 384+6013)
        $game_map.set_tile(38, 90, 0, 384+6014)
        $game_map.set_tile(39, 90, 0, 384+6013)
        $game_map.set_tile(40, 90, 0, 384+6014)
        $game_map.set_tile(41, 90, 0, 384+6013)
        $game_map.set_tile(33, 91, 0, 384+6005)
        $game_map.set_tile(34, 91, 0, 384+6006)
        $game_map.set_tile(35, 91, 0, 384+6005)
        $game_map.set_tile(36, 91, 0, 384+6006)
        $game_map.set_tile(37, 91, 0, 384+6005)
        $game_map.set_tile(38, 91, 0, 384+6006)
        $game_map.set_tile(39, 91, 0, 384+6005)
        $game_map.set_tile(40, 91, 0, 384+6006)
        $game_map.set_tile(41, 91, 0, 384+6005)
        $game_map.set_tile(33, 92, 0, 384+6013)
        $game_map.set_tile(34, 92, 0, 384+6014)
        $game_map.set_tile(35, 92, 0, 384+6013)
        $game_map.set_tile(36, 92, 0, 384+6014)
        $game_map.set_tile(37, 92, 0, 384+6013)
        $game_map.set_tile(38, 92, 0, 384+6014)
        $game_map.set_tile(39, 92, 0, 384+6013)
        $game_map.set_tile(40, 92, 0, 384+6014)
        $game_map.set_tile(41, 92, 0, 384+6013)
        
        # "little dot" rocks
        $game_map.set_tile(33, 89, 2, 384+1606)
        $game_map.set_tile(39, 87, 2, 384+1606)
        $game_map.set_tile(40, 90, 2, 384+1606)
        $game_map.set_tile(41, 85, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(33, 85, 2, 384+1661)
        $game_map.set_tile(35, 90, 2, 384+1661)
        $game_map.set_tile(39, 88, 2, 384+1661)
        $game_map.set_tile(40, 86, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(33, 86, 2, 384+1658)
        $game_map.set_tile(35, 92, 2, 384+1658)
        $game_map.set_tile(36, 85, 2, 384+1658)
        $game_map.set_tile(38, 88, 2, 384+1658)
        $game_map.set_tile(41, 87, 2, 384+1658)
        $game_map.set_tile(41, 91, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(33, 91, 2, 384+1651)
        $game_map.set_tile(34, 91, 2, 384+1652)
        $game_map.set_tile(33, 92, 2, 384+1659)
        $game_map.set_tile(34, 92, 2, 384+1660)
        
        $game_map.set_tile(37, 85, 2, 384+1651)
        $game_map.set_tile(38, 85, 2, 384+1652)
        $game_map.set_tile(37, 86, 2, 384+1659)
        $game_map.set_tile(38, 86, 2, 384+1660)
        
        $game_map.set_tile(38, 90, 2, 384+1651)
        $game_map.set_tile(39, 90, 2, 384+1652)
        $game_map.set_tile(38, 91, 2, 384+1659)
        $game_map.set_tile(39, 91, 2, 384+1660)
        
        $game_map.set_tile(40, 91, 2, 384+1651)
        $game_map.set_tile(41, 91, 2, 384+1652)
        $game_map.set_tile(40, 92, 2, 384+1659)
        $game_map.set_tile(41, 92, 2, 384+1660)
        
        # big rocks
        
        # construction hole
        $game_map.set_tile(34, 86, 1, 384+6044)
        $game_map.set_tile(35, 86, 1, 384+6045)
        $game_map.set_tile(36, 86, 1, 384+6046)
        $game_map.set_tile(37, 86, 1, 384+6047)
        $game_map.set_tile(34, 87, 1, 384+6052)
        $game_map.set_tile(35, 87, 1, 384+6053)
        $game_map.set_tile(36, 87, 1, 384+6054)
        $game_map.set_tile(37, 87, 1, 384+6055)
        $game_map.set_tile(34, 88, 1, 384+6060)
        $game_map.set_tile(35, 88, 1, 384+6061)
        $game_map.set_tile(36, 88, 1, 384+6062)
        $game_map.set_tile(37, 88, 1, 384+6063)
        $game_map.set_tile(34, 89, 1, 384+6068)
        $game_map.set_tile(35, 89, 1, 384+6069)
        $game_map.set_tile(36, 89, 1, 384+6070)
        $game_map.set_tile(37, 89, 1, 384+6071)
        
      else
              
        # Layer 1 : grey background
        for j in 85..92 do
          for i in 33 ..41 do
            $game_map.set_tile(i, j, 0, 384+2137)
          end
        end
        
        # Layer 2 : white borders
        $game_map.set_tile(33, 85, 1, 384+428)
        $game_map.set_tile(34, 85, 1, 384+429)
        $game_map.set_tile(35, 85, 1, 384+429)
        $game_map.set_tile(36, 85, 1, 384+429)
        $game_map.set_tile(37, 85, 1, 384+429)
        $game_map.set_tile(38, 85, 1, 384+429)
        $game_map.set_tile(39, 85, 1, 384+429)
        $game_map.set_tile(40, 85, 1, 384+429)
        $game_map.set_tile(41, 85, 1, 384+431)
        $game_map.set_tile(33, 86, 1, 384+436)
        $game_map.set_tile(41, 86, 1, 384+439)
        $game_map.set_tile(33, 87, 1, 384+436)
        $game_map.set_tile(41, 87, 1, 384+439)
        $game_map.set_tile(33, 88, 1, 384+436)
        $game_map.set_tile(41, 88, 1, 384+439)
        $game_map.set_tile(33, 89, 1, 384+436)
        $game_map.set_tile(41, 89, 1, 384+439)
        $game_map.set_tile(33, 90, 1, 384+436)
        $game_map.set_tile(41, 90, 1, 384+439)
        $game_map.set_tile(33, 91, 1, 384+436)
        $game_map.set_tile(41, 91, 1, 384+439)
        $game_map.set_tile(33, 92, 1, 384+452)
        $game_map.set_tile(34, 92, 1, 384+453)
        $game_map.set_tile(35, 92, 1, 384+453)
        $game_map.set_tile(36, 92, 1, 384+453)
        $game_map.set_tile(37, 92, 1, 384+453)
        $game_map.set_tile(38, 92, 1, 384+453)
        $game_map.set_tile(39, 92, 1, 384+453)
        $game_map.set_tile(40, 92, 1, 384+453)
        $game_map.set_tile(41, 92, 1, 384+455)
        
        # Layer 3 : mini walls
        $game_map.set_tile(33, 84, 2, 384+6313)
        $game_map.set_tile(34, 84, 2, 384+6314)
        $game_map.set_tile(35, 84, 2, 384+6314)
        $game_map.set_tile(36, 84, 2, 384+6314)
        $game_map.set_tile(37, 84, 2, 384+6314)
        $game_map.set_tile(38, 84, 2, 384+6314)
        $game_map.set_tile(39, 84, 2, 384+6314)
        $game_map.set_tile(40, 84, 2, 384+6314)
        $game_map.set_tile(41, 84, 2, 384+6315)
        $game_map.set_tile(33, 85, 2, 384+6321)
        $game_map.set_tile(34, 85, 2, 384+6322)
        $game_map.set_tile(35, 85, 2, 384+6322)
        $game_map.set_tile(36, 85, 2, 384+6322)
        $game_map.set_tile(37, 85, 2, 384+6322)
        $game_map.set_tile(38, 85, 2, 384+6322)
        $game_map.set_tile(39, 85, 2, 384+6322)
        $game_map.set_tile(40, 85, 2, 384+6322)
        $game_map.set_tile(41, 85, 2, 384+6323)
        $game_map.set_tile(33, 86, 2, 384+6329)
        $game_map.set_tile(41, 86, 2, 384+6331)
        $game_map.set_tile(33, 87, 2, 384+6329)
        $game_map.set_tile(41, 87, 2, 384+6331)
        $game_map.set_tile(33, 88, 2, 384+6329)
        $game_map.set_tile(41, 88, 2, 384+6331)
        $game_map.set_tile(33, 89, 2, 384+6329)
        $game_map.set_tile(41, 89, 2, 384+6331)
        $game_map.set_tile(33, 90, 2, 384+6329)
        $game_map.set_tile(41, 90, 2, 384+6331)
        $game_map.set_tile(33, 91, 2, 384+6337)
        $game_map.set_tile(34, 91, 2, 384+6338)
        $game_map.set_tile(35, 91, 2, 384+6338)
        $game_map.set_tile(36, 91, 2, 384+6338)
        $game_map.set_tile(37, 91, 2, 384+6338)
        $game_map.set_tile(38, 91, 2, 384+6338)
        $game_map.set_tile(39, 91, 2, 384+6338)
        $game_map.set_tile(40, 91, 2, 384+6338)
        $game_map.set_tile(41, 91, 2, 384+6339)
        $game_map.set_tile(33, 92, 2, 384+6345)
        $game_map.set_tile(34, 92, 2, 384+6346)
        $game_map.set_tile(35, 92, 2, 384+6346)
        $game_map.set_tile(36, 92, 2, 384+6346)
        $game_map.set_tile(37, 92, 2, 384+6346)
        $game_map.set_tile(38, 92, 2, 384+6346)
        $game_map.set_tile(39, 92, 2, 384+6346)
        $game_map.set_tile(40, 92, 2, 384+6346)
        $game_map.set_tile(41, 92, 2, 384+6347)
        
        # Layer 3 : cones
        $game_map.set_tile(32, 84, 2, 384+6156)
        $game_map.set_tile(32, 85, 2, 384+6164)
        $game_map.set_tile(32, 91, 2, 384+6156)
        $game_map.set_tile(32, 92, 2, 384+6164)
  
      end
    end
    
    #=========================================================================
    # Town exteriors (13 (cleanup) 23 49 95
    #=========================================================================
    if @buildings[23] < 3 
      
      # Layer 0 only plain grass
      $game_map.set_tile(10, 13, 0, 384)
      $game_map.set_tile(11, 6, 0, 384)
      $game_map.set_tile(4, 10, 0, 384)
      $game_map.set_tile(13, 10, 0, 384)
      $game_map.set_tile(13, 13, 0, 384)
      $game_map.set_tile(28, 13, 0, 384)
      $game_map.set_tile(34, 13, 0, 384)
      $game_map.set_tile(3, 21, 0, 384)
      $game_map.set_tile(3, 24, 0, 384)
      $game_map.set_tile(8, 26, 0, 384)
      $game_map.set_tile(41, 25, 0, 384)
      $game_map.set_tile(37, 30, 0, 384)
      $game_map.set_tile(23, 38, 0, 384)
      $game_map.set_tile(12, 48, 0, 384)
      $game_map.set_tile(22, 44, 0, 384)
      $game_map.set_tile(28, 44, 0, 384)
      $game_map.set_tile(4, 61, 0, 384)
      $game_map.set_tile(7, 64, 0, 384)
      $game_map.set_tile(34, 70, 0, 384)
      $game_map.set_tile(31, 88, 0, 384)
      $game_map.set_tile(3, 92, 0, 384)
      $game_map.set_tile(6, 102, 0, 384)
      $game_map.set_tile(15, 102, 0, 384)
      $game_map.set_tile(1, 98, 0, 384)
      $game_map.set_tile(15, 108, 0, 384)
      
      # Layer 1 cleanup (animated flowers, lights etc)
      $game_map.set_tile(3, 6, 1, 0)
      $game_map.set_tile(12, 7, 1, 0)
      $game_map.set_tile(2, 13, 1, 0)
      $game_map.set_tile(3, 13, 1, 0)
      $game_map.set_tile(16, 12, 1, 0)
      $game_map.set_tile(17, 12, 1, 0)
      $game_map.set_tile(18, 12, 1, 0)
      $game_map.set_tile(16, 13, 1, 0)
      $game_map.set_tile(17, 13, 1, 0)
      $game_map.set_tile(18, 13, 1, 0)
      $game_map.set_tile(19, 9, 1, 0)
      $game_map.set_tile(24, 12, 1, 0)
      $game_map.set_tile(25, 12, 1, 0)
      $game_map.set_tile(26, 12, 1, 0)
      $game_map.set_tile(24, 13, 1, 0)
      $game_map.set_tile(25, 13, 1, 0)
      $game_map.set_tile(26, 13, 1, 0)
      $game_map.set_tile(29, 1, 1, 0)
      $game_map.set_tile(29, 2, 1, 0)
      $game_map.set_tile(29, 3, 1, 0)
      $game_map.set_tile(36, 12, 1, 0)
      $game_map.set_tile(36, 13, 1, 0)
      $game_map.set_tile(40, 12, 1, 0)
      $game_map.set_tile(40, 13, 1, 0)
      $game_map.set_tile(5, 24, 1, 0)
      $game_map.set_tile(6, 24, 1, 0)
      $game_map.set_tile(7, 24, 1, 0)
      $game_map.set_tile(25, 25, 1, 0)
      $game_map.set_tile(26, 25, 1, 0)
      $game_map.set_tile(28, 30, 1, 0)
      $game_map.set_tile(28, 31, 1, 0)
      $game_map.set_tile(28, 32, 1, 0)
      $game_map.set_tile(28, 33, 1, 0)
      $game_map.set_tile(28, 34, 1, 0)
      $game_map.set_tile(39, 24, 1, 0)
      $game_map.set_tile(40, 24, 1, 0)
      $game_map.set_tile(35, 27, 1, 0)
      $game_map.set_tile(36, 27, 1, 0)
      $game_map.set_tile(37, 27, 1, 0)
      $game_map.set_tile(38, 27, 1, 0)
      $game_map.set_tile(39, 27, 1, 0)
      $game_map.set_tile(40, 27, 1, 0)
      $game_map.set_tile(41, 27, 1, 0)
      $game_map.set_tile(42, 27, 1, 0)
      $game_map.set_tile(35, 28, 1, 0)
      $game_map.set_tile(36, 28, 1, 0)
      $game_map.set_tile(37, 28, 1, 0)
      $game_map.set_tile(38, 28, 1, 0)
      $game_map.set_tile(39, 28, 1, 0)
      $game_map.set_tile(40, 28, 1, 0)
      $game_map.set_tile(41, 28, 1, 0)
      $game_map.set_tile(42, 28, 1, 0)
      $game_map.set_tile(35, 29, 1, 0)
      $game_map.set_tile(36, 29, 1, 0)
      $game_map.set_tile(37, 29, 1, 0)
      $game_map.set_tile(38, 29, 1, 0)
      $game_map.set_tile(39, 29, 1, 0)
      $game_map.set_tile(40, 29, 1, 0)
      $game_map.set_tile(41, 29, 1, 0)
      $game_map.set_tile(42, 29, 1, 0)
      $game_map.set_tile(35, 33, 1, 0)
      $game_map.set_tile(35, 34, 1, 0)
      $game_map.set_tile(35, 35, 1, 0)
      $game_map.set_tile(35, 36, 1, 0)
      $game_map.set_tile(35, 37, 1, 0)
      $game_map.set_tile(11, 49, 1, 0)
      $game_map.set_tile(12, 49, 1, 0)
      $game_map.set_tile(13, 49, 1, 0)
      $game_map.set_tile(16, 45, 1, 0)
      $game_map.set_tile(17, 45, 1, 0)
      $game_map.set_tile(18, 45, 1, 0)
      $game_map.set_tile(19, 45, 1, 0)
      $game_map.set_tile(12, 55, 1, 0)
      $game_map.set_tile(13, 55, 1, 0)
      $game_map.set_tile(14, 55, 1, 0)
      $game_map.set_tile(24, 43, 1, 0)
      $game_map.set_tile(25, 43, 1, 0)
      $game_map.set_tile(26, 43, 1, 0)
      $game_map.set_tile(27, 43, 1, 0)
      $game_map.set_tile(9, 66, 1, 0)
      $game_map.set_tile(9, 67, 1, 0)
      $game_map.set_tile(9, 68, 1, 0)
      $game_map.set_tile(9, 69, 1, 0)
      $game_map.set_tile(9, 70, 1, 0)
      $game_map.set_tile(8, 92, 1, 0)
      $game_map.set_tile(9, 92, 1, 0)
      $game_map.set_tile(14, 84, 1, 0)
      $game_map.set_tile(27, 84, 1, 0)
      $game_map.set_tile(31, 93, 1, 0)
      $game_map.set_tile(32, 93, 1, 0)
      $game_map.set_tile(5, 104, 1, 0)
      $game_map.set_tile(6, 104, 1, 0)
      $game_map.set_tile(5, 105, 1, 0)
      $game_map.set_tile(6, 105, 1, 0)
      $game_map.set_tile(11, 104, 1, 0)
      $game_map.set_tile(12, 104, 1, 0)
      $game_map.set_tile(11, 105, 1, 0)
      $game_map.set_tile(12, 105, 1, 0)
      
      $game_map.set_tile(29, 5, 1, 0)
      $game_map.set_tile(29, 6, 1, 0)
      $game_map.set_tile(29, 7, 1, 0)
      $game_map.set_tile(34, 5, 1, 0)
      $game_map.set_tile(34, 6, 1, 0)
      $game_map.set_tile(34, 7, 1, 0)
      $game_map.set_tile(4, 11, 1, 0)
      $game_map.set_tile(4, 12, 1, 0)
      $game_map.set_tile(4, 13, 1, 0)
      $game_map.set_tile(14, 11, 1, 0)
      $game_map.set_tile(14, 12, 1, 0)
      $game_map.set_tile(14, 13, 1, 0)
      $game_map.set_tile(27, 11, 1, 0)
      $game_map.set_tile(27, 12, 1, 0)
      $game_map.set_tile(27, 13, 1, 0)
      $game_map.set_tile(34, 11, 1, 0)
      $game_map.set_tile(34, 12, 1, 0)
      $game_map.set_tile(34, 13, 1, 0)
      $game_map.set_tile(2, 16, 1, 0)
      $game_map.set_tile(2, 17, 1, 0)
      $game_map.set_tile(2, 18, 1, 0)
      $game_map.set_tile(34, 18, 1, 0)
      $game_map.set_tile(34, 19, 1, 0)
      $game_map.set_tile(34, 20, 1, 0)
      $game_map.set_tile(8, 26, 1, 0)
      $game_map.set_tile(8, 27, 1, 0)
      $game_map.set_tile(8, 28, 1, 0)
      $game_map.set_tile(29, 37, 1, 0)
      $game_map.set_tile(29, 38, 1, 0)
      $game_map.set_tile(29, 39, 1, 0)
      $game_map.set_tile(22, 41, 1, 0)
      $game_map.set_tile(22, 42, 1, 0)
      $game_map.set_tile(22, 43, 1, 0)
      $game_map.set_tile(29, 43, 1, 0)
      $game_map.set_tile(29, 44, 1, 0)
      $game_map.set_tile(29, 45, 1, 0)
      $game_map.set_tile(14, 47, 1, 0)
      $game_map.set_tile(14, 48, 1, 0)
      $game_map.set_tile(14, 49, 1, 0)
      $game_map.set_tile(17, 55, 1, 0)
      $game_map.set_tile(17, 56, 1, 0)
      $game_map.set_tile(17, 57, 1, 0)
      $game_map.set_tile(28, 55, 1, 0)
      $game_map.set_tile(28, 56, 1, 0)
      $game_map.set_tile(28, 57, 1, 0)
      $game_map.set_tile(7, 62, 1, 0)
      $game_map.set_tile(7, 63, 1, 0)
      $game_map.set_tile(7, 64, 1, 0)
      $game_map.set_tile(14, 66, 1, 0)
      $game_map.set_tile(14, 67, 1, 0)
      $game_map.set_tile(14, 68, 1, 0)
      $game_map.set_tile(17, 66, 1, 0)
      $game_map.set_tile(17, 67, 1, 0)
      $game_map.set_tile(17, 68, 1, 0)
      $game_map.set_tile(28, 66, 1, 0)
      $game_map.set_tile(28, 67, 1, 0)
      $game_map.set_tile(28, 68, 1, 0)
      $game_map.set_tile(34, 70, 1, 0)
      $game_map.set_tile(34, 71, 1, 0)
      $game_map.set_tile(34, 72, 1, 0)
      $game_map.set_tile(9, 72, 1, 0)
      $game_map.set_tile(9, 73, 1, 0)
      $game_map.set_tile(9, 74, 1, 0)
      $game_map.set_tile(34, 76, 1, 0)
      $game_map.set_tile(34, 77, 1, 0)
      $game_map.set_tile(34, 78, 1, 0)
      $game_map.set_tile(28, 81, 1, 0)
      $game_map.set_tile(28, 82, 1, 0)
      $game_map.set_tile(28, 83, 1, 0)
      $game_map.set_tile(31, 86, 1, 0)
      $game_map.set_tile(31, 87, 1, 0)
      $game_map.set_tile(31, 88, 1, 0)
      $game_map.set_tile(9, 90, 1, 0)
      $game_map.set_tile(9, 91, 1, 0)
      $game_map.set_tile(9, 92, 1, 0)
      $game_map.set_tile(15, 93, 1, 0)
      $game_map.set_tile(15, 94, 1, 0)
      $game_map.set_tile(15, 95, 1, 0)
      $game_map.set_tile(3, 98, 1, 0)
      $game_map.set_tile(3, 99, 1, 0)
      $game_map.set_tile(3, 100, 1, 0)
      
      # Layer 2 Flower pots cleanup
      $game_map.set_tile(29, 10, 2, 0)
      $game_map.set_tile(34, 10, 2, 0)
      $game_map.set_tile(34, 21, 2, 0)
      $game_map.set_tile(8, 24, 2, 0)
      $game_map.set_tile(29, 42, 2, 0)
      $game_map.set_tile(38, 43, 2, 0)
      $game_map.set_tile(14, 65, 2, 0)
      $game_map.set_tile(28, 93, 2, 0)
      $game_map.set_tile(14, 109, 2, 0)
      $game_map.set_tile(3, 109, 2, 0)
      
      
      
      # Park cleanup, layer 0 plain grass
      for j in 55..69
        for i in 17..19
          $game_map.set_tile(i, j, 0, 384)
        end
      end
      
      for j in 55..62
        for i in 20..23
          $game_map.set_tile(i, j, 0, 384)
        end
      end
      
      for j in 68..69
        for i in 20..23
          $game_map.set_tile(i, j, 0, 384)
        end
      end
      
      for j in 55..69
        for i in 24..28
          $game_map.set_tile(i, j, 0, 384)
        end
      end
      
      # Park cleanup, layer 1 flowers etc
      for j in 56..61
        for i in 19..27
          $game_map.set_tile(i, j, 1, 0)
        end
      end
      
      for j in 63..67
        for i in 25..27
          $game_map.set_tile(i, j, 1, 0)
        end
      end
      
      # Park cleanup, layer 2 benches
      $game_map.set_tile(18, 65, 2, 0)
      $game_map.set_tile(18, 66, 2, 0)
      $game_map.set_tile(18, 67, 2, 0)
      
      $game_map.set_tile(20, 60, 2, 0)
      $game_map.set_tile(21, 60, 2, 0)
      $game_map.set_tile(20, 61, 2, 0)
      $game_map.set_tile(21, 61, 2, 0)
      
      $game_map.set_tile(25, 65, 2, 0)
      $game_map.set_tile(25, 66, 2, 0)
      $game_map.set_tile(25, 67, 2, 0)
      
      if @buildings[13] < 2
        
        # Bench cleanup
        $game_map.set_tile(7, 29, 2, 0)
        $game_map.set_tile(7, 30, 2, 0)
        $game_map.set_tile(8, 29, 2, 0)
        $game_map.set_tile(8, 30, 2, 0)
        
        # Cracked ground layer 0
        $game_map.set_tile(10, 23, 0, 384+6005)
        $game_map.set_tile(11, 23, 0, 384+6006)
        $game_map.set_tile(12, 23, 0, 384+6005)
        $game_map.set_tile(13, 23, 0, 384+6006)
        $game_map.set_tile(14, 23, 0, 384+6005)
        $game_map.set_tile(15, 23, 0, 384+6006)
        $game_map.set_tile(16, 23, 0, 384+6005)
        $game_map.set_tile(17, 23, 0, 384+6006)
        $game_map.set_tile(18, 23, 0, 384+6005)
        $game_map.set_tile(19, 23, 0, 384+6006)
        $game_map.set_tile(20, 23, 0, 384+6005)
        $game_map.set_tile(21, 23, 0, 384+6006)
        $game_map.set_tile(22, 23, 0, 384+6005)
        $game_map.set_tile(23, 23, 0, 384+6006)
        $game_map.set_tile(24, 23, 0, 384+6005)
        $game_map.set_tile(25, 23, 0, 384+6006)
        $game_map.set_tile(26, 23, 0, 384+6005)
        $game_map.set_tile(27, 23, 0, 384+6006)
        $game_map.set_tile(28, 23, 0, 384+6005)
        $game_map.set_tile(29, 23, 0, 384+6006)
        $game_map.set_tile(30, 23, 0, 384+6005)
        $game_map.set_tile(31, 23, 0, 384+6006)
        $game_map.set_tile(32, 23, 0, 384+6005)
        $game_map.set_tile(33, 23, 0, 384+6006)
        
        $game_map.set_tile(9, 24, 0, 384+6014)
        $game_map.set_tile(10, 24, 0, 384+6013)
        $game_map.set_tile(30, 24, 0, 384+6013)
        $game_map.set_tile(31, 24, 0, 384+6014)
        $game_map.set_tile(32, 24, 0, 384+6013)
        $game_map.set_tile(33, 24, 0, 384+6014)
        
        $game_map.set_tile(9, 25, 0, 384+6006)
        $game_map.set_tile(10, 25, 0, 384+6005)
        $game_map.set_tile(30, 25, 0, 384+6005)
        $game_map.set_tile(31, 25, 0, 384+6006)
        $game_map.set_tile(32, 25, 0, 384+6005)
        $game_map.set_tile(33, 25, 0, 384+6006)
        
        $game_map.set_tile(7, 26, 0, 384+6014)
        $game_map.set_tile(8, 26, 0, 384+6013)
        $game_map.set_tile(9, 26, 0, 384+6014)
        $game_map.set_tile(10, 26, 0, 384+6013)
        $game_map.set_tile(30, 26, 0, 384+6013)
        $game_map.set_tile(31, 26, 0, 384+6014)
        $game_map.set_tile(32, 26, 0, 384+6013)
        $game_map.set_tile(33, 26, 0, 384+6014)
        
        $game_map.set_tile(7, 27, 0, 384+6006)
        $game_map.set_tile(8, 27, 0, 384+6005)
        $game_map.set_tile(9, 27, 0, 384+6006)
        $game_map.set_tile(10, 27, 0, 384+6005)
        $game_map.set_tile(30, 27, 0, 384+6005)
        $game_map.set_tile(31, 27, 0, 384+6006)
        $game_map.set_tile(32, 27, 0, 384+6005)
        $game_map.set_tile(33, 27, 0, 384+6006)
        
        $game_map.set_tile(7, 28, 0, 384+6014)
        $game_map.set_tile(8, 28, 0, 384+6013)
        $game_map.set_tile(9, 28, 0, 384+6014)
        $game_map.set_tile(10, 28, 0, 384+6013)
        $game_map.set_tile(30, 28, 0, 384+6013)
        $game_map.set_tile(31, 28, 0, 384+6014)
        $game_map.set_tile(32, 28, 0, 384+6013)
        $game_map.set_tile(33, 28, 0, 384+6014)
        
        $game_map.set_tile(7, 29, 0, 384+6006)
        $game_map.set_tile(8, 29, 0, 384+6005)
        $game_map.set_tile(9, 29, 0, 384+6006)
        $game_map.set_tile(10, 29, 0, 384+6005)
        $game_map.set_tile(30, 29, 0, 384+6005)
        $game_map.set_tile(31, 29, 0, 384+6006)
        $game_map.set_tile(32, 29, 0, 384+6005)
        $game_map.set_tile(33, 29, 0, 384+6006)
        
        $game_map.set_tile(2, 30, 0, 384+6013)
        $game_map.set_tile(3, 30, 0, 384+6014)
        $game_map.set_tile(4, 30, 0, 384+6013)
        $game_map.set_tile(5, 30, 0, 384+6014)
        $game_map.set_tile(6, 30, 0, 384+6013)
        $game_map.set_tile(7, 30, 0, 384+6014)
        $game_map.set_tile(8, 30, 0, 384+6013)
        $game_map.set_tile(9, 30, 0, 384+6014)
        $game_map.set_tile(10, 30, 0, 384+6013)
        $game_map.set_tile(30, 30, 0, 384+6013)
        $game_map.set_tile(31, 30, 0, 384+6014)
        $game_map.set_tile(32, 30, 0, 384+6013)
        $game_map.set_tile(33, 30, 0, 384+6014)
        
        $game_map.set_tile(2, 31, 0, 384+6005)
        $game_map.set_tile(3, 31, 0, 384+6006)
        $game_map.set_tile(4, 31, 0, 384+6005)
        $game_map.set_tile(5, 31, 0, 384+6006)
        $game_map.set_tile(6, 31, 0, 384+6005)
        $game_map.set_tile(7, 31, 0, 384+6006)
        $game_map.set_tile(8, 31, 0, 384+6005)
        $game_map.set_tile(9, 31, 0, 384+6006)
        $game_map.set_tile(10, 31, 0, 384+6005)
        $game_map.set_tile(30, 31, 0, 384+6005)
        $game_map.set_tile(31, 31, 0, 384+6006)
        $game_map.set_tile(32, 31, 0, 384+6005)
        $game_map.set_tile(33, 31, 0, 384+6006)
        
        $game_map.set_tile(2, 32, 0, 384+6013)
        $game_map.set_tile(3, 32, 0, 384+6014)
        $game_map.set_tile(4, 32, 0, 384+6013)
        $game_map.set_tile(5, 32, 0, 384+6014)
        $game_map.set_tile(6, 32, 0, 384+6013)
        $game_map.set_tile(7, 32, 0, 384+6014)
        $game_map.set_tile(8, 32, 0, 384+6013)
        $game_map.set_tile(9, 32, 0, 384+6014)
        $game_map.set_tile(10, 32, 0, 384+6013)
        $game_map.set_tile(30, 32, 0, 384+6013)
        $game_map.set_tile(31, 32, 0, 384+6014)
        $game_map.set_tile(32, 32, 0, 384+6013)
        $game_map.set_tile(33, 32, 0, 384+6014)
        
        $game_map.set_tile(2, 33, 0, 384+6005)
        $game_map.set_tile(3, 33, 0, 384+6006)
        $game_map.set_tile(4, 33, 0, 384+6005)
        $game_map.set_tile(5, 33, 0, 384+6006)
        $game_map.set_tile(6, 33, 0, 384+6005)
        $game_map.set_tile(7, 33, 0, 384+6006)
        $game_map.set_tile(8, 33, 0, 384+6005)
        $game_map.set_tile(9, 33, 0, 384+6006)
        $game_map.set_tile(10, 33, 0, 384+6005)
        $game_map.set_tile(30, 33, 0, 384+6005)
        $game_map.set_tile(31, 33, 0, 384+6006)
        $game_map.set_tile(32, 33, 0, 384+6005)
        $game_map.set_tile(33, 33, 0, 384+6006)
        
        # "little dot" rocks
        $game_map.set_tile(10, 28, 2, 384+1606)
        $game_map.set_tile(13, 26, 2, 384+1606)
        $game_map.set_tile(14, 29, 2, 384+1606)
        $game_map.set_tile(14, 30, 2, 384+1606)
        $game_map.set_tile(15, 25, 2, 384+1606)
        $game_map.set_tile(16, 28, 2, 384+1606)
        $game_map.set_tile(19, 30, 2, 384+1606)
        $game_map.set_tile(19, 27, 2, 384+1606)
        $game_map.set_tile(20, 27, 2, 384+1606)
        $game_map.set_tile(21, 27, 2, 384+1606)
        $game_map.set_tile(21, 25, 2, 384+1606)
        $game_map.set_tile(24, 28, 2, 384+1606)
        $game_map.set_tile(27, 26, 2, 384+1606)
        $game_map.set_tile(30, 28, 2, 384+1606)
        $game_map.set_tile(30, 31, 2, 384+1606)
        $game_map.set_tile(31, 31, 2, 384+1606)
        $game_map.set_tile(35, 32, 2, 384+1606)
        $game_map.set_tile(36, 27, 2, 384+1606)
        $game_map.set_tile(37, 29, 2, 384+1606)
        $game_map.set_tile(39, 30, 2, 384+1606)
        $game_map.set_tile(41, 28, 2, 384+1606)
        
        # little grey rocks
        $game_map.set_tile(3, 30, 2, 384+1661)
        $game_map.set_tile(10, 24, 2, 384+1661)
        $game_map.set_tile(13, 30, 2, 384+1661)
        $game_map.set_tile(20, 29, 2, 384+1661)
        $game_map.set_tile(23, 25, 2, 384+1661)
        $game_map.set_tile(25, 30, 2, 384+1661)
        $game_map.set_tile(26, 23, 2, 384+1661)
        $game_map.set_tile(28, 32, 2, 384+1661)
        $game_map.set_tile(32, 29, 2, 384+1661)
        $game_map.set_tile(33, 23, 2, 384+1661)
        $game_map.set_tile(33, 26, 2, 384+1661)
        $game_map.set_tile(39, 27, 2, 384+1661)
        $game_map.set_tile(41, 30, 2, 384+1661)
        
        # little brown rocks
        $game_map.set_tile(3, 31, 2, 384+1658)
        $game_map.set_tile(6, 31, 2, 384+1658)
        $game_map.set_tile(8, 28, 2, 384+1658)
        $game_map.set_tile(14, 27, 2, 384+1658)
        $game_map.set_tile(16, 23, 2, 384+1658)
        $game_map.set_tile(18, 28, 2, 384+1658)
        $game_map.set_tile(28, 25, 2, 384+1658)
        $game_map.set_tile(30, 26, 2, 384+1658)
        $game_map.set_tile(32, 27, 2, 384+1658)
        $game_map.set_tile(37, 31, 2, 384+1658)
        $game_map.set_tile(38, 28, 2, 384+1658)
        $game_map.set_tile(40, 31, 2, 384+1658)
        
        # middle rocks
        $game_map.set_tile(7, 25, 2, 384+1651)
        $game_map.set_tile(8, 25, 2, 384+1652)
        $game_map.set_tile(7, 26, 2, 384+1659)
        $game_map.set_tile(8, 26, 2, 384+1660)
        
        $game_map.set_tile(4, 32, 2, 384+1651)
        $game_map.set_tile(5, 32, 2, 384+1652)
        $game_map.set_tile(4, 33, 2, 384+1659)
        $game_map.set_tile(5, 33, 2, 384+1660)
        
        $game_map.set_tile(7, 29, 2, 384+1651)
        $game_map.set_tile(8, 29, 2, 384+1652)
        $game_map.set_tile(7, 30, 2, 384+1659)
        $game_map.set_tile(8, 30, 2, 384+1660)
        
        $game_map.set_tile(8, 31, 2, 384+1651)
        $game_map.set_tile(9, 31, 2, 384+1652)
        $game_map.set_tile(8, 32, 2, 384+1659)
        $game_map.set_tile(9, 32, 2, 384+1660)
        
        $game_map.set_tile(9, 26, 2, 384+1651)
        $game_map.set_tile(10, 26, 2, 384+1652)
        $game_map.set_tile(9, 27, 2, 384+1659)
        $game_map.set_tile(10, 27, 2, 384+1660)
        
        $game_map.set_tile(16, 25, 2, 384+1651)
        $game_map.set_tile(17, 25, 2, 384+1652)
        $game_map.set_tile(16, 26, 2, 384+1659)
        $game_map.set_tile(17, 26, 2, 384+1660)
        
        $game_map.set_tile(21, 29, 2, 384+1651)
        $game_map.set_tile(22, 29, 2, 384+1652)
        $game_map.set_tile(21, 30, 2, 384+1659)
        $game_map.set_tile(22, 30, 2, 384+1660)
        
        $game_map.set_tile(24, 25, 2, 384+1651)
        $game_map.set_tile(25, 25, 2, 384+1652)
        $game_map.set_tile(24, 26, 2, 384+1659)
        $game_map.set_tile(25, 26, 2, 384+1660)
        
        $game_map.set_tile(30, 23, 2, 384+1651)
        $game_map.set_tile(31, 23, 2, 384+1652)
        $game_map.set_tile(30, 24, 2, 384+1659)
        $game_map.set_tile(31, 24, 2, 384+1660)
        
        $game_map.set_tile(32, 24, 2, 384+1651)
        $game_map.set_tile(33, 24, 2, 384+1652)
        $game_map.set_tile(32, 25, 2, 384+1659)
        $game_map.set_tile(33, 25, 2, 384+1660)
        
        $game_map.set_tile(39, 32, 2, 384+1651)
        $game_map.set_tile(40, 32, 2, 384+1652)
        $game_map.set_tile(39, 33, 2, 384+1659)
        $game_map.set_tile(40, 33, 2, 384+1660)
        
        # big rocks
        $game_map.set_tile(18, 23, 2, 384+1613)
        $game_map.set_tile(19, 23, 2, 384+1614)
        $game_map.set_tile(18, 24, 2, 384+1621)
        $game_map.set_tile(19, 24, 2, 384+1622)
        $game_map.set_tile(20, 24, 2, 384+1623)
        $game_map.set_tile(18, 25, 2, 384+1629)
        $game_map.set_tile(19, 25, 2, 384+1630)
        $game_map.set_tile(20, 25, 2, 384+1631)
        $game_map.set_tile(18, 26, 2, 384+1637)
        $game_map.set_tile(19, 26, 2, 384+1638)
        
        $game_map.set_tile(26, 27, 2, 384+1613)
        $game_map.set_tile(27, 27, 2, 384+1614)
        $game_map.set_tile(26, 28, 2, 384+1621)
        $game_map.set_tile(27, 28, 2, 384+1622)
        $game_map.set_tile(28, 28, 2, 384+1623)
        $game_map.set_tile(26, 29, 2, 384+1629)
        $game_map.set_tile(27, 29, 2, 384+1630)
        $game_map.set_tile(28, 29, 2, 384+1631)
        $game_map.set_tile(26, 30, 2, 384+1637)
        $game_map.set_tile(27, 30, 2, 384+1638)
        
        $game_map.set_tile(35, 28, 2, 384+1613)
        $game_map.set_tile(36, 28, 2, 384+1614)
        $game_map.set_tile(35, 29, 2, 384+1621)
        $game_map.set_tile(36, 29, 2, 384+1622)
        $game_map.set_tile(37, 29, 2, 384+1623)
        $game_map.set_tile(35, 30, 2, 384+1629)
        $game_map.set_tile(36, 30, 2, 384+1630)
        $game_map.set_tile(37, 30, 2, 384+1631)
        $game_map.set_tile(35, 31, 2, 384+1637)
        $game_map.set_tile(36, 31, 2, 384+1638)
        end
            
    end
  end
end