if ARMSettings::ProgressCounter && ARMSettings::ProgressCountItems
  #===============================================================================
  # Picking up an item found on the ground
  #===============================================================================
  def pbItemBall(item, quantity = 1)
    item = GameData::Item.get(item)
    return false if !item || quantity < 1
    itemInfo = getItemInfo(item, quantity, false)
    result = getItemMessage(itemInfo)
    if $item_log && result
      ItemLog.showItemScene(item) if $item_log.register(item) != nil
    end
    return result
  end

  #===============================================================================
  # Being given an item
  #===============================================================================
  #def pbReceiveItem(item, quantity = 1)
   # item = GameData::Item.get(item)
    #return false if !item || quantity < 1
    #itemInfo = getItemInfo(item, quantity, true)
    #result = getItemMessage(itemInfo)
    #if $item_log && result
     # ItemLog.showItemScene(item) if $item_log.register(item) != nil
    #end
    #return result
  #end

  #===============================================================================
  # Item handler
  #===============================================================================
  def getItemInfo(item, quantity, verb)
    if Essentials::VERSION.include?("21")
      itemname = (quantity > 1) ? item.portion_name_plural : item.portion_name
    elsif Essentials::VERSION.include?("20")
      itemname = (quantity > 1) ? item.name_plural : item.name
    end
    pocket = item.pocket
    move = item.move
    meName = (item.is_key_item?) ? "Key item get" : "Item get"
    verb = verb ? _INTL("obtained") : _INTL("found")
    bag = $bag.add(item, quantity) ? true : false
    return { item: item, itemname: itemname, quantity: quantity, pocket: pocket, move: move, meName: meName, verb: verb, bag: bag }
  end

  #===============================================================================
  # Item Message handler
  #===============================================================================
  def getItemMessage(itemInfo)
    sound = itemInfo[:bag] ? "\\me[#{itemInfo[:meName]}]" : ""
    wait = itemInfo[:bag] ? "\\wtnp[40]" : ""
    if itemInfo[:item] == :DNASPLICERS && itemInfo[:bag]
      pbMessage("#{sound}" + _INTL("You {1} \\c[1]{2}\\c[0]!", itemInfo[:verb], itemInfo[:itemname]) + "#{wait}")
    elsif itemInfo[:item].is_machine?   # TM or HM
      sound = itemInfo[:bag] ? "\\me[Machine get]" : ""
	  target = _INTL("You")
      wait = itemInfo[:bag] ? "\\wtnp[70]" : ""
	  verb = _INTL(itemInfo[:verb])
	  quantity = _INTL(itemInfo[:quantity])
	  itemname = _INTL(itemInfo[:itemname])
	  movename = _INTL(GameData::Move.get(itemInfo[:move]).name)
	  pbMessage("#{sound}#{target} #{verb} #{quantity} \\c[1]#{itemname} #{movename} \\c[0]!#{wait}")
    elsif itemInfo[:quantity] > 1
	  target = _INTL("You")
      wait = itemInfo[:bag] ? "\\wtnp[40]" : ""
	  verb = _INTL(itemInfo[:verb])
	  quantity = itemInfo[:quantity]
	  itemname = _INTL(itemInfo[:itemname])
	  pbMessage("#{sound}#{target} #{verb} #{quantity} \\c[1]#{itemname} \\c[0]!#{wait}")
    else
	  target = _INTL("You")
      wait = itemInfo[:bag] ? "\\wtnp[40]" : ""
	  verb = _INTL(itemInfo[:verb])
	  quantity = _INTL(itemInfo[:quantity])
	  itemname = _INTL(itemInfo[:itemname])
	  pbMessage("#{sound}#{target} #{verb} 1 \\c[1]#{itemname} \\c[0]!#{wait}")
    end
    if itemInfo[:bag]
	  begintext = _INTL("You put the {1} in", itemInfo[:itemname])
	  middletext = _INTL("your Bag's")
	  endtext = _INTL("pocket")
	  iconidentifier = "bagPocket" + itemInfo[:pocket].to_s
	  nompoche = PokemonBag.pocket_names[itemInfo[:pocket] - 1]
      pbMessage("#{begintext}\\n#{middletext} <icon=#{iconidentifier}>\\c[1]#{nompoche}\\c[0] #{endtext}.")
      countItem(itemInfo)
      return true
    else
      pbMessage(_INTL("But your Bag is full..."))
      return false
    end
  end

  def countItem(itemInfo)
    mapID = $game_map.map_id
    map = load_data(sprintf("Data/Map%03d.rxdata", mapID))
    eventID = pbMapInterpreter.get_self.id
    return if map.nil? || !map.events[eventID].name[/item/i]
    map = GameData::MapMetadata.try_get(mapID)
    district = getDistrictName(map)
    $ArckyGlobal.itemTracker[district] ||= { :total => 0 }
    $ArckyGlobal.itemTracker[district][:maps] ||= {}
    $ArckyGlobal.itemTracker[district][:maps][mapID] ||= { :found => 0}
    $ArckyGlobal.itemTracker[district][:maps][mapID][eventID] ||= { :found => 0, :items => [] }
    unless $ArckyGlobal.itemTracker[district][:maps][mapID][eventID][:items].include?(itemInfo[:item])
      $ArckyGlobal.itemTracker[district][:maps][mapID][eventID][:items] += [itemInfo[:item]]
      $ArckyGlobal.itemTracker[district][:maps][mapID][eventID][:found] += itemInfo[:quantity]
      $ArckyGlobal.itemTracker[district][:total] += itemInfo[:quantity]
      $ArckyGlobal.itemTracker[district][:maps][mapID][:found] += itemInfo[:quantity]
    end
  end
end
