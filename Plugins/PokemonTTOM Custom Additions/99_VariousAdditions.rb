#===============================================================================
# Custom additions
#===============================================================================
# Social checks
def pbFullShinyParty
  team = $player.party
  return false if team.length < 6
  6.times do |index|
    return false if not team[index].shiny?
  end
  return true
end

def pbTownStatus
  famelvl = $town.calculateFameLvl
  case famelvl
  when 0      
    pbTipCard(
      :TOWNSTATUSCENTER1,
      :TOWNSTATUSCENTER2,
      :TOWNSTATUSCENTER3
      )
  when 1..4
    pbTipCard(
      :TOWNSTATUSCENTER1,
      :TOWNSTATUSCENTER2,
      :TOWNSTATUSCENTER3,
      :TOWNSTATUSCENTER4
      )
  when 5..9
    pbTipCard(
      :TOWNSTATUSCENTER1,
      :TOWNSTATUSCENTER2,
      :TOWNSTATUSCENTER3,
      :TOWNSTATUSCENTER4,
      :TOWNSTATUSCENTER5,
      :TOWNSTATUSCENTER6
      )
  when 10..19 
    pbTipCard(
      :TOWNSTATUSCENTER1,
      :TOWNSTATUSCENTER2,
      :TOWNSTATUSCENTER3,
      :TOWNSTATUSCENTER4,
      :TOWNSTATUSCENTER5,
      :TOWNSTATUSCENTER6,
      :TOWNSTATUSCENTER7,
      :TOWNSTATUSCENTER8
      )
  when 20..29 
    pbTipCard(
      :TOWNSTATUSCENTER1,
      :TOWNSTATUSCENTER2,
      :TOWNSTATUSCENTER3,
      :TOWNSTATUSCENTER4,
      :TOWNSTATUSCENTER5,
      :TOWNSTATUSCENTER6,
      :TOWNSTATUSCENTER7,
      :TOWNSTATUSCENTER8,
      :TOWNSTATUSCENTER9,
      :TOWNSTATUSCENTER10
      )
  when 30..49 
    pbTipCard(
      :TOWNSTATUSCENTER1,
      :TOWNSTATUSCENTER2,
      :TOWNSTATUSCENTER3,
      :TOWNSTATUSCENTER4,
      :TOWNSTATUSCENTER5,
      :TOWNSTATUSCENTER6,
      :TOWNSTATUSCENTER7,
      :TOWNSTATUSCENTER8,
      :TOWNSTATUSCENTER9,
      :TOWNSTATUSCENTER10,
      :TOWNSTATUSCENTER11,
      :TOWNSTATUSCENTER12
      )
  when 50..69 
    pbTipCard(
      :TOWNSTATUSCENTER1,
      :TOWNSTATUSCENTER2,
      :TOWNSTATUSCENTER3,
      :TOWNSTATUSCENTER4,
      :TOWNSTATUSCENTER5,
      :TOWNSTATUSCENTER6,
      :TOWNSTATUSCENTER7,
      :TOWNSTATUSCENTER8,
      :TOWNSTATUSCENTER9,
      :TOWNSTATUSCENTER10,
      :TOWNSTATUSCENTER11,
      :TOWNSTATUSCENTER12,
      :TOWNSTATUSCENTER13,
      :TOWNSTATUSCENTER14
      )
  else
    pbTipCard(
      :TOWNSTATUSCENTER1,
      :TOWNSTATUSCENTER2,
      :TOWNSTATUSCENTER3,
      :TOWNSTATUSCENTER4,
      :TOWNSTATUSCENTER5,
      :TOWNSTATUSCENTER6,
      :TOWNSTATUSCENTER7,
      :TOWNSTATUSCENTER8,
      :TOWNSTATUSCENTER9,
      :TOWNSTATUSCENTER10,
      :TOWNSTATUSCENTER11,
      :TOWNSTATUSCENTER12,
      :TOWNSTATUSCENTER13,
      :TOWNSTATUSCENTER14,
      :TOWNSTATUSCENTER15,
      :TOWNSTATUSCENTER16
      )
  end
end


# Rock Gym
def checkVoid1(x, y)
  return true if x == 34 && y > 123 && y < 128
  return true if x == 34 && y > 132 && y < 145
  return true if x == 44 && y > 123 && y < 128
  return true if x == 44 && y > 132 && y < 145
  return true if y == 124 && x > 33 && x < 39
  return true if y == 124 && x > 39 && x < 45
  return true if y == 129 && x > 34 && x < 44
  return true if y == 130 && x > 34 && x < 44
  return false
end

def checkVoid2(x, y)
  return true if y == 101 && x > 10 && x < 18
  return true if y == 102 && x > 10 && x < 18
  return true if y == 108 && x > 8 && x < 13
  return true if y == 108 && x > 34 && x < 44
  return true if y == 109 && x > 15 && x < 20
  return true if y == 109 && x > 15 && x < 18
  return false
end

def checkVoid3(x, y)
	return true if x == 64 && y > 100 && y < 107
	return true if y == 101 && x > 59 && x < 69
	return true if y == 106 && x > 59 && x < 69
	return false  
end

def checkVoid4(x, y)
	return true if x == 32 && y > 85 && y < 89
	return true if x == 32 && y > 98 && y < 108
	return true if x == 33 && y > 85 && y < 88
	return true if x == 33 && y > 99 && y < 108
	return true if x == 34 && y > 85 && y < 87
	return true if x == 34 && y > 100 && y < 103
	return true if x == 36 && y > 90 && y < 94
	return true if x == 36 && y > 94 && y < 98
	return true if x == 42 && y > 90 && y < 94
	return true if x == 42 && y > 94 && y < 98
	return true if x == 44 && y > 85 && y < 87
	return true if x == 44 && y > 100 && y < 103
	return true if x == 45 && y > 85 && y < 88
	return true if x == 45 && y > 99 && y < 108
	return true if x == 46 && y > 85 && y < 89
	return true if x == 46 && y > 98 && y < 108
	return true if y == 91 && x > 35 && x < 43
	return true if y == 94 && x > 31 && x < 35
	return true if y == 94 && x > 43 && x < 47
	return true if y == 97 && x > 35 && x < 43
	return true if y == 102 && x > 31 && x < 38
	return true if y == 102 && x > 40 && x < 47
	return false  
end

def checkVoidB2(x, y)
	return true if y == 125 && x > 9 && x < 23
	return true if y == 129 && x > 9 && x < 23
	return true if y == 133 && x > 9 && x < 23
	return true if x == 9 && y > 134 && y < 139
	return true if x == 10 && y > 134 && y < 139
	return true if x == 22 && y > 134 && y < 139
	return true if x == 23 && y > 134 && y < 139
	return false  
end

def checkVoidB3(x, y)
  return true if x == 55 && y > 121 && y < 135
  return true if x == 56 && y > 121 && y < 135
  return true if x == 57 && y > 126 && y < 131
  return true if x == 58 && y > 126 && y < 131
  return true if x == 59 && y > 127 && y < 130
  return true if x == 65 && y > 127 && y < 130
  return true if x == 66 && y > 126 && y < 131
  return true if x == 67 && y > 126 && y < 131
  return true if x == 68 && y > 121 && y < 135
  return true if x == 69 && y > 121 && y < 135
  return false
end