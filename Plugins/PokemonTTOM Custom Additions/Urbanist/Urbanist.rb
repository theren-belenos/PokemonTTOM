class PokemonMartAdapter
  def getHearts
    return $bag.quantity(:HEARTSCALE)
  end
end

class Window_PokemonMartUrbanist < Window_PokemonMart
  def entry
    return (self.index >= @stock.length) ? nil : @stock[self.index]
  end
  
  def drawItem(index, count, rect)
    textpos = []
    rect = drawCursor(index, rect)
    ypos = rect.y
    if index == count - 1
      textpos.push([_INTL("CANCEL"), rect.x, ypos + 2, :left, self.baseColor, self.shadowColor])
    else
      itemname = @stock[index][0]
			case @stock[index][4]
			when 0
				status = _INTL("Not built")
				itemname = "??????????"
			when 1
				status = _INTL("Locked")
			when 2
				status = _INTL("1 H.S.")
			when 3
				status = _INTL("Bought")
			else
				status = _INTL("Actual")
			end
			puts "status"
			puts status
      sizeStatus = self.contents.text_size(status).width
      xStatus = rect.x + rect.width - sizeStatus - 2 - 16
      textpos.push([itemname, rect.x, ypos + 2, :left, self.baseColor, self.shadowColor])
      textpos.push([status, xStatus, ypos + 2, :left, self.baseColor, self.shadowColor])
    end
    pbDrawTextPositions(self.contents, textpos)
  end
end

class PokemonMart_Scene
  def pbStartUrbanist(stock, adapter)
    # Scroll right before showing screen
    pbScrollMap(6, 5, 5)
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @stock = stock
    @adapter = adapter
    @sprites = {}
    @sprites["background"] = IconSprite.new(0, 0, @viewport)
    @sprites["background"].setBitmap("Graphics/UI/Mart/bg"+stock[0][4].to_s)
    winAdapter = BuyAdapter.new(adapter)
		
		@sprites["backgroundbigicon"] = Sprite.new(@viewport)
    @sprites["backgroundbigicon"].bitmap = Bitmap.new("Graphics/Pictures/Urbanist/neutralbg")
    @sprites["backgroundbigicon"].x = 2
    @sprites["backgroundbigicon"].y = 2
    @sprites["backgroundbigicon"].opacity = 255
		
	  @sprites["bigicon"] = Sprite.new(@viewport)
    @sprites["bigicon"].bitmap = Bitmap.new("Graphics/Pictures/Urbanist/"+stock[0][1])
    @sprites["bigicon"].x = 0
    @sprites["bigicon"].y = 0
    @sprites["bigicon"].opacity = 255
		
    @sprites["itemwindow"] = Window_PokemonMartUrbanist.new(
      stock, winAdapter, Graphics.width - 316 - 16, 10, 330 + 16, Graphics.height - 124
    )
    @sprites["itemwindow"].viewport = @viewport
    @sprites["itemwindow"].index = 0
    @sprites["itemwindow"].refresh
		
    @sprites["itemtextwindow"] = Window_UnformattedTextPokemon.newWithSize(
      "", 48, Graphics.height - 96 - 16, Graphics.width - 64, 128, @viewport
    )
    pbPrepareWindow(@sprites["itemtextwindow"])
    @sprites["itemtextwindow"].baseColor = Color.new(248, 248, 248)
    @sprites["itemtextwindow"].shadowColor = Color.black
    @sprites["itemtextwindow"].windowskin = nil
		
    @sprites["helpwindow"] = Window_AdvancedTextPokemon.new("")
    pbPrepareWindow(@sprites["helpwindow"])
    @sprites["helpwindow"].visible = false
    @sprites["helpwindow"].viewport = @viewport
    pbBottomLeftLines(@sprites["helpwindow"], 1)
		
    @sprites["qtywindow"] = Window_AdvancedTextPokemon.new("")
    pbPrepareWindow(@sprites["qtywindow"])
    @sprites["qtywindow"].setSkin("Graphics/Windowskins/goldskin")
    @sprites["qtywindow"].viewport = @viewport
    @sprites["qtywindow"].width = 190
    @sprites["qtywindow"].height = 72
    @sprites["qtywindow"].baseColor = Color.new(88, 88, 80)
    @sprites["qtywindow"].shadowColor = Color.new(168, 184, 184)
    @sprites["qtywindow"].text = _INTL("Heart Scales:") + " " + @adapter.getHearts.to_s
    @sprites["qtywindow"].y    = Graphics.height - 100 - @sprites["qtywindow"].height
    pbDeactivateWindows(@sprites)
    @buying = true
    pbRefreshUrbanist
    Graphics.frame_reset
  end
  
  def pbRefreshUrbanist
	puts "coucou1"
    if @subscene
      @subscene.pbRefreshUrbanist
    else
      itemwindow = @sprites["itemwindow"]
			if itemwindow.entry
				@sprites["background"].setBitmap("Graphics/UI/Mart/bg"+itemwindow.entry[4].to_s)
				case itemwindow.entry[4]
				when 0
					@sprites["itemtextwindow"].text = _INTL("Locked ; building not built.")
					@sprites["bigicon"].bitmap = Bitmap.new("Graphics/Pictures/Urbanist/locked")
				when 1
					@sprites["itemtextwindow"].text = _INTL("Locked ; to unlock :") + "\n" + itemwindow.entry[2]
					@sprites["bigicon"].bitmap = Bitmap.new("Graphics/Pictures/Urbanist/locked")
				else
					@sprites["itemtextwindow"].text = itemwindow.entry[3]
					path="Graphics/Pictures/Urbanist/"+itemwindow.entry[1]
					if File.exist?(path+".png")
						@sprites["bigicon"].bitmap = Bitmap.new(path)
					else
						@sprites["bigicon"].bitmap = Bitmap.new("Graphics/Pictures/Urbanist/placeholder")
					end
				end
			else
				@sprites["itemtextwindow"].text = _INTL("Quit shopping.")
			end
      @sprites["qtywindow"].visible = !itemwindow.item.nil?
      @sprites["qtywindow"].text    = _INTL("Heart Scales:") + " " + @adapter.getHearts.to_s
      @sprites["qtywindow"].y       = Graphics.height - 102 - @sprites["qtywindow"].height
      itemwindow.refresh
    end
  end
  
  def pbChooseUrbanist
    itemwindow = @sprites["itemwindow"]
    @sprites["helpwindow"].visible = false
    pbActivateWindow(@sprites, "itemwindow") do
      pbRefreshUrbanist
      loop do
        Graphics.update
        Input.update
        olditem = itemwindow.item
        self.update
        pbRefreshUrbanist if itemwindow.item != olditem
        if Input.trigger?(Input::BACK)
          pbPlayCloseMenuSE
          return nil
        elsif Input.trigger?(Input::USE)
          if itemwindow.index < @stock.length
            pbRefreshUrbanist
            return @stock[itemwindow.index]
          else
            return nil
          end
        end
      end
    end
  end
	
	
end
 
class PokemonMartScreen
  def pbUrbanistScreen
    @scene.pbStartUrbanist(@stock, @adapter)
    item = nil
    loop do
      item = @scene.pbChooseUrbanist
      break if !item
      itemname = item[0]
			state = item[4]
			building = item[5]
			index = item[6]
      price = 1
			case state
			when 0
				pbMessage(_INTL("<b>Urbanist:</b> This is for a building you didn't build yet, thus this variant is unavailable, sorry!"))
        next
			when 1
				pbMessage(_INTL("<b>Urbanist:</b> You can't build this variant yet. Check the requirements!"))
				next
			when 2
				if @adapter.getHearts < price
					pbMessage(_INTL("<b>Urbanist:</b> You don't have any Heart Scale! You can't buy this variant!"))
					next
				end
				next if !pbConfirm(_INTL("<b>Urbanist:</b> So you want to unlock this: {1}?\nIt'll cost you a Heart Scale. All right?", itemname))
				$bag.remove(:HEARTSCALE,1)
				pbSEPlay("Mart buy item")
				pbMessage(_INTL("<b>Urbanist:</b> Here you are! Thank you!"))
				$town.buildings[building] = index
				pbMessage(_INTL("<b>Urbanist:</b> The new variant was automatically selected! Have a nice day!"))
				break
			when 3
				next if !pbConfirm(_INTL("<b>Urbanist:</b> Do you want to chose this variant?"))
				$town.buildings[building] = index
				pbMessage(_INTL("<b>Urbanist:</b> Okay! Have a nice day!"))
				break
			when 0
				pbMessage(_INTL("<b>Urbanist:</b> This is the actual selected variant."))
        next
			end
		end
    @scene.pbEndBuyScene
  end
	
	def pbDisplayUrbanistPaused(msg)
    cw = @sprites["helpwindow"]
    cw.letterbyletter = true
    cw.text = msg
    pbBottomLeftLines(cw, 2)
    cw.visible = true
    yielded = false
    pbPlayDecisionSE
    loop do
      Graphics.update
      Input.update
      wasbusy = cw.busy?
      self.update
      if !cw.busy? && !yielded
        yield if block_given?   #  For playing SE as soon as the message is all shown
        yielded = true
      end
      pbRefreshUrbanist if !cw.busy? && wasbusy
      if Input.trigger?(Input::USE) || Input.trigger?(Input::BACK)
        if cw.resume && !cw.busy?
          @sprites["helpwindow"].visible = false
          break
        end
      end
    end
  end
end

 
def pbUrbanist(type = 0)
  texts = [_INTL("Welcome dear Leader! Here are habitations variants!"), _INTL("Welcome dear Leader! Here are various buildings variants!"), _INTL("Welcome dear Leader! Here are external decorations variants!")]
  pbMessage(texts[type])
  stocks = prepareUrbanistStocks(type)
  scene = PokemonMart_Scene.new
  screen = PokemonMartScreen.new(scene, stocks)
  screen.pbUrbanistScreen
	pbMessage(_INTL("Have a nice day, dear Leader!"))
end

def getUrbanistState(id,building,index,min)
	return 4 if $town.buildings[building] == index
	return 0 if $town.buildings[building] < min
	return $town.urbanist[id] + 2
end

def checkUrbanistUnlock
	puts "checking unlocks..."
	Achievements.fixDexAchievements
	puts $PokemonGlobal.dexachievements
	$town.urbanist[4] = 0 if ($town.urbanist[4] == -1 && $PokemonGlobal.dexachievements["KANTO"]["level"] == 1)
	$town.urbanist[5] = 0 if ($town.urbanist[5] == -1 && $PokemonGlobal.dexachievements["JOHTO"]["level"] == 1)
	$town.urbanist[6] = 0 if ($town.urbanist[6] == -1 && $PokemonGlobal.dexachievements["HOENN"]["level"] == 1)
	$town.urbanist[7] = 0 if ($town.urbanist[7] == -1 && $PokemonGlobal.dexachievements["SINNOH"]["level"] == 1)
	$town.urbanist[8] = 0 if ($town.urbanist[8] == -1 && $PokemonGlobal.dexachievements["UNOVA"]["level"] == 1)
	$town.urbanist[9] = 0 if ($town.urbanist[9] == -1 && $PokemonGlobal.dexachievements["KALOS"]["level"] == 1)
	$town.urbanist[10] = 0 if ($town.urbanist[10] == -1 && $PokemonGlobal.dexachievements["ALOLA"]["level"] == 1)
	$town.urbanist[11] = 0 if ($town.urbanist[11] == -1 && $PokemonGlobal.dexachievements["GALAR"]["level"] == 1)
	$town.urbanist[12] = 0 if ($town.urbanist[12] == -1 && $PokemonGlobal.dexachievements["PALDEA"]["level"] == 1)
	$town.urbanist[16] = 0 if ($town.urbanist[16] == -1 && $PokemonGlobal.dexachievements["JOHTO"]["level"] == 1)
	$town.urbanist[20] = 0 if ($town.urbanist[20] == -1 && $PokemonGlobal.dexachievements["GALAR"]["level"] == 1)
	$town.urbanist[24] = 0 if ($town.urbanist[24] == -1 && $PokemonGlobal.dexachievements["JOHTO"]["level"] == 1)
	$town.urbanist[28] = 0 if ($town.urbanist[28] == -1 && $PokemonGlobal.dexachievements["JOHTO"]["level"] == 1)
	$town.urbanist[32] = 0 if ($town.urbanist[32] == -1 && $PokemonGlobal.dexachievements["GALAR"]["level"] == 1)
	$town.urbanist[36] = 0 if ($town.urbanist[36] == -1 && $PokemonGlobal.dexachievements["JOHTO"]["level"] == 1)
	$town.urbanist[44] = 0 if ($town.urbanist[44] == -1 && $PokemonGlobal.dexachievements["SINNOH"]["level"] == 1)
	$town.urbanist[48] = 0 if ($town.urbanist[48] == -1 && $PokemonGlobal.dexachievements["GLOBAL"]["level"] == 1)
	$town.urbanist[56] = 0 if ($town.urbanist[56] == -1 && $PokemonGlobal.dexachievements["KANTO"]["level"] == 1)
	$town.urbanist[68] = 0 if ($town.urbanist[68] == -1 && $PokemonGlobal.dexachievements["HOENN"]["level"] == 1)
	$town.urbanist[72] = 0 if ($town.urbanist[72] == -1 && $PokemonGlobal.dexachievements["HOENN"]["level"] == 1)
	$town.urbanist[76] = 0 if ($town.urbanist[76] == -1 && $PokemonGlobal.dexachievements["UNOVA"]["level"] == 1)
	$town.urbanist[80] = 0 if ($town.urbanist[80] == -1 && $PokemonGlobal.dexachievements["KALOS"]["level"] == 1)
	$town.urbanist[84] = 0 if ($town.urbanist[84] == -1 && $PokemonGlobal.dexachievements["ALOLA"]["level"] == 1)
	$town.urbanist[88] = 0 if ($town.urbanist[88] == -1 && $PokemonGlobal.dexachievements["PALDEA"]["level"] == 1)
end

# return [nom, nomimage, unlocktext, text, state]
def prepareUrbanistStocks(type)
	case type
	when 0
		return [
			[_INTL("Your house A"), "PJHouseA", "", _INTL("Base color for your house"), getUrbanistState(0,11,2,2),11,2],
			[_INTL("Your house B"), "PJHouseB", "", _INTL("Variant color for your house"), getUrbanistState(1,11,3,2),11,3],
			[_INTL("Your house C"), "PJHouseC", "", _INTL("Variant color for your house"), getUrbanistState(2,11,4,2),11,4],
			[_INTL("Your house D"), "PJHouseD", "", _INTL("Variant color for your house"), getUrbanistState(3,11,5,2),11,5],
			[_INTL("Your house E"), "PJHouseE", _INTL("Obtain the achievement for completing 25% of Kanto's Pokedex"), _INTL("Kanto inspired variant for your house"), getUrbanistState(4,11,6,2),11,6],
			[_INTL("Your house F"), "PJHouseF", _INTL("Obtain the achievement for completing 25% of Johto's Pokedex"), _INTL("Johto inspired variant for your house"), getUrbanistState(5,11,7,2),11,7],
			[_INTL("Your house G"), "PJHouseG", _INTL("Obtain the achievement for completing 25% of Hoenn's Pokedex"), _INTL("Hoenn inspired variant for your house"), getUrbanistState(6,11,8,2),11,8],
			[_INTL("Your house H"), "PJHouseH", _INTL("Obtain the achievement for completing 25% of Sinnoh's Pokedex"), _INTL("Sinnoh inspired variant for your house"), getUrbanistState(7,11,9,2),11,9],
			[_INTL("Your house I"), "PJHouseI", _INTL("Obtain the achievement for completing 25% of Unova's Pokedex"), _INTL("Unova inspired variant for your house"), getUrbanistState(8,11,10,2),11,10],
			[_INTL("Your house J"), "PJHouseJ", _INTL("Obtain the achievement for completing 25% of Kalos' Pokedex"), _INTL("Kalos inspired variant for your house"), getUrbanistState(9,11,11,2),11,11],
			[_INTL("Your house K"), "PJHouseK", _INTL("Obtain the achievement for completing 25% of Alola's Pokedex"), _INTL("Alola inspired variant for your house"), getUrbanistState(10,11,12,2),11,12],
			[_INTL("Your house L"), "PJHouseL", _INTL("Obtain the achievement for completing 25% of Galar's Pokedex"), _INTL("Galar inspired variant for your house"), getUrbanistState(11,11,13,2),11,13],
			[_INTL("Your house M"), "PJHouseM", _INTL("Obtain the achievement for completing 25% of Paldea's Pokedex"), _INTL("Paldea inspired variant for your house"), getUrbanistState(12,11,14,2),11,14],
			[_INTL("Melly's house A"), "MellyA", "", _INTL("Base color for Melly's house"), getUrbanistState(13,21,2,2),21,2],
			[_INTL("Melly's house B"), "MellyB", "", _INTL("Variant color for Melly's house"), getUrbanistState(14,21,3,2),21,3],
			[_INTL("Melly's house C"), "MellyC", "", _INTL("Variant color for Melly's house"), getUrbanistState(15,21,4,2),21,4],
			[_INTL("Melly's house D"), "MellyD", _INTL("Obtain the achievement for completing 25% of Johto's Pokedex"), _INTL("Variant color for Melly's house"), getUrbanistState(16,21,5,2),21,5],
			[_INTL("1st Block A"), "Block1A", "", _INTL("Base color for the 1st block"), getUrbanistState(17,35,3,3),35,3],
			[_INTL("1st Block B"), "Block1B", "", _INTL("Variant color for the 1st block"), getUrbanistState(18,35,4,3),35,4],
			[_INTL("1st Block C"), "Block1C", "", _INTL("Variant color for the 1st block"), getUrbanistState(19,35,5,3),35,5],
			[_INTL("1st Block D"), "Block1D", _INTL("Obtain the achievement for completing 25% of Galar's Pokedex"), _INTL("Base color for the 1st block"), getUrbanistState(20,35,6,3),35,6],
			[_INTL("3rd House A"), "House3A", "", _INTL("Base color for the 3rd house"), getUrbanistState(21,47,2,2),47,2],
			[_INTL("3rd House B"), "House3B", "", _INTL("Variant color for the 3rd house"), getUrbanistState(22,47,3,2),47,3],
			[_INTL("3rd House C"), "House3C", "", _INTL("Variant color for the 3rd house"), getUrbanistState(23,47,4,2),47,4],
			[_INTL("3rd House D"), "House3D", _INTL("Obtain the achievement for completing 25% of Johto's Pokedex"), _INTL("Variant color for the 3rd house"), getUrbanistState(24,47,5,2),47,5],
			[_INTL("4th House A"), "House4A", "", _INTL("Base color for the 4th house"), getUrbanistState(25,79,2,2),79,2],
			[_INTL("4th House B"), "House4B", "", _INTL("Variant color for the 4th house"), getUrbanistState(26,79,3,2),79,3],
			[_INTL("4th House C"), "House4C", "", _INTL("Variant color for the 4th house"), getUrbanistState(27,79,4,2),79,4],
			[_INTL("4th House D"), "House4D", _INTL("Obtain the achievement for completing 25% of Johto's Pokedex"), _INTL("Variant color for the 4th house"), getUrbanistState(28,79,5,2),79,5],
			[_INTL("2nd Block A"), "Block2A", "", _INTL("Base color for the 2nd Block"), getUrbanistState(29,63,3,3),63,3],
			[_INTL("2nd Block B"), "Block2B", "", _INTL("Variant color for the 2nd Block"), getUrbanistState(30,63,4,3),63,4],
			[_INTL("2nd Block C"), "Block2C", "", _INTL("Variant color for the 2nd Block"), getUrbanistState(31,63,5,3),63,5],
			[_INTL("2nd Block D"), "Block2D", _INTL("Obtain the achievement for completing 25% of Galar's Pokedex"), _INTL("Variant color for the 2nd Block"), getUrbanistState(32,63,6,3),63,6],
			[_INTL("5th House A"), "House5A", "", _INTL("Base color for the 5th house"), getUrbanistState(33,93,2,2),93,2],
			[_INTL("5th House B"), "House5B", "", _INTL("Variant color for the 5th house"), getUrbanistState(34,93,3,2),93,3],
			[_INTL("5th House C"), "House5C", "", _INTL("Variant color for the 5th house"), getUrbanistState(35,93,4,2),93,4],
			[_INTL("5th House D"), "House5D", _INTL("Obtain the achievement for completing 25% of Johto's Pokedex"), _INTL("Variant color for the 5th house"), getUrbanistState(36,93,5,2),93,5]	
			]
				
	when 1
		return [
			[_INTL("Lab A"), "LabA", "", _INTL("Base color for Maple's Lab"), getUrbanistState(37,0,2,2),0,2],
			[_INTL("Lab B"), "LabB", "", _INTL("Variant color for Maple's Lab"), getUrbanistState(38,0,3,2),0,3],
			[_INTL("Lab C"), "LabC", "", _INTL("Variant color for Maple's Lab"), getUrbanistState(39,0,4,2),0,4],
			[_INTL("Lab D"), "LabD", "", _INTL("Variant color for Maple's Lab"), getUrbanistState(40,0,5,2),0,5],
			[_INTL("PokéCenter A"), "PCA", "", _INTL("Base color for the PokéCenter"), getUrbanistState(41,4,2,2),4,2],
			[_INTL("PokéCenter B"), "PCB", "", _INTL("Variant color for the PokéCenter"), getUrbanistState(42,4,3,2),4,3],
			[_INTL("PokéCenter C"), "PCC", "", _INTL("Variant color for the PokéCenter"), getUrbanistState(43,4,4,2),4,4],
			[_INTL("PokéCenter D"), "PCD", _INTL("Obtain the achievement for completing 25% of Sinnoh's Pokedex"), _INTL("Variant color for the PokéCenter"), getUrbanistState(44,4,5,2),4,5],
			[_INTL("Dept. Store A"), "StoreA", "", _INTL("Base color for the Dept. Store"), getUrbanistState(45,3,3,3),3,3],
			[_INTL("Dept. Store B"), "StoreB", "", _INTL("Variant color for the Dept. Store"), getUrbanistState(46,3,4,3),3,4],
			[_INTL("Dept. Store C"), "StoreC", "", _INTL("Variant color for the Dept. Store"), getUrbanistState(47,3,5,3),3,5],
			[_INTL("Dept. Store D"), "StoreD", _INTL("Obtain the achievement for completing 25% of the National Pokedex"), _INTL("Variant color for the Dept. Store"), getUrbanistState(48,3,6,3),3,6],
			[_INTL("Academy A"), "AcademyA", "", _INTL("Base color for the Academy"), getUrbanistState(49,25,4,4),25,4],
			[_INTL("Academy B"), "AcademyB", "", _INTL("Variant color for the Academy"), getUrbanistState(50,25,5,4),25,5],
			[_INTL("Academy C"), "AcademyC", "", _INTL("Variant color for the Academy"), getUrbanistState(51,25,6,4),25,6],
			[_INTL("Academy D"), "AcademyD", "", _INTL("Variant color for the Academy"), getUrbanistState(52,25,7,4),25,7],
			[_INTL("Safari A"), "SafariA", "", _INTL("Base color for the Safari"), getUrbanistState(53,37,4,4),37,4],
			[_INTL("Safari B"), "SafariB", "", _INTL("Variant color for the Safari"), getUrbanistState(54,37,5,4),37,5],
			[_INTL("Safari C"), "SafariC", "", _INTL("Variant color for the Safari"), getUrbanistState(55,37,6,4),37,6],
			[_INTL("Safari D"), "SafariD", _INTL("Obtain the achievement for completing 25% of Kanto's Pokedex"), _INTL("Variant color for the Safari"), getUrbanistState(56,37,7,4),37,7],
			[_INTL("Clothes' Shop A"), "ClothesA", "", _INTL("Base color for the Clothes' Shop"), getUrbanistState(57,51,2,2),51,2],
			[_INTL("Clothes' Shop B"), "ClothesB", "", _INTL("Variant color for the Clothes' Shop"), getUrbanistState(58,51,3,2),51,3],
			[_INTL("Clothes' Shop C"), "ClothesC", "", _INTL("Variant color for the Clothes' Shop"), getUrbanistState(59,51,4,2),51,4],
			[_INTL("Clothes' Shop D"), "ClothesD", "", _INTL("Variant color for the Clothes' Shop"), getUrbanistState(60,51,5,2),51,5],
			[_INTL("Casino A"), "CasinoA", "", _INTL("Base color for the Casino"), getUrbanistState(61,52,3,3),52,3],
			[_INTL("Casino B"), "CasinoB", "", _INTL("Variant color for the Casino"), getUrbanistState(62,52,4,3),52,4],
			[_INTL("Casino C"), "CasinoC", "", _INTL("Variant color for the Casino"), getUrbanistState(63,52,5,3),52,5],
			[_INTL("Casino D"), "CasinoD", "", _INTL("Variant color for the Casino"), getUrbanistState(64,52,6,3),52,6],
			[_INTL("Hangar A"), "HangarA", "", _INTL("Base color for the Dock's Hangar"), getUrbanistState(65,53,4,4),53,4],
			[_INTL("Hangar B"), "HangarB", "", _INTL("Variant color for the Dock's Hangar"), getUrbanistState(66,53,5,4),53,5],
			[_INTL("Hangar C"), "HangarC", "", _INTL("Variant color for the Dock's Hangar"), getUrbanistState(67,53,6,4),53,6],
			[_INTL("Hangar D"), "HangarD", _INTL("Obtain the achievement for completing 25% of Hoenn's Pokedex"), _INTL("Variant color for the Dock's Hangar"), getUrbanistState(68,53,7,4),53,7],
			[_INTL("Lighthouse A"), "LighthouseA", "", _INTL("Variant color for the Dock's Hangar"), getUrbanistState(69,96,9,9),96,9],
			[_INTL("Lighthouse B"), "LighthouseB", "", _INTL("Variant color for the Dock's Hangar"), getUrbanistState(70,96,10,9),96,10],
			[_INTL("Lighthouse C"), "LighthouseC", "", _INTL("Variant color for the Dock's Hangar"), getUrbanistState(71,96,11,9),96,11],
			[_INTL("Lighthouse D"), "LighthouseD", _INTL("Obtain the achievement for completing 25% of Hoenn's Pokedex"), _INTL("Variant color for the Dock's Hangar"), getUrbanistState(72,96,12,9),96,12],
			[_INTL("Battle Café A"), "CafeA", "", _INTL("Base color for the Battle Café"), getUrbanistState(73,69,4,4),69,4],
			[_INTL("Battle Café B"), "CafeB", "", _INTL("Variant color for the Battle Café"), getUrbanistState(74,69,5,4),69,5],
			[_INTL("Battle Café C"), "CafeC", "", _INTL("Variant color for the Battle Café"), getUrbanistState(75,69,6,4),69,6],
			[_INTL("Battle Café D"), "CafeD", _INTL("Obtain the achievement for completing 25% of Unova's Pokedex"), _INTL("Variant color for the Battle Café"), getUrbanistState(76,69,7,4),69,7],
			[_INTL("Grand Hotel A"), "HotelA", "", _INTL("Base color for the Grand Hotel"), getUrbanistState(77,82,16,16),82,16],
			[_INTL("Grand Hotel B"), "HotelB", "", _INTL("Variant color for the Grand Hotel"), getUrbanistState(78,82,17,16),82,17],
			[_INTL("Grand Hotel C"), "HotelC", "", _INTL("Variant color for the Grand Hotel"), getUrbanistState(79,82,18,16),82,18],
			[_INTL("Grand Hotel D"), "HotelD", _INTL("Obtain the achievement for completing 25% of Kalos' Pokedex"), _INTL("Variant color for the Grand Hotel"), getUrbanistState(80,82,19,16),82,19],
			[_INTL("Battle Resto A"), "RestoA", "", _INTL("Base color for the Battle Resto"), getUrbanistState(81,85,6,6),85,6],
			[_INTL("Battle Resto B"), "RestoB", "", _INTL("Variant color for the Battle Resto"), getUrbanistState(82,85,7,6),85,7],
			[_INTL("Battle Resto C"), "RestoC", "", _INTL("Variant color for the Battle Resto"), getUrbanistState(83,85,8,6),85,8],
			[_INTL("Battle Resto D"), "RestoD", _INTL("Obtain the achievement for completing 25% of Alola's Pokedex"), _INTL("Variant color for the Battle Resto"), getUrbanistState(84,85,9,6),85,9],
			[_INTL("Radio Tower A"), "RadioA", "", _INTL("Base color for the Radio Tower"), getUrbanistState(85,97,17,17),97,17],
			[_INTL("Radio Tower B"), "RadioB", "", _INTL("Variant color for the Radio Tower"), getUrbanistState(86,97,18,17),97,18],
			[_INTL("Radio Tower C"), "RadioC", "", _INTL("Variant color for the Radio Tower"), getUrbanistState(87,97,19,17),97,19],
			[_INTL("Radio Tower D"), "RadioD", _INTL("Obtain the achievement for completing 25% of Paldea's Pokedex"), _INTL("Variant color for the Radio Tower"), getUrbanistState(88,97,20,17),97,20]
			]
				
	else
		return [
			[_INTL("Lamp Posts A"), "LampA", "", _INTL("Base lamp posts"), getUrbanistState(89,1,2,2),1,2],
			[_INTL("Lamp Posts B"), "LampB", "", _INTL("Variant lamp posts"), getUrbanistState(90,1,3,2),1,3],
			[_INTL("Lamp Posts C"), "LampC", "", _INTL("Variant lamp posts"), getUrbanistState(91,1,4,2),1,4],
			[_INTL("Lamp Posts D"), "LampD", "", _INTL("Variant lamp posts"), getUrbanistState(92,1,5,2),1,5],
			[_INTL("Flowers A"), "FlowersA", "", _INTL("Base flowers"), getUrbanistState(93,5,2,2),5,2],
			[_INTL("Flowers B"), "FlowersB", "", _INTL("Variant flowers"), getUrbanistState(94,5,3,2),5,3],
			[_INTL("Flowers C"), "FlowersC", "", _INTL("Variant flowers"), getUrbanistState(95,5,4,2),5,4],
			[_INTL("Flowers D"), "FlowersD", "", _INTL("Variant flowers"), getUrbanistState(96,5,5,2),5,5],
			[_INTL("Docks' paving A"), "DockpavingA", "", _INTL("Base docks' paving"), getUrbanistState(97,2,2,2),2,2],
			[_INTL("Docks' paving B"), "DockpavingB", "", _INTL("Variant docks' paving"), getUrbanistState(98,2,3,2),2,3],
			[_INTL("Docks' paving C"), "DockpavingC", "", _INTL("Variant docks' paving"), getUrbanistState(99,2,4,2),2,4],
			[_INTL("Docks' paving D"), "DockpavingD", "", _INTL("Variant docks' paving"), getUrbanistState(100,2,5,2),2,5],
			[_INTL("Beauty stands A"), "BeautyA", "", _INTL("Base stands for the Beauty market"), getUrbanistState(101,27,2,2),27,2],
			[_INTL("Beauty stands B"), "BeautyB", "", _INTL("Variant stands for the Beauty market"), getUrbanistState(102,27,2,3),27,3],
			[_INTL("Beauty stands C"), "BeautyC", "", _INTL("Variant stands for the Beauty market"), getUrbanistState(103,27,2,4),27,4],
			[_INTL("Beauty stands D"), "BeautyD", "", _INTL("Variant stands for the Beauty market"), getUrbanistState(104,27,2,5),27,5],
			[_INTL("Roads paving A"), "RoadsA", "", _INTL("Base roads paving"), getUrbanistState(105,49,6,6),49,6],
			[_INTL("Roads paving B"), "RoadsB", "", _INTL("Variant roads paving"), getUrbanistState(106,49,7,6),49,7],
			[_INTL("Roads paving C"), "RoadsC", "", _INTL("Variant roads paving"), getUrbanistState(107,49,8,6),49,8],
			[_INTL("Roads paving D"), "RoadsD", "", _INTL("Variant roads paving"), getUrbanistState(108,49,9,6),49,9],
			[_INTL("Café's terrace A"), "CafeterraceA", "", _INTL("Base café's terrace"), getUrbanistState(109,54,3,3),54,3],
			[_INTL("Café's terrace B"), "CafeterraceB", "", _INTL("Variant café's terrace"), getUrbanistState(110,54,4,3),54,4],
			[_INTL("Café's terrace C"), "CafeterraceC", "", _INTL("Variant café's terrace"), getUrbanistState(111,54,5,3),54,5],
			[_INTL("Café's terrace D"), "CafeterraceD", "", _INTL("Variant café's terrace"), getUrbanistState(112,54,6,3),54,6],
			[_INTL("Resto's terrace A"), "RestoterraceA", "", _INTL("Base resto's terrace"), getUrbanistState(113,70,3,3),70,3],
			[_INTL("Resto's terrace B"), "RestoterraceB", "", _INTL("Variant resto's terrace"), getUrbanistState(114,70,4,3),70,4],
			[_INTL("Resto's terrace C"), "RestoterraceC", "", _INTL("Variant resto's terrace"), getUrbanistState(115,70,5,3),70,5],
			[_INTL("Resto's terrace D"), "RestoterraceD", "", _INTL("Variant resto's terrace"), getUrbanistState(116,70,6,3),70,6],
			[_INTL("Sidewalk paving A"), "SidewalkA", "", _INTL("Base sidewalk paving"), getUrbanistState(117,95,11,11),95,11],
			[_INTL("Sidewalk paving B"), "SidewalkB", "", _INTL("Variant sidewalk paving"), getUrbanistState(118,95,12,11),95,12],
			[_INTL("Sidewalk paving C"), "SidewalkC", "", _INTL("Variant sidewalk paving"), getUrbanistState(119,95,13,11),95,13],
			[_INTL("Sidewalk paving D"), "SidewalkD", "", _INTL("Variant sidewalk paving"), getUrbanistState(120,95,14,11),95,14]
			]
	end
end
	
def initUrbanist
	tab = [0]*150
	
	# all base variants (do not need to buy)
	tab[0] = 1
	tab[13] = 1
	tab[17] = 1
	tab[21] = 1
	tab[25] = 1
	tab[29] = 1
	tab[33] = 1
	tab[37] = 1
	tab[41] = 1
	tab[45] = 1
	tab[49] = 1
	tab[53] = 1
	tab[57] = 1
	tab[61] = 1
	tab[65] = 1
	tab[69] = 1
	tab[73] = 1
	tab[77] = 1
	tab[81] = 1
	tab[85] = 1
	tab[89] = 1
	tab[93] = 1
	tab[97] = 1
	tab[101] = 1
	tab[105] = 1
	tab[109] = 1
	tab[113] = 1
	tab[117] = 1
	
	# all locked variants at the start
	for i in (4..12)
		tab[i] = -1 
	end
	tab[16] = -1
	tab[20] = -1
	tab[24] = -1
	tab[28] = -1
	tab[32] = -1
	tab[36] = -1
	tab[44] = -1
	tab[48] = -1
	tab[56] = -1
	tab[68] = -1
	tab[72] = -1
	tab[76] = -1
	tab[80] = -1
	tab[84] = -1
	tab[88] = -1
	$town.urbanist = tab
end