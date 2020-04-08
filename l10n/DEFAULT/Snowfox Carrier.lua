--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- Name: Operation Snowfox Carrier
-- Author: Surrexen    ༼ つ ◕_◕ ༽つ    (づ｡◕‿◕｡)づ 
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////MAIN

trigger.action.outSound('Background Chatter.ogg')

--////CARRIER GROUP PATROL ROUTE
--////Set Carrier Group To Patrol Waypoints Indefinately
GROUP:FindByName("CVN-74 John C. Stennis"):PatrolRoute()
GROUP:FindByName("LHA-1 Tarawa"):PatrolRoute()

--////GET THE GAME MODE SETUP (FLAG 10000 IN MISSION EDITOR TRIGGERS, 0 FOR MULTIPLAYER, 1 FOR SINGLEPLAYER)
GameMode = trigger.misc.getUserFlag(10000)


if ( GameMode == 0 ) then
	--MULTIPLAYER (AIR STARTS)
	trigger.action.outText("Operation Snowfox Will Run In Multiplayer Mode [Aerial Starts For AI CAP and Fleet Defence]", 15)
	
	--[[
	
	--////CARRIER GROUP RECOVERY TANKER
	tankerStennis=RECOVERYTANKER:New("CVN-74 John C. Stennis", "SQ BLUE S-3B")
	tankerStennis:SetTakeoffAir()
	tankerStennis:SetRadio(238)
	tankerStennis:SetTACAN(38, "ARC")
	tankerStennis:SetCallsign(CALLSIGN.Tanker.Arco)
	tankerStennis:SetModex(380)
	tankerStennis:SetAltitude(6000)
	tankerStennis:SetSpeed(336) -- 336kt TAS = 300IAS @ 6000ft. 347.2kt TAS = 310kt IAS @ 6000ft
	tankerStennis:Start()

	--Set Immortal/Invis since it doesn't inherit it
	SEF_RecoveryTanker = Unit.getByName(tankerStennis:GetUnitName())
	--SEF_RecoveryTanker:getController():setCommand({id = 'SetImmortal', params = {value = true}})
	SEF_RecoveryTanker:getController():setCommand({id = 'SetInvisible', params = {value = true}})
	--trigger.action.outText("Recovery Tanker Now Immortal", 15)
	--trigger.action.outText("Recovery Tanker Now Invisible", 15)

	--////CARRIER GROUP RESCUE HELO
	heloStennis=RESCUEHELO:New("CVN-74 John C. Stennis", "SQ BLUE CH-53E")
	heloStennis:SetTakeoffAir()
	heloStennis:SetModex(530)
	heloStennis:Start()

	--Set Immortal/Invisible since it doesn't inherit it
	SEF_RescueHelo = Unit.getByName(heloStennis:GetUnitName())
	--SEF_RescueHelo:getController():setCommand({id = 'SetImmortal', params = {value = true}})
	SEF_RescueHelo:getController():setCommand({id = 'SetInvisible', params = {value = true}})
	--trigger.action.outText("Rescue Helo Now Immortal", 15)
	--trigger.action.outText("Rescue Helo Now Invisible", 15)
	]]--	
else
	--SINGLEPLAYER (GROUND STARTS)
	trigger.action.outText("Operation Snowfox Will Run In Singleplayer Mode [Ground Starts For AI CAP and Fleet Defence]", 15)
	
	--[[
	--////CARRIER GROUP RECOVERY TANKER
	tankerStennis=RECOVERYTANKER:New("CVN-74 John C. Stennis", "SQ BLUE S-3B")
	tankerStennis:SetRadio(238)
	tankerStennis:SetTACAN(38, "ARC")
	tankerStennis:SetCallsign(CALLSIGN.Tanker.Arco)
	tankerStennis:SetModex(380)
	tankerStennis:SetAltitude(6000)
	tankerStennis:SetSpeed(336) -- 336kt TAS = 300IAS @ 6000ft. 347.2kt TAS = 310kt IAS @ 6000ft
	tankerStennis:Start()

	--Set Immortal/Invis since it doesn't inherit it
	SEF_RecoveryTanker = Unit.getByName(tankerStennis:GetUnitName())
	--SEF_RecoveryTanker:getController():setCommand({id = 'SetImmortal', params = {value = true}})
	SEF_RecoveryTanker:getController():setCommand({id = 'SetInvisible', params = {value = true}})
	--trigger.action.outText("Recovery Tanker Now Immortal", 15)
	--trigger.action.outText("Recovery Tanker Now Invisible", 15)

	--////CARRIER GROUP RESCUE HELO
	heloStennis=RESCUEHELO:New("CVN-74 John C. Stennis", "SQ BLUE CH-53E")
	heloStennis:SetModex(530)
	heloStennis:Start()

	--Set Immortal/Invisible since it doesn't inherit it
	SEF_RescueHelo = Unit.getByName(heloStennis:GetUnitName())
	--SEF_RescueHelo:getController():setCommand({id = 'SetImmortal', params = {value = true}})
	SEF_RescueHelo:getController():setCommand({id = 'SetInvisible', params = {value = true}})
	--trigger.action.outText("Rescue Helo Now Immortal", 15)
	--trigger.action.outText("Rescue Helo Now Invisible", 15)
	]]--	
end

--------------------------------------------------------------------------------------------------------------

--[[

tankerStennis:GetUnitName()
:getController():setCommand({id = 'SetImmortal', params = {value = true}})
:getController():setCommand({id = 'SetInvisible', params = {value = true}})

]]--