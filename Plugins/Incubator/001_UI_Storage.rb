class PokemonStorageScreen
def pbStartScreen(command)
  $game_temp.in_storage = true
  @heldpkmn = nil
  case command
  when 0   # Organise
    @scene.pbStartBox(self, command)
    loop do
      selected = @scene.pbSelectBox(@storage.party)
      if selected.nil?
        if pbHeldPokemon
          pbDisplay(_INTL("You're holding a Pokémon!"))
          next
        end
        next if pbConfirm(_INTL("Continue Box operations?"))
        break
      elsif selected[0] == -3   # Close box
        if pbHeldPokemon
          pbDisplay(_INTL("You're holding a Pokémon!"))
          next
        end
        if pbConfirm(_INTL("Exit from the Box?"))
          pbSEPlay("PC close")
          break
        end
        next
      elsif selected[0] == -4   # Box name
        pbBoxCommands
      else
        pokemon = @storage[selected[0], selected[1]]
        heldpoke = pbHeldPokemon
        next if !pokemon && !heldpoke
        if @scene.quickswap
          if @heldpkmn
            (pokemon) ? pbSwap(selected) : pbPlace(selected)
          else
            pbHold(selected)
          end
        else
          commands = []
          cmdMove     = -1
          cmdSummary  = -1
          cmdWithdraw = -1
          cmdItem     = -1
          cmdMark     = -1
          cmdRelease  = -1
          cmdIncubator = -1 # Add Incubator command
          cmdDebug    = -1

          if heldpoke
            helptext = _INTL("{1} is selected.", heldpoke.name)
            commands[cmdMove = commands.length] = (pokemon) ? _INTL("Shift") : _INTL("Place")
          elsif pokemon
            helptext = _INTL("{1} is selected.", pokemon.name)
            commands[cmdMove = commands.length] = _INTL("Move")
          end
          commands[cmdIncubator = commands.length] = _INTL("Incubator") if $bag.has?(:INCUBATOR) # Add Incubator command if item is in the bag
          commands[cmdSummary = commands.length]  = _INTL("Summary")
          commands[cmdWithdraw = commands.length] = (selected[0] == -1) ? _INTL("Store") : _INTL("Withdraw")
          commands[cmdItem = commands.length]     = _INTL("Item")
          commands[cmdMark = commands.length]     = _INTL("Mark")
          commands[cmdRelease = commands.length]  = _INTL("Release")
          commands[cmdDebug = commands.length]    = _INTL("Debug") if $DEBUG
          commands[commands.length]               = _INTL("Cancel")

          command = pbShowCommands(helptext, commands)
          if cmdMove >= 0 && command == cmdMove   # Move/Shift/Place
            if @heldpkmn
              (pokemon) ? pbSwap(selected) : pbPlace(selected)
            else
              pbHold(selected)
            end
          elsif cmdSummary >= 0 && command == cmdSummary   # Summary
            pbSummary(selected, @heldpkmn)
          elsif cmdWithdraw >= 0 && command == cmdWithdraw   # Store/Withdraw
            (selected[0] == -1) ? pbStore(selected, @heldpkmn) : pbWithdraw(selected, @heldpkmn)
          elsif cmdItem >= 0 && command == cmdItem   # Item
            pbItem(selected, @heldpkmn)
          elsif cmdMark >= 0 && command == cmdMark   # Mark
            pbMark(selected, @heldpkmn)
          elsif cmdRelease >= 0 && command == cmdRelease   # Release
            pbRelease(selected, @heldpkmn)
          elsif cmdIncubator >= 0 && command == cmdIncubator   # Incubator
            pbUseIncubator(selected, @heldpkmn)
          elsif cmdDebug >= 0 && command == cmdDebug   # Debug
            pbPokemonDebug((@heldpkmn) ? @heldpkmn : pokemon, selected, heldpoke)
          end
        end
      end
    end
    @scene.pbCloseBox
  when 1   # Withdraw
    @scene.pbStartBox(self, command)
    loop do
      selected = @scene.pbSelectBox(@storage.party)
      if selected.nil?
        next if pbConfirm(_INTL("Continue Box operations?"))
        break
      else
        case selected[0]
        when -2   # Party Pokémon
          pbDisplay(_INTL("Which one will you take?"))
          next
        when -3   # Close box
          if pbConfirm(_INTL("Exit from the Box?"))
            pbSEPlay("PC close")
            break
          end
          next
        when -4   # Box name
          pbBoxCommands
          next
        end
        pokemon = @storage[selected[0], selected[1]]
        next if !pokemon
        command = pbShowCommands(_INTL("{1} is selected.", pokemon.name),
                                 [_INTL("Withdraw"),
                                  _INTL("Summary"),
                                  _INTL("Mark"),
                                  _INTL("Release"),
                                  _INTL("Cancel")])
        case command
        when 0 then pbWithdraw(selected, nil)
        when 1 then pbSummary(selected, nil)
        when 2 then pbMark(selected, nil)
        when 3 then pbRelease(selected, nil)
        end
      end
    end
    @scene.pbCloseBox
  when 2   # Deposit
    @scene.pbStartBox(self, command)
    loop do
      selected = @scene.pbSelectParty(@storage.party)
      if selected == -3   # Close box
        if pbConfirm(_INTL("Exit from the Box?"))
          pbSEPlay("PC close")
          break
        end
        next
      elsif selected < 0
        next if pbConfirm(_INTL("Continue Box operations?"))
        break
      else
        pokemon = @storage[-1, selected]
        next if !pokemon
        command = pbShowCommands(_INTL("{1} is selected.", pokemon.name),
                                 [_INTL("Store"),
                                  _INTL("Summary"),
                                  _INTL("Mark"),
                                  _INTL("Release"),
                                  _INTL("Cancel")])
          case command
          when 0 then pbStore([-1, selected], nil)
          when 1 then pbSummary([-1, selected], nil)
          when 2 then pbMark([-1, selected], nil)
          when 3 then pbRelease([-1, selected], nil)
          end
        end
      end
      @scene.pbCloseBox
    when 3
      @scene.pbStartBox(self, command)
      @scene.pbCloseBox
    end
    $game_temp.in_storage = false
  end

  def count_empty_slots
    $PokemonGlobal.count_empty_slots($PokemonGlobal.eggs)
  end

  def pbUseIncubator(selected, heldpoke)
    box = selected[0]
    index = selected[1]
    pkmn = (heldpoke) ? heldpoke : @storage[box, index]
    item = GameData::Item.get(:INCUBATOR)
    empty_slots = (count_empty_slots-1)
    if !$PokemonGlobal.eggs.index(nil)
      pbMessage(_INTL("The {1} is currenly full.",item.name)) 
    else
      ret = pbConfirmMessage("Do you want to add the egg to the incubator?")
      if ret == true
        ret = addEgg(pkmn)
        if ret == true
          @scene.pbRelease(selected, heldpoke)
          if heldpoke
            @heldpkmn = nil
          else
            @storage.pbDelete(box, index)
            @scene.pbRefresh
            pbDisplay(_INTL("{1} last slots have been filled", item.name)) if (empty_slots == 0)
            pbDisplay(_INTL("{1} can store up to {2} more Egg", item.name, empty_slots)) if (empty_slots != 0)
            @scene.pbRefresh
          end
          @scene.pbRefresh
          return
        end
      end
    end
  end
end


#===============================================================================
# Bag visuals [Bag Screen With Intercatable Party]
#===============================================================================
if PluginManager.findDirectory("Bag Screen w/int. Party")
  puts "Found folder"
  class PokemonBag_Scene
    alias_method :original_pbRefreshParty, :pbRefreshParty

  def pbRefreshParty
    for i in 0...Settings::MAX_PARTY_SIZE
      @sprites["pokemon#{i}"].dispose
    end
    for i in 0...Settings::MAX_PARTY_SIZE
      if @party[i]
        @sprites["pokemon#{i}"] = PokemonBagPartyPanel.new(@party[i], i, @viewport)
      else
        @sprites["pokemon#{i}"] = PokemonBagPartyBlankPanel.new(@party[i], i, @viewport)
      end
    end
  end
end
end
