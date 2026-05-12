

module Settings
	#===========================================================================
	#=============================== Settings ==================================
	#===========================================================================

	#---------------------------------------------------------------------------
	#  Here you can define premade sets of parameters for number scales, so you
	#  don't have to always adjust parameters manually for common number scales
	#  in your game. Each premade set definition is a hash, where the key is the 
	#  ID of the set. Within each definition hash, the keys are functions you 
	#  would normally use to alter an instance of ChooseNumberScaleParams, but 
	#  as a string. The values are the arguments you'd include for that function.
	#  Multiple arguments must be grouped in an array.
	#  Example 1: If you want to set the range for a set, since the function for
	#  that is normally setRange(min_number, max_number), you would add
	#	 "setRange" => [min_number, max_number]
	#	 Example 2: If you want to set the tick length for a set, since the
	#  function for that is normally setTickLength(length), you would add
	#  "setTickLength" => length
	#---------------------------------------------------------------------------	
  CHOOSE_NUMBER_SCALE_PARAM_PREMADES = {
    :EV => {
      "setLabelSuffix" => "EV",
    },
    :Percent => {
      "setRange" => [0,100],
      "setInitialValue" => 50,
      "setLongTickInterval" => 10,
      "setVisibleNumbers" => [0,10,20,30,40,50,60,70,80,90,100],
      "setLabelSuffix" => _INTL("%"),
      "setCancelValue" => -1,
    },
    :OvenF => {
      "setRange" => [200,500],
      "setInitialValue" => 350,
      "setCancelValue" => -1,
      "setInterval" => 5,
      "setLongTickInterval" => 50,
      "setVisibleNumbers" => [200,300,400,500],
      "setLabelSuffix" => _INTL("°F"),
      "setCursorGraphic" => "cursor_fire"
    },
    :OvenC => {
      "setRange" => [100,260],
      "setInitialValue" => 175,
      "setCancelValue" => -1,
      "setInterval" => 5,
      "setLongTickInterval" => 20,
      "setVisibleNumbers" => [100,140,180,220,260],
      "setLabelSuffix" => _INTL("°C"),
      "setCursorGraphic" => "cursor_fire",
      "setConditionalCursorGraphics" => [[100,120,"cursor_fire_verylow"], [120,160,"cursor_fire_low"], 
                                        [200,240,"cursor_fire_high"], [240,260,"cursor_fire_veryhigh"]]
    },
    :Range1 => {
      "setInitialValue" => 55,
      "setSelectedValues" => 55,
      "setCancelValue" => -1,
      "setInterval" => 5,
      "setVisibleNumbers" => [0,10,20,30,40,50,60,70,80,90,100],
      "setRangeChoices" => [[0,25,Color.new(80,118,192)],[25,55,Color.new(86,144,250)],[55,85,Color.new(252,124,80)],[85,100,Color.new(204,86,46)]],
      "setRangeCursorLabels" => [_INTL("Much Lower"),_INTL("Lower"),_INTL("Higher"),_INTL("Much Higher")]
    }
  }
end