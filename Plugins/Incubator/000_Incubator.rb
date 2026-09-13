#-------------------------------------------------------------------------------
# [INCUBATOR]
# Name = Incubator
# NamePlural = Incubators
# Pocket = 8
# Price = 0
# FieldUse = Direct
# Flags = KeyItem
# Description = An Incubator in which to keep up to 6 eggs until they hatch.
#-------------------------------------------------------------------------------
# Enable the next Incubator level with:
# $PokemonGlobal.incubator_level += 1
# Set the Incubator level with:
# $PokemonGlobal.incubator_level = 1

# You can give the Incubator via script
# => $bag.add(:INCUBATOR, 1)
# and then you can set it level if you want to have a higher Level like this one
# $PokemonGlobal.incubator_level = 8
# the higher the level the quicker it hatchs egg

# the names for the Incubator is under "setup_name_bar" you can change the names there

# Version v2.0.0 - [23w24a]
class PokemonGlobalMetadata
  attr_accessor :eggs, :incubator_level, :filler

  MAX_INCUBATOR_LEVEL = 10

  alias old_initialize initialize
  def initialize
    old_initialize
    @eggs = Array.new(6, nil)
    @incubator_level = 0
    $slowerskip = 0
  end

  def count_empty_slots(array)
   array.count(&:nil?)
 end

 def incubatorUpgrade
   @incubator_level = [@incubator_level + 1, MAX_INCUBATOR_LEVEL].min
  end

  def incubatorSetLevel(level)
    @incubator_level = [(level), MAX_INCUBATOR_LEVEL].min
   end

  $PokemonGlobal = PokemonGlobalMetadata.new
end

def incubatorNext
  if $PokemonGlobal.incubator_level == 10
    pbMessage(_INTL("The Incubator allready on it higest tier."))
  else
    $PokemonGlobal.incubatorUpgrade
    pbMessage(_INTL("The Incubator level is now {1}.", $PokemonGlobal.incubator_level)) if $PokemonGlobal.incubator_level > 0
  end
end

def incubatorSet(level)
  $PokemonGlobal.incubatorSetLevel(level)
  pbMessage(_INTL("The Incubator is now a Prototype.", $PokemonGlobal.incubator_level)) if $PokemonGlobal.incubator_level == 0 && $DEBUG
  pbMessage(_INTL("The Incubator is now a Basic.", $PokemonGlobal.incubator_level)) if $PokemonGlobal.incubator_level == 1 && $DEBUG
  pbMessage(_INTL("The Incubator is now Lv.{1}.", $PokemonGlobal.incubator_level)) if $PokemonGlobal.incubator_level > 1 && $DEBUG
end

#-------------------------------------------------------------------------------
# Egg Sprite Class
#-------------------------------------------------------------------------------
class EggSprite < Sprite
  def initialize(viewport, selected, pokemon, x, y)
    super(viewport)
    @pokemon = pokemon
    @selected = selected
    @sprites = {}
    self.bitmap = Bitmap.new(72, 104)
    self.x = x
    self.y = y
    refresh
  end

  def refresh
    if @pokemon
      update_frame_skip
      create_egg_sprite if @pokemon.steps_to_hatch > 0
      create_pkmn_sprite if @pokemon.steps_to_hatch == 0
      draw_hatch_steps  if @pokemon.steps_to_hatch > 0
      create_progress if @pokemon.steps_to_hatch > 0
      glass_overlay unless @pokemon.steps_to_hatch == 0
    end
    draw_selection if @selected
  end

  def dispose
    pbDisposeSpriteHash(@sprites)
    super
  end

  def update
    pbUpdateSpriteHash(@sprites)
    super
  end

  private

  def update_frame_skip
    steps = @pokemon.steps_to_hatch
    @frameskip = case steps
                 when 0...1275 then 5
                 when 1275...2550 then 10
                 when 2550...10200 then 15
                 else 20
                 end
  end

  def create_egg_sprite
    sprite = GameData::Species.egg_icon_filename(@pokemon.species, @pokemon.form)
    @sprites["egg"] = AnimatedSprite.create(sprite, 2, @frameskip, self.viewport)
    @sprites["egg"].x = self.x + 2
    @sprites["egg"].y = self.y - 4
    @sprites["egg"].play
  end

  def create_pkmn_sprite
    sprite = GameData::Species.icon_filename(@pokemon.species, @pokemon.form)
    @sprites["pkmn"] = AnimatedSprite.create(sprite, 2, @frameskip, self.viewport)
    @sprites["pkmn"].x = self.x + 2
    @sprites["pkmn"].y = self.y - 8
    @sprites["pkmn"].play
  end

  def draw_hatch_steps
    base = Color.new(6, 35, 52)
    shadow = Color.new(169, 179, 184)
    pbSetSystemFont(self.bitmap)
    steps = @pokemon.steps_to_hatch
    pbDrawTextPositions(self.bitmap, [[steps.to_s, 34, 66, 2, base, shadow]])
  end

  def draw_selection
    self.bitmap.blt(-2, -2, Bitmap.new("Graphics/UI/Incubator/selection"), Rect.new(0, 0, 72, 104))
  end

  def glass_overlay
    @sprites["glass"] = IconSprite.new(0, 0, self.viewport)
    @sprites["glass"].bitmap = Bitmap.new("Graphics/UI/Incubator/glass")
    @sprites["glass"].x = self.x - 2
    @sprites["glass"].y = self.y - 2
  end

  def create_progress
    #sprite = GameData::Species.egg_icon_filename(@pokemon.species, @pokemon.form)
    @sprites["progress"] = AnimatedSprite.create("Graphics/UI/Incubator/progressicon", 6, 4, self.viewport)
    @sprites["progress"].x = self.x + 30
    @sprites["progress"].y = self.y + 52
    @sprites["progress"].play
  end
end

#-------------------------------------------------------------------------------
# Incubator Scene Class
#-------------------------------------------------------------------------------
class Incubator_Scene
  def pbGetTextSize(text, use_system_font = true, font_name = "", font_size = 0, maxwidth = 0)
    dummy_bitmap = Bitmap.new(1, 1)
    if use_system_font
      pbSetSystemFont(dummy_bitmap)
    else
      font = Font.new(font_name, font_size)
      dummy_bitmap.font = font
    end
    text_size = dummy_bitmap.text_size(text, maxwidth)
    return text_size.width
  end

  def initialize
    setup_viewport
    setup_sprites
    setup_eggs
    setup_name_bar
    setup_level_bar
    refresh
  end

  def refresh
    dispose_eggs
    @sprites["text"].bitmap.clear
    @incubatormeter.clear
    populate_egg_sprites
    display_selected_egg_info
  end

  def dispose
    dispose_eggs
    pbDisposeSpriteHash(@sprites)
  end

  def pbUpdate
      pbUpdateSpriteHash(@sprites)
      @sprites["panorama"].x  = 0 if @sprites["panorama"].x == - 4480
      @sprites["panorama"].x -= 1 if $slowerskip == 3 #if BagScreenWiInParty::PANORAMA == true
      $slowerskip = 0 if $slowerskip == 3
      $slowerskip += 1

  end

  private

  def setup_viewport
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
  end

  def setup_sprites
    @sprites = {}
    @eggs = {}
    @index = 0
    @sprites["background"] = IconSprite.new(0, 0, @viewport)
    @sprites["background"].bitmap = Bitmap.new("Graphics/UI/Incubator/bg")
    @sprites["panorama"] = IconSprite.new(0, 268, @viewport)
    @sprites["panorama"].bitmap = Bitmap.new("Graphics/UI/Incubator/panorama")
    @sprites["ui"] = IconSprite.new(0, 0, @viewport)
    @sprites["ui"].bitmap = Bitmap.new("Graphics/UI/Incubator/hactherpanel")
    @sprites["namebar"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @namebar = @sprites["namebar"].bitmap
    @sprites["namebarend"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @namebarend = @sprites["namebarend"].bitmap
    @sprites["name"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @overlay = @sprites["name"].bitmap
    pbSetSystemFont(@overlay)
    @sprites["meter"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @incubatormeter = @sprites["meter"].bitmap
    pbSetSystemFont(@incubatormeter)
    @sprites["text"] = Sprite.new(@viewport)
    @sprites["text"].bitmap = Bitmap.new(158, 190)
    @sprites["text"].x = 300
    @sprites["text"].y = 64
    pbSetSystemFont(@sprites["text"].bitmap)
  end

  def setup_eggs
    $PokemonGlobal.eggs ||= Array.new(6, nil)
  end

  def setup_name_bar
    text_name = (GameData::Item.get(:INCUBATOR).name)
    text_width = pbGetTextSize(text_name)
	puts text_width
    meter_width = text_width + 16
    x = 24
    y = 6
    imagepos = [["Graphics/UI/Incubator/namebar", x, y, 0, 0, meter_width, 36]]
    pbDrawImagePositions(@namebar, imagepos)
    imagepos = [["Graphics/UI/Incubator/namebarend", x + meter_width, y, 0, 0, 16, 36]]
    pbDrawImagePositions(@namebarend, imagepos)
    pbDrawTextPositions(@overlay, [[text_name, x + 16, y + 8, 0, Color.new(248, 248, 248), Color.new(70, 70, 70)]])
  end

  def setup_level_bar
    text_name = _INTL("Egg State")
    text_width = pbGetTextSize(text_name)
    meter_width = text_width + 16
    x = 524 - 52 - meter_width
    y = 6
    imagepos = [["Graphics/UI/Incubator/namebar", x, y, 0, 0, meter_width, 36]]
    pbDrawImagePositions(@namebar, imagepos)
    imagepos = [["Graphics/UI/Incubator/namebarend", x + meter_width, y, 0, 0, 16, 36]]
    pbDrawImagePositions(@namebarend, imagepos)
    pbDrawTextPositions(@overlay, [[text_name, x + 16, y + 8, 0, Color.new(248, 248, 248), Color.new(70, 70, 70)]])
  end

  def populate_egg_sprites
    $PokemonGlobal.eggs.each_with_index do |egg, index|
      x, y = calculate_egg_position(index)
      selected = (index == @index)
      @eggs[index.to_s] = EggSprite.new(@viewport, selected, egg, x, y)
    end
  end

  def calculate_egg_position(index)
    if index < 3
      x = 46 + 80 * index
      y = 46
    else
      x = 46 + 80 * (index - 3)
      y = 158
    end
    [x, y]
  end

  def display_selected_egg_info
    return if $PokemonGlobal.eggs[@index].nil?

    egg = $PokemonGlobal.eggs[@index]
    steps = egg.steps_to_hatch
    eggstate = determine_egg_state(steps)
    base = Color.new(248, 248, 248)
    shadow = Color.new(0, 0, 0)
    drawFormattedTextEx(@sprites["text"].bitmap, 0, 2, 158, eggstate, base, shadow)
    pbDrawImagePositions(@incubatormeter, [["Graphics/UI/Incubator/incubator_meter_bg", 300, 218]]) unless (egg.name != "Egg" || egg.name != "Oeuf")
    draw_incubator_meter(egg) unless (egg.name != "Egg" || egg.name != "Oeuf")
  end

  def determine_egg_state(steps)
    egg = $PokemonGlobal.eggs[@index]
    return _INTL("{1} have been hatched.",egg.speciesName) if (egg.name != "Egg" && egg.name != "Oeuf")
    case steps
    when 0...1275
      _INTL("Sounds can be heard coming from inside! This Egg will hatch soon!")
    when 1275...2550
      _INTL("It appears to move occasionally. It may be close to hatching.")
    when 2550...10200
      _INTL("What will hatch from this Egg? It doesn't seem close to hatching.")
    else
      _INTL("It looks like this Egg will take a long time to hatch.")
    end
  end

  def draw_incubator_meter(egg)
    stepmax = egg.species_data.hatch_steps
    cem = (stepmax - egg.steps_to_hatch + 1)
    proc = (cem * 100 / stepmax).floor
    proc = 99 if proc == 100
    w = ((cem * 148) / stepmax).floor
    w = 1 if w < 1
    w = ((w / 2).round) * 2
    meterzone  = 0
    meterzone  = 1 if cem <= (stepmax * 0.6).floor
    meterzone  = 2 if cem <= (stepmax * 0.2).floor
    x, y = 304, 218
    imagepos = [["Graphics/UI/Incubator/incubator_meter", x, y, 0, meterzone * 26, w, 26]]
    pbDrawImagePositions(@incubatormeter, imagepos)
    textpos = [["#{proc}%", x + 88, y + 6, 1, Color.new(248, 248, 248), Color.new(0, 0, 0)]]
    pbDrawTextPositions(@incubatormeter, textpos)
  end

  def dispose_eggs
    @eggs.each_value(&:dispose)
    @eggs.clear
  end

  def handle_input
    loop do
      @eggs.each_value{|egg|
      egg.update}
      Graphics.update
      Input.update
      pbUpdate
      if Input.trigger?(Input::LEFT) || Input.trigger?(Input::RIGHT)
        pbPlayCursorSE
        change_selection(Input.trigger?(Input::RIGHT) ? 1 : -1)
      elsif Input.trigger?(Input::UP) || Input.trigger?(Input::DOWN)
        pbPlayCursorSE
        change_selection(Input.trigger?(Input::UP) ? -3 : 3)
      elsif Input.trigger?(Input::BACK)
        pbPlayCloseMenuSE
        dispose
        break
      elsif Input.trigger?(Input::USE)
        if $PokemonGlobal.eggs[@index] == nil
          ret = pbConfirmMessage(_INTL("This Incubator is empty\\nDo you want to add an Egg?"))
          if ret == true
            chosen=0
            pbFadeOutIn(99999){
              scene = PokemonParty_Scene.new
              screen = PokemonPartyScreen.new(scene,$player.party)
              screen.pbStartScene(_INTL("Choose an Egg."),false)
              chosen=screen.pbChoosePokemon
              screen.pbEndScene
            }
            if $player.party[chosen] != nil
              if !$player.party[chosen].egg?
                pbMessage(_INTL("The chosen Pokémon is not an Egg."))
              else
                $PokemonGlobal.eggs[@index] = $player.party[chosen]
                $player.party.delete_at(chosen)
                refresh
              end
            end
          end
        else
          commands = []
          cmdEditSteps    = -1
          cmdTakeEgg      = -1
          cmdHatchEGG     = -1
          cmdTakePokemon  = -1
          cmdRelease      = -1
          cmdBack         = -1
          commands[cmdEditSteps = commands.length]    = _INTL("Edit Steps") if $DEBUG && ($PokemonGlobal.eggs[@index].name) == "Egg"
          commands[cmdTakeEgg = commands.length]      = _INTL("Take")
          commands[cmdHatchEGG = commands.length]     = _INTL("Hatch") if $DEBUG && ($PokemonGlobal.eggs[@index].name) == "Egg"
          commands[cmdRelease = commands.length]      = _INTL("Release") if ($PokemonGlobal.eggs[@index].name) != "Egg"
          commands[commands.length]                   = _INTL("Back")

          command = pbMessage(_INTL("What would you like to do?"), commands, -1)

          if cmdEditSteps >= 0 && command == cmdEditSteps   # edit steps
            params = ChooseNumberParams.new
            params.setRange(1, $PokemonGlobal.eggs[@index].species_data.hatch_steps)
            params.setDefaultValue($PokemonGlobal.eggs[@index].steps_to_hatch)
            steps_left = pbMessageChooseNumber(_INTL("Set the number of steps left (1 to {1})", $PokemonGlobal.eggs[@index].species_data.hatch_steps) , params )
            $PokemonGlobal.eggs[@index].steps_to_hatch = steps_left
            #pbMessage(_INTL("Steps to hatch for the Egg set to {1}.", steps_left))
            #puts "Steps to hatch for the Egg set to #{steps_left}."
            refresh

          elsif cmdTakeEgg >= 0 && command == cmdTakeEgg   # Take egg out
            takeEgg($PokemonGlobal.eggs[@index],@index)
            refresh

          elsif cmdHatchEGG >= 0 && command == cmdHatchEGG   # hatch egg
            $PokemonGlobal.eggs[@index].steps_to_hatch = 0
            pbHatch($PokemonGlobal.eggs[@index])
            takeEgg($PokemonGlobal.eggs[@index],@index)
            refresh

          elsif cmdRelease >= 0 && command == cmdRelease   # Release pokmon
            $PokemonGlobal.eggs[@index] = nil
            refresh
          end
        end
      end
    end
  end

  def change_selection(delta)
    @index = (@index + delta) % 6
    @index = (@index < 0) ? 5 : @index
    refresh
  end
end

def takeEgg(egg,index)
  pbMessage(_INTL("Your party is full")) if  $player.party.length == 6
  sel = pbConfirmMessage(_INTL("Do you want to add the {1} to your team?",egg.name)) unless $player.party.length == 6
  if sel==true
    pbStorePokemon(egg)
    $PokemonGlobal.eggs[index] = nil
  else
    if $PokemonStorage.full?
      pbMessage(_INTL("There´s no more room for Pokémon!") + "\1")
      pbMessage(_INTL("The Pokémon Boxes are full and can't accept any more!"))
      return false
    end
    oldcurbox     = $PokemonStorage.currentBox
    storedbox     = $PokemonStorage.pbStoreCaught(egg)
    curboxname    = $PokemonStorage[oldcurbox].name
    boxname       = $PokemonStorage[storedbox].name
    if storedbox != oldcurbox
      pbMessage(_INTL("Box \"{1}\" is full.\1",curboxname))
      pbMessage(_INTL("{1} was transfered to box \"{2}.\"",egg.name,boxname))
      $PokemonGlobal.eggs[index] = nil
    else
      pbMessage(_INTL("{1} was transfered to box \"{2}.\"",egg.name,boxname))
      $PokemonGlobal.eggs[index] = nil
    end
  end

end

EventHandlers.add(:on_player_step_taken, :item_hatch_eggs,
  proc {
    a = 2 + pbGet(209)
	$PokemonGlobal.eggs = Array.new(6, nil) if $PokemonGlobal.eggs == nil
    $PokemonGlobal.eggs.each_with_index do |egg, i|
      next if egg.nil? || egg.steps_to_hatch <= 0
      egg.steps_to_hatch -= a
      $player.pokemon_party.each do |pkmn|
        next if !pkmn.ability&.has_flag?("FasterEggHatching")
        egg.steps_to_hatch -= a
        break
      end
      if egg.steps_to_hatch <= 0
        egg.steps_to_hatch = 0
        pbHatch(egg)
        takeEgg(egg, i)
      end
    end
  }
)

#-------------------------------------------------------------------------------
# Item Handler
#-------------------------------------------------------------------------------
ItemHandlers::UseFromBag.add(:INCUBATOR, proc { |item|
  pbFadeOutIn(99999){ openIncubator }
  next 1
})

ItemHandlers::UseInField.add(:INCUBATOR, proc{ |item|
  pbFadeOutIn(99999){ openIncubator }
  next 1
})

def openIncubator
  scene = Incubator_Scene.new
  scene.handle_input
end

#-------------------------------------------------------------------------------
# Egg Creation
#-------------------------------------------------------------------------------
def pbGenerateEgg(egg, text = "")
  return false if !egg# || $player.party_full?
  pkmn = Pokemon.new(egg, Settings::EGG_LEVEL) if !egg.is_a?(Pokemon)
  item = GameData::Item.get(:INCUBATOR)
  pkmn.name = _INTL("Egg")
  pkmn.steps_to_hatch = pkmn.species_data.hatch_steps
  pkmn.obtain_text = text
  pkmn.calc_stats
  # Add egg to party
  if $bag.has?(:INCUBATOR) && $PokemonGlobal.eggs.index(nil)
    ret = pbConfirmMessage(_INTL("Do you want to add the egg to the incubator?"))
    if ret == true
      ret = addEgg(pkmn)
      if ret == true
        return true
      end
    end
  end
  pbMessage(_INTL("The \\c[1]{1}\\c[0] is full.", item.name)) if $bag.has?(:INCUBATOR) && !$PokemonGlobal.eggs.index(nil)
  if $player.party.length < 6 && pbConfirmMessage(_INTL("Would you like to add the {1} to your team", pkmn.name))
    $player.party[$player.party.length] = pkmn
    return true
  else
    if pbBoxesFull?
      pbMessage(_INTL("There´s no more room for Pokémon!") + "\1")
      pbMessage(_INTL("The Pokémon Boxes are full and can't accept any more!"))
      return
    end
    oldcurbox     = $PokemonStorage.currentBox
    storedbox     = $PokemonStorage.pbStoreCaught(pkmn)
    curboxname    = $PokemonStorage[oldcurbox].name
    boxname       = $PokemonStorage[storedbox].name
    creator       = nil
    creator       = pbGetStorageCreator if $player.seen_storage_creator
    if storedbox != oldcurbox
      pbMessage(_INTL("{1} is full.\nThe {2} was transfered to \"{3}\"!",curboxname,pkmn.name,boxname))
    else
      pbMessage(_INTL("The {1} was transfered to box \\c[1]\"{2}.\"\\c[0]",pkmn.name,boxname))
    end
    return true
  end
  return false
end

def addEgg(egg)
  $PokemonGlobal.eggs = Array.new(6, nil) if $PokemonGlobal.eggs == nil
  $PokemonGlobal.eggs.each_index{|index|
    if $PokemonGlobal.eggs[index] == nil
      $PokemonGlobal.eggs[index] = egg
      return true
    end
  }
  pbMessage(_INTL("The incubator is full.", pkmn.name))
  return false
end

def egghacted
  pbMessage("#{$stats.eggs_hatched}")
end
