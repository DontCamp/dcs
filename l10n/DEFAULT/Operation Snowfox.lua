--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- Name: Operation Snowfox
-- Author: Surrexen    ༼ つ ◕_◕ ༽つ    (づ｡◕‿◕｡)づ 
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////MISSION LOGIC FUNCTIONS

function SEF_MissionSelector()	
	
	if ( NumberOfCompletedMissions >= TotalScenarios ) then
			
		OperationComplete = true
		trigger.action.outText("Operation Snowfox Has Been Successful", 15)
		--WRITE PROGRESS TABLES TO EMPTY AND SAVE WITH NO ARGUMENTS
		SnowfoxUnitInterment = {}
		SEF_SaveUnitIntermentTableNoArgs()
		SnowfoxStaticInterment = {}
		SEF_SaveStaticIntermentTableNoArgs()			
	else
		Randomiser = math.random(1,TotalScenarios)
		if ( trigger.misc.getUserFlag(Randomiser) > 0 ) then
			--SELECTED MISSION [Randomiser] ALREADY DONE, FLAG VALUE >=1, SELECT ANOTHER ONE
			SEF_MissionSelector()
		elseif ( trigger.misc.getUserFlag(Randomiser) == 0 ) then
			--SELECTED MISSION [Randomiser] IS AVAILABLE TO START, SET TO STARTED AND VALIDATE
			trigger.action.setUserFlag(Randomiser,1)
			SEF_RetrieveMissionInformation(Randomiser)
			--trigger.action.outText("Validating Mission Number "..Randomiser.." For Targeting", 15)
			SEF_ValidateMission()										
		else
			trigger.action.outText("Mission Selection Error", 15)
		end
	end		
end

function SEF_RetrieveMissionInformation ( MissionNumber )
	
	--SET GLOBAL VARIABLES TO THE SELECTED MISSION
	ScenarioNumber = MissionNumber
	AGMissionTarget = OperationSnowfox_AG[MissionNumber].TargetName
	AGTargetTypeStatic = OperationSnowfox_AG[MissionNumber].TargetStatic
	AGMissionBriefingText = OperationSnowfox_AG[MissionNumber].TargetBriefing		
end

function SEF_ValidateMission()
	
	--CHECK TARGET TO SEE IF IT IS ALIVE OR NOT
	if ( AGTargetTypeStatic == false and AGMissionTarget ~= nil ) then
		--TARGET IS NOT STATIC					
		if ( GROUP:FindByName(AGMissionTarget):IsAlive() == true ) then
			--GROUP VALID
			trigger.action.outSound('That Is Our Target.ogg')
			trigger.action.outText(AGMissionBriefingText,15)			
		elseif ( GROUP:FindByName(AGMissionTarget):IsAlive() == false or GROUP:FindByName(AGMissionTarget):IsAlive() == nil ) then
			--GROUP NOT VALID
			trigger.action.setUserFlag(ScenarioNumber,4)
			NumberOfCompletedMissions = NumberOfCompletedMissions + 1
			AGMissionTarget = nil
			AGMissionBriefingText = nil
			SEF_MissionSelector()						
		else			
			trigger.action.outText("Mission Validation Error - Unexpected Result In Group Size", 15)						
		end		
	elseif ( AGTargetTypeStatic == true and AGMissionTarget ~= nil ) then		
		--TARGET IS STATIC		
		if ( StaticObject.getByName(AGMissionTarget) ~= nil and StaticObject.getByName(AGMissionTarget):isExist() == true ) then
			--STATIC IS VALID
			trigger.action.outSound('That Is Our Target.ogg')
			trigger.action.outText(AGMissionBriefingText,15)								
		elseif ( StaticObject.getByName(AGMissionTarget) == nil or StaticObject.getByName(AGMissionTarget):isExist() == false ) then
			--STATIC TARGET NOT VALID, ASSUME TARGET ALREADY DESTROYED			
			trigger.action.setUserFlag(ScenarioNumber,4)
			NumberOfCompletedMissions = NumberOfCompletedMissions + 1	
			AGMissionTarget = nil
			AGMissionBriefingText = nil
			SEF_MissionSelector()
		else
			trigger.action.outText("Mission Validation Error - Unexpected Result In Static Test", 15)	
		end		
	elseif ( OperationComplete == true ) then
		trigger.action.outText("The Operation Is Complete - No Further Targets To Validate For Mission Assignment", 15)
	else		
		trigger.action.outText("Mission Validation Error - Mission Validation Unavailable, No Valid Targets", 15)
	end
end

function SEF_SkipScenario()	
	--CHECK MISSION IS NOT SUDDENLY FLAGGED AS STATE 4 (COMPLETED)
	if ( trigger.misc.getUserFlag(ScenarioNumber) >= 1 and trigger.misc.getUserFlag(ScenarioNumber) <= 3 ) then
		--RESET MISSION TO STATE 0 (NOT STARTED), CLEAR TARGET INFORMATION AND REROLL A NEW MISSION
		trigger.action.setUserFlag(ScenarioNumber,0) 
		AGMissionTarget = nil
		AGMissionBriefingText = nil
		SEF_MissionSelector()
	elseif ( OperationComplete == true ) then
		trigger.action.outText("The Operation Has Been Completed, All Objectives Have Been Met", 15)
	else		
		trigger.action.outText("Unable To Skip As Current Mission Is In A Completion State", 15)
	end
end

function MissionSuccess()
	
	--SET GLOBALS TO NIL
	AGMissionTarget = nil
	AGMissionBriefingText = nil
	
	local RandomMissionSuccessSound = math.random(1,5)
	trigger.action.outSound('AG Kill ' .. RandomMissionSuccessSound .. '.ogg')	
end

function SEF_MissionTargetStatus(TimeLoop, time)

	if (AGTargetTypeStatic == false and AGMissionTarget ~= nil) then
		--TARGET IS NOT STATIC
					
		if (GROUP:FindByName(AGMissionTarget):IsAlive() == true) then
			--GROUP STILL ALIVE
						
			return time + 10			
		elseif (GROUP:FindByName(AGMissionTarget):IsAlive() == false or GROUP:FindByName(AGMissionTarget):IsAlive() == nil) then 
			--GROUP DEAD
			trigger.action.outText("Mission Update - Mission Successful", 15)
			trigger.action.setUserFlag(ScenarioNumber,4)
			NumberOfCompletedMissions = NumberOfCompletedMissions + 1
			MissionSuccess()
			timer.scheduleFunction(SEF_MissionSelector, {}, timer.getTime() + 20)
			
			return time + 30			
		else			
			trigger.action.outText("Mission Target Status - Unexpected Result, Monitor Has Stopped", 15)						
		end		
	elseif (AGTargetTypeStatic == true and AGMissionTarget ~= nil) then
		--TARGET IS STATIC
		if ( StaticObject.getByName(AGMissionTarget) ~= nil and StaticObject.getByName(AGMissionTarget):isExist() == true ) then 
			--STATIC ALIVE
			
			return time + 10				
		else				
			--STATIC DESTROYED
			trigger.action.outText("Mission Update - Mission Successful", 15)
			trigger.action.setUserFlag(ScenarioNumber,4)
			NumberOfCompletedMissions = NumberOfCompletedMissions + 1
			MissionSuccess()
			timer.scheduleFunction(SEF_MissionSelector, {}, timer.getTime() + 20)
			
			return time + 30				
		end		
	else		
		return time + 10
	end	
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////MISSION TARGET TABLE

function SEF_InitializeMissionTable()
	
	OperationSnowfox_AG = {}	
	
	--ABU MUSA ISLAND
	OperationSnowfox_AG[1] = {				
		TargetName = "Abu Musa - AAA 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets located on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}				
	OperationSnowfox_AG[2] = {
		TargetName = "Abu Musa - Artillery 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Artillery assets located on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}	
	OperationSnowfox_AG[3] = {
		TargetName = "Abu Musa - Bunker 1",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Western Bunker on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}						
	OperationSnowfox_AG[4] = {
		TargetName = "Abu Musa - Bunker 2",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Eastern Bunker on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}					
	OperationSnowfox_AG[5] = {
		TargetName = "Abu Musa - Cargo Ships 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Cargo Ships North-East of Abu Musa Island \nAbu Musa Island Sector - Grid CP27",
	}			
	OperationSnowfox_AG[6] = {
		TargetName = "Abu Musa - Comms",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}			
	OperationSnowfox_AG[7] = {						
		TargetName = "Abu Musa - Missile Research",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Missile R&D Facility on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}					
	OperationSnowfox_AG[8] = {
		TargetName = "Abu Musa - Navy 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Armed Speedboats moared at Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}					
	OperationSnowfox_AG[9] = {
		TargetName = "Abu Musa - SAM 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Mobile SAM on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}					
	OperationSnowfox_AG[10] = {
		TargetName = "Abu Musa - Silkworm 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Silkworm Site on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}					
	--SIRRI ISLAND
	OperationSnowfox_AG[11] = {
		TargetName = "Sirri Island - SAM 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Mobile SAM on Sirri Island \nSirri Island Sector - Grid BP56",
	}			
	OperationSnowfox_AG[12] = {
		TargetName = "Sirri Island - AAA 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets on Sirri Island \nSirri Island Sector - Grid BP56",
	}			
	OperationSnowfox_AG[13] = {
		TargetName = "Sirri Island - Cargo Ships 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Cargo Ships docked at Sirri Island \nSirri Island Sector - Grid BP56",
	}			
	OperationSnowfox_AG[14] = {
		TargetName = "Sirri Island - Command 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Command Convoy located on Sirri Island \nSirri Island Sector - Grid BP56",
	}			
	OperationSnowfox_AG[15] = {
		TargetName = "Sirri Island - Comms",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower on Sirri Island \nSirri Island Sector - Grid BP56",
	}
	OperationSnowfox_AG[16] = {
		TargetName = "Sirri Island - Navy 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Naval Vessels North-West of Sirri Island \nSirri Island Sector - Grid BP38",
	}
	OperationSnowfox_AG[17] = {
		TargetName = "Sirri Island - Cargo Ships 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Cargo Ships South-East of Sirri Island \nSirri Island Sector - Grid BP65",
	}
	OperationSnowfox_AG[18] = {
		TargetName = "Sirri Island - Oil Processing",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Oil Processing Facility on Sirri Island \nSirri Island Sector - Grid BP56",
	}
	OperationSnowfox_AG[19] = {
		TargetName = "Sirri Island - Oil Refinery",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Oil Refinery Facility on Sirri Island \nSirri Island Sector - Grid BP56",
	}
	OperationSnowfox_AG[20] = {
		TargetName = "Sirri Island - Supply 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Supply Trucks on Sirri Island \nSirri Island Sector - Grid BP56",
	}	
	--TUNB ISLAND
	OperationSnowfox_AG[21] = {
		TargetName = "Tunb Island - AAA 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets on Tunb Island \nTunb Islands Sector - Grid CQ30",
	}
	OperationSnowfox_AG[22] = {
		TargetName = "Tunb Island - Artillery 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Western Artillery on Tunb Island \nTunb Islands Sector - Grid CQ30",
	}
	OperationSnowfox_AG[23] = {
		TargetName = "Tunb Island - Artillery 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Northern Artillery on Tunb Island \nTunb Islands Sector - Grid CQ30",
	}
	OperationSnowfox_AG[24] = {
		TargetName = "Tunb Island - Comms",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower On Tunb Island \nTunb Islands Sector - Grid CQ30",
	}
	OperationSnowfox_AG[25] = {
		TargetName = "Tunb Island - Navy 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Armed Speedboats docked at Tunb Island \nTunb Islands Sector - Grid CQ30",
	}
	OperationSnowfox_AG[26] = {
		TargetName = "Tunb Island - SAM 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Mobile SAM on Tunb Island \nTunb Islands Sector - Grid CQ30",
	}
	--TUNB KOCHAK
	OperationSnowfox_AG[27] = {
		TargetName = "Tunb Kochak - AAA 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the AAA assets on Tunb Kochak \nTunb Islands Sector - Grid CQ10",
	}
	OperationSnowfox_AG[28] = {
		TargetName = "Tunb Kochak - Artillery 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Central Artillery on Tunb Kochak \nTunb Islands Sector - Grid CQ10",
	}
	OperationSnowfox_AG[29] = {
		TargetName = "Tunb Kochak - Comms",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower on Tunb Kochak \nTunb Islands Sector - Grid CQ10",
	}
	OperationSnowfox_AG[30] = {
		TargetName = "Tunb Kochak - SAM 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Mobile SAM on Tunb Kochak \nTunb Islands Sector - Grid CQ10",
	}
	--BANDAR LENGEH	
	OperationSnowfox_AG[31] = {
		TargetName = "Bandar Lengeh - AAA 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets North-East of Bandar Lengeh \nBandar Lengeh Sector - Grid BQ94",
	}
	OperationSnowfox_AG[32] = {
		TargetName = "Bandar Lengeh - Artillery 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Artillery North-East of Bandar Lengeh \nBandar Lengeh Sector - Grid BQ94",
	}
	OperationSnowfox_AG[33] = {
		TargetName = "Bandar Lengeh - SAM 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Mobile SAM North-East of Bandar Lengeh \nBandar Lengeh Sector - Grid BQ94",
	}
	OperationSnowfox_AG[34] = {
		TargetName = "Bandar Lengeh - Supply 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy supply trucks supporting SA-11 site South-West of Bandar Lengeh \nBandar Lengeh Sector - Grid BQ73",
	}
	OperationSnowfox_AG[35] = {
		TargetName = "Bandar Lengeh - Supply 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy supply trucks North-East of Bandar Lengeh \nBandar Lengeh Sector - Grid BQ94",
	}
	OperationSnowfox_AG[36] = {
		TargetName = "Bandar Lengeh - Navy 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Naval Vessels South of Bandar Lengeh \nBandar Lengeh Sector - Grid BQ71",
	}
	OperationSnowfox_AG[37] = {
		TargetName = "Bandar Lengeh - Cargo Ships 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Cargo Ships docked at Bandar Lengeh \nBandar Lengeh Sector - Grid BQ83",
	}
	OperationSnowfox_AG[38] = {
		TargetName = "Bandar Lengeh - Armor 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy T-55 Tanks North-East of Bandar Lengeh \nBandar Lengeh Sector - Grid BQ94",
	}
	OperationSnowfox_AG[39] = {
		TargetName = "Bandar Lengeh - Armor 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy APC's North-East of Bandar Lengeh \nBandar Lengeh Sector - Grid BQ94",
	}
	--////Major SAM Site
	OperationSnowfox_AG[40] = {
		TargetName = "Bandar Lengeh - SA-11",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-11 SAM site South-West of Bandar Lengeh \nBandar Lengeh Sector - Grid BQ73",
	}	
	--////QESHM ISLAND
	OperationSnowfox_AG[41] = {
		TargetName = "Qeshm Island - AAA 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets on Qeshm Island \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[42] = {
		TargetName = "Qeshm Island - Drone Control Tower",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The Drone Control Tower on Qeshm Island \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[43] = {
		TargetName = "Qeshm Island - Drone Hangar",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The Drone Hangar on Qeshm Island \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[44] = {
		TargetName = "Qeshm Island - Mobile Radar",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The Mobile Radar on Qeshm Island \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[45] = {
		TargetName = "Qeshm Island - Navy 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Submarines docked at Qeshm Island \nQeshm Island Sector - Grid CQ95",
	}	
	OperationSnowfox_AG[46] = {
		TargetName = "Qeshm Island - Navy 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Armed Speedboats docked at Qeshm Island \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[47] = {
		TargetName = "Qeshm Island - SAM 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The Mobile SAM on Qeshm Island \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[48] = {
		TargetName = "Qeshm Island - Transport Plane 1",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The Transport Plane being loaded at Qeshm Island airfield \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[49] = {
		TargetName = "Qeshm Island - Supply 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The Fuel Trucks at Qeshm Island airfield \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[50] = {
		TargetName = "Qeshm Island - Infantry 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The Infantry at Qeshm Island airfield \nQeshm Island Sector - Grid CQ95",
	}
	--////HAVADARYA
	OperationSnowfox_AG[51] = {
		TargetName = "Havadarya - Uranium Mine",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Uranium Mine West of Havadarya \nHavadarya Sector - Grid CQ99",
	}	
	OperationSnowfox_AG[52] = {
		TargetName = "Havadarya - AAA 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets protecting the Uranium Mine West of Havadarya \nHavadarya Sector - Grid CQ99",
	}
	OperationSnowfox_AG[53] = {
		TargetName = "Havadarya - Supply 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Supply Trucks stationed at the Uranium Mine West of Havadarya \nHavadarya Sector - Grid CQ99",
	}
	OperationSnowfox_AG[54] = {
		TargetName = "Havadarya - SAM 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Mobile SAM stationed at the Uranium Mine West of Havadarya \nHavadarya Sector - Grid CQ99",
	}
	OperationSnowfox_AG[55] = {
		TargetName = "Havadarya - AAA 3",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets protecting the Rajaei Port West of Havadarya \nHavadarya Sector - Grid DQ09",
	}	
	OperationSnowfox_AG[56] = {
		TargetName = "Havadarya - Navy 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Submarines docked at the Havadarya Naval Base \nHavadarya Sector - Grid DR20",
	}	
	OperationSnowfox_AG[57] = {
		TargetName = "Havadarya - Navy 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Naval Vessels docked at the Havadarya Naval Base \nHavadarya Sector - Grid DR20",
	}	
	OperationSnowfox_AG[58] = {
		TargetName = "Havadarya - Cargo Ships 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Cargo Ships docked at the Havadarya Port \nHavadarya Sector - Grid DR20",	
	}	
	OperationSnowfox_AG[59] = {
		TargetName = "Havadarya - AAA 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets protecting the Havadarya Naval Base \nHavadarya Sector - Grid DR20",	
	}	
	OperationSnowfox_AG[60] = {
		TargetName = "Havadarya - Silkworm 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Silkworm Site at the Havadarya Naval Base \nHavadarya Sector - Grid DR20",
	}
	OperationSnowfox_AG[61] = {
		TargetName = "Havadarya - Supply 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Supply Trucks at the HQ-2/SA-2 site at Havadarya \nHavadarya Sector - Grid DR10",
	}	
	--////Major SAM Site
	OperationSnowfox_AG[62] = {
		TargetName = "Havadarya - HQ-2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the HQ-2/SA-2 site at Havadarya \nHavadarya Sector - Grid DR10",
	}	
	--////BANDAR ABBAS
	OperationSnowfox_AG[63] = {
		TargetName = "Bandar Abbas - AAA 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets at Bandar Abbas \nBandar Abbas Sector - Grid DR30",
	}
	OperationSnowfox_AG[64] = {
		TargetName = "Bandar Abbas - Command 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Command Vehicles And Trucks at Bandar Abbas \nBandar Abbas Sector - Grid DR30",
	}
	OperationSnowfox_AG[65] = {
		TargetName = "Bandar Abbas - Military HQ",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Military HQ at Bandar Abbas \nBandar Abbas Sector - Grid DR30",
	}
	OperationSnowfox_AG[66] = {
		TargetName = "Bandar Abbas - SAM 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Mobile SAM at Bandar Abbas \nBandar Abbas Sector - Grid DR30",
	}
	OperationSnowfox_AG[67] = {
		TargetName = "Bandar Abbas - Supply 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Supply Trucks supporting the Hawk Site at Bandar Abbas \nBandar Abbas Sector - Grid DR31",
	}	
	OperationSnowfox_AG[68] = {
		TargetName = "Bandar Abbas - Supply 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Supply Trucks supporting the SA-5/SA-10 Site at Bandar Abbas \nBandar Abbas Sector - Grid DR31",	
	}
	--////Major SAM Site
	OperationSnowfox_AG[69] = {
		TargetName = "Bandar Abbas - Hawk",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Hawk Site at Bandar Abbas \nBandar Abbas Sector - Grid DR31",
	}
	--////Major SAM Site
	OperationSnowfox_AG[70] = {
		TargetName = "Bandar Abbas - SA-5",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-5/SA-10 Site at Bandar Abbas \nBandar Abbas Sector - Grid DR31",
	}
	--////LARAK ISLAND
	OperationSnowfox_AG[71] = {
		TargetName = "Larak Island - Communications",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower at Larak Island \nLarak Island Sector - Grid DQ37",
	}
	OperationSnowfox_AG[72] = {
		TargetName = "Larak Island - Silkworm 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Silkworm Site at Larak Island \nLarak Island Sector - Grid DQ36",
	}
	--////Seerik-Gerouk
	OperationSnowfox_AG[73] = {
		TargetName = "Seerik - AAA 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets at Seerik \nSeerik Sector - Grid EQ13",
	}	
	OperationSnowfox_AG[74] = {
		TargetName = "Seerik - Armor 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy T-72 Tanks at Seerik \nSeerik Sector - Grid EQ13",	
	}	
	OperationSnowfox_AG[75] = {
		TargetName = "Seerik - Artillery 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Artillery at Seerik \nSeerik Sector - Grid EQ13",
	}
	OperationSnowfox_AG[76] = {
		TargetName = "Seerik - SAM 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Mobile SAM at Seerik \nSeerik Sector - Grid EQ13",
	}
	OperationSnowfox_AG[77] = {
		TargetName = "Seerik - Supply 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Supply Trucks at Seerik \nSeerik Sector - Grid EQ13",
	}
	OperationSnowfox_AG[78] = {
		TargetName = "Seerik - Silkworm 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Silkworm Site North of Seerik \nSeerik Sector - Grid EQ04",
	}
	OperationSnowfox_AG[79] = {
		TargetName = "Seerik - Supply 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Supply Trucks at the Gerouk Khordad/SA-10 Site North of Seerik \nSeerik Sector - Grid EQ05",
	}
	OperationSnowfox_AG[80] = {
		TargetName = "Seerik - AAA 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets protecting the Gerouk Khordad/SA-10 Site North of Seerik \nSeerik Sector - Grid EQ05",
	}
	--////Major SAM Site
	OperationSnowfox_AG[81] = {
		TargetName = "Seerik - Khordad",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Gerouk Khordad/SA-10 Site North of Seerik \nSeerik Sector - Grid EQ05",
	}
	--////BANDAR-E-JASK
	OperationSnowfox_AG[82] = {
		TargetName = "Jask - AAA 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the AAA assets at Bandar-e-Jask \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[83] = {
		TargetName = "Jask - Cargo Ships 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Cargo Ships docked at Bandar-e-Jask Port \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[84] = {
		TargetName = "Jask - Navy 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Naval Vessels docked at Bandar-e-Jask Port \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[85] = {
		TargetName = "Jask - SAM 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Mobile SAM at Bandar-e-Jask \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[86] = {
		TargetName = "Jask - Supply 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Supply Trucks at Bandar-e-Jask \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[87] = {
		TargetName = "Jask - Trucks 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Supply Trucks at Bandar-e-Jask Port \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[88] = {
		TargetName = "Jask - Armor 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the T-72 Tanks at Bandar-e-Jask \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[89] = {
		TargetName = "Jask - Command 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Command Convoy at Bandar-e-Jask airfield \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[90] = {
		TargetName = "Jask - Comms",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower at Bandar-e-Jask \nBandar-e-Jask Sector - Grid EP73",
	}
	--////MINAB
	OperationSnowfox_AG[91] = {
		TargetName = "Minab - AAA 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets at Minab Dam \nMinab Sector - Grid ER10",
	}	
	OperationSnowfox_AG[92] = {
		TargetName = "Minab - SAM 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Mobile SAM at Minab Dam \nMinab Sector - Grid ER10",
	}
	OperationSnowfox_AG[93] = {
		TargetName = "Minab - Supply 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Supply Trucks at Minab Dam \nMinab Sector - Grid ER10",
	}
	OperationSnowfox_AG[94] = {
		TargetName = "Minab - Infantry 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Anti-Air Infantry at Minab Dam \nMinab Sector - Grid ER10",
	}
	OperationSnowfox_AG[95] = {
		TargetName = "Minab - Armor 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the BMP's at Minab Dam \nMinab Sector - Grid ER10",
	}
	OperationSnowfox_AG[96] = {
		TargetName = "Minab - AAA 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets at the Minab Drone Base \nMinab Sector - Grid EQ09",
	}	
	OperationSnowfox_AG[97] = {
		TargetName = "Minab - Comms",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower South-East of the Minab Drone Base \nMinab Sector - Grid EQ09",	
	}
	OperationSnowfox_AG[98] = {
		TargetName = "Minab - Drone Hangar",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Drone Hangar at the Minab Drone Base \nMinab Sector - Grid EQ09",
	}
	OperationSnowfox_AG[99] = {
		TargetName = "Minab - Drone Control Tower",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Drone Control Tower at the Minab Drone Base \nMinab Sector - Grid EQ09",
	}
	OperationSnowfox_AG[100] = {
		TargetName = "Minab - Transport 1",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Transport Helicopter at the Minab Drone Base \nMinab Sector - Grid EQ09",
	}
	--////Expanded Mission List 1
	OperationSnowfox_AG[101] = {
		TargetName = "Qeshm Island - Naval Warehouse",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Warehouse at the Qeshm Island Naval Base \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[102] = {
		TargetName = "Bandar Lengeh - Boat Bunker",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Boat Bunker at Bandar Lengeh \nBandar Lengeh Sector - Grid BQ83",
	}	
	OperationSnowfox_AG[103] = {
		TargetName = "Bandar Lengeh - Navy 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Armed Speedboats at Bandar Lengeh \nBandar Lengeh Sector - Grid BQ83",	
	}
	OperationSnowfox_AG[104] = {
		TargetName = "Bandar Abbas - Missile Bunker 1",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Western Missile Bunker at the Bandar Abbas Underground Missile Facility\nBandar Abbas Sector - Grid DR22",
	}
	OperationSnowfox_AG[105] = {
		TargetName = "Bandar Abbas - Missile Bunker 2",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Eastern Missile Bunker at the Bandar Abbas Underground Missile Facility\nBandar Abbas Sector - Grid DR22",
	}
	OperationSnowfox_AG[106] = {
		TargetName = "Bandar Abbas - Missile Barracks",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Missile Barracks at the Bandar Abbas Underground Missile Facility\nBandar Abbas Sector - Grid DR22",
	}	
	OperationSnowfox_AG[107] = {
		TargetName = "Bandar Abbas - Munitions Storage",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Munitions Storage at the Bandar Abbas Underground Missile Facility\nBandar Abbas Sector - Grid DR22",
	}
	OperationSnowfox_AG[108] = {
		TargetName = "Bandar Abbas - Road Outpost",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Road Outpost near the Bandar Abbas Underground Missile Facility \nBandar Abbas Sector - Grid DR22",
	}
	OperationSnowfox_AG[109] = {
		TargetName = "Bandar Abbas - Infantry 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Infantry at the Road Outpost near the Bandar Abbas Underground Missile Facility \nBandar Abbas Sector - Grid DR22",
	}	
	OperationSnowfox_AG[110] = {
		TargetName = "Bandar Abbas - SAM 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Mobile SAM at the Bandar Abbas Underground Missile Facility\nBandar Abbas Sector - Grid DR22",	
	}
	OperationSnowfox_AG[111] = {
		TargetName = "Bandar Abbas - AAA 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the AAA assets at the Bandar Abbas Underground Missile Facility\nBandar Abbas Sector - Grid DR22",
	}
	OperationSnowfox_AG[112] = {
		TargetName = "Bandar Abbas - AAA 3",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the AAA assets at the Bandar Abbas Underground Missile Facility\nBandar Abbas Sector - Grid DR22",
	}	
	OperationSnowfox_AG[113] = {
		TargetName = "Tunb Kochak - Artillery 2",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Northern Artillery on Tunb Kochak\nTunb Islands Sector - Grid CQ10",
	}
	OperationSnowfox_AG[114] = {
		TargetName = "Qeshm Island - Power Plant 1",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Power Plant Facility South of Dargahan\nQeshm Island Sector - Grid DQ08",
	}
	OperationSnowfox_AG[115] = {
		TargetName = "Bandar Lengeh - Power Plant",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Power Plant Facility North-West of Kang\nBandar Lengeh Sector - Grid BQ94",
	}
	OperationSnowfox_AG[116] = {
		TargetName = "Bandar Abbas - Power Plant West",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Western Power Plant Facility at Bandar Abbas\nBandar Abbas Sector - Grid DR20",
	}
	OperationSnowfox_AG[117] = {
		TargetName = "Bandar Abbas - Power Plant East",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Eastern Power Plant Facility at Bandar Abbas\nBandar Abbas Sector - Grid DR31",
	}
	OperationSnowfox_AG[118] = {
		TargetName = "Qeshm Island - Power Plant 2",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Power Plant Facility at Bandar Khamir\nQeshm Island Sector - Grid CQ68",	
	}
	OperationSnowfox_AG[119] = {
		TargetName = "Bandar Abbas - Military Base",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Military Base Barracks at Bandar Abbas\nBandar Abbas Sector - Grid DR31",	
	}
	OperationSnowfox_AG[120] = {
		TargetName = "Bandar Abbas - Supply 3",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Supply Trucks at the Military Base Barracks at Bandar Abbas\nBandar Abbas Sector - Grid DR31",
	}
	--////Expanded Mission List 2
	OperationSnowfox_AG[121] = {
		TargetName = "Bandar Lengeh - EWR Bandar Lengeh",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Early Warning Radar at Bandar Lengeh\nBandar Lengeh Sector - Grid BQ83",
	}
	OperationSnowfox_AG[122] = {
		TargetName = "Havadarya - EWR Tazeyan-e Zir",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Early Warning Radar North of Tazeyan-e Zir\nHavadarya Sector - Grid DR13",
	}
	OperationSnowfox_AG[123] = {
		TargetName = "Havadarya - EWR Havadarya",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Early Warning Radar at Havadarya\nHavadarya Sector - Grid DR20",
	}
	OperationSnowfox_AG[124] = {
		TargetName = "Bandar Lengeh - EWR Kish",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Early Warning Radar on Kish Island\nBandar Lengeh Sector - Grid YK93",
	}
	OperationSnowfox_AG[125] = {
		TargetName = "Jask - EWR Jask",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Early Warning Radar at Bandar-e-Jask\nBandar-e-Jask Sector - Grid EP73",
	}
	--////Expanded Mission List 3
	OperationSnowfox_AG[126] = {
		TargetName = "Bandar Abbas - Scud 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Scud Launchers at the Bandar Abbas Underground Missile Facility\nBandar Abbas Sector - Grid DR22",
	}
	OperationSnowfox_AG[127] = {
		TargetName = "Jask - Scud 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Scud Launchers North-East of Bandar-e-Jask airfield\nBandar-e-Jask Sector - Grid EP84",
	}
	OperationSnowfox_AG[128] = {
		TargetName = "Havadarya - Scud 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Scud Launchers located at Havadarya\nHavadarya Sector - Grid DR10",
	}
	OperationSnowfox_AG[129] = {
		TargetName = "Minab - Scud 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Scud Launchers located at Minab\nMinab Sector - Grid ER00",
	}
	OperationSnowfox_AG[130] = {
		TargetName = "Seerik - Navy 1",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Naval Vessels located North-West of Seerik\nSeerik Sector - Grid DQ94",
	}		
	
	--Debug Code
	--[[
	trigger.action.outText("Target 1 Name: "..OperationSnowfox_AG[1].TargetName, 15)
	trigger.action.outText("Target 1 Type: "..OperationSnowfox_AG[1].TargetType, 15)
	trigger.action.outText(OperationSnowfox_AG[1].TargetBriefing, 15)
	
	OperationSnowfox_AG[1] = {}
	OperationSnowfox_AG[1][1] = "Test Sector - Supply 1"
	OperationSnowfox_AG[1][2] = "Unit"
	trigger.action.outText("Target 1 Name: "..OperationSnowfox_AG[1][1], 15)
	trigger.action.outText("Target 1 Type: "..OperationSnowfox_AG[1][2], 15)
	]]--
end

--////End Mission Target Table
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////ON DEMAND MISSION INFORMATION

local function CheckObjectiveRequest()
	
	if ( AGMissionBriefingText ~= nil ) then
		trigger.action.outText(AGMissionBriefingText, 15)
		trigger.action.outSound('That Is Our Target.ogg')
	elseif ( OperationComplete == true ) then
		trigger.action.outText("The Operation Has Been Completed, There Are No Further Objectives", 15)
	elseif ( AGMissionBriefingText == nil and OperationComplete == false ) then
		trigger.action.outText("Check Objective Request Error - No Briefing Available And Operation Is Not Completed", 15)
	else
		trigger.action.outText("Check Objective Request Error - Unexpected Result Occured", 15)
	end	
end

function TargetReport()
			
	if (AGTargetTypeStatic == false and AGMissionTarget ~=nil) then
		TargetGroup = GROUP:FindByName(AGMissionTarget)	
		
		if (GROUP:FindByName(AGMissionTarget):IsAlive() == true) then
		
			TargetRemainingUnits = Group.getByName(AGMissionTarget):getSize()	
			
			MissionPlayersBlue = SET_CLIENT:New():FilterCoalitions("blue"):FilterActive():FilterOnce()
			
			MissionPlayersBlue:ForEachClient(
				function(Client)
					if Client:IsAlive() == true then
						ClientPlayerName = Client:GetPlayerName()	  
						ClientUnitName = Client:GetName()			  
						ClientGroupName = Client:GetClientGroupName() 			
						ClientGroupID = Client:GetClientGroupID()	   	
				
						PlayerUnit = UNIT:FindByName(ClientUnitName)		
					
						PlayerCoord = PlayerUnit:GetCoordinate()
						TargetCoord = TargetGroup:GetCoordinate()
						TargetHeight = math.floor(TargetGroup:GetCoordinate():GetLandHeight() * 100)/100
						TargetHeightFt = math.floor(TargetHeight * 3.28084)
						PlayerDistance = PlayerCoord:Get2DDistance(TargetCoord)

						TargetVector = PlayerCoord:GetDirectionVec3(TargetCoord)
						TargetBearing = PlayerCoord:GetAngleRadians (TargetVector)	
					
						PlayerBR = PlayerCoord:GetBRText(TargetBearing, PlayerDistance, SETTINGS:SetImperial())
					
						--List the amount of units remaining in the group
						if (TargetRemainingUnits > 1) then
							SZMessage = "There are "..TargetRemainingUnits.." targets remaining for this mission" 
						elseif (TargetRemainingUnits == 1) then
							SZMessage = "There is "..TargetRemainingUnits.." target remaining for this mission" 
						elseif (TargetRemainingUnits == nil) then					
							SZMessage = "Unable To Determine Group Size"
						else			
							SZMessage = "Nothing to report"		
						end		
					
						BRMessage = "Target bearing "..PlayerBR
						ELEMessage = "Elevation "..TargetHeight.."m".." / "..TargetHeightFt.."ft"
					
						_SETTINGS:SetLL_Accuracy(0)
						CoordStringLLDMS = TargetCoord:ToStringLLDMS(SETTINGS:SetImperial())
						_SETTINGS:SetLL_Accuracy(3)
						CoordStringLLDDM = TargetCoord:ToStringLLDDM(SETTINGS:SetImperial())
						_SETTINGS:SetLL_Accuracy(2)
						CoordStringLLDMSDS = TargetCoord:ToStringLLDMSDS(SETTINGS:SetImperial())
						
						trigger.action.outTextForGroup(ClientGroupID, "Target Report For "..ClientPlayerName.."\n".."\n"..AGMissionBriefingText.."\n"..BRMessage.."\n"..SZMessage.."\n"..CoordStringLLDMS.."\n"..CoordStringLLDDM.."\n"..CoordStringLLDMSDS.."\n"..ELEMessage, 30)							
					else						
					end				
				end
			)
		else
			trigger.action.outText("Target Report Unavailable", 15)
		end
		
	elseif (AGTargetTypeStatic == true and AGMissionTarget ~=nil) then
		TargetGroup = STATIC:FindByName(AGMissionTarget, false)
		
		MissionPlayersBlue = SET_CLIENT:New():FilterCoalitions("blue"):FilterActive():FilterOnce()

		MissionPlayersBlue:ForEachClient(
			function(Client)
				if Client:IsAlive() == true then
					ClientPlayerName = Client:GetPlayerName()	
					ClientUnitName = Client:GetName()			
					ClientGroupName = Client:GetClientGroupName()				
					ClientGroupID = Client:GetClientGroupID()
				
					PlayerUnit = UNIT:FindByName(ClientUnitName)		
					
					PlayerCoord = PlayerUnit:GetCoordinate()
					TargetCoord = TargetGroup:GetCoordinate()
					TargetHeight = math.floor(TargetGroup:GetCoordinate():GetLandHeight() * 100)/100
					TargetHeightFt = math.floor(TargetHeight * 3.28084)
					PlayerDistance = PlayerCoord:Get2DDistance(TargetCoord)
					
					TargetVector = PlayerCoord:GetDirectionVec3(TargetCoord)
					TargetBearing = PlayerCoord:GetAngleRadians (TargetVector)	
										
					PlayerBR = PlayerCoord:GetBRText(TargetBearing, PlayerDistance, SETTINGS:SetImperial())

					BRMessage = "Target bearing "..PlayerBR
					ELEMessage = "Elevation "..TargetHeight.."m".." / "..TargetHeightFt.."ft"
					
					_SETTINGS:SetLL_Accuracy(0)
					CoordStringLLDMS = TargetCoord:ToStringLLDMS(SETTINGS:SetImperial())
					_SETTINGS:SetLL_Accuracy(3)
					CoordStringLLDDM = TargetCoord:ToStringLLDDM(SETTINGS:SetImperial())
					_SETTINGS:SetLL_Accuracy(2)
					CoordStringLLDMSDS = TargetCoord:ToStringLLDMSDS(SETTINGS:SetImperial())
					
					trigger.action.outTextForGroup(ClientGroupID, "Target Report For "..ClientPlayerName.."\n".."\n"..AGMissionBriefingText.."\n"..BRMessage.."\n"..CoordStringLLDMS.."\n"..CoordStringLLDDM.."\n"..CoordStringLLDMSDS.."\n"..ELEMessage, 30)							
				else
				end				
			end
		)		
	elseif ( OperationComplete == true ) then
		trigger.action.outText("The Operation Has Been Completed, There Are No Further Targets", 15)	
	else
		trigger.action.outText("No Target Information Available", 15)
	end
end
--////End On Demand Mission Information
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////AI SUPPORT FLIGHT FUNCTIONS

--[[

SQ BLUE SEAD F-16C
SQ BLUE CAS A-10C
SQ BLUE ASS AJS37
SQ BLUE CAP F-15C

Flags

5001 = Fighter Screen Enabled
5002 = Close Air Support Enabled
5003 = Anti-Ship Strike Enabled
5004 = SEAD Enabled
5005 = Pinpoint Strike Enabled
5891 = Drone JTAC Enabled

5010 = true if Fighter Screen active
5020 = true if Close Air Support is active
5030 = true if Anti Ship Strike is active
5040 = true if SEAD Mission is active
5050 = true if Pinpoint Strike Mission is active
5892 - true if Drone support is active

5011 = Fighter Screen Push Command
5021 = Close Air Support Push Command
5031 = Anti Ship Push Command
5041 = SEAD Mission Push Command
5051 = Pinpoint Strike Push Command

]]--

--////COMBAT AIR PATROL FIGHTER SCREEN
function RequestFighterSupport(CAPSector)
	
	if ( trigger.misc.getUserFlag(5001) == 1 ) then	
		if ( trigger.misc.getUserFlag(5010) == 0 ) then
			
			local RouteNumber = CAPSector
			
			BLUECAP1 = SPAWN
				:New( "RT BLUE CAP "..RouteNumber )
				:InitLimit( 2, 2 )
				:InitRandomizeTemplate( { "SQ BLUE CAP F-15C" } )
				:OnSpawnGroup(
					function( SpawnGroup )								
						RTBLUECAPGROUPNAME = SpawnGroup.GroupName
						RTBLUECAPGROUPID = Group.getByName(RTBLUECAPGROUPNAME):getID()												
					end
				)				
				:Spawn()
			
			trigger.action.outText("Fighter Screen Launched",60)
			--Set flag 5010 to 1
			trigger.action.setUserFlag(5010,1)	
			
		elseif ( trigger.misc.getUserFlag(5010) == 1) then
			--Check if the spawned Fighter Screen group is still alive or not
						
			if ( BLUECAP1:IsAlive() ) then
				trigger.action.outText("Fighter Screen Is Currently Active, Further Support Is Unavailable",60)
			else
				trigger.action.setUserFlag(5010,0)
				RequestFighterSupport(CAPSector)
			end			
		else			
		end
	else
		trigger.action.outText("Fighter Screen Unavailable For This Mission",60)		
	end
end

function AbortCAPMission()

	if (trigger.misc.getUserFlag(5010) == 1 ) then
		if ( GROUP:FindByName(RTBLUECAPGROUPNAME):IsAlive() ) then
			--If Alive, Perform RTB command
			local RTB = {}
			--RTB.fromWaypointIndex = 2
			RTB.goToWaypointIndex = 6
								
			local RTBTask = {id = 'SwitchWaypoint', params = RTB}
			Group.getByName(RTBLUECAPGROUPNAME):getController():setOption(0, 3)
			Group.getByName(RTBLUECAPGROUPNAME):getController():setCommand(RTBTask)	
			
			trigger.action.outText("Fighter Screen Is Returning To Base",60)
		else
			trigger.action.outText("Fighter Screen Does Not Have Fighters To Recall",60)
		end
	else
		trigger.action.outText("Fighter Screen Has Not Been Deployed",60)
	end
end

--////CLOSE AIR SUPPORT
function RequestCASSupport(CASSector)

	if ( trigger.misc.getUserFlag(5002) == 1 ) then
		if ( trigger.misc.getUserFlag(5020) == 0 ) then

			local RouteNumber = CASSector
			
			BLUECAS1 = SPAWN
				:New( "RT BLUE CAS "..RouteNumber )
				:InitLimit( 2, 2 )
				:InitRandomizeTemplate( { "SQ BLUE CAS A-10C" } )
				:OnSpawnGroup(
					function( SpawnGroup )								
						RTBLUECASGROUPNAME = SpawnGroup.GroupName
						RTBLUECASGROUPID = Group.getByName(RTBLUECASGROUPNAME):getID()												
					end
				)
				:Spawn()
			
			trigger.action.outText("Close Air Support Launched",60)
			--Set flag 5020 to 1
			trigger.action.setUserFlag(5020,1)	
			
		elseif ( trigger.misc.getUserFlag(5020) == 1) then
			--Check if the spawned Close Air Support group is still alive or not
			
			if ( BLUECAS1:IsAlive() ) then
				trigger.action.outText("Close Air Support Is Currently Active, Further Support Is Unavailable",60)
			else				
				trigger.action.setUserFlag(5020,0)
				RequestCASSupport(CASSector)
			end		
		else			
		end
	else
		trigger.action.outText("Close Air Support Unavailable For This Mission",60)
	end	
end

function AbortCASMission()

	if ( trigger.misc.getUserFlag(5020) == 1 ) then
		if ( GROUP:FindByName(RTBLUECASGROUPNAME):IsAlive() ) then
			--If Alive, Perform RTB command
			local RTB = {}
			--RTB.fromWaypointIndex = 2
			RTB.goToWaypointIndex = 5
								
			local RTBTask = {id = 'SwitchWaypoint', params = RTB}			
			Group.getByName(RTBLUECASGROUPNAME):getController():setOption(0, 3) -- (0, 4) is weapons hold, (0, 3) is return fire
			Group.getByName(RTBLUECASGROUPNAME):getController():setCommand(RTBTask)	
			
			trigger.action.outText("Close Air Support Is Returning To Base",60)
		else
			trigger.action.outText("Close Air Support Does Not Have Planes To Recall",60)
		end
	else
		trigger.action.outText("Close Air Support Has Not Been Deployed",60)
	end
end

--////ANTI-SHIPPING
function RequestASSSupport(ASSSector)
	
	if ( trigger.misc.getUserFlag(5003) == 1 ) then	
		if ( trigger.misc.getUserFlag(5030) == 0 ) then
			
			local RouteNumber = ASSSector
			
			BLUEASS1 = SPAWN
				:New( "RT BLUE ASS "..RouteNumber )
				:InitLimit( 2, 2 )
				:InitRandomizeTemplate( { "SQ BLUE ASS AJS37" } ) --"SQ BLUE ASS AJS37", "SQ BLUE ASS F/A-18C"
				:OnSpawnGroup(
					function( SpawnGroup )								
						RTBLUEASSGROUPNAME = SpawnGroup.GroupName
						RTBLUEASSGROUPID = Group.getByName(RTBLUEASSGROUPNAME):getID()												
					end
				)
				:Spawn()					
			
			trigger.action.outText("Anti-Shipping Strike Launched",60)
			--Set flag 5030 to 1
			trigger.action.setUserFlag(5030,1)		
			
		elseif ( trigger.misc.getUserFlag(5030) == 1) then
			--Check if the spawned Anti-Shipping group is still alive or not
			
			if ( BLUEASS1:IsAlive() ) then
				trigger.action.outText("Anti-Shipping Is Currently Active, Further Support Is Unavailable",60)
			else
				trigger.action.setUserFlag(5030,0)
				RequestASSSupport(ASSSector)
			end		
		else			
		end
	else
		trigger.action.outText("Anti-Shipping Strike Unavailable For This Mission",60)	
	end	
end

function AbortASSMission()

	if ( trigger.misc.getUserFlag(5030) == 1 ) then
		if ( GROUP:FindByName(RTBLUEASSGROUPNAME):IsAlive() ) then
			--If Alive, Perform RTB command
			local RTB = {}
			--RTB.fromWaypointIndex = 2
			RTB.goToWaypointIndex = 7
								
			local RTBTask = {id = 'SwitchWaypoint', params = RTB}
			Group.getByName(RTBLUEASSGROUPNAME):getController():setOption(0, 3)
			Group.getByName(RTBLUEASSGROUPNAME):getController():setCommand(RTBTask)	
			
			trigger.action.outText("Anti-Shipping Support Is Returning To Base",60)
		else
			trigger.action.outText("Anti-Shipping Support Does Not Have Planes To Recall",60)
		end
	else
		trigger.action.outText("Anti-Shipping Support Has Not Been Deployed",60)
	end
end

--////SEAD
function RequestSEADSupport(SEADSector)
	
	if ( trigger.misc.getUserFlag(5004) == 1 ) then
		if ( trigger.misc.getUserFlag(5040) == 0 ) then
			
			local RouteNumber = SEADSector
			
			BLUESEAD1 = SPAWN
				:New( "RT BLUE SEAD "..RouteNumber )
				:InitLimit( 2, 2 )
				:InitRandomizeTemplate( { "SQ BLUE SEAD F-16C", "SQ BLUE SEAD F/A-18C" } )
				:OnSpawnGroup(
					function( SpawnGroup )								
						RTBLUESEADGROUPNAME = SpawnGroup.GroupName
						RTBLUESEADGROUPID = Group.getByName(RTBLUESEADGROUPNAME):getID()	
												
					end
				)
				:Spawn()
			
			trigger.action.outText("SEAD Mission Launched",60)
			--Set flag 5040 to 1
			trigger.action.setUserFlag(5040,1)	
			
		elseif ( trigger.misc.getUserFlag(5040) == 1) then
			--Check if the spawned SEAD group is still alive or not
			
			if ( BLUESEAD1:IsAlive() ) then
				trigger.action.outText("SEAD Is Currently Active, Further Support Is Unavailable",60)
			else
				trigger.action.setUserFlag(5040,0)
				RequestSEADSupport(SEADSector)
			end		
		else			
		end
	else
		trigger.action.outText("SEAD Unavailable For This Mission",60)
	end		
end

function AbortSEADMission()

	if ( trigger.misc.getUserFlag(5040) == 1 ) then
		if ( GROUP:FindByName(RTBLUESEADGROUPNAME):IsAlive() ) then
			--If Alive, Perform RTB command
			local RTB = {}
			--RTB.fromWaypointIndex = 2
			RTB.goToWaypointIndex = 5
								
			local RTBTask = {id = 'SwitchWaypoint', params = RTB}
			Group.getByName(RTBLUESEADGROUPNAME):getController():setOption(0, 3)
			Group.getByName(RTBLUESEADGROUPNAME):getController():setCommand(RTBTask)	
			
			trigger.action.outText("SEAD Support Is Returning To Base",60)
		else
			trigger.action.outText("SEAD Support Does Not Have Planes To Recall",60)
		end
	else
		trigger.action.outText("SEAD Support Has Not Been Deployed",60)
	end
end


--////PINPOINT STRIKE
function RequestPINSupport(PinSector)
	
	if ( trigger.misc.getUserFlag(5005) == 1 ) then
		if ( trigger.misc.getUserFlag(5050) == 0 ) then
			
			PINRouteNumber = PinSector
			
			BLUEPIN1 = SPAWN
				:New( "RT BLUE PIN "..PINRouteNumber )
				:InitLimit( 2, 2 )
				:InitRandomizeTemplate( { "SQ BLUE PIN F-117A", "SQ BLUE PIN Tornado GR4", "SQ BLUE PIN F-15E" } )
				:OnSpawnGroup(
					function( SpawnGroup )								
						RTBLUEPINGROUPNAME = SpawnGroup.GroupName
						RTBLUEPINGROUPID = Group.getByName(RTBLUEPINGROUPNAME):getID()												
					end
				)
				:Spawn()
			
			trigger.action.outText("Pinpoint Strike Mission Launched",60)
			--Set flag 5050 to 1
			trigger.action.setUserFlag(5050,1)	
			
		elseif ( trigger.misc.getUserFlag(5050) == 1) then
			--Check if the spawned Pinpoint Strike group is still alive or not
			
			if ( BLUEPIN1:IsAlive() ) then
				trigger.action.outText("Pinpoint Strike Is Currently Active, Further Support Is Unavailable",60)
			else
				trigger.action.setUserFlag(5050,0)
				RequestPINSupport(PinSector)
			end		
		else			
		end
	else
		trigger.action.outText("Pinpoint Strike Unavailable For This Mission",60)
	end	
end

function AbortPINMission()

	if ( trigger.misc.getUserFlag(5050) == 1 ) then
		if ( GROUP:FindByName(RTBLUEPINGROUPNAME):IsAlive() ) then
			--If Alive, Perform RTB command
			local RTB = {}
			--RTB.fromWaypointIndex = 2
			RTB.goToWaypointIndex = 6
								
			local RTBTask = {id = 'SwitchWaypoint', params = RTB}
			Group.getByName(RTBLUEPINGROUPNAME):getController():setOption(0, 3)
			Group.getByName(RTBLUEPINGROUPNAME):getController():setCommand(RTBTask)	
			
			trigger.action.outText("Pinpoint Strike Support Is Returning To Base",60)
		else
			trigger.action.outText("Pinpoint Strike Support Does Not Have Planes To Recall",60)
		end
	else
		trigger.action.outText("Pinpoint Strike Support Has Not Been Deployed",60)
	end
end

function SEF_PinpointStrikeTargetAcquisition()
	
	--See https://wiki.hoggitworld.com/view/DCS_task_bombing for further details
	--CHECK TARGET IS IN THE SAME SECTOR THE FLIGHT WAS CALLED TO, GET DETAILS IF IT IS AND ABORT IF NOT
	if ( AGMissionTarget ~= nil and string.find(AGMissionTarget, PINRouteNumber) ) then		
		if ( AGTargetTypeStatic == true ) then
			if ( StaticObject.getByName(AGMissionTarget):isExist() == true ) then
				TargetGroupPIN = STATIC:FindByName(AGMissionTarget, false)
				TargetCoordForStrike = TargetGroupPIN:GetCoordinate():GetVec2()
					
				local target = {}
				target.point = TargetCoordForStrike
				target.expend = "Two"
				target.weaponType = 14
				target.attackQty = 1
				target.groupAttack = true
				local engage = {id = 'Bombing', params = target}
				Group.getByName(RTBLUEPINGROUPNAME):getController():pushTask(engage)
				trigger.action.outText("The Pinpoint Strike Flight Reports Target Coordinates Are Locked In And They Are Engaging!", 15)	
			else
				trigger.action.outText("Pinpoint Strike Mission Unable To Locate Target, Aborting Mission", 15)
				AbortPINMission()
			end
		elseif ( AGTargetTypeStatic == false ) then
			if ( GROUP:FindByName(AGMissionTarget):IsAlive() == true ) then
				TargetGroupPIN = GROUP:FindByName(AGMissionTarget, false)
				TargetCoordForStrike = TargetGroupPIN:GetCoordinate():GetVec2()
					
				local target = {}
				target.point = TargetCoordForStrike
				target.expend = "Two"
				target.weaponType = 14 -- See https://wiki.hoggitworld.com/view/DCS_enum_weapon_flag for other weapon launch codes
				target.attackQty = 1
				target.groupAttack = true
				local engage = {id = 'Bombing', params = target}
				Group.getByName(RTBLUEPINGROUPNAME):getController():pushTask(engage)
				trigger.action.outText("The Pinpoint Strike Flight Reports Target Coordinates Are Locked In And They Are Engaging!", 15)		
			else
				trigger.action.outText("Pinpoint Strike Mission Unable To Locate Target", 15)
				AbortPINMission()
			end
		else
			trigger.action.outText("Pinpoint Strike Mission Unable To Locate Target", 15)
			AbortPINMission()
		end
	else
		trigger.action.outText("The Pinpoint Strike Flight Reports The Mission Target Is Not In Their Designated Sector", 15)
		AbortPINMission()		
	end	
end

--////DRONE JTAC
function RequestDroneSupport(DRONESector)
	
	if ( trigger.misc.getUserFlag(5891) == 1 ) then	
		if ( trigger.misc.getUserFlag(5892) == 0 ) then
			
			local RouteNumber = DRONESector
			
			BLUEDRONE1 = SPAWN
				:New( "RT BLUE Drone "..RouteNumber )
				:InitLimit( 1, 1 )
				:InitRandomizeTemplate( { "SQ BLUE MQ-9 Reaper" } )
				:OnSpawnGroup(
					function( SpawnGroup )								
						RTBLUEDRONEGROUPNAME = SpawnGroup.GroupName
						RTBLUEDRONEGROUPID = Group.getByName(RTBLUEDRONEGROUPNAME):getID()												
					end
				)				
				:Spawn()
			
			trigger.action.outText("MQ-9 Reaper Aerial Drone Launched",60)
			--Set flag 5892 to 1
			trigger.action.setUserFlag(5892,1)	
			
		elseif ( trigger.misc.getUserFlag(5892) == 1) then
			--Check if the spawned drone is still alive or not
						
			if ( BLUEDRONE1:IsAlive() ) then
				trigger.action.outText("MQ-9 Reaper Aerial Drone Is Currently Active, Further Support Is Unavailable",60)
			else
				trigger.action.setUserFlag(5892,0)
				RequestDroneSupport(DRONESector)
			end			
		else			
		end
	else
		trigger.action.outText("MQ-9 Reaper Aerial Drone Unavailable For This Mission",60)		
	end
end

function AbortDroneMission()

	if (trigger.misc.getUserFlag(5892) == 1 ) then
		if ( GROUP:FindByName(RTBLUEDRONEGROUPNAME):IsAlive() ) then
			--If Alive, Perform RTB command
			local RTB = {}
			--RTB.fromWaypointIndex = 2
			RTB.goToWaypointIndex = 3
								
			local RTBTask = {id = 'SwitchWaypoint', params = RTB}
			Group.getByName(RTBLUEDRONEGROUPNAME):getController():setOption(0, 3)
			Group.getByName(RTBLUEDRONEGROUPNAME):getController():setCommand(RTBTask)	
			
			trigger.action.outText("MQ-9 Reaper Aerial Drone Is Returning To Base",60)
		else
			trigger.action.outText("MQ-9 Reaper Aerial Drone Is Unable To Be Recalled",60)
		end
	else
		trigger.action.outText("MQ-9 Reaper Aerial Drone Has Not Been Deployed",60)
	end
end

--////AI FLAG SWITCHES ETC
function SEF_CAPCommenceAttack()
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Fighter Screen Commence Attack", nil, function() trigger.action.setUserFlag(5011,1) end, nil)
	trigger.action.outText("Fighter Screen Push Command Available",60)
end

function SEF_CASCommenceAttack()
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Close Air Support Commence Attack", nil, function() trigger.action.setUserFlag(5021,1) end, nil)
	trigger.action.outText("Close Air Support Push Command Available",60)
end

function SEF_AntiShipCommenceAttack()
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Anti-Ship Strike Commence Attack", nil, function() trigger.action.setUserFlag(5031,1) end, nil)
	trigger.action.outText("Anti-Ship Strike Push Command Available",60)
end

function SEF_SEADCommenceAttack()
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "SEAD Commence Attack", nil, function() trigger.action.setUserFlag(5041,1) end, nil)
	trigger.action.outText("SEAD Push Command Available",60)
end

function SEF_PinpointStrikeCommenceAttack()
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Pinpoint Strike Commence Attack", nil, function() trigger.action.setUserFlag(5051,1) end, nil)
	trigger.action.outText("Pinpoint Strike Push Command Available",60)
end

function SEF_CAPRemovePush()
	missionCommands.removeItemForCoalition(coalition.side.BLUE, {[1] = nil, [2] = "Fighter Screen Commence Attack"})
	trigger.action.setUserFlag(5011,0)
end

function SEF_CASRemovePush()
	missionCommands.removeItemForCoalition(coalition.side.BLUE, {[1] = nil, [2] = "Close Air Support Commence Attack"})
	trigger.action.setUserFlag(5021,0)
end

function SEF_ASSRemovePush()
	missionCommands.removeItemForCoalition(coalition.side.BLUE, {[1] = nil, [2] = "Anti-Ship Strike Commence Attack"})
	trigger.action.setUserFlag(5031,0)
end

function SEF_SEADRemovePush()
	missionCommands.removeItemForCoalition(coalition.side.BLUE, {[1] = nil, [2] = "SEAD Commence Attack"})
	trigger.action.setUserFlag(5041,0)
end

function SEF_PINRemovePush()
	missionCommands.removeItemForCoalition(coalition.side.BLUE, {[1] = nil, [2] = "Pinpoint Strike Commence Attack"})
	trigger.action.setUserFlag(5051,0)
end

function SEF_CheckAIPushFlags( timeloop, time )	
	if ( trigger.misc.getUserFlag(5011) == 1 ) then
		timer.scheduleFunction(SEF_CAPRemovePush, 53, timer.getTime() + 1)
		return time + 2
	elseif ( trigger.misc.getUserFlag(5021) == 1 ) then
		timer.scheduleFunction(SEF_CASRemovePush, 53, timer.getTime() + 1)
		return time + 2
	elseif ( trigger.misc.getUserFlag(5031) == 1 ) then
		timer.scheduleFunction(SEF_ASSRemovePush, 53, timer.getTime() + 1)
		return time + 2
	elseif ( trigger.misc.getUserFlag(5041) == 1 ) then
		timer.scheduleFunction(SEF_SEADRemovePush, 53, timer.getTime() + 1)
		return time + 2
	elseif ( trigger.misc.getUserFlag(5051) == 1 ) then
		timer.scheduleFunction(SEF_PINRemovePush, 53, timer.getTime() + 1)
		return time + 2
	else
		return time + 2
	end
end

--////End Support Functions
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////Radio Menu 

function SEF_RadioMenuSetup()
	--////Set Up Menu
	-- table missionCommands.addSubMenuForCoalition(enum coalition.side, string name , table path)
	-- table missionCommands.addCommand(string name, table/nil path, function functionToRun , any anyArguement)
	-- table missionCommands.addCommandForCoalition(enum coalition.side, string name, table/nil path, function functionToRun , any anyArguement)

	--////Setup Submenu For Support Requests
	SupportMenuMain = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Request Support", nil)
	SupportMenuAbort = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Abort Directives", nil)
	SupportMenuCAP  = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Request Fighter Support", SupportMenuMain)
	SupportMenuCAS  = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Request Close Air Support", SupportMenuMain)
	SupportMenuSEAD = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Request SEAD Support", SupportMenuMain)
	SupportMenuASS = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Request Anti-Shipping Support", SupportMenuMain)
	SupportMenuPIN = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Request Pinpoint Strike", SupportMenuMain)
	SupportMenuDrone = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Request MQ-9 Reaper Drone", SupportMenuMain)
	
	--////Setup Menu Option To Get The Current Objective
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Check Current Objective", nil, function() CheckObjectiveRequest() end, nil)
	--////Target Report to get target numbers and coordinates 
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Target Report", nil, function() TargetReport() end, nil)
	--////Drop Smoke On The Target
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Smoke Current Objective", nil, function() SEF_TargetSmoke() end, nil)
	
	--////AI Support Flights Mission Abort Codes
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Abort Mission Fighter Screen", SupportMenuAbort, function() AbortCAPMission() end, nil)	
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Abort Mission Close Air Support", SupportMenuAbort, function() AbortCASMission() end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Abort Mission Anti-Shipping", SupportMenuAbort, function() AbortASSMission() end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Abort Mission SEAD", SupportMenuAbort, function() AbortSEADMission() end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Abort Mission Pinpoint Strike", SupportMenuAbort, function() AbortPINMission() end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Abort Mission MQ-9 Reaper Drone", SupportMenuAbort, function() AbortDroneMission() end, nil)	
	
	--////Snowfox Mission Options
	SnowfoxOptions = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Snowfox Options", nil)
	SnowfoxCAPOptions = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Snowfox CAP Options", SnowfoxOptions)
	SnowfoxSNDOptions = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Snowfox Sound Options", SnowfoxOptions)
	SnowfoxCAPKhasab = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Enable Khasab Vipers", SnowfoxCAPOptions, function() SEF_KhasabCAP() end, nil)
	SnowfoxFleetCats = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Enable Fleet Tomcats", SnowfoxCAPOptions, function() SEF_FleetTomcats() end, nil)
	SnowfoxFleetBugs = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Enable Fleet Hornets", SnowfoxCAPOptions, function() SEF_FleetHornets() end, nil)
	SnowfoxToggleFiringSounds = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Toggle Firing Sounds", SnowfoxSNDOptions, function() SEF_ToggleFiringSounds() end, nil)
	--SnowfoxDisableShips  = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Naval Ships AI Off", SnowfoxOptions, function() SEF_DisableShips() end, nil)
	SnowfoxDefenceCheck  = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Check Defence Networks", SnowfoxOptions, function() SEF_CheckDefenceNetwork() end, nil)
	SnowfoxAirfieldCheck  = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Check Airfield Status", SnowfoxOptions, function() SEF_CheckAirfieldStatus() end, nil)
	SnowfoxSkipScenario  = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Skip This Mission", SnowfoxOptions, function() SEF_SkipScenario() end, nil)	
	
	--////CAP Support Sector List
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Musa Island", SupportMenuCAP, function() RequestFighterSupport('Abu Musa') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sirri Island", SupportMenuCAP, function() RequestFighterSupport('Sirri') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Islands", SupportMenuCAP, function() RequestFighterSupport('Tunb') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Lengeh", SupportMenuCAP, function() RequestFighterSupport('Bandar Lengeh') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Larak Island", SupportMenuCAP, function() RequestFighterSupport('Larak') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Qeshm Island", SupportMenuCAP, function() RequestFighterSupport('Qeshm') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Havadarya", SupportMenuCAP, function() RequestFighterSupport('Havadarya') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Abbas", SupportMenuCAP, function() RequestFighterSupport('Bandar Abbas') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Minab", SupportMenuCAP, function() RequestFighterSupport('Minab') end, nil)
	
	SupportMenuCAP2 = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Other Sectors", SupportMenuCAP)
	
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Seerik", SupportMenuCAP2, function() RequestFighterSupport('Seerik') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar-e-Jask", SupportMenuCAP2, function() RequestFighterSupport('Jask') end, nil)
	
	--////CAS Support Sector List
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Musa Island", SupportMenuCAS, function() RequestCASSupport('Abu Musa') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sirri Island", SupportMenuCAS, function() RequestCASSupport('Sirri') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Islands", SupportMenuCAS, function() RequestCASSupport('Tunb') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Lengeh", SupportMenuCAS, function() RequestCASSupport('Bandar Lengeh') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Larak Island", SupportMenuCAS, function() RequestCASSupport('Larak') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Qeshm Island", SupportMenuCAS, function() RequestCASSupport('Qeshm') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Havadarya", SupportMenuCAS, function() RequestCASSupport('Havadarya') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Abbas", SupportMenuCAS, function() RequestCASSupport('Bandar Abbas') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Minab", SupportMenuCAS, function() RequestCASSupport('Minab') end, nil)
	
	SupportMenuCAS2 = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Other Sectors", SupportMenuCAS)
	
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Seerik", SupportMenuCAS2, function() RequestCASSupport('Seerik') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar-e-Jask", SupportMenuCAS2, function() RequestCASSupport('Jask') end, nil)
	
	--////SEAD Support Sector List
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Musa Island", SupportMenuSEAD, function() RequestSEADSupport('Abu Musa') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sirri Island", SupportMenuSEAD, function() RequestSEADSupport('Sirri') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Islands", SupportMenuSEAD, function() RequestSEADSupport('Tunb') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Lengeh", SupportMenuSEAD, function() RequestSEADSupport('Bandar Lengeh') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Larak Island", SupportMenuSEAD, function() RequestSEADSupport('Larak') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Qeshm Island", SupportMenuSEAD, function() RequestSEADSupport('Qeshm') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Havadarya", SupportMenuSEAD, function() RequestSEADSupport('Havadarya') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Abbas", SupportMenuSEAD, function() RequestSEADSupport('Bandar Abbas') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Minab", SupportMenuSEAD, function() RequestSEADSupport('Minab') end, nil)
	
	SupportMenuSEAD2 = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Other Sectors", SupportMenuSEAD)
	
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Seerik", SupportMenuSEAD2, function() RequestSEADSupport('Seerik') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar-e-Jask", SupportMenuSEAD2, function() RequestSEADSupport('Jask') end, nil)
	
	--////ANTI-SHIP Support Sector List
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Musa Island", SupportMenuASS, function() RequestASSSupport('Abu Musa') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sirri Island", SupportMenuASS, function() RequestASSSupport('Sirri') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Lengeh", SupportMenuASS, function() RequestASSSupport('Bandar Lengeh') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Qeshm Island", SupportMenuASS, function() RequestASSSupport('Qeshm') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Havadarya", SupportMenuASS, function() RequestASSSupport('Havadarya') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Seerik", SupportMenuASS, function() RequestASSSupport('Seerik') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar-e-Jask", SupportMenuASS, function() RequestASSSupport('Jask') end, nil)
	
	--////PIN Support Sector List
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Musa Island", SupportMenuPIN, function() RequestPINSupport('Abu Musa') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sirri Island", SupportMenuPIN, function() RequestPINSupport('Sirri') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Islands", SupportMenuPIN, function() RequestPINSupport('Tunb') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Lengeh", SupportMenuPIN, function() RequestPINSupport('Bandar Lengeh') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Larak Island", SupportMenuPIN, function() RequestPINSupport('Larak') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Qeshm Island", SupportMenuPIN, function() RequestPINSupport('Qeshm') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Havadarya", SupportMenuPIN, function() RequestPINSupport('Havadarya') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Abbas", SupportMenuPIN, function() RequestPINSupport('Bandar Abbas') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Minab", SupportMenuPIN, function() RequestPINSupport('Minab') end, nil)
	
	SupportMenuPIN2 = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Other Sectors", SupportMenuPIN)
	
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Seerik", SupportMenuPIN2, function() RequestPINSupport('Seerik') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar-e-Jask", SupportMenuPIN2, function() RequestPINSupport('Jask') end, nil)

	--////Drone Support Sector List
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Musa Island", SupportMenuDrone, function() RequestDroneSupport('Abu Musa') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sirri Island", SupportMenuDrone, function() RequestDroneSupport('Sirri') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Islands", SupportMenuDrone, function() RequestDroneSupport('Tunb') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Lengeh", SupportMenuDrone, function() RequestDroneSupport('Bandar Lengeh') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Larak Island", SupportMenuDrone, function() RequestDroneSupport('Larak') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Qeshm Island", SupportMenuDrone, function() RequestDroneSupport('Qeshm') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Havadarya", SupportMenuDrone, function() RequestDroneSupport('Havadarya') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Abbas", SupportMenuDrone, function() RequestDroneSupport('Bandar Abbas') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Minab", SupportMenuDrone, function() RequestDroneSupport('Minab') end, nil)
	
	SupportMenuDrone2 = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Other Sectors", SupportMenuDrone)
	
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Seerik", SupportMenuDrone2, function() RequestDroneSupport('Seerik') end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar-e-Jask", SupportMenuDrone2, function() RequestDroneSupport('Jask') end, nil)	
end	


--////End Radio Menu Functions
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////NAVAL FUNCTIONS

function SEF_ROEWeaponFreeStennis()	
	Group.getByName("CVN-74 John C. Stennis"):getController():setOption(0, 2)
	--trigger.action.outText("Stennis ROE Set To Weapons Free", 15)
end

function SEF_ROEWeaponFreeTarawa()	
	Group.getByName("LHA-1 Tarawa"):getController():setOption(0, 2)
	--trigger.action.outText("Tarawa ROE Set To Weapons Free", 15)
end
						
function SEF_ROEHoldStennis()	
	Group.getByName("CVN-74 John C. Stennis"):getController():setOption(0, 4)
	--trigger.action.outText("Stennis ROE Set Back To Weapons Hold", 15)
end

function SEF_ROEHoldTarawa()	
	Group.getByName("LHA-1 Tarawa"):getController():setOption(0, 4)
	--trigger.action.outText("Tarawa ROE Set Back To Weapons Hold", 15)
end

function SEF_StennisShipTargeting()		
	SEF_ROEWeaponFreeStennis()	
	timer.scheduleFunction(SEF_ROEHoldStennis, {}, timer.getTime() + 5) 	
end

function SEF_TarawaShipTargeting()		
	SEF_ROEWeaponFreeTarawa()	
	timer.scheduleFunction(SEF_ROEHoldTarawa, {}, timer.getTime() + 5) 	
end

function SEF_CarrierStennisDefenceZone()
	CarrierStennisDefenceZone = ZONE_GROUP:New("Carrier Stennis", GROUP:FindByName( "CVN-74 John C. Stennis" ), 40233) --Approx 25nm		
end

function SEF_CarrierTarawaDefenceZone()
	CarrierTarawaDefenceZone = ZONE_GROUP:New("Carrier Tarawa", GROUP:FindByName( "LHA-1 Tarawa" ), 24140)	--Approx 15nm	
end

function SEF_NavalDefenceZoneScanner(Timeloop, time)
	--trigger.action.outText("Carrier Stennis Is Scanning For Targets", 15)
	StennisScanResult = CarrierStennisDefenceZone:Scan( { Unit.Category.AIRPLANE, Unit.Category.HELICOPTER } )
	StennisRedPresense = CarrierStennisDefenceZone:IsSomeInZoneOfCoalition(coalition.side.RED)
	StennisDefenceZoneCount = 0
			
	if ( StennisRedPresense == true ) then				
		SET_CARRIERSTENNISDEFENCE = SET_UNIT:New():FilterCoalitions( "red" ):FilterCategories({"helicopter","plane"}):FilterOnce()		
		SET_CARRIERSTENNISDEFENCE:ForEachUnitCompletelyInZone( CarrierStennisDefenceZone, function ( GroupObject )
			StennisDefenceZoneCount = StennisDefenceZoneCount + 1
			end
		)		
		if ( StennisDefenceZoneCount > 1 ) then
			--trigger.action.outText("Carrier Stennis Has Detected "..StennisDefenceZoneCount.." Targets In Their Airspace", 15)			
			SEF_StennisShipTargeting()						
		elseif ( StennisDefenceZoneCount == 1 ) then
			--trigger.action.outText("Carrier Stennis Has Detected "..StennisDefenceZoneCount.." Target In Their Airspace", 15)			
			SEF_StennisShipTargeting()			
		else			
		end		
	else	
	end
	
	--trigger.action.outText("Carrier Tarawa Is Scanning For Targets", 15)
	TarawaScanResult = CarrierTarawaDefenceZone:Scan( { Unit.Category.AIRPLANE, Unit.Category.HELICOPTER } )
	TarawaRedPresense = CarrierTarawaDefenceZone:IsSomeInZoneOfCoalition(coalition.side.RED)
	TarawaDefenceZoneCount = 0
			
	if ( TarawaRedPresense == true ) then				
		SET_CARRIERTARAWADEFENCE = SET_UNIT:New():FilterCoalitions( "red" ):FilterCategories({"helicopter","plane"}):FilterOnce()		
		SET_CARRIERTARAWADEFENCE:ForEachUnitCompletelyInZone( CarrierTarawaDefenceZone, function ( GroupObject )
			TarawaDefenceZoneCount = TarawaDefenceZoneCount + 1
			end
		)		
		if ( TarawaDefenceZoneCount > 1 ) then
			--trigger.action.outText("Carrier Tarawa Has Detected "..TarawaDefenceZoneCount.." Targets In Their Airspace", 15)			
			SEF_TarawaShipTargeting()						
		elseif ( TarawaDefenceZoneCount == 1 ) then
			--trigger.action.outText("Carrier Tarawa Has Detected "..TarawaDefenceZoneCount.." Target In Their Airspace", 15)			
			SEF_TarawaShipTargeting()			
		else
		end		
	else
	end	
	
	return time + 20	
end

--////End Naval Functions
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////OVERRIDE FUNCTIONS

function SEF_DisableShips()
	
	--SWITCH NAVAL VESSEL AI OFF
	--[[
	Group.getByName("Abu Musa - Navy 1"):getController():setOnOff(false)
	Group.getByName("Bandar Lengeh - Navy 1"):getController():setOnOff(false)
	Group.getByName("Jask - Navy 1"):getController():setOnOff(false)
	Group.getByName("Havadarya - Navy 1"):getController():setOnOff(false)
	Group.getByName("Havadarya - Navy 2"):getController():setOnOff(false)
	Group.getByName("Qeshm Island - Navy 1"):getController():setOnOff(false)
	Group.getByName("Qeshm Island - Navy 2"):getController():setOnOff(false)
	Group.getByName("Sirri Island - Navy 1"):getController():setOnOff(false)
	Group.getByName("Tunb Island - Navy 1"):getController():setOnOff(false)
	Group.getByName("Qeshm Island - Navy 2"):getController():setOnOff(false)
	Group.getByName("Seerik - Navy 1"):getController():setOnOff(false)	
	]]--
	trigger.action.outText("Naval Vessel AI is now off", 15)
end

function SEF_ToggleFiringSounds()

	if ( OnShotSoundsEnabled == 0 ) then
		OnShotSoundsEnabled = 1
		trigger.action.outText("Firing Sounds Are Now Enabled", 15)
	elseif ( OnShotSoundsEnabled == 1 ) then
		OnShotSoundsEnabled = 0
		trigger.action.outText("Firing Sounds Are Now Disabled", 15)
	else		
	end
end

--////End Override Functions
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////RED BOMBER ATTACK FUNCTIONS

--[[

--TEMPLATES
SQ RUS Tu-95MS
SQ RUS Tu-160				
SQ RUS Su-24				
SQ RUS Tu-22M3				
SQ IRN Su-25
	
--ROUTES	
RT RED PIN 1
RT RED PIN 2

]]--

function SEF_RedBomberAttack()	
	
	if ( trigger.misc.getUserFlag(5006) == 1 ) then
		if ( trigger.misc.getUserFlag(5070) == 0 ) then
			
			local RouteNumber = math.random(1,2)
			
			REDBomberTarget = "RED Bomber Target "..RouteNumber
			
			REDPIN1 = SPAWN
				:New( "RT RED PIN "..RouteNumber )
				:InitLimit( 2, 1 )
				:InitRandomizeTemplate( { "SQ RUS Tu-95MS", "SQ RUS Tu-160", "SQ RUS Su-24M", "SQ RUS Tu-22M3", "SQ IRN Su-25" } )
				:OnSpawnGroup(
					function( SpawnGroup )								
						RTREDPINGROUPNAME = SpawnGroup.GroupName
						RTREDPINGROUPID = Group.getByName(RTREDPINGROUPNAME):getID()												
					end
				)
				:Spawn()
			
			--trigger.action.outText("Mission Update \nEnemy Bombers Approaching",60)
			--Set flag 5070 to 1
			trigger.action.setUserFlag(5070,1)	
			
		elseif ( trigger.misc.getUserFlag(5070) == 1) then
			--Check if the spawned Pinpoint Strike group is still alive or not
			
			if ( REDPIN1:IsAlive() ) then
				--Do nothing as bombers are still active
			else
				trigger.action.setUserFlag(5070,0)
				SEF_RedBomberAttack()
			end		
		else			
		end
	else
		trigger.action.outText("Enemy Bomber Missions Currently Disabled",60)
	end
end

function SEF_RedBomberScheduler(timeloop, time)

	if (trigger.misc.getUserFlag(5006) == 1) then
		SEF_RedBomberAttack()		
		
		return time + math.random(1800, 2700) --Initiate between 30 minutes and 45 minutes	
	else		
	end
end

function SEF_REDBomberTargetAcquisition()
	
	TargetGroupREDPIN = ZONE:FindByName(REDBomberTarget) 
	TargetCoordForREDStrike = TargetGroupREDPIN:GetCoordinate():GetVec2()
			
	local target = {}
		target.point = TargetCoordForREDStrike
		target.expend = "Four"
		target.weaponType = 2956984318
		target.attackQty = 1
		target.groupAttack = true					
										
	local engage = {id = 'AttackMapObject', params = target}
	Group.getByName(RTREDPINGROUPNAME):getController():pushTask(engage) -- :setTask(engage)
					
	--////Launch Codes
	--Any ASM = 4161536
	--Any AG Weapon = 2956984318
	
	--[[
		Bombing = { 
			id = 'AttackMapObject', 
			params = { 
				point = Vec2,
				weaponType = number, 
				expend = enum AI.Task.WeaponExpend,
				attackQty = number, 
				direction = Azimuth, 
				groupAttack = boolean, 
			} 
		}
	]]--
end

--////End Red Bomber Functions
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////BLUE AWACS/TANKER SPAWN

function SEF_BLUEAwacsSpawn()	
			
	BLUEAWACS = SPAWN
		:New( "RT AWACS BLUE" )
		:InitLimit( 1, 1 )
		:InitRandomizeTemplate( { "SQ BLUE E-3A" } )
		
		:OnSpawnGroup(
			function( SpawnGroup )								
				RTBLUEAWACSGROUPNAME = SpawnGroup.GroupName
				RTBLUEAWACSGROUPID = Group.getByName(RTBLUEAWACSGROUPNAME):getID()												
			end
		)		
		:Spawn()		
end

function SEF_BLUETexacoSpawn()	
			
	BLUETEXACO = SPAWN
		:New( "RT TEXACO" )
		:InitLimit( 1, 1 )
		:InitRandomizeTemplate( { "SQ BLUE KC-135MPRS" } )
		
		:OnSpawnGroup(
			function( SpawnGroup )								
				RTBLUETEXACOGROUPNAME = SpawnGroup.GroupName
				RTBLUETEXACOGROUPID = Group.getByName(RTBLUETEXACOGROUPNAME):getID()												
			end
		)		
		:Spawn()		
end

function SEF_BLUEShellSpawn()	
			
	BLUESHELL = SPAWN
		:New( "RT SHELL" )
		:InitLimit( 1, 1 )
		:InitRandomizeTemplate( { "SQ BLUE KC-135" } )
		
		:OnSpawnGroup(
			function( SpawnGroup )								
				RTBLUESHELLGROUPNAME = SpawnGroup.GroupName
				RTBLUESHELLGROUPID = Group.getByName(RTBLUESHELLGROUPNAME):getID()												
			end
		)		
		:Spawn()
end

function SEF_BLUEArcoSpawn()	
			
	BLUEARCO = SPAWN
		:New( "RT ARCO" )
		:InitLimit( 1, 1 )
		:InitRandomizeTemplate( { "SQ BLUE S-3B" } )
		
		:OnSpawnGroup(
			function( SpawnGroup )								
				RTBLUEARCOGROUPNAME = SpawnGroup.GroupName
				RTBLUESARCOGROUPID = Group.getByName(RTBLUEARCOGROUPNAME):getID()												
			end
		)		
		:Spawn()
end

function SEF_BLUEAWACSRTBMessage()
	trigger.action.outText("AWACS Is Returning To Base",60)
end

function SEF_BLUETexacoRTBMessage()
	trigger.action.outText("Tanker Texaco Is Returning To Base",60)
end

function SEF_BLUEShellRTBMessage()
	trigger.action.outText("Tanker Shell Is Returning To Base",60)
end

function SEF_BLUEArcoRTBMessage()
	trigger.action.outText("Tanker Arco Is Returning To Base",60)
end

--////End Blue Awacs/Tankers Spawn
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////TARGET SMOKE FUNCTIONS

function SEF_TargetSmokeLock()
	TargetSmokeLockout = 1
end

function SEF_TargetSmokeUnlock()
	TargetSmokeLockout = 0
end

function SEF_TargetSmoke()
	
	if ( TargetSmokeLockout == 0 ) then
		if ( AGTargetTypeStatic == false and AGMissionTarget ~= nil ) then
			--TARGET IS NOT STATIC					
			if ( GROUP:FindByName(AGMissionTarget):IsAlive() == true ) then
				--GROUP VALID
				SEFTargetSmokeGroupCoord = GROUP:FindByName(AGMissionTarget):GetCoordinate()
				SEFTargetSmokeGroupCoord:SmokeRed()
				--SEFTargetSmokeGroupCoord:SmokeBlue()
				--SEFTargetSmokeGroupCoord:SmokeGreen()
				--SEFTargetSmokeGroupCoord:SmokeOrange()
				--SEFTargetSmokeGroupCoord:SmokeWhite()
				trigger.action.outSound('Target Smoke.ogg')
				trigger.action.outText("Target Has Been Marked With Red Smoke", 15)
				SEF_TargetSmokeLock()
				timer.scheduleFunction(SEF_TargetSmokeUnlock, 53, timer.getTime() + 300)				
			else			
				trigger.action.outText("Target Smoke Currently Unavailable - Unable To Acquire Target Group", 15)						
			end		
		elseif ( AGTargetTypeStatic == true and AGMissionTarget ~= nil ) then		
			--TARGET IS STATIC		
			if ( StaticObject.getByName(AGMissionTarget) ~= nil and StaticObject.getByName(AGMissionTarget):isExist() == true ) then
				--STATIC IS VALID
				SEFTargetSmokeStaticCoord = STATIC:FindByName(AGMissionTarget):GetCoordinate()
				SEFTargetSmokeStaticCoord:SmokeRed()
				--SEFTargetSmokeStaticCoord:SmokeBlue()
				--SEFTargetSmokeStaticCoord:SmokeGreen()
				--SEFTargetSmokeStaticCoord:SmokeOrange()
				--SEFTargetSmokeStaticCoord:SmokeWhite()
				trigger.action.outSound('Target Smoke.ogg')		
				trigger.action.outText("Target Has Been Marked With Red Smoke", 15)
				SEF_TargetSmokeLock()
				timer.scheduleFunction(SEF_TargetSmokeUnlock, 53, timer.getTime() + 300)				
			else
				trigger.action.outText("Target Smoke Currently Unavailable - Unable To Acquire Target Building", 15)	
			end			
		else		
			trigger.action.outText("Target Smoke Currently Unavailable - No Valid Targets", 15)
		end
	else
		trigger.action.outText("Target Smoke Currently Unavailable - Smoke Shells Are Being Reloaded", 15)
	end	
end

--////End Target Smoke Functions
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////OTHER FUNCTIONS

function SEF_CheckDefenceNetwork()
	trigger.action.outText("Allied Defence Network Consists Of "..BLUEDetectionSetGroup:Count().." Groups\nIranian Defence Network Consists Of "..REDDetectionSetGroup:Count().." Groups", 15)

	--BLUEDetectionSetGroup:ForEachGroup(
	--	function(BlueDefenceGroupCheck)
	--		BlueDefenceGroupName = BlueDefenceGroupCheck:GetName()			
	--		trigger.action.outText(BlueDefenceGroupName, 60)			
	--	end
	--)	
end

function SEF_CheckAirfieldStatus()
	trigger.action.outText("Airfield Status Report".."\n\n"..BandarLengehStatus.."\n"..HavadaryaStatus.."\n"..BandarAbbasStatus.."\n"..JaskStatus, 15)
end

--////End Other Functions
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////MAIN

		--////GLOBAL VARIABLE INITIALISATION	
		NumberOfCompletedMissions = 0
		TotalScenarios = 130
		OperationComplete = false
		OnShotSoundsEnabled = 1
		SoundLockout = 0
		TargetSmokeLockout = 0	
						
		--////ENABLE CAP/CAS/ASS/SEAD/PIN/DRONE
		trigger.action.setUserFlag(5001,1)
		trigger.action.setUserFlag(5002,1)
		trigger.action.setUserFlag(5003,1)
		trigger.action.setUserFlag(5004,1)
		trigger.action.setUserFlag(5005,1)
		trigger.action.setUserFlag(5891,1)
		--////ENABLE RED BOMBER ATTACKS
		trigger.action.setUserFlag(5006,1)
		
		--////FUNCTIONS
		SEF_InitializeMissionTable()		
		SEF_MissionSelector()
		SEF_RadioMenuSetup()
		SEF_BLUEAwacsSpawn()
		SEF_BLUETexacoSpawn()
		SEF_BLUEShellSpawn()
		SEF_BLUEArcoSpawn()
		--SEF_CarrierStennisDefenceZone()
		--SEF_CarrierTarawaDefenceZone()
		
		--////SCHEDULERS
		--AI FLIGHT PUSH FLAGS
		timer.scheduleFunction(SEF_CheckAIPushFlags, 53, timer.getTime() + 1)
		--MISSION TARGET STATUS
		timer.scheduleFunction(SEF_MissionTargetStatus, 53, timer.getTime() + 10)
		--RED BOMBER ATTACKS - WAIT 10-15 MINUTES BEFORE STARTING
		timer.scheduleFunction(SEF_RedBomberScheduler, 53, timer.getTime() + math.random(600, 900))
		--NAVAL DEFENCE ZONE SCANNER - WAIT 5 MINUTES BEFORE STARTING
		--timer.scheduleFunction(SEF_NavalDefenceZoneScanner, 53, timer.getTime() + 300)				
	
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////