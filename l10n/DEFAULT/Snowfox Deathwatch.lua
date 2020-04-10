--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- Name: Operation Snowfox Deathwatch
-- Author: Surrexen    ༼ つ ◕_◕ ༽つ    (づ｡◕‿◕｡)づ 
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////Start
--trigger.action.outText("Initialising Deathwatch Routines",15)

--////DECLARE SETS
SET_DEATHWATCH = SET_UNIT:New():FilterPrefixes( { "SQ IRN", "SQ RUS" } ):FilterCoalitions( "red" ):FilterCountries( { "Russia", "Iran" } ):FilterStart()
SET_RTREDBLUELAND = SET_UNIT:New():FilterPrefixes( { "RT BLUE", "RT RED", "RT AWACS", "RT TEXACO", "RT SHELL" } ):FilterCoalitions( { "blue", "red" } ):FilterStart()
SET_BLUEFIRE = SET_UNIT:New():FilterCoalitions( "blue" ):FilterStart()

--////DEBUGGER TO MAKE SURE SETS ARE POPULATING, WRITES TO DCS.LOG
--[[
SCHEDULER:New(nil,function() 
	BASE:E({"Set List has",SET_DEATHWATCH:Count(),"Items in it"}) 
end, {}, 60,60)
]]--

--////SUBSCRIBE SETS TO EVENTS
SET_DEATHWATCH:HandleEvent(EVENTS.Crash)
SET_RTREDBLUELAND:HandleEvent(EVENTS.Land)
SET_BLUEFIRE:HandleEvent(EVENTS.Shot)
--==================================================================================================================================================================================
--////FUNCTIONS

local function FriendlyDownSound()
	trigger.action.outSound('Oh Jesus.ogg')
end

function SET_RTREDBLUELAND:OnEventLand(EventData)

	local RTREDBLUEPLANEGROUP = EventData.IniDCSGroupName
	local RTREDBLUEPLANEUNIT = EventData.IniDCSUnitName
	local RTREDBLUETYPE = EventData.IniTypeName
	local RTREDBLUEPLACENAME = EventData.PlaceName
		
	if string.find(RTREDBLUEPLANEGROUP, "RT BLUE") then
		trigger.action.outText("An " .. RTREDBLUETYPE .. " Has Landed At " .. RTREDBLUEPLACENAME,15)
		Unit.getByName(RTREDBLUEPLANEUNIT):destroy()
	elseif string.find(RTREDBLUEPLANEGROUP, "RT RED") then
		--trigger.action.outText("An " .. RTREDBLUETYPE .. " Has Landed At " .. RTREDBLUEPLACENAME,15)
		Unit.getByName(RTREDBLUEPLANEUNIT):destroy()
	elseif string.find(RTREDBLUEPLANEGROUP, "RT AWACS") then
		trigger.action.outText("An " .. RTREDBLUETYPE .. " Has Landed At " .. RTREDBLUEPLACENAME,15)
		Unit.getByName(RTREDBLUEPLANEUNIT):destroy()
		timer.scheduleFunction(SEF_BLUEAwacsSpawn, {}, timer.getTime() + 10)	
	elseif string.find(RTREDBLUEPLANEGROUP, "RT TEXACO") then
		trigger.action.outText("An " .. RTREDBLUETYPE .. " Has Landed At " .. RTREDBLUEPLACENAME,15)
		Unit.getByName(RTREDBLUEPLANEUNIT):destroy()
		timer.scheduleFunction(SEF_BLUETexacoSpawn, {}, timer.getTime() + 10)
	elseif string.find(RTREDBLUEPLANEGROUP, "RT SHELL") then
		trigger.action.outText("An " .. RTREDBLUETYPE .. " Has Landed At " .. RTREDBLUEPLACENAME,15)
		Unit.getByName(RTREDBLUEPLANEUNIT):destroy()
		timer.scheduleFunction(SEF_BLUEShellSpawn, {}, timer.getTime() + 10)
	elseif string.find(RTREDBLUEPLANEGROUP, "RT ARCO") then
		trigger.action.outText("An " .. RTREDBLUETYPE .. " Has Landed At " .. RTREDBLUEPLACENAME,15)
		Unit.getByName(RTREDBLUEPLANEUNIT):destroy()
		timer.scheduleFunction(SEF_BLUEArcoSpawn, {}, timer.getTime() + 10)	
	else		
	end	
end

function SET_DEATHWATCH:OnEventCrash(EventData)
	local CrashedUnitCoalition = EventData.IniCoalition
	local CrashedUnitType = EventData.IniTypeName
	local CrashedUnitPlaneGroup = EventData.IniDCSGroupName
	
	if ( CrashedUnitCoalition == 1 and CrashedUnitType == 'MiG-21Bis' ) then			-- Enemy MiG-21Bis Down
		trigger.action.outText("A " .. CrashedUnitType .. " Has Been Destroyed!",15)
		local RandomMigSound = math.random(1,2)
		if (RandomMigSound == 1) then 
			trigger.action.outSound('mig21splash-1.ogg')
		else
			trigger.action.outSound('mig21splash-2.ogg')
		end		
	elseif ( CrashedUnitCoalition == 1 and CrashedUnitType ~= 'MiG-21Bis' ) then		-- Enemy Non-MiG Down
		trigger.action.outText("A " .. CrashedUnitType .. " Has Been Destroyed!",15)
		local RandomAAKillSound = math.random(1,6)
		trigger.action.outSound('AA Kill ' .. RandomAAKillSound .. '.ogg')				
	elseif ( CrashedUnitCoalition == 2 and CrashedUnitType ~= 'F-14B' ) then 		-- Allied Plane Down - non-f-14
		trigger.action.outText("A " .. CrashedUnitType .. " Has Been Destroyed!",15)
		timer.scheduleFunction(FriendlyDownSound, {}, timer.getTime() + 1)		
	elseif ( CrashedUnitCoalition == 2 and CrashedUnitType == 'F-14B' and CrashedUnitPlaneGroup ~= 'CVN-74 John C. Stennis - F-14B' and CrashedUnitPlaneGroup ~= 'Sharjah Intl - F-14B' ) then 		-- Allied Plane Down - CAP f-14
		trigger.action.outText("A " .. CrashedUnitType .. " Has Been Destroyed!",15)
		timer.scheduleFunction(FriendlyDownSound, {}, timer.getTime() + 1)		
	elseif ( CrashedUnitCoalition == 2 and CrashedUnitType == 'F-14B' ) then 		-- Allied Plane Down - player f-14
		trigger.action.outText("A " .. CrashedUnitType .. " Has Been Destroyed!",15)
		trigger.action.outSound('topgun-death.ogg')	
		
		--Respawn AWACS and Tankers
		if string.find(CrashedUnitPlaneGroup, "RT AWACS") then
			timer.scheduleFunction(SEF_BLUEAwacsSpawn, {}, timer.getTime() + 10)				
		elseif string.find(CrashedUnitPlaneGroup, "RT TEXACO") then
			timer.scheduleFunction(SEF_BLUETexacoSpawn, {}, timer.getTime() + 10)			
		elseif string.find(CrashedUnitPlaneGroup, "RT SHELL") then			
			timer.scheduleFunction(SEF_BLUEShellSpawn, {}, timer.getTime() + 10)
		elseif string.find(CrashedUnitPlaneGroup, "RT ARCO") then			
			timer.scheduleFunction(SEF_BLUEArcoSpawn, {}, timer.getTime() + 10)	
		else
		end		
	else		
	end		
end

function SET_BLUEFIRE:OnEventShot(EventData)
	local ShotCoalition = EventData.IniCoalition
	local ShotWeapon = EventData.weapon:getDesc()
	local ShotCategory = ShotWeapon.category	
	local ShotMissileCategory = ShotWeapon.missileCategory
	local ShotMissileGuidanceType = ShotWeapon.guidance
	local ShotWeaponName = EventData.weapon:getTypeName()
	--local ShotTarget = EventData.TgtDCSUnitName
				
	if ( OnShotSoundsEnabled == 1 ) then --Play sound if OnShotSounds is enabled and not SoundLocked. Set SoundLockout time on playsound.
		--////Check if Blue Coalition Is The One That Is Firing
		if ( ShotCoalition == 2 ) then
			--MISSILES		
			if ( ShotCategory == 1 ) then --Missile, any type		
				if ( ShotMissileCategory == 1 ) then -- 1 is A2A Missile "Fox"
						if ( ShotMissileGuidanceType == 4 ) then -- 4 is Fox 1, 2 is Fox 2, 3 is Fox 3
							
							--trigger.action.outText("Fox 1!", 15)				
													
							if ( timer.getAbsTime() >= SoundLockout + 7 ) then
								local RandomFox1Sound = math.random(1,2)
								trigger.action.outSound('Fox1 ' .. RandomFox1Sound .. '.ogg')
								SoundLockout = timer.getAbsTime()
							else
							end	
						
						elseif ( ShotMissileGuidanceType == 2 ) then
							
							--trigger.action.outText("Fox 2!", 15)
							
							if ( timer.getAbsTime() >= SoundLockout + 7 ) then	
								local RandomFox2Sound = math.random(1,3)
								trigger.action.outSound('Fox2 ' .. RandomFox2Sound .. '.ogg')
								SoundLockout = timer.getAbsTime()
							else
							end		
							
						elseif ( ShotMissileGuidanceType == 3 ) then
							
							--trigger.action.outText("Fox 3!", 15)
							
							if ( timer.getAbsTime() >= SoundLockout + 7 ) then
								local RandomFox3Sound = math.random(1,5)
								trigger.action.outSound('FoxGeneric ' .. RandomFox3Sound .. '.ogg')
								SoundLockout = timer.getAbsTime()
							else
							end							
						else
						end
				elseif ( ShotMissileCategory == 4 ) then --4 for Anti-Ship Missile "Bruiser"
					
					--trigger.action.outText("Bruiser!", 15)
					
					--////Can't find any Bruiser sounds yet
					--if ( timer.getAbsTime() >= SoundLockout + 7 ) then
						--local RandomBruiserSound = math.random(1,1)
						--trigger.action.outSound('Bruiser ' .. RandomBruiserSound .. '.ogg')
						--SoundLockout = timer.getAbsTime()
					--else
					--end
					
				elseif ( ShotMissileCategory == 6 ) then --6 for Other Missile "Rifle" (Maverick, HARM, Harpoon) -- Need to work out how to distinguish between anti-rad 'magnum' and anti-ship 'bruiser'
					
					--trigger.action.outText("Weapon: "..ShotWeaponName, 15)
					
					--Now test for the missile name
					--////ANTI RADIATION
					if ( ShotWeaponName == "weapons.missiles.AGM_88" or ShotWeaponName == "weapons.missiles.AGM_122" or ShotWeaponName == "weapons.missiles.X_58" 
								or ShotWeaponName == "weapons.missiles.X_25MP" or ShotWeaponName == "LD-10" ) then
						
						--trigger.action.outText("Magnum!", 15)
						
						if ( timer.getAbsTime() >= SoundLockout + 7 ) then
							local RandomMagnumSound = math.random(1,1)
							trigger.action.outSound('Magnum ' .. RandomMagnumSound .. '.ogg')
							SoundLockout = timer.getAbsTime()
						else
						end		
						
					--////ASM's
					elseif ( ShotWeaponName == "weapons.missiles.AGM_65D" or ShotWeaponName == "weapons.missiles.AGM_65E" or ShotWeaponName == "weapons.missiles.AGM_65F" 
								or ShotWeaponName == "weapons.missiles.AGM_65G" or ShotWeaponName == "weapons.missiles.AGM_65H" or ShotWeaponName == "weapons.missiles.AGM_65K" 
								or ShotWeaponName == "weapons.missiles.X_29T" or ShotWeaponName == "weapons.missiles.X_29L" or ShotWeaponName == "weapons.missiles.X_25ML" 
								or ShotWeaponName == "weapons.missiles.S-25L" or ShotWeaponName == "weapons.missiles.Vikhr_M" or ShotWeaponName == "weapons.missiles.RB75" 
								or ShotWeaponName == "weapons.missiles.CM-802AKG" or ShotWeaponName == "weapons.missiles.C-701T" or ShotWeaponName == "weapons.missiles.C-701IR" ) then
						
						--trigger.action.outText("Rifle!", 15)
						
						if ( timer.getAbsTime() >= SoundLockout + 7 ) then
							local RandomRifleSound = math.random(1,1)
							trigger.action.outSound('Rifle ' .. RandomRifleSound .. '.ogg')
							SoundLockout = timer.getAbsTime()
						else
						end		
						
					--////ANTI-SHIP
					elseif ( ShotWeaponName == "weapons.missiles.AGM_84D" or ShotWeaponName == "weapons.missiles.C-802AK" or ShotWeaponName == "weapons.missiles.ROBOT" ) then
						
						--trigger.action.outText("Bruiser!", 15)
						
						--////Can't find any Bruiser sounds yet
						--if ( timer.getAbsTime() >= SoundLockout + 7 ) then
							--local RandomBruiserSound = math.random(1,1)
							--trigger.action.outSound('Bruiser ' .. RandomBruiserSound .. '.ogg')
							--SoundLockout = timer.getAbsTime()
						--else
						--end						
					else
					end								
				else
				end
			--////ROCKETS	
			elseif ( ShotCategory == 2 ) then --Rockets, any type
				--Brevity Call Nails ... I think
				--Probably best not to do rockets as so many get fired
				--trigger.action.outText("Nails!", 15)
				
			--////BOMBS	
			elseif ( ShotCategory == 3 ) then --Bomb, any type
				
				--trigger.action.outText("Pickle!", 15)
				
				if ( timer.getAbsTime() >= SoundLockout + 7 ) then
					local RandomPickleSound = math.random(1,5)
					trigger.action.outSound('Pickle ' .. RandomPickleSound .. '.ogg')		
					SoundLockout = timer.getAbsTime()
				else
				end		
				
			--////SHELLS
			elseif ( ShotCategory == 0 ) then --Shell, any type
				--No Brevity Call
				--trigger.action.outText("Shell!", 15)	
			else
			end	
		elseif ( ShotCoalition == 1 ) then
			if ( ShotMissileCategory == 2 ) then
				
				--trigger.action.outText("SAM Launch!", 15)
				
				if ( timer.getAbsTime() >= SoundLockout + 7 ) then
					local RandomSAMSound = math.random(1,6)
					trigger.action.outSound('SAM ' .. RandomSAMSound .. '.ogg')			
					SoundLockout = timer.getAbsTime()
				else
				end				
			else
			end	
		else
		end
	else
	end	
end