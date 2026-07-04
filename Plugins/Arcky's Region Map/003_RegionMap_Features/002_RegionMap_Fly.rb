class PokemonRegionMap_Scene
  def getFlyIconPositions
    @mapInfo.each do |key, value|
      selFlySpots = Hash.new { |hash, key| hash[key] = [] }
      value[:positions].each do |pos|
        flySpot = pos[:flyspot]
        next if flySpot.empty?
        key = [flySpot[:map], flySpot[:x], flySpot[:y]]
        selFlySpots[key] << [flySpot, pos[:x], pos[:y]]
      end
      selFlySpots.each do |index, spot|
        visited = visited = spot.any? { |map| map[0][:visited] }
        name = visited ? "mapFly" : "mapFlyDis"
        centerX = spot.map { |map| map[1] }.sum.to_f / spot.length
        centerY = spot.map { |map| map[2] }.sum.to_f / spot.length
        original = spot.map { |map| { x: map[1], y: map[2] } }
        result = [centerX, centerY]
        unless result.nil?
          value[:flyicons] << { name: name, x: result[0], y: result[1], originalpos: original }
        end
      end
    end
  end
  
  def getTownDevIconPositions
    limit = getFameLimit
	#puts @mapInfo
    @mapInfo.each do |key, value|
      selFlySpots = Hash.new { |hash, key| hash[key] = [] }
      value[:positions].each do |pos|
        flySpot = pos[:flyspot]
        next if flySpot.empty?
        key = [flySpot[:map], flySpot[:x], flySpot[:y]]
        selFlySpots[key] << [flySpot, pos[:x], pos[:y]]
      end
      selFlySpots.each do |index, spot|
		if $town.getBuildingData(index[0])[2] == 0 || $town.buildings[index[0]] > 0
			if $town.buildings[index[0]] > $town.getBuildingData(index[0])[1]
				name = "TownDevBuilt"
			else
				name = "TownDevWIP"
			end
		else
			name = "TownDevUnbuilt"
		end
		centerX = spot.map { |map| map[1] }.sum.to_f / spot.length
        centerY = spot.map { |map| map[2] }.sum.to_f / spot.length
        original = spot.map { |map| { x: map[1], y: map[2] } }
        result = [centerX, centerY]
        unless result.nil?
          value[:flyicons] << { name: name, x: result[0], y: result[1], originalpos: original }
        end
      end
    end
  end

  def addFlyIconSprites
    if !@spritesMap["FlyIcons"]
      @spritesMap["FlyIcons"] = BitmapSprite.new(@mapWidth, @mapHeight, @viewportMap)
      @spritesMap["FlyIcons"].x = @spritesMap["map"].x
      @spritesMap["FlyIcons"].y = @spritesMap["map"].y
      @spritesMap["FlyIcons"].visible = @mode == 1
    end
    @spritesMap["FlyIcons"].z = 15
    @mapInfo.each do |key, value|
      value[:flyicons].each do |spot|
        next if spot.nil?
        pbDrawImagePositions(
          @spritesMap["FlyIcons"].bitmap,
          [["#{FOLDER}Icons/Fly/#{spot[:name]}", pointXtoScreenX(spot[:x]), pointYtoScreenY(spot[:y])]]
        )
      end
    end
    @spritesMap["FlyIcons"].visible = @mode == 1
  end
  
  def getFameLimit
	fame = $town.calculateFameLvl
	if fame < 1
		limit = 35
	else
		if fame < 5
			limit = 30
		else
			if fame < 10
				limit = 25
			else
				if fame < 20
					limit = 20
				else
					if fame < 30
						limit = 15
					else
						if fame < 50
							limit = 10
						else
							if fame < 70
								limit = 5
							else
								limit = 0
							end
						end
					end
				end
			end
		end
	end
	return limit
  end	
  
  def addDevIconSprites
	if !@spritesMap["FlyIcons"]
		@spritesMap["FlyIcons"] = BitmapSprite.new(@mapWidth, @mapHeight, @viewportMap)
		@spritesMap["FlyIcons"].x = @spritesMap["map"].x
		@spritesMap["FlyIcons"].y = @spritesMap["map"].y
		@spritesMap["FlyIcons"].visible = true
	end
    @spritesMap["FlyIcons"].z = 15
	limit = getFameLimit
    @mapInfo.each do |key, value|
      value[:flyicons].each do |spot|
        next if spot.nil? 
		next if	spot[:y] < limit
        pbDrawImagePositions(
          @spritesMap["FlyIcons"].bitmap,
          [["#{FOLDER}Icons/Dev/#{spot[:name]}", pointXtoScreenX(spot[:x]), pointYtoScreenY(spot[:y])]]
        )
      end
    end
    @spritesMap["FlyIcons"].visible = true
  end

  def getFlyLocationAndConfirm
    @healspot = pbGetHealingSpot(@mapX, @mapY)
    if @healspot && ($PokemonGlobal.visitedMaps[@healspot[0]] || ($DEBUG && Input.press?(Input::CTRL)))
	  if @healspot[0] == 245 && $town.weekday > 0
		messageMap(_INTL("It's not the weekend. You can't go to Camosack!"))
		return false
	  else
		name = pbGetMapNameFromId(@healspot[0])
		return confirmMessageMap(_INTL("Would you like to use Fly to go to {1}?", name))
	  end
    end
  end
  
  def getTownDevAndConfirm
    @sprites["cursor"].visible = false
	@sprites["upArrow"].visible = false
	@sprites["downArrow"].visible = false
	@sprites["leftArrow"].visible = false
	@sprites["rightArrow"].visible = false
    infos = pbGetTownDevInfos(@mapX, @mapY)
    if infos
		name = _INTL("{1} - {2}", infos[0], infos[1])
		index = infos[2]
		data = $town.getBuildingData(infos[2])
		pbShowTipCard(("TOWNDEV"+(index.to_s)).to_sym,("TOWNDEV"+(index.to_s)+"REWARDS").to_sym)
		@sprites["cursor"].visible = true
		@sprites["upArrow"].visible = true
		@sprites["downArrow"].visible = true
		@sprites["leftArrow"].visible = true
		@sprites["rightArrow"].visible = true
		
		
		# Construction non achetée
		if $town.buildings[index] == 0
		
			# Vérification prérequis
			pre = data[3]
			flag = false
			
			# Bâtiments
			pre.length.times do |i|
				flag = true if not $town.finished?(pre[i])
			end
			
			
			if flag 
				messageMap(_INTL("Prerequisites not satisfied."))
				pbPlayCancelSE
			else
				if $town.funds < (data[2]*1000)
					messageMap(_INTL("Cost: $") + (data[2]*1000).floor().to_s + ". " + _INTL("Funds available: $") + $town.funds.floor().to_s + ".\n" + _INTL("Not enough funds to invest on this task"))
					pbPlayCancelSE
				else
					if confirmMessageMap(_INTL("Cost: $") + (data[2]*1000).floor().to_s + ". " + _INTL("Funds available: $") + $town.funds.to_i.to_s + ".\n" + _INTL("Do you want to invest on this task ?"))
						pbPlayDecisionSE
						$town.funds -= (data[2]*1000).floor()
						$town.buildings[index] = 1
						messageMap(_INTL("Investment complete !"))
						if data[1] == 0
							pbPlayLevelUpSE
							$town.build(infos[2])
							messageMap(_INTL("As an instant build, the task is completed !"))
							@spritesMap["FlyIcons"].bitmap.clear
						end
					else
						pbPlayCancelSE
					end
				end
			end
		else
			if data[1] < $town.buildings[index]
				messageMap(_INTL("Task already done."))
			end	
		end
		
		# Construction en cours ou tout juste achetée
		if data[1] >= $town.buildings[index] && $town.buildings[index] > 0
			while true
				unassigned = $town.totalworkers
				onthistask = 0
				$town.workers.length.times do |i|
					if $town.workers[i] > -1
						unassigned -= 1
						if $town.workers[i] == index
							onthistask += 1
						end
					end
				end
				message = _INTL("Progression:") + " " + ($town.buildings[index]-1).to_s + " / " + data[1].to_s + "\n" + _INTL("Workers:") + " " + onthistask.to_s + " " + _INTL("on this task ;") + " " + unassigned.to_s + " " + _INTL("free") 
				missing = 1 + data[1] - $town.buildings[index]
				if $town.weekday != 0 && $town.weekday != 8
					messageMap(message)
					break
				else
					case pbChangeWorkers(message, onthistask, unassigned, missing)
					when 0 # Add a worker on this task
						$town.workers.length.times do |i|
							if $town.workers[i] == -1
								$town.workers[i] = index
								break
							end
						end
					when 1 # Remove a worker from this task
						$town.workers.length.times do |i|
							if $town.workers[i] == index
								$town.workers[i] = -1
								break
							end
						end
					else 
						break
					end
				end
			end
		end
    end
  end

  def canFlyOtherRegion
    @mapName = @playerMapName if !@mapName
    return false if !ARMSettings::AllowFlyToOtherRegions
    flyRegion = ARMSettings::FlyToRegions
    regionName = (@currentRegionName).to_sym
    canFly = flyRegion.key?(regionName) && flyRegion[regionName].include?(@region)
    return true if canFly && ARMSettings::LocationFlyToOtherRegion.key?(regionName) && ARMSettings::LocationFlyToOtherRegion[regionName].include?(@mapName)
  end

  def canActivateQuickFly(lastChoiceFly, cursor)
    @visited = getFlyLocations
    return if @visited.empty?
    if enableMode(ARMSettings::CanQuickFly) && Input.trigger?(ARMSettings::QuickFlyButton)
      findChoice = @visited.find_index { |pos| pos[:x] == @mapX && pos[:y] == @mapY }
      lastChoiceFly = findChoice if findChoice
      choice = messageMap(_INTL("Quick Fly: Choose one of the available locations to fly to."),
          (0...@visited.size).to_a.map{ |i| "#{@visited[i][:name]}" }, -1, nil, lastChoiceFly, true) { pbUpdate }
      if choice != -1
        @mapX = @visited[choice][:x]
        @mapY = @visited[choice][:y]
      elsif choice == -1
        @mapX = cursor[:oldX]
        @mapY = cursor[:oldY]
      end
      @sprites["cursor"].x = 8 + (@mapX * ARMSettings::SquareWidth)
      @sprites["cursor"].y = 24 + (@mapY * ARMSettings::SquareHeight)
      @sprites["cursor"].x -= UI_BORDER_WIDTH if ARMSettings::RegionMapBehindUI
      @sprites["cursor"].y -= UI_BORDER_HEIGHT if ARMSettings::RegionMapBehindUI
      pbGetMapLocation(@mapX, @mapY)
      centerMapOnCursor
    end
    return choice
  end

  def getFlyLocations
    visits = []
    @mapInfo.each do |key, value|
      value[:positions].each do |pos|
        next if pos[:flyspot].empty? || !pos[:flyspot][:visited]
        sel = { name: value[:mapname], x: pos[:x], y: pos[:y], flyspot: pos[:flyspot] }
        visits << sel unless visits.any? { |visited| visited[:flyspot] == sel[:flyspot] }
      end
    end
    return visits
  end
end
