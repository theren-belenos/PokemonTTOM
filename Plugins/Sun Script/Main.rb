#===============================================================================
# SCRIPT DE RAYO DE SOL - CREATED BY POLECTRON
#===============================================================================
# * Settings
#===============================================================================
module SunSettings
  BGPATH = "Graphics/Fogs/sun.png" # Make sure the path and file extension are correct
  UPDATESPERSECONDS = 5
  SUN_OPACITY = 60  # Base opacity (lower = less intense)
  
  # Global sun sprite - only one exists
  @@sun_sprite = nil
  @@active_spritesets = []
  
  def self.sun_sprite
    @@sun_sprite
  end
  
  def self.sun_sprite=(sprite)
    @@sun_sprite = sprite
  end
  
  def self.register_spriteset(spriteset)
    @@active_spritesets << spriteset
  end
  
  def self.unregister_spriteset(spriteset)
    @@active_spritesets.delete(spriteset)
  end
  
  def self.active_spritesets
    @@active_spritesets
  end
  
  def self.primary_spriteset
    @@active_spritesets.first
  end
end

#===============================================================================
# * Main
#===============================================================================
class Spriteset_Map
  include SunSettings

  alias :initializeSun :initialize
  alias :updateOldSun :update

  def initialize(*args)
    initializeSun(*args)
    SunSettings.register_spriteset(self)
    
    # Am I the primary spriteset?
    @is_primary = (SunSettings.primary_spriteset == self)
    echoln "Spriteset initialized - Primary: #{@is_primary}, Total spritesets: #{SunSettings.active_spritesets.length}"
    
    $sun_switch = true
  end

  def dispose
    SunSettings.unregister_spriteset(self)
    
    # If I was primary and there are no more spritesets, clean up the sun
    if @is_primary && SunSettings.active_spritesets.empty?
      disposeSun
      echoln "Last spriteset disposing - sun cleaned up"
    elsif @is_primary
      echoln "Primary spriteset disposed but #{SunSettings.active_spritesets.length} others remain"
    end
    
    super if defined?(super)
  end

  def update
    updateOldSun
    # Only the first active spriteset manages the sun
    updateSun if SunSettings.primary_spriteset == self
  end

  #===============================================================================
  # * HUD Data
  #===============================================================================
  def createSun
    # Always dispose first to prevent any duplicates
    disposeSun
    
    map_metadata = GameData::MapMetadata.try_get($game_map.map_id)
    return unless map_metadata && map_metadata.outdoor_map

    # Check conditions
    return if PBDayNight.isNight?
    return unless $sun_switch
    return unless $game_screen.weather_type == :None
    return if $game_map.fog_name != ""
    return if BGPATH == ""
    return if pbResolveBitmap(BGPATH).nil?
    
    # Create single GLOBAL sprite
    sun_sprite = Sprite.new(@viewport1)
    sun_sprite.bitmap = Bitmap.new(BGPATH)
    sun_sprite.z = 200  # Lower z-index to prevent overlaying issues
    sun_sprite.blend_type = 1
    sun_sprite.x = 0
    sun_sprite.y = 0
    
    # Scale to fit screen
    sun_sprite.zoom_x = Graphics.width.to_f / sun_sprite.bitmap.width
    sun_sprite.zoom_y = Graphics.height.to_f / sun_sprite.bitmap.height
    
    # Set initial opacity
    sun_sprite.opacity = calculateSunAlpha
    
    # Store globally
    SunSettings.sun_sprite = sun_sprite
    
    echoln "SUN CREATED - Opacity: #{sun_sprite.opacity}, Object ID: #{sun_sprite.object_id}"
  end
  #===============================================================================

  def updateSun
    sun_sprite = SunSettings.sun_sprite
    
    map_metadata = GameData::MapMetadata.try_get($game_map.map_id)
    should_show = map_metadata && map_metadata.outdoor_map && 
                  !PBDayNight.isNight? && $sun_switch && 
                  $game_screen.weather_type == :None && 
                  $game_map.fog_name == ""
    
    if should_show
      # Create sun if it doesn't exist
      if sun_sprite.nil? || sun_sprite.disposed?
        createSun
        sun_sprite = SunSettings.sun_sprite
      end
      
      # Update opacity only
      if sun_sprite && !sun_sprite.disposed?
        new_opacity = calculateSunAlpha
        if sun_sprite.opacity != new_opacity
          echoln "SUN OPACITY CHANGE: #{sun_sprite.opacity} -> #{new_opacity}, Object ID: #{sun_sprite.object_id}"
          sun_sprite.opacity = new_opacity
        end
      end
    else
      # Hide sun
      disposeSun
    end
  end

  def disposeSun
    sun_sprite = SunSettings.sun_sprite
    if sun_sprite && !sun_sprite.disposed?
      echoln "SUN DISPOSED - Object ID: #{sun_sprite.object_id}"
      sun_sprite.dispose
    end
    SunSettings.sun_sprite = nil
  end

  # Calculate the alpha value based on the time of day
  def calculateSunAlpha
    current_time = pbGetTimeNow
    hour = current_time.hour
    
    if hour >= 6 && hour <= 18
      # Day time - use base opacity
      return SUN_OPACITY
    elsif hour > 18 && hour <= 20
      # Gradually fade out between 6 PM and 8 PM
      progress = (hour - 18) / 2.0
      return (SUN_OPACITY * (1.0 - progress)).to_i
    elsif hour >= 4 && hour < 6
      # Gradually become visible between 4 AM and 6 AM
      progress = (hour - 4) / 2.0
      return (SUN_OPACITY * progress).to_i
    else
      # Night - invisible
      return 0
    end
  end
end

#===============================================================================

class Scene_Map
  include SunSettings

  alias :updateOldSun :update
  alias :miniupdateOldSun :miniupdate
  alias :createSpritesetsOldSun :createSpritesets

  UPDATERATE = (UPDATESPERSECONDS > 0) ? 
               (Graphics.frame_rate / UPDATESPERSECONDS).floor : 0x3FFF

  def update
    updateOldSun
  end

  def miniupdate
    miniupdateOldSun
  end

  def createSpritesets
    createSpritesetsOldSun
  end

  def checkAndUpdateSun
    # This method is no longer needed - each spriteset manages its own sun
  end
end