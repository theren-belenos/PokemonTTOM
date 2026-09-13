#===============================================================================
# Using "move" (ie Omnimachine)
#===============================================================================
# CS01 : Cut
HiddenMoveHandlers::UseMove.add(:CUT, proc { |move, pokemon|
  pbMessage(_INTL("You used the Omnimachine to cut down the Tree!"))
  $stats.cut_count += 1
  facingEvent = $game_player.pbFacingEvent
  pbSmashEvent(facingEvent) if facingEvent
  next true
})

def pbCut
  move = :CUT
  movefinder = $bag.has?(:HM01)
  if !pbCheckHiddenMoveBadge(Settings::BADGE_FOR_CUT, false) || (!$DEBUG && !movefinder)
    pbMessage(_INTL("This tree looks like it can be cut down."))
    return false
  end
  if pbConfirmMessage(_INTL("This tree looks like it can be cut down!\nWould you like to use the Omnimachine's Cut function to cut it down?"))
    $stats.cut_count += 1
    pbMessage(_INTL("You used the Omnimachine to cut down the Tree!"))
    return true
  end
  return false
end

# CS02 : Flash
HiddenMoveHandlers::UseMove.add(:FLASH, proc { |move, pokemon|
  darkness = $game_temp.darkness_sprite
  next false if !darkness || darkness.disposed?
  pbMessage(_INTL("You used the Omnimachine to lighten the place!"))
  $PokemonGlobal.flashUsed = true
  $stats.flash_count += 1
  duration = 0.7
  pbWait(duration) do |delta_t|
    darkness.radius = lerp(darkness.radiusMin, darkness.radiusMax, duration, delta_t)
  end
  darkness.radius = darkness.radiusMax
  next true
})

# CS03 : Rock Smash
HiddenMoveHandlers::UseMove.add(:ROCKSMASH, proc { |move, pokemon|
  pbMessage(_INTL("You used the Omnimachine to break this rock!"))
  $stats.rock_smash_count += 1
  facingEvent = $game_player.pbFacingEvent
  if facingEvent
    pbSmashEvent(facingEvent)
    pbRockSmashRandomEncounter
  end
  next true
})

def pbRockSmash
  move = :ROCKSMASH
  movefinder = $bag.has?(:HM03)
  if !pbCheckHiddenMoveBadge(Settings::BADGE_FOR_ROCKSMASH, false) || (!$DEBUG && !movefinder)
    pbMessage(_INTL("It's a rugged rock, but it looks breakable."))
    return false
  end
  if pbConfirmMessage(_INTL("This rock seems breakable.\nWould you like to use the Omnimachine's Rock Smash function on it?"))
    $stats.rock_smash_count += 1
    pbMessage(_INTL("You used the Omnimachine to break this rock!"))
    return true
  end
  return false
end

# CS04 : Fly
def pbFlyToNewLocation(pkmn = nil, move = :FLY)
  return false if $game_temp.fly_destination.nil?
  pbMessage(_INTL("You deploy the Omnimachine! It becomes a plane that takes you to your destination!"))
  $stats.fly_count += 1
  pbFadeOutIn do
    pbSEPlay("Fly")
    $game_temp.player_new_map_id    = $game_temp.fly_destination[0]
    $game_temp.player_new_x         = $game_temp.fly_destination[1]
    $game_temp.player_new_y         = $game_temp.fly_destination[2]
    $game_temp.player_new_direction = 2
    $game_temp.fly_destination = nil
    pbDismountBike
    $scene.transfer_player
    if $game_map.map_id == 8
      $town.build_town 
    end
    if $game_map.map_id == 245
      UnrealTime.advance_to(12)
      $game_switches[167] = true
    else 
      $game_switches[167] = false
    end
    $game_map.autoplay
    $game_map.refresh
    yield if block_given?
    pbWait(0.25)
  end
  pbEraseEscapePoint
  return true
end

# CS 05 : Calm Skies -> TODO NEW

# CS06 : Strength
HiddenMoveHandlers::UseMove.add(:STRENGTH, proc { |move, pokemon|
  pbMessage(_INTL("You activate the Omnimachine strength function!"))
  pbMessage(_INTL("Omnimachine's strength made it possible to move boulders around!"))
  $PokemonMap.strengthUsed = true
  next true
})


# CS07 : Surf
HiddenMoveHandlers::UseMove.add(:SURF, proc { |move, pokemon|
  $game_temp.in_menu = false
  pbCancelVehicles
  pbMessage(_INTL("You deploy the Omnimachine! It becomes a light boat for you to explore the sea!"))
  surfbgm = GameData::Metadata.get.surf_BGM
  pbCueBGM(surfbgm, 0.5) if surfbgm
  pbStartSurfing
  next true
})

# CS08 : Rock Climb -> TODO check plugin

# CS09 : Dive

# CS10 : Waterfall



#===============================================================================
# Using a registered item
#===============================================================================
def pbUseKeyItem
  cs = [:CUT, :FLASH, :ROCKSMASH, :FLY, :STRENGTH, :SURF, :ROCKCLIMB, :DIVE, :WATERFALL]
  other = [:DIG, :HEADBUTT, :SECRETPOWER,:SWEETSCENT,:TELEPORT,:WHIRLPOOL]
  real_moves = []
  cs.each do |move|
    real_moves.push([move,-1]) if pbCanUseHiddenMove?(-1, move, false)
  end
  other.each do |move|
    $player.party.each_with_index do |pkmn, i|
      next if pkmn.egg? || !pkmn.hasMove?(move)
      real_moves.push([move, i]) if pbCanUseHiddenMove?(pkmn, move, false)
    end
  end
  real_items = []
  $bag.registered_items.each do |i|
    itm = GameData::Item.get(i).id
    real_items.push(itm) if $bag.has?(itm)
  end
  if real_items.length == 0 && real_moves.length == 0
    pbMessage(_INTL("An item in the Bag can be registered to this key for instant use."))
  else
    $game_temp.in_menu = true
    $game_map.update
    sscene = PokemonReadyMenu_Scene.new
    sscreen = PokemonReadyMenu.new(sscene)
    sscreen.pbStartReadyMenu(real_moves, real_items)
    $game_temp.in_menu = false
  end
end

#===============================================================================
# Tweaking quick menu display
#===============================================================================
class ReadyMenuButton < Sprite

  def initialize(index, command, selected, side, viewport = nil)
    super(viewport)
    @index = index
    @command = command   # Item/move ID, name, mode (T move/F item), pkmnIndex
    @selected = selected
    @side = side
    if @command[2]
      @button = AnimatedBitmap.new("Graphics/UI/Ready Menu/icon_movebutton")
    else
      @button = AnimatedBitmap.new("Graphics/UI/Ready Menu/icon_itembutton")
    end
    @contents = Bitmap.new(@button.width, @button.height / 2)
    self.bitmap = @contents
    pbSetSystemFont(self.bitmap)
    if @command[2]
	  if @command[3] == -1
	    @icon = ItemIconSprite.new(0, 0, :OMNIMACHINE, viewport)
		@icon.setOffset(PictureOrigin::RIGHT)
	  else
        @icon = PokemonIconSprite.new($player.party[@command[3]], viewport) 
		@icon.setOffset(PictureOrigin::CENTER)
	  end
    else
      @icon = ItemIconSprite.new(0, 0, @command[0], viewport)
    end
    @icon.z = self.z + 1
    refresh
  end
  
  def refresh
    sel = (@selected == @index && (@side == 0) == @command[2])
    self.y = ((Graphics.height - (@button.height / 2)) / 2) - ((@selected - @index) * ((@button.height / 2) + 4))
    if @command[2]   # Pokémon
      self.x = (sel) ? 0 : -16
      @icon.x = self.x + 52
      @icon.y = self.y + 32
    else   # Item
      self.x = (sel) ? Graphics.width - @button.width : Graphics.width + 16 - @button.width
      @icon.x = self.x + 32
      @icon.y = self.y + (@button.height / 4)
    end
    self.bitmap.clear
    rect = Rect.new(0, (sel) ? @button.height / 2 : 0, @button.width, @button.height / 2)
    self.bitmap.blt(0, 0, @button.bitmap, rect)
    textx = 144
    if !@command[2]
      textx = (GameData::Item.get(@command[0]).is_important?) ? 146 : 124
    end
    textpos = [
      [@command[1], textx, 24, :center, Color.new(248, 248, 248), Color.new(40, 40, 40), :outline]
    ]
    if !@command[2] && !GameData::Item.get(@command[0]).is_important?
      qty = $bag.quantity(@command[0])
      if qty > 99
        textpos.push([_INTL(">99"), 230, 24, :right,
                      Color.new(248, 248, 248), Color.new(40, 40, 40), :outline])
      else
        textpos.push([_INTL("x{1}", qty), 230, 24, :right,
                      Color.new(248, 248, 248), Color.new(40, 40, 40), :outline])
      end
    end
    pbDrawTextPositions(self.bitmap, textpos)
  end
  
end


class PokemonReadyMenu
  def pbStartReadyMenu(moves, items)
    commands = [[], []]   # Moves, items
    moves.each do |i|
			if i[1] == -1
				commands[0].push([i[0], "Omnimachine: " + GameData::Move.get(i[0]).name, true, i[1]])
			else
				commands[0].push([i[0], GameData::Move.get(i[0]).name, true, i[1]])
			end
    end
    commands[0].sort! { |a, b| a[1] <=> b[1] }
    items.each do |i|
      commands[1].push([i, GameData::Item.get(i).name, false])
    end
    commands[1].sort! { |a, b| a[1] <=> b[1] }
    @scene.pbStartScene(commands)
    loop do
      command = @scene.pbShowCommands
      break if command == -1
      if command[0] == 0   # Use a move
        move = commands[0][command[1]][0]
		if commands[0][command[1]][3] == -1 
			user = -1
		else
		    user = $player.party[commands[0][command[1]][3]]
		end
        if move == :FLY
          ret = nil
          pbFadeOutInWithUpdate(99999, @scene.sprites) do
            pbHideMenu
            scene = PokemonRegionMap_Scene.new(-1, false)
            screen = PokemonRegionMapScreen.new(scene)
            ret = screen.pbStartFlyScreen
            pbShowMenu if !ret
          end
          if ret
            $game_temp.fly_destination = ret
            $game_temp.in_menu = false
            pbUseHiddenMove(user, move)
            break
          end
        else
          pbHideMenu
          if pbConfirmUseHiddenMove(user, move)
            $game_temp.in_menu = false
            pbUseHiddenMove(user, move)
            break
          else
            pbShowMenu
          end
        end
      else   # Use an item
        item = commands[1][command[1]][0]
        pbHideMenu
        if ItemHandlers.triggerConfirmUseInField(item)
          $game_temp.in_menu = false
          break if pbUseKeyItemInField(item)
          $game_temp.in_menu = true
        end
      end
      pbShowMenu
    end
    @scene.pbEndScene
  end
end