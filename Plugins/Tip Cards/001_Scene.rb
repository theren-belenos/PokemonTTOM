def pbShowTipCard(*ids)
    scene = TipCard_Scene.new(ids)
    screen = TipCard_Screen.new(scene)
    screen.pbStartScreen
end

alias pbTipCard pbShowTipCard

def pbShowTipCardsGrouped(*groups, continuous: false)
    sections = groups
    if sections.length > 1 || (sections.length == 1 && Settings::TIP_CARDS_SINGLE_GROUP_SHOW_HEADER)
        scene = TipCardGroups_Scene.new(sections, false, continuous)
        screen = TipCardGroups_Screen.new(scene)
        screen.pbStartScreen
    elsif sections[0]
        tips = Settings::TIP_CARDS_GROUPS[sections[0]][:Tips]
        pbShowTipCard(*tips)
    else
        Console.echo_warn "No available tips to show"
    end
end

alias pbTipCardsGrouped pbShowTipCardsGrouped

#===============================================================================
# Tip Card Scene
#===============================================================================  
class TipCard_Screen
    def initialize(scene)
        @scene = scene
    end
  
    def pbStartScreen
        @scene.pbStartScene
        @scene.pbScene
        @scene.pbEndScene
    end
end
  
class TipCard_Scene
    def initialize(tips)
        @tips = tips
    end

    def pbStartScene
        @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
        @viewport.z = 99999
        @index = 0
		@animatingFameLvl = false
		@count = 0
		@fraction_tic = 0
		@exp_fraction = 0
		@fameRequired = 0
		@remainingFame = 0
        @pages = @tips.length
        @sprites = {}
        @sprites["background"] = IconSprite.new(0, 0, @viewport)
        @sprites["background"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/#{Settings::TIP_CARDS_DEFAULT_BG}"))
        @sprites["background"].x = (Graphics.width - @sprites["background"].bitmap.width) / 2
        @sprites["background"].y = (Graphics.height - @sprites["background"].bitmap.height) / 2
        @sprites["background"].visible = true
        @sprites["image"] = IconSprite.new(0, 0, @viewport)
        @sprites["image"].visible = false
		@sprites["stars"] = IconSprite.new(0, 0, @viewport)
        @sprites["stars"].visible = false
		@sprites["hearts"] = IconSprite.new(0, 0, @viewport)
        @sprites["hearts"].visible = false
        @sprites["arrow_right"] = IconSprite.new(0, 0, @viewport)
        @sprites["arrow_right"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/arrow_right"))
        @sprites["arrow_right"].x = Graphics.width / 2 + 48
        @sprites["arrow_right"].y = @sprites["background"].y + @sprites["background"].bitmap.height -  @sprites["arrow_right"].bitmap.height - 4
        @sprites["arrow_right"].visible = false
        @sprites["arrow_left"] = IconSprite.new(0, 0, @viewport)
        @sprites["arrow_left"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/arrow_left"))
        @sprites["arrow_left"].x = Graphics.width / 2 - 48 - @sprites["arrow_left"].bitmap.width
        @sprites["arrow_left"].y = @sprites["background"].y + @sprites["background"].bitmap.height -  @sprites["arrow_left"].bitmap.height - 4
        @sprites["arrow_left"].visible = false
		@sprites["famelvlbar"] = IconSprite.new(0, 0, @viewport)
		@sprites["famelvlbar"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/famelvlbar"))
		@sprites["famelvlbar"].x = @sprites["background"].x + 64
        @sprites["famelvlbar"].y = @sprites["background"].y + 96
        @sprites["famelvlbar"].visible = false
		@famebarbitmap  = AnimatedBitmap.new("Graphics/Pictures/Tip Cards/famelvlfill")
		@famebar = Sprite.new(@viewport)
		@famebar.bitmap = @famebarbitmap.bitmap
		@sprites["famelvlfill"] = @famebar
		@sprites["famelvlfill"].x = @sprites["background"].x + 72
        @sprites["famelvlfill"].y = @sprites["background"].y + 107
        @sprites["famelvlfill"].visible = false
        @sprites["overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
        @sprites["overlay"].visible = true
        pbSEPlay(Settings::TIP_CARDS_SHOW_SE)
        pbDrawTip
    end
    
    def pbScene
        loop do
            Graphics.update
            Input.update
            pbUpdate
            oldindex = @index
            quit = false
			if @animatingFameLvl == false
				if Input.trigger?(Input::USE)
					if @index < @pages - 1
						@index += 1
					else 
						pbSEPlay(Settings::TIP_CARDS_DISMISS_SE)
						break
					end
				elsif Input.trigger?(Input::BACK) || Input.trigger?(Input::LEFT)
					@index -= 1 if @index > 0
				elsif Input.trigger?(Input::RIGHT)
					@index += 1 if @index < @pages - 1
				end
				if oldindex != @index
					pbDrawTip
					if Settings::TIP_CARDS_SWITCH_SE
						pbSEPlay(Settings::TIP_CARDS_SWITCH_SE)
					else
						pbPlayCursorSE
					end
				end
			end
        end
    end
    
    def pbEndScene
        # pbFadeOutAndHide(@sprites) { pbUpdate }
        pbUpdate
        Graphics.update
        Input.update
        pbDisposeSpriteHash(@sprites)
        @viewport.dispose
    end
	
	def fameLevelUp
		overlay = @sprites["overlay"].bitmap
		base = Settings::TIP_CARDS_TEXT_MAIN_COLOR
		shadow = Settings::TIP_CARDS_TEXT_SHADOW_COLOR
		@exp_fraction = 0
		pbSEStop
		@famebar.src_rect.width = @famebarbitmap.width
		pbPlayLevelUpSE
		oldlvl = $town.calculateFameLvl
		newlvl = oldlvl + 1
		bottomtext = "<ac><b>Fame level up: "
		bottomtext << oldlvl.to_s
		bottomtext << " -> <c3=FFD700,DAA520>"
		bottomtext << newlvl.to_s
		bottomtext << "</b></c3>"
		drawFormattedTextEx(overlay, @sprites["background"].x + 24, @sprites["background"].y + 160, @sprites["background"].width - 48, bottomtext, base, shadow)
		loop do
			Graphics.update
			Input.update
			if Input.trigger?(Input::USE)
				pbPlayCursorSE
				break
			end
		end
		rewards = $town.getRewardText(newlvl)
		rewardtext = rewards[0]
		newmin = rewards[1].to_i
		newmax = rewards[2].to_i
		if newmin > 0
			rewardtext << "\nMinimum daily trainers: "
			rewardtext << (newmin-1).to_s
			rewardtext << " -> <c3=FFD700,DAA520><b>"
			rewardtext << newmin.to_s
			rewardtext << "</b></c3>"
		end
		if newmax > 0
			rewardtext << "\nMaximum daily trainers: "
			rewardtext << (newmax-1).to_s
			rewardtext << " -> <c3=FFD700,DAA520><b>"
			rewardtext << newmax.to_s
			rewardtext << "</b></c3>"
		end
		rewardtext << "\nBonus: +<c3=FFD700,DAA520><b>$"
		rewardtext << ($town.rank*1000).to_s
		rewardtext << "</b></c3> funds & money!</al>"
		drawFormattedTextEx(overlay, @sprites["background"].x + 24, @sprites["background"].y + 190, @sprites["background"].width - 48, rewardtext, base, shadow)
		loop do
			Graphics.update
			Input.update
			if Input.trigger?(Input::USE)
				pbPlayCursorSE
				break
			end
		end
		fameToAdd = @remainingFame
		fameNeeded = $town.calculateFameForUp(newlvl)
		@exp_fraction = 0
		target_fraction =  fameToAdd.to_f / fameNeeded.to_f 
		@count = 100 * target_fraction
		@fraction_tic = target_fraction / @count	
		@famebar.src_rect.width = 0
		limits = [0,3,6,10,15,20,25,30,40,50,60,70,85,100]
		if fameToAdd > 0 || newlvl < limits[$town.rank]
			pbSEPlay("Pkmn exp gain")
			@animatingFameLvl = false 
		end
	end
	
	def endFillbar
		bottomtext = "Fame needed for level up: <b>"
		bottomtext << @fameRequired.to_s
		bottomtext << " </b>more"
		overlay = @sprites["overlay"].bitmap
		base = Settings::TIP_CARDS_TEXT_MAIN_COLOR
		shadow = Settings::TIP_CARDS_TEXT_SHADOW_COLOR
		drawFormattedTextEx(overlay, @sprites["background"].x + 24, @sprites["background"].y + 175, @sprites["background"].width - 48, bottomtext, base, shadow)
	end
	
	def pbUpdateFillbar
		if @exp_fraction >= 1
			fameLevelUp
		else
			w = @exp_fraction * @famebarbitmap.width
			@famebar.src_rect.width = w
		end	
		@exp_fraction += @fraction_tic
		if @count <= 0
			endFillbar if @remainingFame == 0
			@animatingFameLvl = false
			pbSEStop
		else
			@count -= 1
		end	
	end
  
    def pbUpdate
        pbUpdateSpriteHash(@sprites)
		pbUpdateFillbar if (@animatingFameLvl)
    end

    def pbDrawTip
        overlay = @sprites["overlay"].bitmap
        overlay.clear
        @sprites["image"].visible = false
		@sprites["stars"].visible = false
        @sprites["arrow_right"].visible = false
        @sprites["arrow_left"].visible = false
        pbSetSystemFont(overlay)
        base = Settings::TIP_CARDS_TEXT_MAIN_COLOR
        shadow = Settings::TIP_CARDS_TEXT_SHADOW_COLOR
        tip = @tips[@index]
        info = Settings::TIP_CARDS_CONFIGURATION[tip] || nil
        if info
            text_y_adj = 64
            text_x_adj = 16
            text_width_adj = 0
            pbSetTipCardSeen(tip)
            if info[:Background]
                @sprites["background"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/#{info[:Background]}"))
            else
                @sprites["background"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/#{Settings::TIP_CARDS_DEFAULT_BG}"))
            end
            if info[:Image]
                @sprites["image"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/Images/#{info[:Image]}"))
                image_pos = info[:ImagePosition] || ((@sprites["image"].width > @sprites["image"].height) ? :Top : :Left)
                case image_pos
                when :Top
                    @sprites["image"].x = @sprites["background"].x + 16
                    @sprites["image"].y = @sprites["background"].y + 64
					top_text_x_adj = @sprites["image"].width + 16
                    text_y_adj += @sprites["image"].height + 16
				when :Topcenter
					@sprites["image"].x = (Graphics.width - @sprites["image"].bitmap.width) / 2
                    @sprites["image"].y = @sprites["background"].y + 64
                    text_y_adj += @sprites["image"].height + 16
                when :Bottom
                    @sprites["image"].x = (Graphics.width - @sprites["image"].bitmap.width) / 2
                    @sprites["image"].y = @sprites["background"].y + @sprites["background"].height - @sprites["image"].bitmap.height - 32
                when :Left
                    @sprites["image"].x = @sprites["background"].x + 16
                    @sprites["image"].y = @sprites["background"].y + 64
                    text_x_adj += @sprites["image"].width + 16
                when :Right
                    @sprites["image"].x = @sprites["background"].x + @sprites["background"].width - @sprites["image"].bitmap.width - 16
                    @sprites["image"].y = @sprites["background"].y + 64
                    text_width_adj -= @sprites["image"].width + 16
                end
                @sprites["image"].visible = true
            end
			if info[:Stars]
				@sprites["stars"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/Images/#{info[:Stars]}stars"))
				@sprites["stars"].x = @sprites["background"].x + 50
                @sprites["stars"].y = @sprites["background"].y + 235
				@sprites["stars"].z = 500
                @sprites["stars"].visible = true
			end
			if info[:TrainersInfos]
				variableIndex = [0,204,205,206,207]
				heartsCount = pbGet(variableIndex[info[:TrainersInfos]])
				@sprites["stars"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/Images/#{heartsCount}hearts"))
				@sprites["stars"].x = @sprites["background"].x + 100
                @sprites["stars"].y = @sprites["background"].y + 85
				@sprites["stars"].z = 500
                @sprites["stars"].visible = true
				@sprites["image"].x -= 30
			end
			
            title = "<ac>" + info[:Title] + "</ac>"
		
            # drawFormattedTextEx(bitmap, x, y, width, text, baseColor = nil, shadowColor = nil, lineheight = 32)
            drawFormattedTextEx(overlay, @sprites["background"].x, @sprites["background"].y + 18, @sprites["background"].width, title, base, shadow)
            text_y_adj += info[:YAdjustment] if info[:YAdjustment]
			if info[:BuildingIndex]
				infos = "<ar>"
				if info[:BuildingIndex] && $town.buildings[info[:BuildingIndex]] == 1
					infos += "<i> (In progress)</i>\n"
				elsif info[:BuildingIndex] && $town.buildings[info[:BuildingIndex]] == 2
					infos += "<i> (Already done)</i>\n"
				end
				fundscolor = ($town.buildings[info[:BuildingIndex]] > 0) ? "<c2=318c675a>" : ($town.funds < info[:Funds]) ? "<c2=043c3aff>" : "<c2=06644bd2>" 
				workerscolor = ($town.buildings[info[:BuildingIndex]] > 0) ? "<c2=318c675a>" : ($town.workers < info[:Workers]) ? "<c2=043c3aff>" : "<c2=06644bd2>" 
				instantbuildcolor = ($town.buildings[info[:BuildingIndex]] > 0) ? "<c2=318c675a>" : "<c2=65467b14>"
				
				infos += fundscolor + "Funds : <b>" + info[:Funds].to_s + "</b> / " + $town.funds.to_s + "</c2>\n" + workerscolor + "Workers : <b>" + info[:Workers].to_s + "</b> / " + $town.workers.to_s + "</c2></ar>" 
				if (info[:Instant] && info[:Instant] == 1) 
					infos += "\n<ar>"+instantbuildcolor+"<i>Instant build</i></c2></ar>"
				end
				drawFormattedTextEx(overlay, @sprites["background"].x + 8 + top_text_x_adj, @sprites["background"].y + 64, @sprites["background"].width - (@sprites["background"].x + 24 + top_text_x_adj), infos, base, shadow)
			end
			text = "<al>" + info[:Text] + "</al>"
			if info[:Stars]
				name = pbGet(36) 
				trainerClass = info[:Image]
				text = "<al>Class:</al>\n"
				newtype = true
				newname = true
				i = 0
				while i < $town.rank && newtype do
					encountered = $town.trainersKnown[i+1][info[:Stars]]
					if (encountered.index {|x| x[1] == tip }) != nil
						newtype = false
					end
					i += 1
				end
				i = 0
				while i < $town.rank && newname do
					encountered = $town.trainersKnown[i+1][info[:Stars]]	
					if (encountered.index {|x| x[1] == tip && x[0] == name}) != nil
						newname = false
					end
					i += 1
				end
				if newtype
					text << "<ac><c3=FFD700,DAA520>New!</c3> " + info[:Text] + "    </ac>"		
				else
					text << "<ac>" + info[:Text] + "</ac>"	
				end
				text << "\n\n<al>Name:</al>\n"
				if newname
					text << "<ac><c3=FFD700,DAA520>New!</c3> " + name + "    </ac>"
					
				else
					text << "<ac>" + name + "</ac>"
				end
			end
			if info[:TrainersInfos]
				if info[:TrainersInfos] == 1
					title = "Relation with Melly:"
					text_x_adj = 140
					text_width_adj = 30
					drawFormattedTextEx(overlay, @sprites["background"].x + text_x_adj, @sprites["background"].y + text_y_adj, @sprites["background"].width - text_x_adj + text_width_adj, title, base, shadow)
					text_y_adj += 80
					text = "<al>Melly victory chances:\n"
					stars = $town.getStarsOdds
					i = 1
					while i < stars.length
						if stars[i] > 0
							odds = getWinningChances(1, i)
							text << "<b>"
							text << odds.to_s
							text << "</b>% against "
							text << i.to_s
							text << "-star trainers\n"
						end
						i += 1
					end
					bottomtext = "<ac><c3=B8A8E0,7240E8>Melly victories at the Gym: <b>"
					bottomtext << $town.victoriesCount[1].to_s
					bottomtext << "</b></c3></ac>"
					drawFormattedTextEx(overlay, @sprites["background"].x + 24, @sprites["background"].y + 280, @sprites["background"].width - 48, bottomtext, base, shadow)
				end
				if info[:TrainersInfos] == 2
					title = "Relation with Samy:"
					text_x_adj = 140
					text_width_adj = 30
					drawFormattedTextEx(overlay, @sprites["background"].x + text_x_adj, @sprites["background"].y + text_y_adj, @sprites["background"].width - text_x_adj + text_width_adj, title, base, shadow)
					text_y_adj += 80
					text = "<al>Samy victory chances:\n"
					stars = $town.getStarsOdds
					i = 1
					while i < stars.length
						if stars[i] > 0
							odds = getWinningChances(2, i)
							text << "<b>"
							text << odds.to_s
							text << "</b>% against "
							text << i.to_s
							text << "-star trainers\n"
						end
						i += 1
					end
					bottomtext = "<ac><c3=BDA46A,736440>Samy victories at the Gym: <b>"
					bottomtext << $town.victoriesCount[2].to_s
					bottomtext << "</b></c3></ac>"
					drawFormattedTextEx(overlay, @sprites["background"].x + 24, @sprites["background"].y + 280, @sprites["background"].width - 48, bottomtext, base, shadow)
				end
				if info[:TrainersInfos] == 3
					title = "Relation with Kiana:"
					text_x_adj = 140
					text_width_adj = 30
					drawFormattedTextEx(overlay, @sprites["background"].x + text_x_adj, @sprites["background"].y + text_y_adj, @sprites["background"].width - text_x_adj + text_width_adj, title, base, shadow)
					text_y_adj += 80
					text = "<al>Kiana victory chances:\n"
					stars = $town.getStarsOdds
					i = 1
					while i < stars.length
						if stars[i] > 0
							odds = getWinningChances(3, i)
							text << "<b>"
							text << odds.to_s
							text << "</b>% against "
							text << i.to_s
							text << "-star trainers\n"
						end
						i += 1
					end
					bottomtext = "<ac><c3=A8E0E0,48D8D8>Kiana victories at the Gym: <b>"
					bottomtext << $town.victoriesCount[3].to_s
					bottomtext << "</b></c3></ac>"
					drawFormattedTextEx(overlay, @sprites["background"].x + 24, @sprites["background"].y + 280, @sprites["background"].width - 48, bottomtext, base, shadow)
				end
				if info[:TrainersInfos] == 4
					name = pbGet(12)
					title = "Relation with "
					title << name
					title << ":"
					text_x_adj = 140
					text_width_adj = 30
					drawFormattedTextEx(overlay, @sprites["background"].x + text_x_adj, @sprites["background"].y + text_y_adj, @sprites["background"].width - text_x_adj + text_width_adj, title, base, shadow)
					text_y_adj += 80
					text = "<al>"
					text << name
					text << " victory chances:\n"
					stars = $town.getStarsOdds
					i = 1
					while i < stars.length
						if stars[i] > 0
							odds = getWinningChances(4, i)
							text << "<b>"
							text << odds.to_s
							text << "</b>% against "
							text << i.to_s
							text << "-star trainers\n"
						end
						i += 1
					end
					bottomtext = "<ac><c3=F8A8B8,E82010>"
					bottomtext << name
					bottomtext << " victories at the Gym: <b>"
					bottomtext << $town.victoriesCount[4].to_s
					bottomtext << "</b></c3></ac>"
					drawFormattedTextEx(overlay, @sprites["background"].x + 24, @sprites["background"].y + 280, @sprites["background"].width - 48, bottomtext, base, shadow)
				end
			end
			if info[:Recap]
				if info[:Recap] == 1
					victories = $town.dayTrainers[1] + $town.dayTrainers[2] + $town.dayTrainers[3] + $town.dayTrainers[4] + $town.dayTrainers[5] + $town.dayTrainers[6] + $town.dayTrainers[7]
					allyvictories = $town.dayTrainers[8] + $town.dayTrainers[9] + $town.dayTrainers[10] + $town.dayTrainers[11]
					money = $town.dayMoney
					text = "<ac><b>Total trainers encountered: "
					text << $town.dayTrainers[0].to_s
					text << "</ac></b><al>Victories:  <c3=B8A8E0,7240E8>Melly <b>"
					text << $town.dayTrainers[8].to_s
					if $town.buildings[50] == 3
						text << "  </c3></b><c3=BDA46A,736440>Samy <b>"
						text << $town.dayTrainers[9].to_s
					end
					if $town.buildings[70] == 3
						text << "  </c3></b><c3=A8E0E0,48D8D8>Kiana <b>"
						text << $town.dayTrainers[10].to_s
					end
					if $town.buildings[90] == 3
						text << "  </c3></b><c3=F8A8B8,E82010>"
						text << pbGet(12)
						text << " <b>"
						text << $town.dayTrainers[11].to_s
					end
					text << "</b></c3>  <c3=FFD700,DAA520>You <b>"
					text << (victories-allyvictories).to_s
					if ($town.dayTrainers[0] - victories) > 0
						text << "</b></c3>  <c2=043c3aff>Defeats: <b>"
						text << ($town.dayTrainers[0] - victories).to_s
					else
						text << "</b></c3>  <c2=06644bd2>Defeats: <b>None"
					end
					if money > 0
						text << "</al></c2><ac>------------------------------\nTotal money earned: <c3=FFD700,DAA520>"
						text << money.to_s
						text << "</c3></b></ac><al>Town funds: "
						text << $town.funds.to_s
						text << " + <c3=FFD700,DAA520>"
						text << (money*0.75).floor().to_s
						text << "</c3> = <b><c3=FFD700,DAA520>$"
						text << ($town.funds+money*0.75).floor().to_s
						text << "</c3></b>\nYour money: "
						text << $player.money.to_s
						text << " + <c3=FFD700,DAA520>"
						text << (money*0.25).ceil().to_s
						text << "</c3> = <b><c3=FFD700,DAA520>$"
						text << ($player.money+money*0.25).ceil().to_s
						text << "</c3></b></al>"
					elsif money == 0
						text << "</al></c2><ac>------------------------------\nNo money earned or lost today."
					else
						money = money * -1
						text << "</al></c2><ac>------------------------------\nTotal money lost: <c2=043c3aff>"
						text << money.to_s
						text << "</c2></b></ac><al>Town funds: "
						text << $town.funds.to_s
						text << " - <c2=043c3aff>"
						text << money.to_s
						text << "</c2> = <b><c2=043c3aff>$"
						text << [$town.funds-money.floor(),0].max.to_s
						text << "</c3></b>\nYour money: <b>$"
						text << $player.money.to_s
						text << "</b></al>"
					end
				elsif info[:Recap] == 2
					text ="<ac><b>Fame points earned :</b></ac><ar>"
					if $town.dayTrainers[1] > 0
						trainers = $town.dayTrainers[1]
						text << "\n"
						text << trainers.to_s
						text << " trainer(s) 1-star x 1 = <c3=FFD700,DAA520>"
						text << trainers.to_s
						text << "</c3>"
					end
					if $town.dayTrainers[2] > 0
						trainers = $town.dayTrainers[2]
						text << "\n"
						text << trainers.to_s
						text << " trainer(s) 2-stars x 2 = <c3=FFD700,DAA520>"
						text << (trainers*2).to_s
						text << "</c3>"
					end
					if $town.dayTrainers[3] > 0
						trainers = $town.dayTrainers[3]
						text << "\n"
						text << trainers.to_s
						text << " trainer(s) 3-stars x 3 = <c3=FFD700,DAA520>"
						text << (trainers*3).to_s
						text << "</c3>"
					end
					if $town.dayTrainers[4] > 0
						trainers = $town.dayTrainers[4]
						text << "\n"
						text << trainers.to_s
						text << " trainer(s) 4-stars x 5 = <c3=FFD700,DAA520>"
						text << (trainers*5).to_s
						text << "</c3>"
					end
					if $town.dayTrainers[5] > 0
						trainers = $town.dayTrainers[5]
						text << "\n"
						text << trainers.to_s
						text << " trainer(s) 5-stars x 7 = <c3=FFD700,DAA520>"
						text << (trainers*7).to_s
						text << "</c3>"
					end
					if $town.dayTrainers[6] > 0
						trainers = $town.dayTrainers[6]
						text << "\n"
						text << trainers.to_s
						text << " trainer(s) 6-stars x 10 = <c3=FFD700,DAA520>"
						text << (trainers*10).to_s
						text << "</c3>"
					end
					if $town.dayTrainers[7] > 0
						trainers = $town.dayTrainers[7]
						text << "\n"
						text << trainers.to_s
						text << " trainer(s) 7-stars x 15 = <c3=FFD700,DAA520>"
						text << (trainers*15).to_s
						text << "</c3>"
					end
					dayTotalFame = $town.getDayTotalFame
					text << "No victories today" if dayTotalFame == 0
					text << "\n------------------------------\n<b>Total fame earned: <c3=FFD700,DAA520>"
					text << $town.getDayTotalFame.to_s
					text << "</c3></b></ar>"
				else
					limits = [0,21,51,105,210,365,585,880,1750,3020,4745,6970,11770,25000]
					fameToAdd = $town.getDayTotalFame
					startFame = $town.fame
					startLevelFame = $town.calculateFameLvl
					startFloorFame = $town.calculateFloorFame(startLevelFame)
					fameNeeded = $town.calculateFameForUp(startLevelFame)
					fameAtThisLevel = startFame - startFloorFame
					@exp_fraction = fameAtThisLevel.to_f / fameNeeded.to_f 
					if (fameAtThisLevel + fameToAdd) > fameNeeded
						target_fraction = 1
						@remainingFame = (fameAtThisLevel + fameToAdd) - fameNeeded
					else
						target_fraction = (fameAtThisLevel + fameToAdd).to_f / fameNeeded.to_f 
						@fameRequired = fameNeeded - (fameAtThisLevel + fameToAdd)
					end
					fractions_gap = (target_fraction - @exp_fraction)
					@count = 100 * fractions_gap
					@fraction_tic = fractions_gap.to_f / @count
					w = @exp_fraction * @famebarbitmap.width
					@famebar.src_rect.width = w
					@sprites["famelvlbar"].visible = true
					@sprites["famelvlfill"].visible = true
					title = "<ac><b>Fame Level "
					title << startLevelFame.to_s
					title << "</b></ac>"
					drawFormattedTextEx(overlay, @sprites["background"].x + text_x_adj, @sprites["background"].y + text_y_adj, @sprites["background"].width - 16 - text_x_adj + text_width_adj, title, base, shadow)
					text_y_adj += 80
					text = "<b><ac>------------------------------</ac></b>"
					if startFame < limits[$town.rank] && fameToAdd > 0
						@animatingFameLvl = true 
						pbSEPlay("Pkmn exp gain") 
					end
				end
			end
            if info[:Weekend]
				if info[:Weekend] == 1
					text = "<ac><b>Task(s) done this week: </ac></b><al>"
					tasks = $town.messagesValidateBuildings
					i = 0
					while i < tasks.length
						text << tasks[i]
						i += 1
						text << "\n" if i < tasks.length
					end		
					money = $town.passiveFunds
					text << "</al><ac>------------------------------\nWeekly funds bonus: <c3=FFD700,DAA520>"
					text << money.to_s
					text << "</c3></b></ac><al>Town funds: "
					if money > 0
						text << $town.funds.to_s
						text << " + <c3=FFD700,DAA520>"
						text << money.to_s
						text << "</c3> = <b><c3=FFD700,DAA520>$"
						text << ($town.funds+money).to_s
						text << "</c3>"
					else
						text << $town.funds.to_s
					end
					text << "</al><ac>Weekly fame bonus: <c3=FFD700,DAA520>"
					text << $town.passiveFame.to_s
					text << "</c3>"
				elsif info[:Weekend] == 2
					fameToAdd = $town.passiveFame
					startFame = $town.fame
					startLevelFame = $town.calculateFameLvl
					startFloorFame = $town.calculateFloorFame(startLevelFame)
					fameNeeded = $town.calculateFameForUp(startLevelFame)
					fameAtThisLevel = startFame - startFloorFame
					@exp_fraction = fameAtThisLevel.to_f / fameNeeded.to_f 
					if (fameAtThisLevel + fameToAdd) > fameNeeded
						target_fraction = 1
						@remainingFame = (fameAtThisLevel + fameToAdd) - fameNeeded
					else
						target_fraction = (fameAtThisLevel + fameToAdd).to_f / fameNeeded.to_f 
						@fameRequired = fameNeeded - (fameAtThisLevel + fameToAdd)
					end
					fractions_gap = (target_fraction - @exp_fraction)
					@count = 100 * fractions_gap
					@fraction_tic = fractions_gap.to_f / @count
					w = @exp_fraction * @famebarbitmap.width
					@famebar.src_rect.width = w
					@sprites["famelvlbar"].visible = true
					@sprites["famelvlfill"].visible = true
					title = "<ac><b>Fame Level "
					title << startLevelFame.to_s
					title << "</b></ac>"
					drawFormattedTextEx(overlay, @sprites["background"].x + text_x_adj, @sprites["background"].y + text_y_adj, @sprites["background"].width - 16 - text_x_adj + text_width_adj, title, base, shadow)
					text_y_adj += 80
					text = "<b><ac>------------------------------</ac></b>"
					@animatingFameLvl = true
					pbSEPlay("Pkmn exp gain")
				elsif info[:Weekend] == 3
					text = "<ac><b>Task(s) done this midweek: </ac></b><al>"
					tasks = $town.messagesValidateBuildings
					i = 0
					while i < tasks.length
						text << tasks[i]
						i += 1
						text << "\n" if i < tasks.length
					end		
					money = $town.passiveFunds
					text << "</al><ac>------------------------------"
				else
					startFame = $town.fame
					startLevelFame = $town.calculateFameLvl
					startFloorFame = $town.calculateFloorFame(startLevelFame)
					fameNeeded = $town.calculateFameForUp(startLevelFame)
					fameAtThisLevel = startFame - startFloorFame
					@exp_fraction = fameAtThisLevel.to_f / fameNeeded.to_f 
					w = @exp_fraction * @famebarbitmap.width
					@famebar.src_rect.width = w
					@sprites["famelvlbar"].visible = true
					@sprites["famelvlfill"].visible = true
					title = "<ac><b>Fame Level "
					title << startLevelFame.to_s
					title << "</b></ac>"
					drawFormattedTextEx(overlay, @sprites["background"].x + text_x_adj, @sprites["background"].y + text_y_adj, @sprites["background"].width - 16 - text_x_adj + text_width_adj, title, base, shadow)
					text_y_adj += 80
					text = "<b><ac>------------------------------</ac></b>"
					bottomtext = "Fame needed for level up: <b>"
					bottomtext << (fameNeeded - fameAtThisLevel).to_s
					bottomtext << " </b>more"
					overlay = @sprites["overlay"].bitmap
					base = Settings::TIP_CARDS_TEXT_MAIN_COLOR
					shadow = Settings::TIP_CARDS_TEXT_SHADOW_COLOR
					drawFormattedTextEx(overlay, @sprites["background"].x + 24, @sprites["background"].y + 175, @sprites["background"].width - 48, bottomtext, base, shadow)
				end
			end
			if info[:GymInfos]
				if info[:GymInfos] == 1
					text = "<ac><b>Your Gym is currently rank "
					text << $town.rank.to_s
					text << "</b></ac><al>"
					starsOdds = $town.getStarsOdds
					text << "You will encounter :\n"
					i = 0
					while i < starsOdds.length
						if starsOdds[i] > 0
							text << "- "
							text << starsOdds[i].to_s
							text << "% "
							text << i.to_s
							text << "-star trainers\n"
						end
						i += 1
					end
					trainers = $town.getDailyTrainers
					text << "<al>Daily trainers: <b>"
					text << trainers[0].to_s
					text << "</b> to <b>"
					text << trainers[1].to_s
					text << "</b>\n<c2=06644bd2>Your victories at the Gym: <b>"
					text << $town.victoriesCount[5].to_s
					text << "</b>\n<c2=043c3aff>Your defeats at the Gym: <b>"
					text << $town.victoriesCount[0].to_s
					text << "</b></c2>"
				else
					startFame = $town.fame
					startLevelFame = $town.calculateFameLvl
					startFloorFame = $town.calculateFloorFame(startLevelFame)
					fameNeeded = $town.calculateFameForUp(startLevelFame)
					fameAtThisLevel = startFame - startFloorFame
					@exp_fraction = fameAtThisLevel.to_f / fameNeeded.to_f 
					w = @exp_fraction * @famebarbitmap.width
					@famebar.src_rect.width = w
					@sprites["famelvlbar"].visible = true
					@sprites["famelvlfill"].visible = true
					title = "<ac><b>Fame Level "
					title << startLevelFame.to_s
					title << "</b></ac>"
					drawFormattedTextEx(overlay, @sprites["background"].x + text_x_adj, @sprites["background"].y + text_y_adj, @sprites["background"].width - 16 - text_x_adj + text_width_adj, title, base, shadow)
					text_y_adj += 80
					text = "<b><ac>------------------------------</ac></b>"
					text << "<al>Total fame points: "
					text << startFame.to_s
					text << "\nCurrent Fame Level Progression: "
					text << fameAtThisLevel.to_s
					text << " / "
					text << fameNeeded.to_s
					text << "\nFame needed for level up: <b>"
					text << (fameNeeded - fameAtThisLevel).to_s
					text << " </b>more</al>"
				end
			end
			drawFormattedTextEx(overlay, @sprites["background"].x + text_x_adj, @sprites["background"].y + text_y_adj, @sprites["background"].width - 16 - text_x_adj + text_width_adj, text, base, shadow)
        else
            Console.echo_warn tip.to_s + " is not defined."
            drawFormattedTextEx(overlay, @sprites["background"].x, @sprites["background"].y + 18, @sprites["background"].width, _INTL("<ac>Tip not defined.</ac>"), base, shadow)
        end
        if @pages > 1
            @sprites["arrow_left"].visible = (@index > 0)
            @sprites["arrow_right"].visible = (@index < @pages - 1)
            pbDrawTextPositions(overlay, [[_INTL("{1}/{2}",@index+1, @pages), Graphics.width/2, @sprites["background"].y + @sprites["background"].bitmap.height - 26, 2, base, shadow]])
        end
    end
end

#===============================================================================
# Tip Card Groups Scene
#===============================================================================  
class TipCardGroups_Screen
    def initialize(scene)
        @scene = scene
    end
  
    def pbStartScreen
        @scene.pbStartScene
        @scene.pbScene
        @scene.pbEndScene
    end
end
  
class TipCardGroups_Scene
    def initialize(groups, revisit = true, continuous = false)
        @groups = groups
        @revisit = revisit
        @continuous = continuous
    end

    def pbStartScene
        @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
        @viewport.z = 99999
        @section = 0
        @index = 0
        @sections = @groups.length
        @pages = 0
        @sprites = {}
        @sprites["header"] = IconSprite.new(0, 0, @viewport)
        @sprites["header"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/group_header"))
        @sprites["header"].x = (Graphics.width - @sprites["header"].bitmap.width) / 2
        @sprites["header"].visible = true
        @sprites["background"] = IconSprite.new(0, 0, @viewport)
        @sprites["background"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/#{Settings::TIP_CARDS_DEFAULT_BG}"))
        @sprites["background"].x = (Graphics.width - @sprites["background"].bitmap.width) / 2
        @sprites["background"].visible = true
        
        total_height = @sprites["header"].bitmap.height + @sprites["background"].bitmap.height
        initial_y = (Graphics.height - total_height) / 2
        @sprites["header"].y = initial_y
        @sprites["background"].y = initial_y + @sprites["header"].bitmap.height
        
        @sprites["arrow_right_h"] = IconSprite.new(0, 0, @viewport)
        @sprites["arrow_right_h"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/arrow_right"))
        @sprites["arrow_right_h"].x = @sprites["header"].x + @sprites["header"].bitmap.width - @sprites["arrow_right_h"].bitmap.width - 8
        @sprites["arrow_right_h"].y = @sprites["header"].y + (@sprites["header"].bitmap.height - @sprites["arrow_right_h"].bitmap.height) / 2
        @sprites["arrow_right_h"].visible = false
        @sprites["arrow_left_h"] = IconSprite.new(0, 0, @viewport)
        @sprites["arrow_left_h"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/arrow_left"))
        @sprites["arrow_left_h"].x = @sprites["header"].x + 8 
        @sprites["arrow_left_h"].y = @sprites["header"].y + (@sprites["header"].bitmap.height - @sprites["arrow_left_h"].bitmap.height) / 2
        @sprites["arrow_left_h"].visible = false
        @sprites["image"] = IconSprite.new(0, 0, @viewport)
        @sprites["image"].visible = false
		@sprites["stars"] = IconSprite.new(0, 0, @viewport)
        @sprites["stars"].visible = false
        @sprites["arrow_right"] = IconSprite.new(0, 0, @viewport)
        @sprites["arrow_right"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/arrow_right"))
        @sprites["arrow_right"].x = Graphics.width / 2 + 48
        @sprites["arrow_right"].y = @sprites["background"].y + @sprites["background"].bitmap.height - @sprites["arrow_right"].bitmap.height - 4
        @sprites["arrow_right"].visible = false
        @sprites["arrow_left"] = IconSprite.new(0, 0, @viewport)
        @sprites["arrow_left"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/arrow_left"))
        @sprites["arrow_left"].x = Graphics.width / 2 - 48 - @sprites["arrow_left"].bitmap.width
        @sprites["arrow_left"].y = @sprites["background"].y + @sprites["background"].bitmap.height - @sprites["arrow_left"].bitmap.height - 4
        @sprites["arrow_left"].visible = false
      
        @sprites["overlay_h"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
        @sprites["overlay_h"].visible = true
        @sprites["overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
        @sprites["overlay"].visible = true
        pbSEPlay(Settings::TIP_CARDS_SHOW_SE)
        pbDrawGroup
    end
    
    def pbScene
        loop do
            Graphics.update
            Input.update
            pbUpdate
            oldindex = @index
            oldsection = @section
            quit = false
            if Input.trigger?(Input::USE)
                @index += 1 if @index < @pages - 1
            elsif Input.trigger?(Input::BACK)
                pbSEPlay(Settings::TIP_CARDS_DISMISS_SE)
                break
            elsif Input.trigger?(Input::LEFT)
                if @index > 0
                    @index -= 1 
                elsif @continuous && @index <= 0 && @section > 0
                    @section -= 1
                    @last_index = true
                end
            elsif Input.trigger?(Input::RIGHT)
                if @index < @pages - 1
                    @index += 1 
                elsif @continuous && @index >= @pages - 1 && @section < @sections - 1
                    @section += 1
                end
            elsif Input.trigger?(Input::JUMPUP)
                @section -= 1 if @section > 0
            elsif Input.trigger?(Input::JUMPDOWN)
                @section += 1 if @section < @sections - 1
            elsif Input.trigger?(Input::SPECIAL) && Settings::TIP_CARDS_GROUP_LIST && @sections > 1
                list = []
                @groups.each { |group| list.push(Settings::TIP_CARDS_GROUPS[group][:Title]) }
                val = pbShowCommands(nil, list, -1, @section)
                @section = val unless val < 0
            end
            if oldsection != @section
                @index = 0 unless @last_index
                pbDrawGroup
                if Settings::TIP_CARDS_SWITCH_SE
                    pbSEPlay(Settings::TIP_CARDS_SWITCH_SE)
                else
                    pbPlayCursorSE
                end
            elsif oldindex != @index
                pbDrawTip
                if Settings::TIP_CARDS_SWITCH_SE
                    pbSEPlay(Settings::TIP_CARDS_SWITCH_SE)
                else
                    pbPlayCursorSE
                end
            end
            last_index = nil if last_index
        end
    end
    
    def pbEndScene
        pbUpdate
        Graphics.update
        Input.update
        pbDisposeSpriteHash(@sprites)
        @viewport.dispose
    end
  
    def pbUpdate
        pbUpdateSpriteHash(@sprites)
    end

    def pbDrawGroup
        overlay = @sprites["overlay_h"].bitmap
        overlay.clear
        @sprites["arrow_right_h"].visible = false
        @sprites["arrow_left_h"].visible = false
        pbSetSystemFont(overlay)
        base = Settings::TIP_CARDS_TEXT_MAIN_COLOR
        shadow = Settings::TIP_CARDS_TEXT_SHADOW_COLOR
        group = Settings::TIP_CARDS_GROUPS[@groups[@section]]
        title = "<ac>" + group[:Title] + "</ac>"
        # drawFormattedTextEx(bitmap, x, y, width, text, baseColor = nil, shadowColor = nil, lineheight = 32)
        drawFormattedTextEx(overlay, @sprites["header"].x, @sprites["header"].y + 18, @sprites["header"].width, 
            title, base, shadow)
        if @sections > 1
            @sprites["arrow_left_h"].visible = (@section > 0)
            @sprites["arrow_right_h"].visible = (@section < @sections - 1)
        end
        @tips = []
        if @revisit
            group[:Tips].each do |tip|
                next if !Settings::TIP_CARDS_CONFIGURATION[tip] || Settings::TIP_CARDS_CONFIGURATION[tip][:HideRevisit] || 
                    !pbSeenTipCard?(tip)
                @tips.push(tip)
            end
        else
            @tips = group[:Tips]
        end
        @pages = @tips.length
        pbDrawTip
    end

    def pbDrawTip
        overlay = @sprites["overlay"].bitmap
        overlay.clear
        @sprites["image"].visible = false
		@sprites["stars"].visible = false
        @sprites["arrow_right"].visible = false
        @sprites["arrow_left"].visible = false
        pbSetSystemFont(overlay)
        base = Settings::TIP_CARDS_TEXT_MAIN_COLOR
        shadow = Settings::TIP_CARDS_TEXT_SHADOW_COLOR
        if @last_index
            @index = @pages - 1
            @last_index = nil
        end
        tip = @tips[@index]
        info = Settings::TIP_CARDS_CONFIGURATION[tip] || nil
        if info
            text_y_adj = 64
            text_x_adj = 16
            text_width_adj = 0
            pbSetTipCardSeen(tip)
            if info[:Background]
                @sprites["background"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/#{info[:Background]}"))
            else
                @sprites["background"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/#{Settings::TIP_CARDS_DEFAULT_BG}"))
            end
            if info[:Image]
                @sprites["image"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/Images/#{info[:Image]}"))
                image_pos = info[:ImagePosition] || ((@sprites["image"].width > @sprites["image"].height) ? :Top : :Left)
                case image_pos
                when :Top
                    @sprites["image"].x = (Graphics.width - @sprites["image"].bitmap.width) / 2
                    @sprites["image"].y = @sprites["background"].y + 64
                    text_y_adj += @sprites["image"].height + 16
                when :Bottom
                    @sprites["image"].x = (Graphics.width - @sprites["image"].bitmap.width) / 2
                    @sprites["image"].y = @sprites["background"].y + @sprites["background"].height - @sprites["image"].bitmap.height - 32
                when :Left
                    @sprites["image"].x = @sprites["background"].x + 16
                    @sprites["image"].y = @sprites["background"].y + 64
                    text_x_adj += @sprites["image"].width + 16
                when :Right
                    @sprites["image"].x = @sprites["background"].x + @sprites["background"].width - @sprites["image"].bitmap.width - 16
                    @sprites["image"].y = @sprites["background"].y + 64
                    text_width_adj -= @sprites["image"].width + 16
                end
				@sprites["image"].z = 500
                @sprites["image"].visible = true
            end
			if info[:Stars]
				@sprites["stars"].setBitmap(_INTL("Graphics/Pictures/Tip Cards/Images/#{info[:Stars]}stars"))
				@sprites["stars"].x = @sprites["background"].x + 128
                @sprites["stars"].y = @sprites["background"].y + 128
				@sprites["image"].z = 500
                @sprites["image"].visible = true
			end
				
            title = "<ac>" + info[:Title] + "</ac>"
            # drawFormattedTextEx(bitmap, x, y, width, text, baseColor = nil, shadowColor = nil, lineheight = 32)
            drawFormattedTextEx(overlay, @sprites["background"].x, @sprites["background"].y + 18, @sprites["background"].width, 
                title, base, shadow)
            text_y_adj += info[:YAdjustment] if info[:YAdjustment]
            text = "<ac>" + info[:Text] + "</ac>"
            drawFormattedTextEx(overlay, @sprites["background"].x + text_x_adj, @sprites["background"].y + text_y_adj, 
                @sprites["background"].width - 16 - text_x_adj + text_width_adj, text, base, shadow)
        else
            Console.echo_warn tip.to_s + " is not defined."
            drawFormattedTextEx(overlay, @sprites["background"].x, @sprites["background"].y + 18, @sprites["background"].width, 
                _INTL("<ac>Tip not defined.</ac>"), base, shadow)
        end
        if @pages > 1
            @sprites["arrow_left"].visible = (@index > 0)
            @sprites["arrow_right"].visible = (@index < @pages - 1)
            pbDrawTextPositions(overlay, [[_INTL("{1}/{2}",@index+1, @pages), Graphics.width/2, @sprites["background"].y + @sprites["background"].bitmap.height - 26, 
                2, base, shadow]])
        end
    end
end