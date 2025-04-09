class PokemonRegionMap_Scene

  def refreshFlyScreen
    return if @flyMap
    mapModeSwitchInfo
    if @previewBox.isShown
      @previewBox.hideIt
      hidePreviewBox
    end
    showAndUpdateMapInfo
    getPreviewWeather
    @spritesMap["FlyIcons"].visible = @mode == 1
    @spritesMap["QuestIcons"].visible = @spritesMap["QuestSelect"].visible = @mode == 2 if QUESTPLUGIN && ARMSettings::ShowQuestIcons
    @spritesMap["BerryIcons"].visible = @mode == 3 if BERRYPLUGIN && allowShowingBerries
    @spritesMap["RoamingIcons"].visible = @mode == 4 if enableMode(ARMSettings::ShowRoamingIcons)
    @spritesMap["highlight"].bitmap.clear if @spritesMap["highlight"]
    colorCurrentLocation
  end

  def mapModeSwitchInfo
    return if @zoom
    if !@sprites["modeName"] && !@sprites["buttonName"]
      @sprites["modeName"] = BitmapSprite.new(Graphics.width, Graphics.height, @Viewport)
      pbSetSystemFont(@sprites["modeName"].bitmap)
      @sprites["buttonName"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
      pbSetSystemFont(@sprites["buttonName"].bitmap)
      showButtonPreview
      text2Pos = getTextPosition
      @sprites["buttonPreview"].x = text2Pos[0]
      @sprites["buttonPreview"].y = text2Pos[1]
    end
    unless @flyMap || @wallmap
      return if !@sprites["modeName"] || !@sprites["buttonName"]
      @modeInfo = {
        :normal => {
          mode: 0,
          text: pbGetMessageFromHash(SCRIPTTEXTS, "#{ARMSettings::ModeNames[:normal]}"),
          condition: true
        },
        :fly => {
          mode: 1,
          text: pbGetMessageFromHash(SCRIPTTEXTS, "#{ARMSettings::ModeNames[:fly]}"),
          condition: pbCanFly? && ((!@playerPos.nil? && @region == @playerPos[0]) || canFlyOtherRegion) && ARMSettings::CanFlyFromTownMap
        },
        :quest => {
          mode: 2,
          text: pbGetMessageFromHash(SCRIPTTEXTS, "#{ARMSettings::ModeNames[:quest]}"),
          condition: QUESTPLUGIN && enableMode(ARMSettings::ShowQuestIcons) && !@questMap.empty?
        },
        :berry => {
          mode: 3,
          text: pbGetMessageFromHash(SCRIPTTEXTS, "#{ARMSettings::ModeNames[:berry]}"),
          condition: BERRYPLUGIN && enableMode(ARMSettings::ShowBerryIcons) && !pbGetBerriesAtMapPoint(@region).empty?
        },
        :roaming => {
          mode: 4,
          text: pbGetMessageFromHash(SCRIPTTEXTS, "#{ARMSettings::ModeNames[:roaming]}"),
          condition: enableMode(ARMSettings::ShowRoamingIcons) && $PokemonGlobal.roamPosition.any? { |roamPos| getActiveRoaming(roamPos) && getRoamingTownMapPos(roamPos) }
        }
      }
      @modeCount = @modeInfo.values.count { |mode| mode[:condition] }
      if @modeCount == 1
        text = ""
        @sprites["modeName"].bitmap.clear
        @sprites["buttonPreview"].visible = false
        return
      end
      text = @modeInfo[:normal][:text]
      @modeInfo.each do |mode, data|
        if data[:mode] == @mode && data[:condition]
          text = data[:text]
          break
        end
      end
    else
      text = ""
      text2 = ""
      @modeCount = 1
    end
    @sprites["mapbottom"].previewName = ["", @previewWidth] if @sprites["mapbottom"]
    updateButtonInfo if !ARMSettings::ButtonBoxPosition.nil?
    @sprites["modeName"].bitmap.clear
    pbDrawTextPositions(
      @sprites["modeName"].bitmap,
      [[text, Graphics.width - (22 - ARMSettings::ModeNameOffsetX), 4 + ARMSettings::ModeNameOffsetY, 1, ARMSettings::ModeTextMain, ARMSettings::ModeTextShadow]]
    )
    @sprites["modeName"].z = 100001
  end

  def enableMode(setting)
    case setting
    when Numeric
      return $game_switches[setting] if setting > 0
    when TrueClass
      return true
    end
    return false
  end

  def switchMapMode
    if @modeCount > 2 && ARMSettings::ChangeModeMenu
      @choiceMode = 0 if !@choiceMode
      avaModes = @modeInfo.values.select { |mode| mode[:condition] }
      choice = messageMap(_INTL("Which mode would you like to switch to?"),
      avaModes.map { |mode| "#{mode[:text]}" }, -1, nil, @choiceMode) { pbUpdate }
      if choice != -1
        @choiceMode = choice
        @mode = avaModes[choice][:mode]
      end
    elsif @modeCount == 2
      pbPlayDecisionSE
      nextMode = 0
      @modeInfo.each do |index, data|
        next if data[:mode] <= @mode
        if data[:condition]
          nextMode = data[:mode]
          break
        end
      end
      @mode = nextMode
    end
    @sprites["modeName"].bitmap.clear
    refreshFlyScreen
    @sprites["mapbottom"].previewName = [getPreviewName(@mapX, @mapY), @previewWidth] if @mode == 2 || @mode == 3 || @mode == 4
    @sprites["buttonName"].bitmap.clear
  end
end
