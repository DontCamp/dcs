clientAircraft = {"JTAC1"}
airfieldList = {}
staticSound = 'l10n/DEFAULT/staticSound.ogg'
warningSound = 'l10n/DEFAULT/staticSound.ogg'
beaconSound = 'l10n/DEFAULT/VHF_WarningTone.wav'
REIN_numberOfBattles = 4
numberOfEnemyAAA = 8

local i
local outText = ''
local pos3


-- START OF REINFORCEMENTS

REIN_moveGroupAtoB = function(groupName,A,B)
local path
		path = {}
		path[#path + 1] = mist.ground.buildWP(A)
		path[#path + 1] = mist.ground.buildWP(B)
		mist.goRoute(groupName, path, 'Off Road')
end

REIN_addGroundGroup = function (country,groupName,unitType,numberOfTroops,position)
local i
local units = {}
local alt

	for i =1,numberOfTroops do
		alt = land.getHeight({x=position.x+i*2,y=0,z=position.y+i*2})
		table.insert(units,
		{
			["x"] = position.x+i*2,
			["y"] = position.y+i*2,
			["type"] = unitType,
			["name"] = groupName .. ' Unit #' .. i,
			["unitId"] = i,
			["heading"] = 0,
			["playerCanDrive"] = true,
			["skill"] = "Random"
		})
	end
	REIN_groupCounter = REIN_groupCounter+1
	alt = land.getHeight({x=position.x,y=0,z=position.y})
	coalition.addGroup(country, Group.Category.GROUND, -- create new group (infantry reinforcement)
	{
		["visible"] = false,
		["taskSelected"] = true,
		["route"] = 
		{
			["spans"] = 
			{
			}, -- end of ["spans"]
			["points"] = 
			{
				[1] = 
				{
					["alt"] = alt,
					["type"] = "Turning Point",
					["ETA"] = 0,
					["alt_type"] = "BARO",
					["formation_template"] = "",
					["y"] = position.y,
					["x"] = position.x,
					["ETA_locked"] = true,
					["speed"] = 0,
					["action"] = "Off Road",
					["task"] = 
					{
						["id"] = "ComboTask",
						["params"] = 
						{
							["tasks"] = 
							{
							}, -- end of ["tasks"]
						}, -- end of ["params"]
					}, -- end of ["task"]
					["speed_locked"] = true,
				}, -- end of [1]
			}, -- end of ["points"]
		}, -- end of ["route"]
		["groupId"] = REIN_groupCounter,
		["tasks"] = 
		{
		}, -- end of ["tasks"]
		["hidden"] = false,
		["units"] = units,
		["y"] = position.y,
		["x"] = position.x,
		["name"] = groupName,
		["start_time"] = 0,
		["task"] = "Ground Nothing"
	})
	return groupName
end

REIN_getLeadUnit = function (groupName)
local group
local firstUnit

	group = Group.getByName(groupName)
	firstUnit = Group.getUnits(group)
	return Unit.getName(firstUnit[1])
end

REIN_getInfantryGroupIndex = function (groupName)
local k
local kreturn

	kreturn = 0
	for k=1,#REIN_infantryGroups do
		if REIN_infantryGroups[k].blue == groupName or REIN_infantryGroups[k].blue == groupName then
			kreturn = k
		end
	end
	return kreturn
end

REIN_getHeading = function (position1,position2)
local heading
	local heading = math.floor(math.atan2(position1.z-position2.z,position1.x-position2.x)*57.3)
	if heading<0 then
		heading=heading+360
	end
	return heading
end

REIN_checkFlare = function(groupList,playersWithoutLOS)
local firstUnit
local unitsInNeed
local LOStable
local LOSsubTable
local LOSvisTable
local playerUnit
local playerName
local unitUnit
local unitPosition
local enemyPosition
local group
local groupName
local i
local j
local k
local counter

	unitsInNeed = {}
	if #groupList > 0 and #clientAircraft > 0 then
		for counter = 1,#groupList do -- put together a table containing one unit from every group in need
			table.insert(unitsInNeed,REIN_getLeadUnit(groupList[counter]))
		end
		LOStable = mist.getUnitsLOS(clientAircraft, 0, unitsInNeed, 2, 3000) -- which client aircraft have LOS with troops?
		for i =1,#LOStable do
			LOSsubTable = LOStable[i]
			playerUnit = LOSsubTable.unit
			playerName = Unit.getName(playerUnit)
			for k=1,#playersWithoutLOS do
				if playersWithoutLOS[k] == playerName then
					table.remove(playersWithoutLOS,k) -- remove client aircraft with LOS from the "no-LOS" list
				end
			end
			LOSvisTable = LOSsubTable.vis
			if REIN_smokePopped[playerName] == false then -- smoke has not yet been popped
				for j =1,#LOSvisTable do -- loop over all infantry in LOS
					unitUnit = LOSvisTable[j]
					unitPosition = unitUnit:getPosition().p -- get position for smoke marker
					trigger.action.smoke({x =unitPosition.x, y =unitPosition.y+100, z =unitPosition.z}, 1) -- pop smoke
					REIN_smokePopped[playerName] = true
					group = Unit.getGroup(unitUnit) -- determine the group that has popped flare
					groupName = Group.getName(group)
					enemyPosition = mist.getLeadPos(REIN_infantryGroups[REIN_getInfantryGroupIndex (groupName)].red)
					if enemyPosition then
						heading = REIN_getHeading(unitPosition, enemyPosition)
						REIN_out(playerName .. '. This is ' .. groupName .. '. We just popped a flare on our position. The enemy is at a distance of ' .. math.floor((mist.utils.get2DDist(mist.utils.makeVec2(enemyPosition), mist.utils.makeVec2(unitPosition))+50)/100)*100 .. ' meters, heading ' .. heading .. ' from our position.',30)
					else 
						REIN_out(playerName .. '. This is ' .. groupName .. '. We just popped a flare on our position.',30)
					end
				end
			end
		end
	end
	return playersWithoutLOS
end

REIN_closestUnit = function (playerPosition,groupList)
local distance
local unitPosition
local newDistance
local i
local groupName
local group
local closestOne

	
	closestOne = 0
	distance = 1000000
	local deadOne = 0
	for i =1,#groupList do -- this loop finds the infantry unit that is closest to the helo
		groupName = groupList[i]
		group = Group.getByName(groupName)
		if group then
			unitPosition = mist.getLeadPos(groupName);
			newDistance = mist.utils.get2DDist(mist.utils.makeVec2(playerPosition), mist.utils.makeVec2(unitPosition))
			if newDistance < distance then -- is this the closest one so far
				distance = newDistance
				closestOne = i -- yes, mark it as such
			end
		else
			deadOne = i
		end
	end
	if deadOne > 0 then
		table.remove(groupList, deadOne) -- remove possible dead infantry groups
	end
	return closestOne,distance
end

REIN_groupTransmitMessage = function(groupName)
local group
local groupController

	group = Group.getByName(groupName)
	groupController = Group.getController(group)
	Controller.pushTask(groupController,                                           
	{
		["id"] = "ComboTask",
		["params"] = 
		{
			["tasks"] = 
			{
				[1] = 
				{
					["number"] = 1,
					["auto"] = false,
					["id"] = "WrappedAction",
					["enabled"] = true,
					["params"] = 
					{
						["action"] = 
						{
							["id"] = "TransmitMessage",
							["params"] = 
							{
								["file"] = beaconSound,
								["subtitle"] = "",
								["loop"] = true,
								["duration"] = 5,
							}, -- end of ["params"]
						}, -- end of ["action"]
					}, -- end of ["params"]
				}, -- end of [1]
			}, -- end of ["tasks"]
		}, -- end of ["params"]
	})
end

REIN_groupSetFrequency = function(groupName,ADF)
local group
local groupController

	group = Group.getByName(groupName)
	groupController = Group.getController(group)
	Controller.pushTask(groupController,                                           
	{
		["id"] = "ComboTask",
		["params"] = 
		{
			["tasks"] = 
			{
				[1] = 
			   {
					["enabled"] = true,
					["auto"] = false,
					["id"] = "WrappedAction",
					["number"] = 1,
					["params"] = 
					{
						["action"] = 
						{
							["id"] = "SetFrequency",
							["params"] = 
							{
								["modulation"] = 0,
								["frequency"] = ADF,
							}, -- end of ["params"]
						}, -- end of ["action"]
					}, -- end of ["params"]
				}, -- end of [1]
			}, -- end of ["tasks"]
		}, -- end of ["params"]
	})
end

REIN_groupHoldFire = function(groupName)
local group
local groupController

	group = Group.getByName(groupName)
	groupController = Group.getController(group)
	Controller.pushTask(groupController,                                           
	{
		["id"] = "ComboTask",
		["params"] = 
		{
			["tasks"] = 
			{
				[1] = 
				{
					["enabled"] = true,
					["auto"] = false,
					["id"] = "WrappedAction",
					["number"] = 1,
					["params"] = 
					{
						["action"] = 
						{
							["id"] = "Option",
							["params"] = 
							{
								["name"] = 0,
								["value"] = 4,
							}, -- end of ["params"]
						}, -- end of ["action"]
					}, -- end of ["params"]
				}, -- end of [1]
			}, -- end of ["tasks"]
		}, -- end of ["params"]
	})
end

REIN_groupInvisible = function(groupName,bool)
local group
local groupController

	group = Group.getByName(groupName)
	groupController = Group.getController(group)
	Controller.pushTask(groupController,
	{
		["id"] = "ComboTask",
		["params"] = 
		{
			["tasks"] = 
			{
				[1] = 
				{
					["enabled"] = true,
					["auto"] = false,
					["id"] = "WrappedAction",
					["number"] = 1,
					["params"] = 
							   {
						["action"] = 
						{
							["id"] = "SetInvisible",
							["params"] =
							{
								["value"] = bool,
							}, -- end of ["params"]
						}, -- end of ["action"]
					}, -- end of ["params"]
				}, -- end of [1]
			}, -- end of ["tasks"]
		}, -- end of ["params"]
	})
end

REIN_groupImmortal = function(groupName,bool)
local group
local groupController

	group = Group.getByName(groupName)
	groupController = Group.getController(group)
	Controller.pushTask(groupController,
	{
		["id"] = "ComboTask",
		["params"] = 
		{
			["tasks"] = 
			{
				[1] = 
				{
					["enabled"] = true,
					["auto"] = false,
					["id"] = "WrappedAction",
					["number"] = 1,
					["params"] = 
							   {
						["action"] = 
						{
							["id"] = "SetImmortal",
							["params"] =
							{
								["value"] = bool,
							}, -- end of ["params"]
						}, -- end of ["action"]
					}, -- end of ["params"]
				}, -- end of [1]
			}, -- end of ["tasks"]
		}, -- end of ["params"]
	})
end

REIN_battleOn = function () -- this functions turns on a ground battle at time battle.activationTime by making groups visible
local counter
local pos3
local battle
local nameUS
local nameRussia
local nameRadio
local path

	for counter=1,#REIN_infantryGroups do
		battle = REIN_infantryGroups[counter]
		if timer.getTime() > battle.activationTime and REIN_battleActivated[counter] == false then
			REIN_battleActivated[counter] = true
			nameUS = battle.blue
			nameRussia = battle.red
			nameRadio = battle.radio
			if Group.getByName(nameUS) and Group.getByName(nameRussia) then -- make sure groups still alive
				REIN_out('This is ' .. nameUS .. '. We have encountered enemy infantry and will engage it. Out.',10)
				REIN_groupInvisible(nameUS,false) -- make groups visible
				REIN_groupInvisible(nameRussia,false)
				mist.scheduleFunction(REIN_moveGroupAtoB,{nameUS,mist.getLeadPos(nameUS),mist.getLeadPos(nameRussia)},timer.getTime()+1)
				mist.scheduleFunction(REIN_moveGroupAtoB,{nameRadio,mist.getLeadPos(nameRadio),mist.getLeadPos(nameRussia)},timer.getTime()+2)
			end
		end
	end
end

REIN_createBattles = function()
local counter
local position
	
	for counter = 1,REIN_numberOfBattles do
		position = mist.getRandPointInCircle (mist.utils.zoneToVec3 ('Ground Battle Zone'), 1400, 1400)
		table.insert(REIN_infantryGroups,{blue = REIN_addGroundGroup(country.id.USA,'US Infantry Group #' .. counter,'Soldier M4',16,position),
			red = REIN_addGroundGroup(country.id.INSURGENTS,'Russian Infantry Group #' .. counter,'Infantry AK',24,{x=position.x+(-1+2*math.random())*1000,y=position.y+(-1+2*math.random())*1000}),
			radio = REIN_addGroundGroup(country.id.USA,'Radio Group #' .. counter,'Soldier M4',1,{x=position.x-2,y=position.y-2}),
			ADF = 450000+counter*20000,activationTime = (1+9*math.random())*60,assaultGroup = nil})
		local battle = REIN_infantryGroups[counter]
		local nameUS = battle.blue
		local nameRussia = battle.red
		local nameRadio = battle.radio
		REIN_groupInvisible(nameUS,true) -- make invisible
		REIN_groupInvisible(nameRadio,true)
		REIN_groupImmortal(nameRadio,true)
		REIN_groupHoldFire(nameRadio)
		REIN_groupSetFrequency(nameRadio,battle.ADF) -- set beacon frequency
		REIN_groupTransmitMessage(nameRadio) -- transmit beacon identifier
		REIN_groupInvisible(nameRussia,true) -- make enemy invisible
	end



end

REIN_getLLStringForGroup = function(groupName) -- this is a slight modification of the corresponding mist routine, which gives an error message in the current DCS version
local lat
local lon
local dis
	lat,lon,dis = coord.LOtoLL(mist.getLeadPos(groupName))
	return mist.tostringLL(lat, lon, 0, true)
end

REIN_flagRequestLoadPlus10Function = function (pilotName) -- function gets activated 10 second after player has requested list of pilots down

	if REIN_hasLanded[pilotName] == true then
		REIN_numberOfTroopsInCabin[pilotName] = 8 -- load 8 soldiers
		trigger.action.outSoundForCoalition(coalition.side.BLUE,staticSound)
		trigger.action.outTextForCoalition(coalition.side.BLUE, pilotName .. '. Loading complete. You are ready to go. Out',10)
	end
end

REIN_flagRequestLoadFunction = function () -- function checks if player requested loading troops using "F10"
local counter
local pilotName
local playerUnit
local unitsInZone

	for counter = 1,#clientAircraft do -- loop of all client aircraft in the mission
		pilotName = clientAircraft[counter] -- get name of player
		playerUnit = Unit.getByName(pilotName) -- get player unit
		if playerUnit then -- is client alive?
			if trigger.misc.getUserFlag('load troops' .. pilotName) == 1 then -- yes, player requested it
				trigger.action.setUserFlag('load troops' .. pilotName,0) -- reset flag for future F10 requests
				unitsInZone = mist.getUnitsInZones({pilotName}, airfieldList) -- check if player is at one of the airfields
				if #unitsInZone > 0 and REIN_hasLanded[pilotName] == true then
					trigger.action.outSoundForCoalition(coalition.side.BLUE,staticSound)
					trigger.action.outTextForCoalition(coalition.side.BLUE, 'This is ' .. pilotName .. '. Requesting to load reinforcement troops. Over.',10)
					mist.scheduleFunction(REIN_flagRequestLoadPlus10Function,{pilotName},timer.getTime()+10+counter) -- loading complete in 10 seconds
				end
			end
		end
	end
end

REIN_flagRequestCountFunction = function () -- function outputs number of troops in cabin
local counter
local pilotName
local playerUnit

	for counter = 1,#clientAircraft do -- loop of all client aircraft in the mission
		pilotName = clientAircraft[counter] -- get name of player
		playerUnit = Unit.getByName(pilotName) -- get player unit
		if playerUnit then -- is client alive?
			if trigger.misc.getUserFlag('troop count' .. pilotName) == 1 then -- yes, player requested it
				trigger.action.setUserFlag('troop count' .. pilotName,0) -- reset flag for future F10 requests
				trigger.action.outSoundForCoalition(coalition.side.BLUE,staticSound)
				trigger.action.outTextForCoalition(coalition.side.BLUE,'There are ' .. REIN_numberOfTroopsInCabin[pilotName] .. ' combat troops on board.',10)
			end
		end
	end
end

REIN_flagRequestListPlus10Function = function () -- function gets activated 10 second after player has requested list of pilots down
	local infantryGroup
	local directionText
	local deadOne
	local outText = 'We have ' .. #REIN_groupsInNeed .. ' infantry groups that have requested reinforcements.\n'
	local i
	
	deadOne = 0
	if #REIN_groupsInNeed > 0 then -- if there are any pilots down, it creates the list of pilots down
		outText = outText .. 'Here is the list:\n'
		for i = 1,#REIN_groupsInNeed do
			infantryGroup = Group.getByName(REIN_groupsInNeed[i])
			if infantryGroup then -- check if this unit is alive
				outText = outText .. REIN_groupsInNeed[i] .. ' at ' .. REIN_getLLStringForGroup(REIN_groupsInNeed[i]) .. ', use ADF ' .. REIN_infantryGroups[REIN_getInfantryGroupIndex(REIN_groupsInNeed[i])].ADF/1000 .. ' kHz to locate \n' -- create info string for group
			else
				deadOne = i -- if dead, it will be removed later
			end
		end
		if deadOne > 0 then
			table.remove(REIN_groupsInNeed, deadOne)
			table.remove(REIN_ADF, deadOne)
		end
	end

	outText = outText .. 'We have ' .. #REIN_groupsToBePickedUp .. ' infantry groups that need to be picked up.\n'
	
	deadOne = 0
	if #REIN_groupsToBePickedUp > 0 then -- if there are any pilots down, it creates the list of pilots down
		outText = outText .. 'Here is the list:\n'
		for i = 1,#REIN_groupsToBePickedUp do
			infantryGroup = Group.getByName(REIN_groupsToBePickedUp[i])
			if infantryGroup then -- check if this unit is alive
				outText = outText .. REIN_groupsToBePickedUp[i] .. ' at ' .. REIN_getLLStringForGroup(REIN_groupsToBePickedUp[i]) .. ', use ADF ' .. REIN_infantryGroups[REIN_getInfantryGroupIndex(REIN_groupsToBePickedUp[i])].ADF/1000 .. ' kHz to locate \n' -- create info string for group
			else 
				deadOne = i -- if dead, it will be removed later
			end
		end
		if deadOne > 0 then
			table.remove(REIN_groupsToBePickedUp, deadOne)
			table.remove(REIN_ADF, deadOne)
		end
	end
	REIN_out(outText,100)
end

REIN_flagRequestListFunction = function () -- function checks if player requested list of pilots down by "F10"
	if trigger.misc.getUserFlag('request list of REIN') == 1 then -- yes, player requested it
		trigger.action.setUserFlag('request list of REIN',0) -- reset flag to allow future F10 requests
		trigger.action.outSoundForCoalition(coalition.side.BLUE,staticSound)
		trigger.action.outTextForCoalition(coalition.side.BLUE, 'Requesting an update on tasks related to infantry groups. Over.',10)
		mist.scheduleFunction(REIN_flagRequestListPlus10Function,{},timer.getTime()+10) -- actual list will print in 10 seconds
	end
end

REIN_offloadFunction = function(pilotName,closestOne) -- this function offloads the reinforcement troops 
local playerUnit
local playerPosition
local group
local firstUnit
local groupController
local i
local battle
local nameUS
local nameRussia
local nameAssault
local path
	
--	trigger.action.outTextForGroup(Unit.getGroup(Unit.getByName(pilotName)), 'Alright, lets get going.', 10)
	playerUnit = Unit.getByName(pilotName) -- get client unit
	playerPosition = Unit.getPosition(playerUnit).p
	if REIN_hasLanded[pilotName] == true and REIN_numberOfTroopsInCabin[pilotName] > 7 then -- offload can happen only if there are reinforcement troops in the chopper, and if chopper is on ground
		REIN_out('All troops are off the helo. '.. pilotName .. ', you are good to go. Out.', 10)
		nameUS = REIN_groupsInNeed[closestOne]
		REIN_groupInvisible(nameUS,false) -- make friendly visible to enemy, to restart battle
		i = REIN_getInfantryGroupIndex(nameUS)
		nameRussia = REIN_infantryGroups[i].red
		REIN_groupInvisible(nameRussia,false) -- make enemy visible to enemy, to restart battle
		REIN_infantryGroups[i].assaultGroup = REIN_addGroundGroup(country.id.USA,'Assault Group #' .. i,'Soldier M4',8,{x=playerPosition.x+10,y=playerPosition.z+10})
		nameAssault = REIN_infantryGroups[i].assaultGroup
		mist.scheduleFunction(REIN_moveGroupAtoB,{nameAssault,mist.getLeadPos(nameAssault),mist.getLeadPos(nameRussia)},timer.getTime()+1)
		mist.scheduleFunction(REIN_moveGroupAtoB,{nameUS,mist.getLeadPos(nameUS),mist.getLeadPos(nameRussia)},timer.getTime()+2)

		table.remove(REIN_groupsInNeed, closestOne) -- troop has been helped, it is no longer in need

		REIN_offloadingTroops[pilotName] = false -- troops have been offloaded
		REIN_numberOfTroopsInCabin[pilotName] = REIN_numberOfTroopsInCabin[pilotName] - 8 -- 8 troops were off-loaded from chopper
	end
end

REIN_pickupFunction = function (pilotName,closestOne) -- function gets activated 10 second after player has requested list of pilots down
local size

	if REIN_hasLanded[pilotName] == true then
		size = #Group.getUnits(Group.getByName(REIN_groupsToBePickedUp[closestOne]))
		REIN_numberOfTroopsInCabin[pilotName] = size -- load soldiers
		REIN_out(pilotName .. '. Loading complete. You are ready to go. Out',10)
		REIN_loadingTroops[pilotName] = false -- troops have been loaded
		Group.getByName(REIN_groupsToBePickedUp[closestOne]):destroy()
		table.remove(REIN_groupsToBePickedUp, closestOne) -- troop has been helped, it is no longer in need
	end
end

REIN_out = function(text, delay)
	trigger.action.outSoundForCoalition(coalition.side.BLUE,staticSound)
	trigger.action.outTextForCoalition(coalition.side.BLUE,text,delay)
end

REIN_hasPlayerLandedFunction = function () -- function checks if a helo has landed
local pilotName
local counter
local value
local velocity
local speed
local playerUnit
local playerPosition
local infantryUnit
local infantryPosition
local closestOne
local distance
local unitToBePickedUp
	
	for counter = 1,#clientAircraft do -- loop of all client aircraft in the mission
		pilotName = clientAircraft[counter] -- get name of player
		playerUnit = Unit.getByName(pilotName) -- get client unit
		if playerUnit then -- is client alive?
			playerPosition = Unit.getPosition(playerUnit).p; -- yes, get helo position
			velocity = Unit.getVelocity(playerUnit) -- let's get its velocity
			speed = velocity.x^2+velocity.y^2+velocity.z^2 -- calculate its speed
			if speed < 0.01 and REIN_hasLanded[pilotName] == false then -- if helo is at rest and on ground, we count this as a landing
				REIN_hasLanded[pilotName] = true -- mark it has landed
				unitsInZone = mist.getUnitsInZones({pilotName}, airfieldList) -- is pilot at an airfield?
				if #unitsInZone > 0 and REIN_numberOfTroopsInCabin[pilotName] > 0 then
					REIN_out('This is ' .. pilotName .. '. Off-Loading returning grunts.',10)
					REIN_numberOfTroopsInCabin[pilotName] = 0
				else
					closestOne,distance = REIN_closestUnit(playerPosition,REIN_groupsInNeed)
					if distance < 500 and REIN_offloadingTroops[pilotName] == false then -- if troops are close to helo, and off-loading has not yet been scheduled, let's offload the troops
						if REIN_numberOfTroopsInCabin[pilotName] > 0 then 
								REIN_offloadingTroops[pilotName] = true -- this pilot is scheduled to offload
								mist.scheduleFunction(REIN_offloadFunction,{pilotName,closestOne},timer.getTime()+10) -- offload complete in 10 seconds
								REIN_out (pilotName ..'. Starting to offload reinforcement troops.', 10)
						else
								REIN_out(pilotName ..'. You didnt bring any troops, you dumbass!', 10)
						end
					end
					closestOne,distance = REIN_closestUnit(playerPosition,REIN_groupsToBePickedUp)
					if distance < 500 and REIN_loadingTroops[pilotName] == false then -- if troops are close to helo, and off-loading has not yet been scheduled, let's offload the troops
						if REIN_numberOfTroopsInCabin[pilotName] == 0 then 
								REIN_out(pilotName ..'. Starting to board your chopper.', 10)
								REIN_loadingTroops[pilotName] = true -- this pilot is scheduled to offload
								unitToBePickedUp = REIN_groupsToBePickedUp[closestOne]
								mist.scheduleFunction(REIN_moveGroupAtoB,{unitToBePickedUp,mist.getLeadPos(unitToBePickedUp),{x=playerPosition.x+10,y=playerPosition.y,z=playerPosition.z+10}},timer.getTime()+1)
								mist.scheduleFunction(REIN_pickupFunction,{pilotName,closestOne},timer.getTime()+10) -- offload complete in 10 seconds
						else
								REIN_out(pilotName ..'. Theres no room for us in the chopper, you dumbass!', 10)
						end
					end
				end
			elseif speed > 0.01 then -- if helo is moving, it is not a landing
				REIN_hasLanded[pilotName] = false
			end
		end
	end
end

REIN_flagPopSmokeFunction = function () -- function checks if new LOS has been established, and if yes, it pops a flare on the pilot position
local playersWithoutLOS
local playerName
local i
	
	playersWithoutLOS = {} -- which client aircraft have no LOS with troops
	for i=1,#clientAircraft do
		playersWithoutLOS[i] = clientAircraft[i] -- initially all of them, because we have not checked that yet
	end
	playersWithoutLOS = REIN_checkFlare(REIN_groupsInNeed,playersWithoutLOS)	
	playersWithoutLOS = REIN_checkFlare(REIN_groupsToBeRescued,playersWithoutLOS)	
	for i=1,#playersWithoutLOS do
		playerName = playersWithoutLOS[i]
		REIN_smokePopped[playerName] = false -- allow new smoke marking for units without LOS
	end
end

REIN_checkInfantrySize = function() -- function checks if troop strength has fallen to a critical level, and if so, makes the group invisible (so that it survives until reinforcements arrive)
local counter
local group
local size
local infantryPosition
local enemyPosition
local radioPosition

	for counter = 1,#REIN_infantryGroups do
		group = Group.getByName(REIN_infantryGroups[counter].blue)
		size = #Group.getUnits(group)
		if size < 8 and REIN_takenCasualties[counter] == false then
			REIN_takenCasualties[counter] = true
			table.insert(REIN_groupsInNeed,REIN_infantryGroups[counter].blue)
			trigger.action.outSoundForCoalition(coalition.side.BLUE,warningSound)
			trigger.action.outTextForCoalition(coalition.side.BLUE,'This is ' .. REIN_infantryGroups[counter].blue .. '. We have taken heavy casualties and need immediate reinforcements [use "F10" at airfield to load reinforcement troops]. Locate us at ADF ' .. REIN_infantryGroups[counter].ADF/1000 .. ' kHz.',30)
			table.insert(REIN_ADF,REIN_infantryGroups[counter].ADF)
			REIN_groupInvisible(REIN_infantryGroups[counter].blue,true)
			infantryPosition = mist.getLeadPos(REIN_infantryGroups[counter].blue)
			enemyPosition = mist.getLeadPos(REIN_infantryGroups[counter].red)
			radioPosition = mist.getLeadPos(REIN_infantryGroups[counter].radio)
			mist.scheduleFunction(REIN_moveGroupAtoB,{REIN_infantryGroups[counter].blue,infantryPosition,{x=2*infantryPosition.x - enemyPosition.x,y=2*infantryPosition.z - enemyPosition.z}},timer.getTime()+1)
			mist.scheduleFunction(REIN_moveGroupAtoB,{REIN_infantryGroups[counter].radio,radioPosition,{x=2*infantryPosition.x - enemyPosition.x,y=2*infantryPosition.z - enemyPosition.z}},timer.getTime()+2)
		end
	end
end

REIN_checkEnemyInfantrySize = function() -- same for enemy troops
local counter
local group
local size
local group1
local group2
local position

	for counter = 1,#REIN_infantryGroups do
		group = Group.getByName(REIN_infantryGroups[counter].red)
		if group then
			size = #Group.getUnits(group)
		end
		if group == nil and REIN_enemyDead[counter] == false then
			REIN_enemyDead[counter] = true
			group1 = Group.getByName(REIN_infantryGroups[counter].blue)
			group2 = Group.getByName(REIN_infantryGroups[counter].assaultGroup)
			size = 0
			if group1 then
				size = size + #Group.getUnits(group1)
				position = mist.getLeadPos(REIN_infantryGroups[counter].blue)
				group1:destroy()
			end
			if group2 then
				size = size + #Group.getUnits(group2)
				position = mist.getLeadPos(REIN_infantryGroups[counter].assaultGroup)
				group2:destroy()
			end
			if size > 0 then
				REIN_out('This is ' .. REIN_infantryGroups[counter].blue .. '. We have eliminated the enemy infantry. Thanks for your support. We are ready to be picked up. We are popping green smoke.',10)
				table.insert(REIN_groupsToBePickedUp,REIN_addGroundGroup(country.id.USA,REIN_infantryGroups[counter].blue,'Soldier M4',size,{x=position.x,y=position.z}))
				trigger.action.smoke({x =position.x, y =position.y+100, z =position.z}, 0)
			end
		elseif size < 8 and REIN_enemyTakenCasualties[counter] == false then
			REIN_enemyTakenCasualties[counter] = true
			REIN_groupInvisible(REIN_infantryGroups[counter].red,true)
		end		
	end
end

-- BEGIN MAIN

REIN_infantryGroups = {}
REIN_hasLanded = {}
REIN_offloadingTroops = {}
REIN_loadingTroops = {}
REIN_smokePopped = {}
REIN_groupsInNeed = {}
REIN_groupsToBePickedUp = {}
REIN_numberOfTroopsInCabin = {}
REIN_groupCounter=0
REIN_ADF = {}
REIN_takenCasualties = {}
REIN_enemyTakenCasualties = {}
REIN_enemyDead = {}
REIN_battleActivated = {}

local counter
local pilotName

for counter = 1,#clientAircraft do
local playerUnit
local playerGroup

	pilotName = clientAircraft[counter]
	REIN_hasLanded[pilotName] = true
	REIN_offloadingTroops[pilotName] = false
	REIN_loadingTroops[pilotName] = false
	REIN_smokePopped[pilotName] = false
	REIN_numberOfTroopsInCabin[pilotName] = 0
	playerUnit = Unit.getByName(pilotName)
	if playerUnit then
		--playerGroup = Unit.getGroup(playerUnit)
		--trigger.action.addOtherCommandForGroup(Group.getID(playerGroup), 'ready to load troops (' .. pilotName .. ')', 'load troops' .. pilotName) -- add radio item to "F10" menu
		--trigger.action.addOtherCommandForGroup(Group.getID(playerGroup), 'number of troops in cabin (' .. pilotName .. ')', 'troop count' .. pilotName) -- add radio item to "F10" menu
	end
end

	REIN_createBattles()
	
for counter = 1,#REIN_infantryGroups do
	REIN_takenCasualties[counter] = false
	REIN_enemyTakenCasualties[counter] = false
	REIN_enemyDead[counter] = false
	REIN_battleActivated[counter] = false
end
--trigger.action.addOtherCommandForCoalition(coalition.side.BLUE, 'request list of infantry group related tasks', 'request list of REIN') -- add radio item to "F10" menu
--mist.scheduleFunction(REIN_flagRequestLoadFunction,{},timer.getTime(),1) -- schedule various functions
--mist.scheduleFunction(REIN_flagRequestCountFunction,{},timer.getTime(),1) -- schedule various functions
--mist.scheduleFunction(REIN_flagRequestListFunction,{},timer.getTime(),1) -- schedule various functions
mist.scheduleFunction(REIN_battleOn,{}, timer.getTime(),1)
mist.scheduleFunction(REIN_checkInfantrySize,{}, timer.getTime(),1)
mist.scheduleFunction(REIN_checkEnemyInfantrySize,{}, timer.getTime(),1)	
mist.scheduleFunction(REIN_flagPopSmokeFunction,{},timer.getTime(),1)
--mist.scheduleFunction(REIN_hasPlayerLandedFunction,{},timer.getTime(),1)


ENEMY_addGroundGroup = function (country,groupName,unitType,numberOfTroops,position)
local i
local units = {}
local alt

	for i =1,numberOfTroops do
		alt = land.getHeight({x=position.x+i*2,y=0,z=position.y+i*2})
		table.insert(units,
		{
			["x"] = position.x+i*2,
			["y"] = position.y+i*2,
			["type"] = unitType,
			["name"] = groupName .. ' Unit #' .. i,
			["unitId"] = i,
			["heading"] = 0,
			["playerCanDrive"] = true,
			["skill"] = "Random"
		})
	end
	REIN_groupCounter = REIN_groupCounter+1
	alt = land.getHeight({x=position.x,y=0,z=position.y})
	coalition.addGroup(country, Group.Category.GROUND, -- create new group (infantry reinforcement)
	{
		["visible"] = false,
		["taskSelected"] = true,
		["route"] = 
		{
			["spans"] = 
			{
			}, -- end of ["spans"]
			["points"] = 
			{
				[1] = 
				{
					["alt"] = alt,
					["type"] = "Turning Point",
					["ETA"] = 0,
					["alt_type"] = "BARO",
					["formation_template"] = "",
					["y"] = position.y,
					["x"] = position.x,
					["ETA_locked"] = true,
					["speed"] = 0,
					["action"] = "Off Road",
					["task"] = 
					{
						["id"] = "ComboTask",
						["params"] = 
						{
							["tasks"] = 
							{
							}, -- end of ["tasks"]
						}, -- end of ["params"]
					}, -- end of ["task"]
					["speed_locked"] = true,
				}, -- end of [1]
			}, -- end of ["points"]
		}, -- end of ["route"]
		["groupId"] = REIN_groupCounter,
		["tasks"] = 
		{
		}, -- end of ["tasks"]
		["hidden"] = false,
		["units"] = units,
		["y"] = position.y,
		["x"] = position.x,
		["name"] = groupName,
		["start_time"] = 0,
		["task"] = "Ground Nothing"
	})
	return groupName
end

local counter
local position
	
for counter = 1,numberOfEnemyAAA do
	position = mist.getRandPointInCircle (mist.utils.zoneToVec3 ('Ground Battle Zone'), 1400, 1400)
	ENEMY_addGroundGroup(country.id.INSURGENTS,'Russian AAA Group #' .. counter,'Ural-375 ZU-23',1,position)
end
