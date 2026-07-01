class PokemonGlobalMetadata
  attr_accessor :achievements
  attr_accessor :dexachievements
  
  def achievements
    @achievements={} if !@achievements
    return @achievements
  end
  
  def dexachievements
    @dexachievements={} if !@dexachievements
    return @dexachievements
  end
end


        


module Achievements
  # IDs determine the order that achievements appear in the menu.
  @achievementList={
     "STEPS"=>{
      "id"=>1,
      "name"=>"Tired Feet",
      "description"=>"Walk around the world.",
      "goals"=>[50000,100000,200000]
    },
    "WILD_ENCOUNTERS"=>{
      "id"=>2,
      "name"=>"Running in the Tall Grass",
      "description"=>"Encounter Pokémon.",
      "goals"=>[1000,2000,4000]
    },
    "TRAINER_BATTLES"=>{
      "id"=>3,
      "name"=>"Battlin' Every Day",
      "description"=>"Go into Trainer battles.",
      "goals"=>[250,500,1000]
    },
    "CHALLENGER_BATTLES"=>{
      "id"=>4,
      "name"=>"Uncontested Leader",
      "description"=>"Defeat Challengers at your Gym.",
      "goals"=>[100,200,400]
    },
    "ITEM_BALL_ITEMS"=>{
      "id"=>5,
      "name"=>"Finding Treasure",
      "description"=>"Find items in item balls.",
      "goals"=>[200,400,800]
    },
    "ITEMS_USED"=>{
      "id"=>6,
      "name"=>"Items Are Handy",
      "description"=>"Use items.",
      "goals"=>[250,500,1000]
    },
   "ITEMS_USED_IN_BATTLE"=>{
      "id"=>7,
      "name"=>"Mid-Battle Maintenance",
      "description"=>"Use items in battle.",
      "goals"=>[100,200,400]
    },
    "ITEMS_BOUGHT"=>{
      "id"=>8,
      "name"=>"Buying Supplies",
      "description"=>"Buy items.",
      "goals"=>[250,500,1000]
    },
    "ITEMS_SOLD"=>{
      "id"=>9,
      "name"=>"Seller",
      "description"=>"Sell items.",
      "goals"=>[100,200,400]
    },
    "ACHIEVEMENTS"=>{
      "id"=>10,
      "name"=>"Achievement hunter",
      "description"=>"Earn Achievements (General & Pokédex).",
      "goals"=>[15,30,59]

    }
  }
  @dexAchievementList={
     "KANTO"=>{
      "id"=>1,
      "name"=>"Kanto Pokédex",
      "description"=>"Capture Gen1 Pokémon",
      "goals"=>[38,76,151]
    },
    "JOHTO"=>{
      "id"=>2,
      "name"=>"Johto Pokédex",
      "description"=>"Capture Gen2 Pokémon",
      "goals"=>[25,50,100]
    },
    "HOENN"=>{
      "id"=>3,
      "name"=>"Hoenn Pokédex",
      "description"=>"Capture Gen3 Pokémon",
      "goals"=>[33,66,135]
    },
    "SINNOH"=>{
      "id"=>4,
      "name"=>"Sinnoh Pokédex",
      "description"=>"Capture Gen4 Pokémon",
      "goals"=>[26,52,107]
    },
    "UNOVA"=>{
      "id"=>5,
     "name"=>"Unova Pokédex",
      "description"=>"Capture Gen5 Pokémon",
      "goals"=>[39,78,156]
    },
    "KALOS"=>{
      "id"=>6,
      "name"=>"Kalos Pokédex",
      "description"=>"Capture Gen6 Pokémon",
      "goals"=>[18,36,72]
    },
   "ALOLA"=>{
      "id"=>7,
      "name"=>"Alola Pokédex",
      "description"=>"Capture Gen7 Pokémon",
      "goals"=>[22,44,88]
    },
    "GALAR"=>{
      "id"=>8,
      "name"=>"Galar Pokédex",
      "description"=>"Capture Gen8 Pokémon",
      "goals"=>[24,48,96]
    },
    "PALDEA"=>{
      "id"=>9,
      "name"=>"Paldea Pokédex",
      "description"=>"Capture Gen9 Pokémon",
      "goals"=>[30,60,120]
    },
    "GLOBAL"=>{
      "id"=>10,
      "name"=>"National Pokédex",
      "description"=>"Capture EVERY Pokémon",
      "goals"=>[250,500,1035]

    }
  }

  def self.list
    Achievements.fixAchievements
    return @achievementList
  end
  def self.fixAchievements
    @achievementList.keys.each{|a|
      if $PokemonGlobal.achievements[a].nil?
        $PokemonGlobal.achievements[a]={}
      end
      if $PokemonGlobal.achievements[a]["progress"].nil?
        $PokemonGlobal.achievements[a]["progress"]=0
      end
      if $PokemonGlobal.achievements[a]["level"].nil?
        $PokemonGlobal.achievements[a]["level"]=0
      end
    }
    $PokemonGlobal.achievements.keys.each{|k|
      if !@achievementList.keys.include? k
        $PokemonGlobal.achievements.delete(k)
      end
    }
  end
  def self.incrementProgress(name, amount)
    Achievements.fixAchievements
    if @achievementList.keys.include? name
      if !$PokemonGlobal.achievements[name].nil? && !$PokemonGlobal.achievements[name]["progress"].nil?
        $PokemonGlobal.achievements[name]["progress"]+=amount
        self.checkIfLevelUp(name)
        return true
      else
        return false
      end
    else
      raise "Undefined achievement: "+name.to_s
    end
  end
  def self.decrementProgress(name, amount)
    Achievements.fixAchievements
    if @achievementList.keys.include? name
      if !$PokemonGlobal.achievements[name].nil? && !$PokemonGlobal.achievements[name]["progress"].nil?
        $PokemonGlobal.achievements[name]["progress"]-=amount
        if $PokemonGlobal.achievements[name]["progress"]<0
          $PokemonGlobal.achievements[name]["progress"]=0
        end
        return true
      else
        return false
      end
    else
      raise "Undefined achievement: "+name.to_s
    end
  end
  def self.setProgress(name, amount)
    Achievements.fixAchievements
    if @achievementList.keys.include? name
      if !$PokemonGlobal.achievements[name].nil? && !$PokemonGlobal.achievements[name]["progress"].nil?
        $PokemonGlobal.achievements[name]["progress"]=amount
        if $PokemonGlobal.achievements[name]["progress"]<0
          $PokemonGlobal.achievements[name]["progress"]=0
        end
        self.checkIfLevelUp(name)
        return true
      else
        return false
      end
    else
      raise "Undefined achievement: "+name.to_s
    end
  end
  def self.checkIfLevelUp(name)
    Achievements.fixAchievements
    if @achievementList.keys.include? name
      if !$PokemonGlobal.achievements[name].nil? && !$PokemonGlobal.achievements[name]["progress"].nil?
        level=@achievementList[name]["goals"].length
        @achievementList[name]["goals"].each_with_index{|g,i|
          if $PokemonGlobal.achievements[name]["progress"] < g
            level=i
            break
          end
        }
        if level>$PokemonGlobal.achievements[name]["level"]
          $PokemonGlobal.achievements[name]["level"]=level
		  if @achievementList[name]["name"] == "Achievement hunter"
			self.queueReward(self.getReward(level),true)
		  else
		    self.queueReward(self.getReward(level),false)
		  end
          self.queueMessage(_INTL("Achievement Reached!\n{1} Level {2}.",@achievementList[name]["name"],level.to_s))
		  Achievements.incrementProgress("ACHIEVEMENTS",1)
          return true
        else
          return false
        end
      else
        return false
      end
    else
      raise "Undefined achievement: "+name.to_s
    end
  end
  def self.getCurrentGoal(name)
    Achievements.fixAchievements
    if @achievementList.keys.include? name
      if !$PokemonGlobal.achievements[name].nil? && !$PokemonGlobal.achievements[name]["progress"].nil?
        @achievementList[name]["goals"].each_with_index{|g,i|
          if $PokemonGlobal.achievements[name]["progress"] < g
            return g
          end
        }
        return nil
      else
        return 0
      end
    else
      raise "Undefined achievement: "+name.to_s
    end
  end
  def self.getReward(level,spe)
	if spe
		case level
		when 1
			return :ITEMCHOSER
		when 2
			return :POKEMONCHOSER
		else
			return :POKEMONSHAPER
		end
	else
		case level
		when 1
			return :SAFARICOUPON
		when 2
			return :CASINOCOUPON
		else
			return :SHINYMACHINE
		end
	end
  end
  def self.queueMessage(msg)
    if $achievementmessagequeue.nil?
      $achievementmessagequeue=[]
    end
    $achievementmessagequeue.push(msg)
  end
  def self.queueReward(reward)
	if $achievementrewardsqueue.nil?
      $achievementrewardsqueue=[]
    end
    $achievementrewardsqueue.push(reward)
  end
  
  
  
  # Dex versions
  def self.dexlist
    Achievements.fixDexAchievements
    return @dexAchievementList
  end
  def self.fixDexAchievements
    @dexAchievementList.keys.each{|a|
      if $PokemonGlobal.dexachievements[a].nil?
        $PokemonGlobal.dexachievements[a]={}
      end
      if $PokemonGlobal.dexachievements[a]["progress"].nil?
        $PokemonGlobal.dexachievements[a]["progress"]=0
      end
      if $PokemonGlobal.dexachievements[a]["level"].nil?
        $PokemonGlobal.dexachievements[a]["level"]=0
      end
    }
    $PokemonGlobal.dexachievements.keys.each{|k|
      if !@dexAchievementList.keys.include? k
        $PokemonGlobal.dexachievements.delete(k)
      end
    }
  end
  def self.dexIncrementProgress(name, amount)
    Achievements.fixDexAchievements
    if @dexAchievementList.keys.include? name
      if !$PokemonGlobal.dexachievements[name].nil? && !$PokemonGlobal.dexachievements[name]["progress"].nil?
        $PokemonGlobal.dexachievements[name]["progress"]+=amount
        self.dexCheckIfLevelUp(name)
        return true
      else
        return false
      end
    else
      raise "Undefined achievement: "+name.to_s
    end
  end
  def self.dexDecrementProgress(name, amount)
    Achievements.fixDexAchievements
    if @dexAchievementList.keys.include? name
      if !$PokemonGlobal.dexachievements[name].nil? && !$PokemonGlobal.dexachievements[name]["progress"].nil?
        $PokemonGlobal.dexachievements[name]["progress"]-=amount
        if $PokemonGlobal.dexachievements[name]["progress"]<0
          $PokemonGlobal.dexachievements[name]["progress"]=0
        end
        return true
      else
        return false
      end
    else
      raise "Undefined achievement: "+name.to_s
    end
  end
  def self.dexSetProgress(name, amount)
    Achievements.fixDexAchievements
    if @dexAchievementList.keys.include? name
      if !$PokemonGlobal.dexachievements[name].nil? && !$PokemonGlobal.dexachievements[name]["progress"].nil?
        $PokemonGlobal.dexachievements[name]["progress"]=amount
        if $PokemonGlobal.dexachievements[name]["progress"]<0
          $PokemonGlobal.dexachievements[name]["progress"]=0
        end
        self.dexCheckIfLevelUp(name)
        return true
      else
        return false
      end
    else
      raise "Undefined achievement: "+name.to_s
    end
  end
  def self.dexCheckIfLevelUp(name)
    Achievements.fixDexAchievements
    if @dexAchievementList.keys.include? name
      if !$PokemonGlobal.dexachievements[name].nil? && !$PokemonGlobal.dexachievements[name]["progress"].nil?
        level=@dexAchievementList[name]["goals"].length
        @dexAchievementList[name]["goals"].each_with_index{|g,i|
          if $PokemonGlobal.dexachievements[name]["progress"] < g
            level=i
            break
          end
        }
        if level>$PokemonGlobal.dexachievements[name]["level"]
          $PokemonGlobal.dexachievements[name]["level"]=level
		  if @dexAchievementList[name]["name"] == "National Pokédex"
			self.queueDexReward(self.getDexReward(level),true)
		  else
		    self.queueDexReward(self.getDexReward(level),false)
		  end
          self.queueDexMessage(_INTL("Achievement Reached!\n{1} Level {2}.",@dexAchievementList[name]["name"],level.to_s))
		  Achievements.incrementProgress("ACHIEVEMENTS",1)
          return true
        else
          return false
        end
      else
        return false
      end
    else
      raise "Undefined achievement: "+name.to_s
    end
  end
  def self.getDexCurrentGoal(name)
    Achievements.fixDexAchievements
    if @dexAchievementList.keys.include? name
      if !$PokemonGlobal.dexachievements[name].nil? && !$PokemonGlobal.dexachievements[name]["progress"].nil?
        @dexAchievementList[name]["goals"].each_with_index{|g,i|
          if $PokemonGlobal.dexachievements[name]["progress"] < g
            return g
          end
        }
        return nil
      else
        return 0
      end
    else
      raise "Undefined achievement: "+name.to_s
    end
  end
  def self.getDexReward(level,spe,gen)
	if spe
	  case level
	  when 1
	    reward = _INTL("You've unlocked a new roof color for your house and another building at the urbanist!")
	  when 2
		reward = _INTL("You've unlocked a new outfit at the Clothes Shop!")
	  else
		reward = :SHINYCHARM
	  end
	else
	  pbSet(400+gen,level)
	  case level
	  when 1
	    reward = _INTL("You've unlocked a new roof color for your house and another building at the urbanist!")
	  when 2
		reward = _INTL("You've unlocked a new outfit at the Clothes Shop!")
	  else
		reward = :SHINYMACHINE
	  end
	  return [400+gen,level,reward]
	end
  end
  def self.queueDexMessage(msg)
    if $dexachievementmessagequeue.nil?
      $dexachievementmessagequeue=[]
    end
    $dexachievementmessagequeue.push(msg)
  end
  def self.queueDexReward(reward)
	if $dexachievementrewardsqueue.nil?
      $dexachievementrewardsqueue=[]
    end
    $dexachievementrewardsqueue.push(reward)
  end
end