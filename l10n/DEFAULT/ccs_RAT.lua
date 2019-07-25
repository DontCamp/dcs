
if random_civ_air_traffic == true then

local yak=RAT:New("RAT_YAK")
yak:Spawn(1)

local c130=RAT:New("RAT_C130")
c130:Spawn(1)

local c17=RAT:New("RAT_C17")
c17:Spawn(1)

local an26=RAT:New("RAT_AN26")
an26:Spawn(1)

trigger.action.outText("Random Civilian Air Traffic is ENABLED...", 10)


end

if random_civ_air_traffic == false then

trigger.action.outText("Random Civilian Air Traffic is DISABLED...", 10)

end

env.info('RAT Script complete')