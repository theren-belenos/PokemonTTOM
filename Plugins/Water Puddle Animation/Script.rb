#===============================================================================
# PUDDLE FOOT STEPS SYSTEM (Essentials v21.1)
# - Plays ripple animation when stepping on puddle terrain
#===============================================================================

module FootStepEffects
  PUDDLE_TAG_ID     = 16        # TerrainTag ID for puddles
  PUDDLE_ANIM_ID    = 28        # Animation ID for ripple
  PUDDLE_DELAY_FRAMES = 30      # Delay before ripple plays
end

#===============================================================================
# HEIGHT PATCH for animations with height -1
# Makes puddle ripples render correctly in the stack
#===============================================================================

class SpriteAnimation
  alias __footstep_original_animation_set_sprites animation_set_sprites
  def animation_set_sprites(sprites, cell_data, position, quick_update = false)
    __footstep_original_animation_set_sprites(sprites, cell_data, position, quick_update)
    return unless @_animation_height == -1
    return unless sprites
    sprites.each do |sprite|
      next unless sprite
      sprite.z = -25
    end
  end
end

#===============================================================================
# Puddle spawn helper
#===============================================================================

module FootStepEffects
  def self.spawn_puddle(tx, ty)
    FootstepManager.add(DelayedPuddle.new(tx, ty, PUDDLE_DELAY_FRAMES))
  end

  class DelayedPuddle
    def initialize(tx, ty, delay_frames)
      @tx = tx
      @ty = ty
      @delay = delay_frames
      @disposed = false
    end

    def update
      return if @disposed
      @delay -= 1
      return if @delay > 0
      play_animation
      @disposed = true
    end

    def play_animation
      return unless $scene.is_a?(Scene_Map)
      return unless $scene.spriteset.respond_to?(:addUserAnimation)
      $scene.spriteset.addUserAnimation(
        FootStepEffects::PUDDLE_ANIM_ID,
        @tx, @ty,
        true, -1
      )
    rescue
      # Fail silently to avoid crashes
    end

    def dispose; @disposed = true; end
    def disposed?; @disposed; end
  end
end

#===============================================================================
# Footstep Manager (shared by all systems)
#===============================================================================

module FootStepEffects
  module FootstepManager
    @sprites = []

    class << self
      def add(obj); @sprites << obj; end

      def update
        @sprites.each(&:update)
        @sprites.delete_if(&:disposed?)
      end

      def dispose
        @sprites.each(&:dispose)
        @sprites.clear
      end
    end
  end
end

#===============================================================================
# Hooks
#===============================================================================

class Spriteset_Map
  alias puddle_update update
  def update
    puddle_update
    FootStepEffects::FootstepManager.update
  end

  alias puddle_dispose dispose
  def dispose
    FootStepEffects::FootstepManager.dispose
    puddle_dispose
  end
end

class Game_Character
  alias puddle_increase_steps increase_steps
  def increase_steps
    puddle_increase_steps
    FootStepEffects.on_step_puddle(self) if $scene.is_a?(Scene_Map)
  end
end

#===============================================================================
# Puddle step detection
#===============================================================================

module FootStepEffects
  def self.on_step_puddle(char)
    tx = char.x
    ty = char.y
    terrain = $game_map.terrain_tag(tx, ty)
    return unless terrain
    return unless terrain.id_number == PUDDLE_TAG_ID

    spawn_puddle(tx, ty)
  end
end