def tomBattleRules
  setBattleRule("midbattleScript", {
    "AfterLastSwitchIn_foe" => {
    "speech"  => [_INTL("Hrpf, you're strong!")]}
  })
end

def tomRankUpRules
  setBattleRule("midbattleScript", {
    "AfterLastSwitchIn_foe" => {
    "speech"  => [_INTL("Heh! Maybe you really can become a Gym Leader actually!")]}
  })
end

def nlBattleRules
  setBattleRule("midbattleScript", {
    "AfterLastSwitchIn_foe" => {
    "speech"  => ["..."]}
  })
end

def nlRankUpRules
  setBattleRule("midbattleScript", {
    "AfterLastSwitchIn_foe" => {
    "speech"  => ["..."]}
  })
end

def kathleenBattleRules
  setBattleRule("midbattleScript", {
    "AfterSwitchIn_VESPIQUEN" => {
    "speech"  => [_INTL("Hehe! But can you defeat the queen?")]}
  })
end

def kathleenRankUpRules
  setBattleRule("midbattleScript", {
    "AfterLastSwitchIn_foe" => {
    "speech"  => [_INTL("Hmpf! I won't give up so easily!")]}
  })
end
  
def cassianBattleRules
  setBattleRule("midbattleScript", {
    "AfterLastSwitchIn_foe" => {
    "speech"  => [_INTL("Heh! Now I understand what Samy sees in you!")]}
  })
end

def cassianRankUpRules
  setBattleRule("midbattleScript", {
    "AfterLastSwitchIn_foe" => {
    "speech"  => [_INTL("Show me you deserve my rank 3!")]}
  })
end

def nikodimBattleRules
  setBattleRule("midbattleScript", {
    "AfterLastSwitchIn_foe" => {
    "speech"  => [_INTL("Damn! That's a good groove!")]}
  })
end

def nikodimRankUpRules
  setBattleRule("midbattleScript", {
    "AfterLastSwitchIn_foe" => {
    "speech"  => [_INTL("Wowow! My rank 4 is really in danger there!")]}
  })
end