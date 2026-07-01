#EventHandlers.add(:on_frame_update, :achievement_message_queue,
#proc {
#  if !$achievementmessagequeue.nil?
#    $achievementmessagequeue.each_with_index {|m,i|
#    $achievementmessagequeue.delete_at(i)
#    Kernel.pbMessage(m)
#    }
#  end
#})

class Battle
  
  #use item on pokemon in battle
  def pbUseItemOnPokemon(item, idxParty, userBattler)
    trainerName = pbGetOwnerName(userBattler.index)
    pbUseItemMessage(item, trainerName)
    pkmn = pbParty(userBattler.index)[idxParty]
    battler = pbFindBattler(idxParty, userBattler.index)
    ch = @choices[userBattler.index]
    if ItemHandlers.triggerCanUseInBattle(item, pkmn, battler, ch[3], true, self, @scene, false)
      ItemHandlers.triggerBattleUseOnPokemon(item, pkmn, battler, ch, @scene)
      ch[1] = nil   # Delete item from choice
      Achievements.incrementProgress("ITEMS_USED",1)
      Achievements.incrementProgress("ITEMS_USED_IN_BATTLE",1)
      return
    end
    pbDisplay(_INTL("But it had no effect!"))
    # Return unused item to Bag
    pbReturnUnusedItemToBag(item, userBattler.index)
  end
  
  #use item on pokemon outside of battle
alias achieve_pbUseItemOnPokemon pbUseItemOnPokemon
def pbUseItemOnPokemon(*args)
  ret=achieve_pbUseItemOnPokemon(*args)
  if ret
    Achievements.incrementProgress("ITEMS_USED",1)
  end
end
  
def pbUseItemOnBattler(item, idxParty, userBattler)
  trainerName = pbGetOwnerName(userBattler.index)
  pbUseItemMessage(item, trainerName)
  battler = pbFindBattler(idxParty, userBattler.index)
  ch = @choices[userBattler.index]
  if battler
    if ItemHandlers.triggerCanUseInBattle(item, battler.pokemon, battler, ch[3], true, self, @scene, false)
      ItemHandlers.triggerBattleUseOnBattler(item, battler, @scene)
      ch[1] = nil   # Delete item from choice
      battler.pbItemOnStatDropped
      Achievements.incrementProgress("ITEMS_USED",1)
      Achievements.incrementProgress("ITEMS_USED_IN_BATTLE",1)
      return
    else
      pbDisplay(_INTL("But it had no effect!"))
    end
  else
    pbDisplay(_INTL("But it's not where this item can be used!"))
  end
  # Return unused item to Bag
  pbReturnUnusedItemToBag(item, userBattler.index)
end
end



class PokemonMartScreen
  def pbSellScreen
    item = @scene.pbStartSellScene(@adapter.getInventory, @adapter)
    loop do
      item = @scene.pbChooseSellItem
      break if !item
      itemname       = @adapter.getDisplayName(item)
      itemnameplural = @adapter.getDisplayNamePlural(item)
      if !@adapter.canSell?(item)
        pbDisplayPaused(_INTL("Oh, no. I can't buy {1}.", itemnameplural))
        next
      end
      price = @adapter.getPrice(item, true)
      qty = @adapter.getQuantity(item)
      next if qty == 0
      @scene.pbShowMoney
      if qty > 1
        qty = @scene.pbChooseNumber(
          _INTL("How many {1} would you like to sell?", itemnameplural), item, qty
        )
      end
      if qty == 0
        @scene.pbHideMoney
        next
      end
      price *= qty
      if pbConfirm(_INTL("I can pay ${1}.\nWould that be OK?", price.to_s_formatted))
        old_money = @adapter.getMoney
        @adapter.setMoney(@adapter.getMoney + price)
        $stats.money_earned_at_marts += @adapter.getMoney - old_money
        qty.times { @adapter.removeItem(item) }
        Achievements.incrementProgress("ITEMS_SOLD",qty)
        
        sold_item_name = (qty > 1) ? itemnameplural : itemname
        pbDisplayPaused(_INTL("You turned over the {1} and got ${2}.",
                              sold_item_name, price.to_s_formatted)) { pbSEPlay("Mart buy item") }
        @scene.pbRefresh
      end
      @scene.pbHideMoney
    end
    @scene.pbEndSellScene
  end
end


alias achieve_pbItemBall pbItemBall
def pbItemBall(*args)
  ret=achieve_pbItemBall(*args)
  Achievements.incrementProgress("ITEM_BALL_ITEMS",1) if ret
  return ret
end