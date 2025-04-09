EventHandlers.add(:on_player_step_taken, :graphic_transparency,
  proc {
    atgGetPlayerPosition
  }
)

def atgGetPlayerPosition
  eventSizes = atgGetEventSize
  return if eventSizes.nil?
  eventSizes.each do |id, size|
    $game_system.map_interpreter.pbSetSelfSwitch(id,"A", false) 
    if $game_player.x.between?(size[:xMin], size[:xMax]) && $game_player.y.between?(size[:yMin], size[:yMax])
      unless !size[:ignore].nil? && size[:ignore].any? { |x, y| x == $game_player.x && y == $game_player.y }
        $game_system.map_interpreter.pbSetSelfSwitch(id,"A", true)
      end 
    end 
  end 
end 

def atgGetEventSize
  mapEvents = AGTSetup::GameMaps.find { |key,_| key == $game_map.map_id }
  return if mapEvents.nil?
  eventSizes = {}
  mapEvents[1].each do |event|
    if event.is_a?(Hash)
      ignore = event.values[0]
      event = event.keys[0]
    end 
    eventData = $game_map.events[event]
    next unless !eventData.nil? && eventData.name[/size/]
    eventSizes[event] = { xMin: eventData.x, xMax: (eventData.x + (eventData.width - 1)), yMin: (eventData.y - (eventData.height - 1)), yMax: eventData.y, ignore: ignore }
  end
  return eventSizes
end 