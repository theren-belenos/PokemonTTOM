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

def pbChargeBarRythmGame(idminigame)

	# Définitions des jeux
	case idminigame
	when 1
		outline_name = "ChargeBarLong"
		song = "Audio/BGM/gym.ogg"
		speed = 2
		maxscore = 9700
		maxhits = 58
		zone_size = 0.1
		zone_center = 	[[],[],[],
						[0.35,0.9],                                                                                                                
						[0.47],                                                                                                                 
						[0.39,0.66],                                                                                                                 
						[0.49,0.77],                                                                                                                 
						[0.08,0.88],                                                                                                                 
						[0.7,0.95],                                                                                                               
						[0.16,0.28],                                                                                                               
						[0.13,0.94],                                                                                                                
						[0.24,0.48,0.59,0.84],                                                                                                                
						[0.05,0.16,0.4],                                                                                                                
						[0.19,0.46,0.66,0.79],                                                                                                               
						[0.35,0.62],                                                                                                                
						[0.1,0.49,0.75],                                                                                                               
						[0.05,0.31,0.59,0.84],                                                                                                                
						[0.05,0.16,0.7],                                                                                                               
						[0.05,0.27,0.56,0.82],                                                                                                                
						[0.11,0.56,0.94],                                                                                                                
						[0.2,0.46,0.73],                                                                                                               
						[0.05,0.32,0.48,0.61,0.9],                                                                                                               
						[0.05,0.18,0.46,0.6,0.72] 
						]
		
	when 2
		outline_name = "ChargeBarLong"
		song = "Audio/BGM/town_verdanturf.ogg"
		speed = 3
		maxscore = 15300
		maxhits = 86
		zone_size = 0.12
		zone_center = 	[[],[],[],
						[0.44,0.81],                                                                                                                 
						[0.49,0.84],                                                                                                                 
						[0.17],                                                                                                                  
						[0.13,0.41],                                                                                                                 
						[0.3,0.61,0.92],                                                                                                                 
						[0.25,0.52,0.84],                                                                                                                 
						[0.28,0.45],  
						[],                                                                                                               
						[0.1,0.36,0.65,0.94],                                                                                                                
						[0.23,0.56,0.87],                                                                                                                
						[0.18,0.5,0.81],                                                                                                                
						[0.75],                                                                                                                
						[0.09],                                                                                                                 
						[0.08,0.34,0.61,0.9],                                                                                                                
						[0.22,0.82],                                                                                                               
						[0.16,0.44,0.79],                                                                                                                
						[0.27],                                                                                                                
						[0.9],                                                                                                                
						[0.25,0.54,0.85],                                                                                                               
						[0.14,0.48,0.78],                                                                                                               
						[0.1,0.41,0.75],                                                                                                                
						[0.62,0.94],                                                                                                                
						[0.62,0.94],                                                                                                                
						[0.28],                                                                                                                
						[0.19,0.51],                                                                                                                
						[0.15,0.41,0.74],                                                                                                                
						[0.88],                                                                                                               
						[0.25,0.6,0.94],                                                                                                                
						[0.27],                                                                                                                
						[0.18,0.46],                                                                                                                
						[0.3,0.44,0.58,0.74],                                                                                                                
						[0.82],                                                                                                                
						[0.21,0.54,0.87],                                                                                                                
						[0.18],                                                                                                                
						[0.2,0.52,0.77],                                                                                                                
						[0.08,0.36,0.66],                                                                                                              
						[0.13,0.6],                                                                                                                
						[0.51,0.84],                                                                                                                
						[0.18,0.61],                                                                                                                
						[0.13] 
						]
	when 3
		outline_name = "ChargeBarLong"
		song = "Audio/BGM/battle_nikodim.ogg"
		speed = 4
		maxscore = 22100
		maxhits = 120
		zone_size = 0.14
		zone_center = 	[[],[],[],
						[0.25,0.64,0.93],                                                                                                                 
						[0.33,0.67],                                                                                                                 
						[0.7],                                                                                                                 
						[0.05,0.43,0.77],                                                                                                                 
						[0.62],                                                                                                                 
						[0.24,0.67],                                                                                                                
						[0.06,0.68],                                                                                                                 
						[0.08,0.41,0.76],                                                                                                                
						[0.12,0.76],                                                                                                                
						[0.14,0.55,0.82],                                                                                                                
						[0.12,0.51,0.78],  
						[],                                                                                                              
						[0.84],                                                                                                                
						[0.23,0.56,0.93],                                                                                                                
						[0.34,0.93],                                                                                                                
						[0.29,0.64],                                                                                                                
						[0.1,0.42],                                                                                                                
						[0.08,0.29,0.57],                                                                                                                
						[0.29,0.59,0.78],                                                                                                                
						[0.07],
						[],                                                                                                                 
						[0.24,0.45,0.75],                                                                                                                
						[0.28,0.68],                                                                                                                
						[0.29,0.55,0.84],                                                                                                                
						[0.32,0.69],                                                                                                                
						[0.68],                                                                                                                
						[0.08,0.47,0.82],                                                                                                                
						[0.76],                                                                                                                
						[0.14,0.51,0.92],                                                                                                                
						[0.81],                                                                                                                
						[0.19,0.53,0.93],                                                                                                                
						[0.84],                                                                                                                
						[0.26,0.6,0.93],                                                                                                                
						[0.68,0.94],                                                                                                                
						[0.82],                                                                                                                
						[0.21,0.62],                                                                                                                
						[0.07,0.55,0.81],                                                                                                                
						[0.12,0.36,0.74],                                                                                                                
						[0.12],                                                                                                                 
						[0.06,0.6,0.89],                                                                                                                
						[0.21,0.64],                                                                                                                
						[0.07,0.41],                                                                                                                
						[0.07,0.355,0.66,0.93],                                                                                                                
						[0.4,0.79],                                                                                                                
						[0.09,0.39,0.76],                                                                                                                
						[0.82],                                                                                                                
						[0.16,0.37,0.69,0.93],                                                                                                                
						[0.22,0.47,0.87],                                                                                                                
						[0.2,0.52,0.85],                                                                                                                
						[0.19,0.61],                                                                                                                
						[0.3,0.58,0.87],                                                                                                                
						[0.36,0.72],                                                                                                                
						[0.36,0.66,0.93],                                                                                                                
						[0.4,0.8]
						]
	# recording
	when 4
		outline_name = "ChargeBarLong"
		song = "Audio/BGM/gym.ogg"
		speed = 2	
		maxscore = 10000
		maxhits = 50
		zone_size = 0.1
		zone_center = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
	when 5
		outline_name = "ChargeBarLong"
		song = "Audio/BGM/town_verdanturf.ogg"
		speed = 3	
		maxscore = 10000
		maxhits = 50
		zone_size = 0.1
		zone_center = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
	when 6
		outline_name = "ChargeBarLong"
		song = "Audio/BGM/battle_nikodim.ogg"
		speed = 4	
		maxscore = 10000
		maxhits = 50
		zone_size = 0.1
		zone_center = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
	else
		return -1
	end
					
					
					
  # Stop current music
  Audio.bgm_stop
  
  # Defaults & clamping 
  zone_color = []
  zone_color[0] = Color.new(255, 0, 0, 128)
  zone_color[1] = Color.new(255, 0, 0, 98)
  zone_color[2] = Color.new(255, 0, 0, 64)     
  fill_color = Color.new(0, 192, 0, 240)

  speed = speed.to_i
  speed = 1 if speed < 1

  # Viewport 
  viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
  viewport.z = 99999
  
  # Score & combo
  scoresprite = Sprite.new(viewport)
  scoresprite.bitmap = Bitmap.new("Graphics/Minigame/scoresprite.png")
  scoresprite.x = (Graphics.width - scoresprite.bitmap.width) * 0.08
  scoresprite.y = (Graphics.height - scoresprite.bitmap.height) * 0.3
  scoresprite.opacity = 255
  
  scoretext = Sprite.new(viewport)
  scoretext.bitmap = Bitmap.new(200, 80)
  scoretext.x = scoresprite.x #+ scoresprite.bitmap.width / 2
  scoretext.y = scoresprite.y #+ scoresprite.bitmap.height / 2
  scoretext.bitmap.font.size = 24
  scoretext.bitmap.font.color = Color.new(32, 32, 32, 255)
  scoretext.bitmap.font.bold = true
  #scoretext.bitmap.font.outline = Color.new(0, 0, 0, 255)
  scoretext.bitmap.draw_text(80,47,200,30,"0",0)
  
  combosprite = Sprite.new(viewport)
  combosprite.bitmap = Bitmap.new("Graphics/Minigame/combosprite.png")
  combosprite.x =  (Graphics.width - combosprite.bitmap.width) * 0.92
  combosprite.y = (Graphics.height - combosprite.bitmap.height) * 0.3
  combosprite.opacity = 255
  
  combotext = Sprite.new(viewport)
  combotext.bitmap = Bitmap.new(200, 80)
  combotext.x = combosprite.x #+ scoresprite.bitmap.width / 2
  combotext.y = combosprite.y #+ scoresprite.bitmap.height / 2
  combotext.bitmap.font.size = 24
  combotext.bitmap.font.color = Color.new(64, 64, 64, 255)
  combotext.bitmap.font.bold = true
  combotext.bitmap.draw_text(30,48,200,30,"0",0)
  
  nbbars = zone_center.length-1
  fill = []
  target_sprite = []
  countdown_sprite = []
  back = []
  score = 0
  combo = 0
  hits = 0
  fails = 0
  maxcombo = 1
  countdown = [true,true,true]
  
  for j in 0.. nbbars
	
	  # Trois premières barres : countdown	  
	  countdown_sprite[j-1].dispose if j > 0 && j < 4
	  if j < 3 && countdown[j]
		
	    path = "Graphics/Minigame/start_" + (3-j).to_s + ".png"
	    countdown_sprite[j] = Sprite.new(viewport)
        countdown_sprite[j].bitmap = Bitmap.new(path)
        countdown_sprite[j].x = (Graphics.width - countdown_sprite[j].bitmap.width) / 2
        countdown_sprite[j].y = (Graphics.height - countdown_sprite[j].bitmap.height) / 2
        countdown_sprite[j].opacity = 255

        # Play corresponding sound
        Audio.se_play("Audio/SE/Count.wav", [$PokemonSystem.bgmvolume+10,100].min, 100) #if FileTest.exist?(countdown_sound + ".wav")

        Graphics.update
        Input.update
		
		countdown[j] = false
	  end
	  
	  if j == 3
		Audio.bgm_play(song, [$PokemonSystem.bgmvolume+10,100].min, 100) if j == 3
		$game_variables[168] = true
	  end
  
	  nbtoshow = [nbbars - j, 2].min
	  nbzones = []
	  
	  target_min = []
	  target_max = []
	  
	  inner_width = []
	  inner_height = []
	  
	  # Sprite layers (3 max)
	  
	  for k in 0..nbtoshow
		  target_min[k] = [0]
	      target_max[k] = [0]
		  nbzones[k] = zone_center[j+k].length-1
		  
		  # Zone overlay 
		  target_sprite[k] = Sprite.new(viewport)
		  target_sprite[k].bitmap = nil
		  target_sprite[k].z = 1
		  
		  # Fill bar 
		  fill[k] = Sprite.new(viewport)
		  fill[k].bitmap = nil
		  fill[k].z = 2

		  # Outline (top)
		  back[k] = Sprite.new(viewport)
		  back[k].z = 0

		  # Load outline graphic 
		  path = sprintf("Graphics/Pictures/%s_%i", outline_name, k)
		  path_png = path + ".png"
		  if FileTest.exist?(path_png)
			path = path_png
		  end
		  
		  # If this fails, RGSS will crash here, which is fine for debugging.
		  back[k].bitmap = Bitmap.new(path)

		  bar_width = back[k].bitmap.width
		  bar_height = back[k].bitmap.height

		  back[k].x = (Graphics.width  - bar_width) / 2
		  back[k].y = (Graphics.height - bar_height) / 2 + 70 + bar_height*k + 10*k

		  # Inner region for fill/zone (3 px margin)
		  inner_width[k] = bar_width - 6
		  inner_height[k] = bar_height - 6
		  inner_width[k] = 1 if inner_width[k]  < 1
		  inner_height[k] = 1 if inner_height[k] < 1

		  # Position fill and zone sprites and give them bitmaps
		  fill[k].bitmap = Bitmap.new(inner_width[k], inner_height[k])
		  fill[k].x = back[k].x + 3
		  fill[k].y = back[k].y + 3

		  target_sprite[k].bitmap = Bitmap.new(inner_width[k], inner_height[k])
		  target_sprite[k].x = back[k].x + 3
		  target_sprite[k].y = back[k].y + 3

		  # Compute zone boundaries (in inner pixel space) 
		  zone_pixel_width = []
		  zone_center_px = []
		 
		  for i in 0..nbzones[k]
			zone_pixel_width[i] = (inner_width[k] * zone_size).to_i
			zone_pixel_width[i] = 1 if zone_pixel_width[i] < 1
			zone_center_px[i] = (inner_width[k] * zone_center[j+k][i]).to_i
			target_min[k][i] = zone_center_px[i] - (zone_pixel_width[i] / 2)
			target_max[k][i] = target_min[k][i] + zone_pixel_width[i]
		 
			# Clamp zone inside [0, inner_width]
			if target_min[k][i] < 0
				target_max[k][i] -= target_min[k][i]
				target_min[k][i] = 0
			end
			if target_max[k][i] > inner_width[k]
				diff = target_max[k][i] - inner_width[k]
				target_min[k][i] -= diff
				target_max[k][i] = inner_width[k]
				target_min[k][i] = 0 if target_min[k][i] < 0
			end

			# Draw zone overlay
			target_sprite[k].bitmap.fill_rect(
			target_min[k][i], 0,
			target_max[k][i] - target_min[k][i],
			inner_height[k],
			zone_color[k]
			)
			
		  end
	  end

	  # Game logic variables 
	  value = 0
	  max_value = inner_width[0]
	  fill_speed = speed

	  started = false   # has the "real" game started yet?
		 # have we seen C released after entering?
	  prev_hold = false
	  hit = false
	  alreadyhit = []
	  for i in 0..nbzones[0]
		alreadyhit[i] = false
	  end

	  # Main loop 
	  loop do
		Graphics.update
		Input.update

		pressed = Input.press?(Input::C)   # Space/Z/Enter by default in RMXP
		if pressed == false
			prev_hold = false
			started = true
		else
			hit = true if started == true && prev_hold == false
			prev_hold = true
		end
		
		value += fill_speed
		value = max_value if value > max_value
		fill[0].bitmap.clear
		fill[0].bitmap.fill_rect(0, 0, value, inner_height[0], fill_color)

		if hit
		
			puts "["+j.to_s+","+value.to_s+"]" #if idminigame > 3
		
			flag = false
			for i in 0..nbzones[0]
				if value >= target_min[0][i] && value <= target_max[0][i]
					if alreadyhit[i] == false
						flag = true 
						alreadyhit[i] = true
					end
				end
			end
			
			if flag == true
				hits += 1
				combo += 1
				combo = [20, combo].min
				maxcombo = [combo, maxcombo].max
				gain = 10*combo  # succes
			else
				fails += 1
				gain = -10 # fail
				combo -= 10
				combo = [0, combo].max
				
			end
			score += gain
			
			combotext.bitmap.clear
			scoretext.bitmap.clear
			
			case gain
			when 0..40
				combotext.bitmap.font.color = Color.new(64, 64, 64, 255) #gris
				scoretext.bitmap.font.color = Color.new(64, 64, 64, 255) #gris
			when 50..90
				combotext.bitmap.font.color = Color.new(34, 139, 34, 255) #vert
				scoretext.bitmap.font.color = Color.new(34, 139, 34, 255) #vert
			when 100..140
				combotext.bitmap.font.color = Color.new(70, 130, 180, 255) #bleu
				scoretext.bitmap.font.color = Color.new(70, 130, 180, 255) #bleu
			when 150..190
				combotext.bitmap.font.color = Color.new(147, 112, 219, 255) #violet
				scoretext.bitmap.font.color = Color.new(147, 112, 219, 255) #violet
			when 200
				combotext.bitmap.font.color = Color.new(255, 215, 0, 255) #doré
				scoretext.bitmap.font.color = Color.new(255, 215, 0, 255) #doré
			else
				combotext.bitmap.font.color = Color.new(220, 20, 60, 255) #rouge
				scoretext.bitmap.font.color = Color.new(220, 20, 60, 255) #rouge
			end
			if combo == 20
				combotext.bitmap.draw_text(30,48,200,30,"20 MAX",0)
			else
				combotext.bitmap.draw_text(30,48,200,30,combo.to_s,0)
			end
			scoretext.bitmap.draw_text(80,15,200,30,"+"+gain.to_s,0)
			scoretext.bitmap.font.color = Color.new(32, 32, 32, 255)
			scoretext.bitmap.draw_text(80,47,200,30,score.to_s,0)
			
			
			
		end
		hit = false
		break if value >= max_value
		
		# Allow cancel at any time
		if Input.trigger?(Input::B)
			pbMessage(_INTL("You cancelled the minigame."))
			# Cleanup 
			for k in 0..nbtoshow
				[fill[k], target_sprite[k], back[k]].each do |s|
					next if !s
					if s.bitmap
						s.bitmap.dispose
					end
					s.dispose
				end
			end
			scoresprite.dispose
			combosprite.dispose
			viewport.dispose
			return -1
		end  
	  end

	  # Cleanup 
	  for k in 0..nbtoshow
		  [fill[k], target_sprite[k], back[k]].each do |s|
			next if !s
			if s.bitmap
			  s.bitmap.dispose
			end
			s.dispose
		  end
	  end 
  end
  scoresprite.dispose
  combosprite.dispose
  $game_variables[168] = false
  
  # Affichage des résultats
  resultsprite = Sprite.new(viewport)
  resultsprite.bitmap = Bitmap.new("Graphics/Minigame/resultsprite.png")
  resultsprite.x = (Graphics.width - resultsprite.bitmap.width) * 0.5
  resultsprite.y = (Graphics.height - resultsprite.bitmap.height) * 0.3
  resultsprite.opacity = 255
  
  resulttext = Sprite.new(viewport)
  resulttext.bitmap = Bitmap.new(400, 250)
  resulttext.x = resultsprite.x 
  resulttext.y = resultsprite.y
  resulttext.bitmap.font.bold = true
  
  resulttext.bitmap.font.size = 32
  resulttext.bitmap.font.color = Color.new(32, 32, 32, 255)
  resulttext.bitmap.draw_text(50,10,200,30,_INTL("Résultats"),0)
  
  resulttext.bitmap.font.size = 48
  resulttext.bitmap.font.color = Color.new(255, 215, 0, 255)
  resulttext.bitmap.draw_text(100,45,200,30,score.to_s+" pts",0)
  
  resulttext.bitmap.font.size = 24
  
  resulttext.bitmap.font.color = Color.new(70, 130, 180, 255)
  resulttext.bitmap.draw_text(50,100,200,30,_INTL("Performance: ") + ((score*100).to_f/(maxscore).to_f).floor(2).to_s + "%",0)
  
  resulttext.bitmap.font.color = Color.new(34, 139, 34, 255)
  resulttext.bitmap.draw_text(50,128,200,30,_INTL("Hits: ") + hits.to_s,0)
  
  resulttext.bitmap.font.color = Color.new(220, 20, 60, 255)
  resulttext.bitmap.draw_text(50,156,200,30,_INTL("Fails: ") + fails.to_s,0)
  
  resulttext.bitmap.font.color = Color.new(64, 64, 64, 255)
  resulttext.bitmap.draw_text(50,184,200,30,_INTL("Missed: ") + (maxhits - hits - fails).to_s,0)
  
  resulttext.bitmap.font.color = Color.new(147, 112, 219, 255)
  resulttext.bitmap.draw_text(50,212,200,30,_INTL("Max combo: ") + maxcombo.to_s,0)
  
  pbMessage(_INTL("End of the minigame! Here are your results!"))
  
  Audio.bgm_stop
  
  resultsprite.dispose
  viewport.dispose
  
  # Enregistrement des records si besoin
  pbSet(197+idminigame, score) if score > pbGet(197+idminigame)
  
  return score
end
