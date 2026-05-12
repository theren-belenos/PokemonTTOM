# "Hold until you reach the zone" bar minigame thing

# outline_name : String - filename in Graphics/Pictures (without path)
# zone_size : Float (0–1) - width of the zone as a percentage of bar width
# zone_center : Float (0–1) - position of the zone center along the bar
# zone_color : Color or nil - color of the zone overlay (default: red-ish)
# fill_color : Color or nil - color of the fill bar (default: green)
# speed : Integer - how fast the bar fills (pixels per frame), min 1

# Return codes:
#   1 -> success (right on target)
#   2 -> too low
#   3 -> too high
#   4 -> backed out (quit game)

def pbChargeBarZone(outline_name,
                    zone_size = 0.3,
                    zone_center = 0.5,
                    zone_color = nil,
                    fill_color = nil,
                    speed = 4)

  # Defaults & clamping 
  zone_color ||= Color.new(255, 0, 0, 128)   
  fill_color ||= Color.new(0, 192, 0)

  zone_size = [[zone_size.to_f,   0.0].max, 1.0].min
  zone_center = [[zone_center.to_f, 0.0].max, 1.0].min
  speed = speed.to_i
  speed = 1 if speed < 1

  # Viewport 
  viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
  viewport.z = 99999

  # Sprite layers
  
  # Zone overlay 
  target_sprite = Sprite.new(viewport)
  target_sprite.bitmap = nil
  target_sprite.z = 1
  
  # Fill bar 
  fill = Sprite.new(viewport)
  fill.bitmap = nil
  fill.z = 2

  # Outline (top)
  back = Sprite.new(viewport)
  back.z = 0

  # Load outline graphic 
  path = sprintf("Graphics/Pictures/%s", outline_name)
  path_png = path + ".png"
  if FileTest.exist?(path_png)
    path = path_png
  end
  
  # If this fails, RGSS will crash here, which is fine for debugging.
  back.bitmap = Bitmap.new(path)

  bar_width = back.bitmap.width
  bar_height = back.bitmap.height

  back.x = (Graphics.width  - bar_width) / 2
  back.y = (Graphics.height - bar_height) / 2 - 70

  # Inner region for fill/zone (1 px margin)
  inner_width = bar_width  - 2
  inner_height = bar_height - 2
  inner_width = 1 if inner_width  < 1
  inner_height = 1 if inner_height < 1

  # Position fill and zone sprites and give them bitmaps
  fill.bitmap = Bitmap.new(inner_width, inner_height)
  fill.x = back.x + 1
  fill.y = back.y + 1

  target_sprite.bitmap = Bitmap.new(inner_width, inner_height)
  target_sprite.x = back.x + 1
  target_sprite.y = back.y + 1

  # Compute zone boundaries (in inner pixel space) 
  zone_pixel_width = (inner_width * zone_size).to_i
  zone_pixel_width = 1 if zone_pixel_width < 1

  zone_center_px = (inner_width * zone_center).to_i
  target_min = zone_center_px - (zone_pixel_width / 2)
  target_max = target_min + zone_pixel_width

  # Clamp zone inside [0, inner_width]
  if target_min < 0
    target_max -= target_min
    target_min = 0
  end
  if target_max > inner_width
    diff = target_max - inner_width
    target_min -= diff
    target_max = inner_width
    target_min = 0 if target_min < 0
  end

  # Draw zone overlay
  target_sprite.bitmap.fill_rect(
    target_min, 0,
    target_max - target_min,
    inner_height,
    zone_color
  )

  # Game logic variables 
  value = 0
  max_value = inner_width
  fill_speed = speed

  started = false   # has the "real" game started yet?
  seen_release = false   # have we seen C released after entering?
  prev_hold = false
  result_code = 0

  # Main loop 
  loop do
    Graphics.update
    Input.update

    holding = Input.press?(Input::C)   # Space/Z/Enter by default in RMXP

    if !started
      seen_release = true if !holding
      if seen_release && holding
        started   = true
        prev_hold = true   
      end
    else
      if holding
        value += fill_speed
        value = max_value if value > max_value
      end

      fill.bitmap.clear
      fill.bitmap.fill_rect(0, 0, value, inner_height, fill_color)

      if prev_hold && !holding
        if value >= target_min && value <= target_max
          #pbMessage(_INTL("Nice! Right on target."))
          result_code = 1   # success
        else
          if value < target_min
            #pbMessage(_INTL("Too low..."))
            result_code = 2 # too low
          else
            #pbMessage(_INTL("Too high..."))
            result_code = 3 # too high
          end
        end
        break
      end
      
      prev_hold = holding
    end

    # Allow cancel at any time
    if Input.trigger?(Input::B)
      #pbMessage(_INTL("You backed out."))
      result_code = 4 
      break
    end
  end

  # Cleanup 
  [fill, target_sprite, back].each do |s|
    next if !s
    if s.bitmap
      s.bitmap.dispose
    end
    s.dispose
  end
  viewport.dispose

  return result_code
end
