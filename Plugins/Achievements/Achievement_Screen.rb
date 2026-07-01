class AchievementButton < Sprite
  attr_reader :name
  attr_accessor :selected

  def initialize(dex,x,y,name="",level="",internal="",viewport=nil)
    super(viewport)
    @name=name
    @level=level
    @selected=false
	if dex
		currgoal=Achievements.getDexCurrentGoal(internal)
	else
		currgoal=Achievements.getCurrentGoal(internal)
	end
    if currgoal
      @button=AnimatedBitmap.new("Graphics/Pictures/Achievements/achievementsButton")
    else
      @button=AnimatedBitmap.new("Graphics/Pictures/Achievements/completedButton")
    end
    @contents=BitmapWrapper.new(@button.width,@button.height)
    self.bitmap=@contents
    self.x=x
    self.y=y
    refresh
    update
  end

  def dispose
    @button.dispose
    @contents.dispose
    super
  end

  def refresh
    self.bitmap.clear
    self.bitmap.blt(0,0,@button.bitmap,Rect.new(0,0,@button.width,@button.height))
    pbSetSystemFont(self.bitmap)
    textpos=[          # Name is written on both unselected and selected buttons
       [@name,14,10,0,Color.new(248,248,248),Color.new(40,40,40)],
       [@name,14,62,0,Color.new(248,248,248),Color.new(40,40,40)],
       [@level,482,10,1,Color.new(248,248,248),Color.new(40,40,40)],
       [@level,482,62,1,Color.new(248,248,248),Color.new(40,40,40)]
    ]
    pbDrawTextPositions(self.bitmap,textpos)
  end

  def update
    if self.selected
      self.src_rect.set(0,self.bitmap.height/2,self.bitmap.width,self.bitmap.height/2)
    else
      self.src_rect.set(0,0,self.bitmap.width,self.bitmap.height/2)
    end
    super
  end
end

class AchievementText < Sprite
  attr_reader :index
  attr_reader :name

  def initialize(x,y,description="",progress="",viewport=nil)
    super(viewport)
    @description=description
    @progress=progress
    @button=AnimatedBitmap.new("Graphics/Pictures/Achievements/achievementsText")
    @window=Window_AdvancedTextPokemon.newWithSize("",16,Graphics.height-96,Graphics.width-32,96,viewport)
    @window.letterbyletter=false
    @window.windowskin=nil
    #@window.baseColor=MessageConfig::LIGHTTEXTBASE
    @window.baseColor=MessageConfig::LIGHT_TEXT_MAIN_COLOR
    #@window.shadowColor=MessageConfig::LIGHTTEXTSHADOW
    @window.shadowColor=MessageConfig::LIGHT_TEXT_SHADOW_COLOR
    self.bitmap=@button.bitmap
    self.x=x
    self.y=y
    refresh
    update
  end

  def color=(val)
    @window.color=val
    super
  end
  
  def dispose
    @button.dispose
    @window.dispose
    super
  end

  def refresh
    @window.setText(@description+"\n"+"<ac>"+@progress+"</ac>")
  end

  def change(description,progress)
    @description=description.to_s
    @progress=progress.to_s
    refresh
  end
  
  def update
    @window.update
    super
  end
end

class PokemonAchievements_Scene
  def initialize(menu_index = 0)
    @menu_index = menu_index
    @buttons=[]
    @_buttons=[]
    @achievements=[]
    @achievementInternalNames=[]
  end
  #-----------------------------------------------------------------------------
  # start the scene
  #-----------------------------------------------------------------------------
  def pbStartScene(dex)
    if dex
		ownedbygen=[0,0,0,0,0,0,0,0,0,0,0]
		total = 0
		GameData::Species.each_species { |s| 
			if $player.pokedex.owned?(s)
				ownedbygen[s.generation] += 1
				total += 1
			end
		}
		Achievements.dexSetProgress("KANTO",ownedbygen[1])
		Achievements.dexSetProgress("JOHTO",ownedbygen[2])
		Achievements.dexSetProgress("HOENN",ownedbygen[3])
		Achievements.dexSetProgress("SINNOH",ownedbygen[4])
		Achievements.dexSetProgress("UNOVA",ownedbygen[5])
		Achievements.dexSetProgress("KALOS",ownedbygen[6])
		Achievements.dexSetProgress("ALOLA",ownedbygen[7])
		Achievements.dexSetProgress("GALAR",ownedbygen[8])
		Achievements.dexSetProgress("PALDEA",ownedbygen[9])
		
		Achievements.dexSetProgress("GLOBAL",total)
		
		buttonList={}
		al=Achievements.dexlist.keys
		al=al.sort{|a,b|Achievements.dexlist[a]["id"]<=>Achievements.dexlist[b]["id"]}
		al.each{|k|
		  @buttons.push(_INTL(Achievements.dexlist[k]["name"]))
		  @_buttons.push([k,_INTL(Achievements.dexlist[k]["goals"])]) #in case anyone wants to fix this, this line causes the error "no implicit conversion of Regexp into Integer", but it doesn't seem to affect functionality :) - Gardenette
		  
		  
		  @achievements.push(Achievements.dexlist[k])
		  @achievementInternalNames.push(k)
		  buttonList[k.to_s]=-1
		}
	else
		# Modifs de l'état des achievements ici ?
		Achievements.setProgress("STEPS",$PokemonGlobal.stepcount)
		Achievements.setProgress("WILD_ENCOUNTERS",$stats.wild_encounters)
		Achievements.setProgress("TRAINER_BATTLES",$stats.trainer_battles)
		Achievements.setProgress("CHALLENGER_BATTLES",$town.victoriesCount[5])
		Achievements.setProgress("ITEMS_BOUGHT",$stats.mart_items_bought)
	
		buttonList={}
		al=Achievements.list.keys
		al=al.sort{|a,b|Achievements.list[a]["id"]<=>Achievements.list[b]["id"]}
		al.each{|k|
		  @buttons.push(_INTL(Achievements.list[k]["name"]))
		  @_buttons.push([k,_INTL(Achievements.list[k]["goals"])]) #in case anyone wants to fix this, this line causes the error "no implicit conversion of Regexp into Integer", but it doesn't seem to affect functionality :) - Gardenette
		  
		  
		  @achievements.push(Achievements.list[k])
		  @achievementInternalNames.push(k)
		  buttonList[k.to_s]=-1
		}
	end
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @buttonport=Viewport.new(0,46,Graphics.width,250)
    @buttonport.z=99999
    @button=AnimatedBitmap.new("Graphics/Pictures/Achievements/achievementsButton")
    @sprites={}
	#edited to work with v21
    self.addBackgroundPlaneMod(@sprites,"background","Achievements/achievementsbg",@viewport)
    @sprites["command_window"] = Window_CommandPokemon.new(@buttons,160)
    @sprites["command_window"].visible = false
    @sprites["command_window"].index = @menu_index
    @sprites["achievementText"]=AchievementText.new(8,296,"Error.",_INTL("{1}/{2}","-1","-1"), @viewport)
	if dex
		currgoal=Achievements.getDexCurrentGoal(@achievementInternalNames[0])
		if currgoal
		  progress=_INTL("{1}/{2}",$PokemonGlobal.dexachievements[@_buttons[0][0]]["progress"],currgoal)
		else
		  progress=_INTL("{1}",$PokemonGlobal.dexachievements[@_buttons[0][0]]["progress"])
		end
		@sprites["achievementText"].change(_INTL(@achievements[0]["description"]),progress)
		@sprites["achievementText"].visible = true
		for i in 0...@buttons.length
		  x=8
		  y=(i*50)
		  @sprites["button#{i}"]=AchievementButton.new(dex,x,y,@buttons[i],_INTL("{1}/{2}",$PokemonGlobal.dexachievements[@_buttons[i][0]]["level"],@_buttons[i][1].length),@_buttons[i][0],@buttonport)
		  @sprites["button#{i}"].selected=(i==@sprites["command_window"].index)
		end
	else
		currgoal=Achievements.getCurrentGoal(@achievementInternalNames[0])
		if currgoal
		  progress=_INTL("{1}/{2}",$PokemonGlobal.achievements[@_buttons[0][0]]["progress"],currgoal)
		else
		  progress=_INTL("{1}",$PokemonGlobal.achievements[@_buttons[0][0]]["progress"])
		end
		@sprites["achievementText"].change(_INTL(@achievements[0]["description"]),progress)
		@sprites["achievementText"].visible = true
		for i in 0...@buttons.length
		  x=8
		  y=(i*50)
		  @sprites["button#{i}"]=AchievementButton.new(dex,x,y,@buttons[i],_INTL("{1}/{2}",$PokemonGlobal.achievements[@_buttons[i][0]]["level"],@_buttons[i][1].length),@_buttons[i][0],@buttonport)
		  @sprites["button#{i}"].selected=(i==@sprites["command_window"].index)
		end
	end
	
	if dex
		# Achievements dex
		if !$dexachievementmessagequeue.nil?
			$dexachievementmessagequeue.each_with_index {|m,i|
				$dexachievementmessagequeue.delete_at(i)
				Kernel.pbMessage(m)
				rewards = $dexachievementrewardsqueue[i]
				if rewards[0] == 410
					Kernel.pbSet(rewards[0],rewards[1])
					Kernel.pbReceiveItem(rewards[2])
					Kernel.pbMessage(rewards[2])
				else
					Kernel.pbSet(rewards[0],rewards[1])
					if rewards[1] == 3
						Kernel.pbReceiveItem(rewards[2])
					else
						Kernel.pbMessage(rewards[2])
					end
				end
				$dexachievementrewardsqueue.delete_at(i)
			}
		end
	else
		# Messages d'achievements complétés
		if !$achievementmessagequeue.nil?
			$achievementmessagequeue.each_with_index {|m,i|
				$achievementmessagequeue.delete_at(i)
				Kernel.pbMessage(m)
				Kernel.pbReceiveItem($achievementrewardsqueue[i])
				$achievementrewardsqueue.delete_at(i)
			}
		end
	end
    pbFadeInAndShow(@sprites) { update(dex) }
  end
  #-----------------------------------------------------------------------------
  # play the scene
  #-----------------------------------------------------------------------------
  def pbAchievements(dex)
    loop do
      Graphics.update
      Input.update
      update(dex)
      if Input.trigger?(Input::B)
        break
      end
    end
  end
  #-----------------------------------------------------------------------------
  # end the scene
  #-----------------------------------------------------------------------------
  def pbEndScene(dex)
    pbFadeOutAndHide(@sprites) { update(dex) }
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
  #-----------------------------------------------------------------------------
  # update the scene
  #-----------------------------------------------------------------------------
  def update(dex)
    if @sprites["command_window"].nil?
      pbUpdateSpriteHash(@sprites)
      return true
    end
    oldi = @sprites["command_window"].index rescue 0
    pbUpdateSpriteHash(@sprites)
    newi = @sprites["command_window"].index rescue 0
    if oldi!=newi
      @sprites["button#{oldi}"].selected=false
      @sprites["button#{oldi}"].update
      @sprites["button#{newi}"].selected=true
      @sprites["button#{newi}"].update
	  if dex
	    currgoal=Achievements.getDexCurrentGoal(@achievementInternalNames[newi])
		if currgoal
		  progress=_INTL("{1}/{2}",$PokemonGlobal.dexachievements[@_buttons[newi][0]]["progress"],currgoal)
		else
		  progress=_INTL("{1}",$PokemonGlobal.dexachievements[@_buttons[newi][0]]["progress"])
		end
	  else
		currgoal=Achievements.getCurrentGoal(@achievementInternalNames[newi])
		if currgoal
		  progress=_INTL("{1}/{2}",$PokemonGlobal.achievements[@_buttons[newi][0]]["progress"],currgoal)
		else
		  progress=_INTL("{1}",$PokemonGlobal.achievements[@_buttons[newi][0]]["progress"])
		end
	  end
      @sprites["achievementText"].change(_INTL(@achievements[newi]["description"]),progress)
      while @sprites["button#{newi}"].y>200
        for i in 0...@buttons.length
          @sprites["button#{i}"].y-=50
        end
      end
      while @sprites["button#{newi}"].y<0
        for i in 0...@buttons.length
          @sprites["button#{i}"].y+=50
        end
      end
    end
  end
  
  #added by Gardenette to work in v21.1
  def addBackgroundPlaneMod(sprites, planename, background, viewport = nil)
	sprites[planename] = AnimatedPlane.new(viewport)
	bitmapName = pbResolveBitmap("Graphics/Pictures/#{background}")
	if bitmapName.nil?
		# Plane should exist in any case
		sprites[planename].bitmap = nil
		sprites[planename].visible = false
	else
		sprites[planename].setBitmap(bitmapName)
		sprites.each_value do |spr|
		spr.windowskin = nil if spr.is_a?(Window)
		end
	end
  end #def self.addBackgroundPlaneMod
  
end

class PokemonAchievements
  def initialize(scene)
    @scene=scene
  end

  def pbStartScreen(dex=false)
    @scene.pbStartScene(dex)
    @scene.pbAchievements(dex)
    @scene.pbEndScene(dex)
  end
end