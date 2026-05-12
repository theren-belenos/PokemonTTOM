def pbNumberScale(message = nil, params = nil, &block)
  if params.is_a?(Symbol) && Settings::CHOOSE_NUMBER_SCALE_PARAM_PREMADES[params]
    params = ChooseNumberScaleParams.new(params)
  end
  params = params || ChooseNumberScaleParams.new
  if message
    msgwindow = pbCreateMessageWindow(nil, params.messageSkin)
    ret = pbMessageDisplay(msgwindow, message, true,
                          proc { |msgwindow|
                            next pbChooseNumberOnScale(msgwindow, params, &block)
                          }, &block)
  else
    ret = pbChooseNumberOnScale(nil, params)
  end
  $game_variables[params.resultVariable] = ret 
  pbDisposeMessageWindow(msgwindow) if msgwindow
  return ret
end

#===============================================================================
#
#===============================================================================
class ChooseNumberScaleParams
  attr_reader :messageSkin   # Set the full path for the message's window skin
  attr_reader :skin
  attr_reader :tickLength
  attr_reader :longTickInterval
  attr_reader :visibleNumbers
  attr_reader :interval
  attr_reader :rangeHelpers
  attr_reader :rangeChoices
  attr_reader :rangeLabels
  attr_reader :cursorGraphic
  attr_reader :cursorGraphicConditional
  attr_reader :selectedCursorGraphic
  attr_reader :labelPrefix
  attr_reader :labelSuffix
  attr_reader :cursorYAdj
  attr_reader :widthAdj
  attr_reader :heightAdj
  attr_reader :topLabel
  attr_reader :bottomLabel
  attr_reader :selectedNumber

  def initialize(premade = nil)
    @minNumber = 0
    @maxNumber = 100
    @skin = nil
    @messageSkin = nil
    @initialNumber = 0
    @cancelNumber = 0
    @selectedNumber = nil
    @resultVariable = 1
    @xPos = :center
    @yPos = :center
    @longTickInterval = 5
    @tickLength = 8
    @visibleNumbers = [@minNumber, @maxNumber]
    @interval = 1
    @rangeChoices = nil
    @rangeHelpers = nil
    @rangeLabels = nil
    @cursorGraphic = "cursor"
    @cursorGraphicConditional = nil
    @selectedCursorGraphic = "cursor_selected"
    @labelPrefix = ""
    @labelSuffix = ""
    @cursorYAdj = 0
    @widthAdj = 0
    @heightAdj = 0
    @topLabel = nil
    @bottomLabel = nil
    if premade
        data = Settings::CHOOSE_NUMBER_SCALE_PARAM_PREMADES[premade]
        data.each do |key, value|
            next unless self.respond_to?(key)
            public_send(key, *value)
        end
    end
  end

  def setRange(minNumber, maxNumber)
    maxNumber = minNumber if minNumber > maxNumber
    @minNumber = minNumber
    @maxNumber = maxNumber
    @visibleNumbers = [@minNumber, @maxNumber]
  end

  def setInterval(value)
    @interval = value
  end

  def setInitialValue(number)
    @initialNumber = number
  end

  def setCancelValue(number)
    @cancelNumber = number
  end

  def setMessageSkin(value)
    @messageSkin = "Graphics/Windowskins/#{value}"
  end

  def setSkin(value)
    @skin = "Graphics/Windowskins/#{value}"
  end

  def setCursorGraphic(value)
    @cursorGraphic = value
  end

  def setConditionalCursorGraphics(*value)
    value = nil if value.none?
    @cursorGraphicConditional = value
  end

  def setTopLabel(value)
    @topLabel = value
  end

  def setBottomLabel(value)
    @bottomLabel = value
  end

  def setXPosition(pos)
    @xPos = pos
  end

  def xPosition
    return @xPos
  end

  def setYPosition(pos)
    @yPos = pos
  end

  def yPosition
    return @yPos
  end

  def setWidthAdjust(value)
    @widthAdj = value
  end

  def setHeightAdjust(value)
    @heightAdj = value
  end

  def setCursorYAdjust(value)
    @cursorYAdj = value
  end

  def setTickLength(value)
    @tickLength = value
  end

  def setLongTickInterval(value)
    @longTickInterval = value
  end

  def setVisibleNumbers(*numbers)
    numbers = nil if numbers.none?
    @visibleNumbers = numbers
  end

  def setLabelPrefix(value)
    @labelPrefix = value
  end

  def setLabelSuffix(value)
    @labelSuffix = value
  end

  def setSelectedValues(*numbers)
    numbers = nil if numbers.none?
    @selectedNumber = numbers
  end

  def setSelectedCursorGraphic(*value)
    value = nil if value.none?
    @selectedCursorGraphic = value
  end

  def setRangeChoices(*ranges)
    @rangeChoices = ranges.map {|a| a.clone}
    @rangeHelpers = ranges.map {|a| a.clone}
  end

  def setRangeHelpers(*ranges)
    @rangeHelpers = ranges
  end

  def setRangeCursorLabels(*labels)
    @rangeLabels = labels
  end

  def initialNumber
    return clamp(@initialNumber, self.minNumber, self.maxNumber)
  end

  def cancelNumber
    return @cancelNumber || nil
  end

  def minNumber
    return @minNumber
  end

  def maxNumber
    return @maxNumber
  end

  def resultVariable
    return @resultVariable
  end

  #-----------------------------------------------------------------------------

  private

  def clamp(v, mn, mx)
    return v < mn ? mn : (v > mx ? mx : v)
  end
end

#===============================================================================
#
#===============================================================================
def pbChooseNumberOnScale(msgwindow = nil, params = nil)
  params = ChooseNumberParams.new if !params
  ret = 0
  maximum = params.maxNumber
  minimum = params.minNumber
  cancelNumber = params.cancelNumber
  cmdwindow = Window_InputNumberScalePokemon.new(minimum, maximum, params)
  cmdwindow.z = 99999
  cmdwindow.visible = true
  case params.xPosition
  when Integer
    cmdwindow.x = params.xPosition
  when :left
    cmdwindow.x = 0
  when :right
    cmdwindow.x = Graphics.width - cmdwindow.width
  else
    cmdwindow.x = (Graphics.width - cmdwindow.width) / 2
  end
  case params.yPosition
  when Integer
    cmdwindow.y = params.yPosition
  when :top
    cmdwindow.y = 0
  when :bottom
    cmdwindow.y = Graphics.height - cmdwindow.height - (msgwindow&.height || 0)
  else
    cmdwindow.y = (Graphics.height - cmdwindow.height - (msgwindow&.height || 0)) / 2
  end
  cmdwindow.create_cursor
  loop do
    Graphics.update
    Input.update
    pbUpdateSceneMap
    cmdwindow.update
    msgwindow&.update
    yield if block_given?
    if Input.trigger?(Input::USE)
      if params.rangeChoices
        ret = cmdwindow.range
        pbPlayDecisionSE
        break
      else
        ret = cmdwindow.number
        if ret > maximum
          pbPlayBuzzerSE
        elsif ret < minimum
          pbPlayBuzzerSE
        else
          pbPlayDecisionSE
          break
        end
      end
    elsif Input.trigger?(Input::BACK)
      pbPlayCancelSE
      ret = cancelNumber
      break
    end
  end
  cmdwindow.dispose
  Input.update
  return ret
end

#===============================================================================
#
#===============================================================================
class Window_InputNumberScalePokemon < SpriteWindow_Base
  attr_reader :sign

  def initialize(minimum, maximum, params)
    super(0, 0, 32, 32)
    @topLabel = params.topLabel
    @bottomLabel = params.bottomLabel
    self.width = Graphics.width + params.widthAdj
    self.height = 96 + self.borderY + params.heightAdj + (@bottomLabel ? 24 : 0) + (@topLabel ? 24 : 0)
    self.setSkin(params.skin) if params.skin
    colors = getDefaultTextColors(self.windowskin)
    @baseColor = colors[0]
    @shadowColor = colors[1]
    @yPos = self.height - 64 - (@bottomLabel ? 24 : 0)
    @minimum = minimum
    @maximum = maximum
    @index = params.initialNumber - @minimum
    @longTickInterval = params.longTickInterval
    @tickLength = params.tickLength
    @visibleNumbers = params.visibleNumbers
    @interval = params.interval
    @cursorGraphic = params.cursorGraphic
    @cursorGraphicConditional = params.cursorGraphicConditional
    @rangeChoices = params.rangeChoices
    @rangeHelpers = params.rangeHelpers
    @rangeLabels = params.rangeLabels
    @labelPrefix = params.labelPrefix
    @labelSuffix = params.labelSuffix
    @cursorYAdj = params.cursorYAdj
    @selectedNumber = params.selectedNumber
    @selectedCursorGraphic = params.selectedCursorGraphic
    adjust_range_choices
    self.active = true
    refresh
  end

  def active=(value)
    super
    refresh
  end

  def number(index = @index)
    return index + @minimum
  end

  def range
    arr = @rangeChoices[@range_index]
    return [arr[0], arr[1]]
  end

  def range_index
    return @range_index
  end

  def create_cursor
    @viewport = Viewport.new(self.x, self.y, self.width, self.height)
    @viewport.z = 99999
    @cursor = IconSprite.new(@xPos, @yPos, @viewport)
    @cursorGraphic = "cursor" if !pbResolveBitmap("Graphics/UI/Number Scale Choice/#{@cursorGraphic}")
    @cursor.setBitmap("Graphics/UI/Number Scale Choice/#{@cursorGraphic}")
    @cursor_overlay = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    pbSetSystemFont(@cursor_overlay.bitmap)
    update_cursor
  end

  def update_cursor
    @cursor.x = @xPos + @index * @tickWidth # - @tickWidth/2 # - @cursor.width/2
    @cursor.y = @yPos - @tickLength/2 - @cursor.height/2 + @cursorYAdj
    @cursor_overlay.bitmap.clear
    string = @labelPrefix + number.to_s + @labelSuffix
    if @rangeChoices
      if @rangeChoices[@range_index][3] && @rangeChoices[@range_index][3] != ""
        string = @rangeChoices[@range_index][3] 
      else
        string = "#{@rangeChoices[@range_index][0]} - #{@rangeChoices[@range_index][1]}" 
      end
      
    end
    if @cursorGraphicConditional
      use_default = true
      @cursorGraphicConditional.each do |min, max, graphic|
        if number.between?(min, max)
          @cursor.setBitmap("Graphics/UI/Number Scale Choice/#{graphic}")
          use_default = false
          break
        end
      end
      @cursor.setBitmap("Graphics/UI/Number Scale Choice/#{@cursorGraphic}") if use_default
    end
    pbDrawTextPositions(@cursor_overlay.bitmap,[[string, @cursor.x + @cursor.width/2, @cursor.y - @cursor.height/2 - 8, 2, @baseColor, @shadowColor]])
  end

  def adjust_range_choices
    return unless @rangeChoices
    @rangeChoices.each_with_index do |r, i|
      @rangeChoices[i][2] = (r[0] + r[1]) / 2
      if @rangeLabels
        @rangeChoices[i][3] = @rangeLabels[i] || @rangeLabels[0] || nil
      end
    end
    @rangeChoices.sort_by! { |v| v[2]}
    closest = @rangeChoices.min_by {|v| (v[2] - number).abs}
    @index = closest[2] - @minimum
    @range_index = @rangeChoices.index(closest)
  end

  def refresh
    self.contents = pbDoEnsureBitmap(self.contents,
                                     self.width - self.borderX, self.height - self.borderY)
    pbSetSmallFont(self.contents)
    self.contents.clear
    @tickWidth = ((self.contents.width - self.borderX*2 )/ (@maximum - @minimum)).floor
    @scaleWidth = @tickWidth * (@maximum - @minimum)
    @xPos = (self.contents.width - @scaleWidth) / 2
    start_x = 0
    end_x = 0
    (@minimum..@maximum).each_with_index do |n, i|
      next if @interval > 1 && i % @interval != 0
      x = @xPos + @tickWidth * i #- @tickWidth / 2
      y = @yPos
      length = @tickLength
      if n % @longTickInterval == 0
        y -= length / 2
        length *= 2
      end
      draw_vertical_line(x, y, length)
      start_x = x if n == @minimum
      end_x = x if n == @maximum
      if @visibleNumbers&.include?(n)
        string = @labelPrefix + n.to_s + @labelSuffix
        pbDrawTextPositions(self.contents, [[string, x, y + length + 2, 2, @baseColor, @shadowColor]])
      end
    end
    draw_horizontal_line(start_x, @yPos + @tickLength/2, end_x - start_x)
    if @rangeHelpers
      @rangeHelpers.each do |min, max, color|
        color = Color.new(color) if color.is_a?(String)
        y = @yPos - @tickLength/2
        y -= 1 if y.odd?
        draw_horizontal_line(@xPos + @tickWidth * (min - @minimum), y, 
            @tickWidth * (max - min), 6, color || @baseColor)
      end
    end
    if @selectedNumber
      imgpos = []
      @selectedNumber.each_with_index do |n, i|
        next unless n.between?(@minimum, @maximum)
        graphic = @selectedCursorGraphic[i] || @selectedCursorGraphic[0] || "cursor_selected"
        graphic = "cursor_selected" if !pbResolveBitmap("Graphics/UI/Number Scale Choice/#{graphic}")
        temp_bmp = Bitmap.new("Graphics/UI/Number Scale Choice/#{graphic}") rescue nil
        imgpos.push(["Graphics/UI/Number Scale Choice/#{graphic}", 
            @xPos + (n - @minimum) * @tickWidth - (temp_bmp ? temp_bmp.width/2 : 16), @yPos - @tickLength/2 - (temp_bmp ? temp_bmp.height : 32)])
        temp_bmp&.dispose
      end
      pbDrawImagePositions(self.contents, imgpos)
    end
    if @bottomLabel || @topLabel
      pbSetSystemFont(self.contents)
      textpos = []
      textpos.push([@topLabel, self.contents.width/2, 0, 2, @baseColor, @shadowColor]) if @topLabel
      textpos.push([@bottomLabel, self.contents.width/2, self.contents.height - 24, 2, @baseColor, @shadowColor]) if @bottomLabel
      pbDrawTextPositions(self.contents, textpos) 
      pbSetSmallFont(self.contents)
    end
  end

  def update
    super
    if self.active
      if Input.repeat?(Input::RIGHT) 
        if @rangeChoices
          if @range_index < @rangeChoices.length - 1
            @range_index += 1
            @index = @rangeChoices[@range_index][2] - @minimum
            pbPlayCursorSE
            update_cursor
          end
        elsif number < @maximum
          pbPlayCursorSE
          @index += 1 * @interval
          @index = @maximum - @minimum if number > @maximum
          update_cursor
        end
      elsif Input.repeat?(Input::LEFT)
        if @rangeChoices
          if @range_index > 0
            @range_index -= 1
            @index = @rangeChoices[@range_index][2] - @minimum
            pbPlayCursorSE
            update_cursor
          end
        elsif number > @minimum
          pbPlayCursorSE
          @index -= 1 * @interval
          @index = 0 if number < @minimum
          update_cursor
        end
      elsif Input.repeat?(Input::UP)
        if @rangeChoices
          if @range_index < @rangeChoices.length - 1
            @range_index = @rangeChoices.length - 1
            @index = @rangeChoices[@range_index][2] - @minimum
            pbPlayCursorSE
            update_cursor
          end
        elsif number < @maximum
          pbPlayCursorSE
          @index = @maximum - @minimum
          update_cursor
        end
      elsif Input.repeat?(Input::DOWN)
        if @rangeChoices
          if @range_index > 0
            @range_index = 0
            @index = @rangeChoices[@range_index][2] - @minimum
            pbPlayCursorSE
            update_cursor
          end
        elsif number > @minimum
          pbPlayCursorSE
          @index = 0
          update_cursor
        end
      elsif Input.repeat?(Input::JUMPDOWN)
        if @rangeChoices
          if @range_index < @rangeChoices.length - 1
            @range_index += 1
            @index = @rangeChoices[@range_index][2] - @minimum
            pbPlayCursorSE
            update_cursor
          end
        elsif number < @maximum
          new_index = [@index + @longTickInterval, @maximum - @minimum].min
          if new_index != @index
            pbPlayCursorSE
            @index = new_index
            update_cursor
          end
        end
      elsif Input.repeat?(Input::JUMPUP)
        if @rangeChoices
          if @range_index > 0
            @range_index -= 1
            @index = @rangeChoices[@range_index][2] - @minimum
            pbPlayCursorSE
            update_cursor
          end
        elsif number > @minimum
          new_index = [@index - @longTickInterval, 0].max
          if new_index != @index
            pbPlayCursorSE
            @index = new_index
            update_cursor
          end
        end
      end
    end
  end

  def dispose
    super
    @cursor.dispose
    @cursor_overlay.dispose
  end

  def draw_vertical_line(x, y, length, thickness = 2, color = @baseColor)
    x -= thickness/2
    self.contents.fill_rect(x, y, thickness, length, color)
  end

  def draw_horizontal_line(x, y, length, thickness = 2, color = @baseColor)
    y -= thickness/2
    self.contents.fill_rect(x, y, length, thickness, color)
  end

end