if RockClimbPlugin::FOLLOWING_POKEMON_EX
  #===
  # Overwrites old HiddenMoveHandler to set variable current_rockclimbing and disabling follower_field_move
  #===
  HiddenMoveHandlers::UseMove.add(:ROCKCLIMB, proc { |move,pokemon|
    old_rockclimbing = $PokemonGlobal.current_rockclimbing
    $PokemonGlobal.current_rockclimbing = pokemon
    pbMessage(_INTL("{1} used {2}!",pokemon.name,GameData::Move.get(move).name)) if !pbHiddenMoveAnimation(pokemon, true)
    pbRockClimbMain
    $PokemonGlobal.current_rockclimbing = old_rockclimbing if !pokemon
    next true
  })

  #===
  # Create a new global variable current_rockclimbing
  #===
  class PokemonGlobalMetadata
    # Variable to track the Pokemon that is currently rock climbing
    attr_accessor :current_rockclimbing
  end

  #===
  # Overwrites pbRockClimb to set variable current_rockclimbing and disabling follower_field_move
  #===
  alias pbRockClimb_FollowingPokemonEX pbRockClimb unless defined?(pbRockClimb_FollowingPokemonEX)
  def pbRockClimb
    $game_temp.no_follower_field_move = true
    old_rockclimbing = $PokemonGlobal.current_rockclimbing
    pkmn = $player.get_pokemon_with_move(:ROCKCLIMB)
    $PokemonGlobal.current_rockclimbing = pkmn
    ret = pbRockClimb_FollowingPokemonEX
    $PokemonGlobal.current_rockclimbing = old_rockclimbing if !ret || !pkmn
    $game_temp.no_follower_field_move = false
    return ret
  end

  #===
  # Overwrites pbRockClimbMain to set a move route for Following Pokemon
  #===
  alias pbRockClimbMain_FollowingPokemonEX pbRockClimbMain unless defined?(pbRockClimbMain_FollowingPokemonEX)
  def pbRockClimbMain
    $game_temp.no_follower_field_move = true
    pkmn = $player.get_pokemon_with_move(:ROCKCLIMB)
    anim = pkmn && FollowingPkmn.get_pokemon == pkmn
    if anim
      pbCancelVehicles
      $PokemonEncounters.reset_step_count
      dir = $game_player.direction.clone
      $game_temp.rock_climb_base_dir = dir
      pbTurnTowardEvent($game_player, FollowingPkmn.get_event)
      facing_rock = $game_player.pbFacingTerrainTag.RockClimb || $game_player.pbFacingTerrainTag.RockCrest
      if !facing_rock
        pbTurnTowardEvent(FollowingPkmn.get_event, $game_player)
        pbWait(Graphics.frame_rate / 5)
        FollowingPkmn.move_route([PBMoveRoute::Forward], true)
        pbMoveRoute($game_player, [PBMoveRoute::Forward], true)
        pbWait(Graphics.frame_rate / 5)
        pbTurnTowardEvent($game_player, FollowingPkmn.get_event)
        case dir
        when 2
          FollowingPkmn.move_route([PBMoveRoute::TurnDown], true)
        when 8
          FollowingPkmn.move_route([PBMoveRoute::TurnUp], true)
        end
        pbWait(Graphics.frame_rate / 5)
        case dir
        when 2
          FollowingPkmn.move_route([PBMoveRoute::Jump, 0, 1], true)
        when 8
          FollowingPkmn.move_route([PBMoveRoute::Jump, 0, -1], true)
        end
        pbWait(Graphics.frame_rate / 5)
      end
      $game_temp.rock_climb_base_coords = $map_factory.getFacingCoords(FollowingPkmn.get_event.x, FollowingPkmn.get_event.y, dir, 0)
      FollowingPkmn.toggle_off(false)
      $PokemonGlobal.rockclimbing = true
      pbMoveRoute($game_player, [PBMoveRoute::Forward]) if !facing_rock
      pbWait(Graphics.frame_rate / 5)
      case dir
      when 2
        $game_player.turn_down
      when 8
        $game_player.turn_up
      end
      $game_temp.rock_climb_base_dir = nil
    end
    $PokemonGlobal.rockclimbing = false
    pbRockClimbMain_FollowingPokemonEX
    $game_temp.no_follower_field_move = false
  end

  #===
  # Overwrites pbRockClimbStart to toggle Following Pokemon
  #===
  alias pbRockClimbStart_FollowingPokemonEX pbRockClimbStart unless defined?(pbRockClimbStart_FollowingPokemonEX)
  def pbRockClimbStart
    anim = $PokemonGlobal.current_rockclimbing == FollowingPkmn.get_pokemon
    FollowingPkmn.refresh_internal
    FollowingPkmn.toggle_off(!anim)
    pbWait(Graphics.frame_rate / 5) if !anim
    pbRockClimbStart_FollowingPokemonEX
  end

  #===
  # Overwrites pbRockClimbEnd to toggle Following Pokemon
  #===
  alias pbRockClimbEnd_FollowingPokemonEX pbRockClimbEnd unless defined?(pbRockClimbEnd_FollowingPokemonEX)
  def pbRockClimbEnd
    anim = $PokemonGlobal.current_rockclimbing == FollowingPkmn.get_pokemon
    pbRockClimbEnd_FollowingPokemonEX
    FollowingPkmn.refresh_internal
    FollowingPkmn.toggle_on(!anim)
  end
end

