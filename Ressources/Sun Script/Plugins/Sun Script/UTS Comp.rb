#===============================================================================
# Compatibility script for Unreal Time System
#===============================================================================
if defined?(UnrealTimeSystem)
  module SunSettings
    def self.getTimeNow
      UnrealTimeSystem.current_time
    end
  end

  class Spriteset_Map
    alias :calculateSunAlphaUnreal :calculateSunAlpha

    def calculateSunAlpha
      current_time = SunSettings.getTimeNow
      hour = current_time.hour
      alpha = 128

      if hour >= 6 && hour <= 18
        # Full visibility during the day
        alpha = 128
      elsif hour > 18 && hour <= 20
        # Gradually fade out between 6 PM and 8 PM
        alpha = 128 - ((hour - 18) * 64).to_i
      elsif hour >= 4 && hour < 6
        # Gradually become visible between 4 AM and 6 AM
        alpha = ((hour - 4) * 64).to_i
      else
        # Invisible at night
        alpha = 0
      end

      return alpha
    end
  end
end