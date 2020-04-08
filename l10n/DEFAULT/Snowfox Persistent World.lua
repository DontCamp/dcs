----------------------------------------------------------
SaveScheduleUnits = 150 --Seconds between each table write
----------------------------------------------------------
  
function IntegratedbasicSerialize(s)
    if s == nil then
		return "\"\""
    else
		if ((type(s) == 'number') or (type(s) == 'boolean') or (type(s) == 'function') or (type(s) == 'table') or (type(s) == 'userdata') ) then
			return tostring(s)
		elseif type(s) == 'string' then
			return string.format('%q', s)
		end
    end
end
  
-- imported slmod.serializeWithCycles (Speed)
function IntegratedserializeWithCycles(name, value, saved)
    local basicSerialize = function (o)
		if type(o) == "number" then
			return tostring(o)
		elseif type(o) == "boolean" then
			return tostring(o)
		else -- assume it is a string
			return IntegratedbasicSerialize(o)
		end
	end

    local t_str = {}
    saved = saved or {}       -- initial value
    if ((type(value) == 'string') or (type(value) == 'number') or (type(value) == 'table') or (type(value) == 'boolean')) then
		table.insert(t_str, name .. " = ")
			if type(value) == "number" or type(value) == "string" or type(value) == "boolean" then
				table.insert(t_str, basicSerialize(value) ..  "\n")
			else
				if saved[value] then    -- value already saved?
					table.insert(t_str, saved[value] .. "\n")
				else
					saved[value] = name   -- save name for next time
					table.insert(t_str, "{}\n")
						for k,v in pairs(value) do      -- save its fields
							local fieldname = string.format("%s[%s]", name, basicSerialize(k))
							table.insert(t_str, IntegratedserializeWithCycles(fieldname, v, saved))
						end
				end
			end
		return table.concat(t_str)
    else
		return ""
    end
end

function file_exists(name) --check if the file already exists for writing
	if lfs.attributes(name) then
    return true
    else
    return false end 
end

function writemission(data, file)--Function for saving to file (commonly found)
	File = io.open(file, "w")
	File:write(data)
	File:close()
end

function SEF_GetTableLength(Table)
	local TableLengthCount = 0
	for _ in pairs(Table) do TableLengthCount = TableLengthCount + 1 end
	return TableLengthCount
end

--////SAVE FUNCTION FOR UNITS
function SEF_SaveUnitIntermentTable(timeloop, time)
	IntermentMissionStr = IntegratedserializeWithCycles("SnowfoxUnitInterment", SnowfoxUnitInterment)
	writemission(IntermentMissionStr, "SnowfoxUnitInterment.lua")
	--trigger.action.outText("Progress Has Been Saved", 15)	
	return time + SaveScheduleUnits
end

function SEF_SaveUnitIntermentTableNoArgs()
	IntermentMissionStr = IntegratedserializeWithCycles("SnowfoxUnitInterment", SnowfoxUnitInterment)
	writemission(IntermentMissionStr, "SnowfoxUnitInterment.lua")		
end

--////SAVE FUNCTION FOR STATICS
function SEF_SaveStaticIntermentTable(timeloop, time)
	IntermentMissionStrStatic = IntegratedserializeWithCycles("SnowfoxStaticInterment", SnowfoxStaticInterment)
	writemission(IntermentMissionStrStatic, "SnowfoxStaticInterment.lua")
	--trigger.action.outText("Progress Has Been Saved", 15)	
	return time + SaveScheduleUnits
end

function SEF_SaveStaticIntermentTableNoArgs()
	IntermentMissionStrStatic = IntegratedserializeWithCycles("SnowfoxStaticInterment", SnowfoxStaticInterment)
	writemission(IntermentMissionStrStatic, "SnowfoxStaticInterment.lua")	
end

-------------------------------------------------------------------------------------------------------------------------------------
--////MAIN

SEFDeletedUnitCount = 0
SEFDeletedStaticCount = 0

--////LOAD UNITS
if file_exists("SnowfoxUnitInterment.lua") then
	DeadUnitsList = SET_UNIT:New():FilterCoalitions("red"):FilterCategories("ground"):FilterActive(true):FilterStart()
	DeadUnitsList:HandleEvent(EVENTS.Dead)
	
	dofile("SnowfoxUnitInterment.lua")
	
	UnitIntermentTableLength = SEF_GetTableLength(SnowfoxUnitInterment)	
	--trigger.action.outText("Unit Table Length Is "..UnitIntermentTableLength, 15)
		
	for i = 1, UnitIntermentTableLength do
		--trigger.action.outText("Unit Interment Element "..i.." Is "..SnowfoxUnitInterment[i], 15)		
		
		if ( Unit.getByName(SnowfoxUnitInterment[i]) ~= nil ) then
			Unit.getByName(SnowfoxUnitInterment[i]):destroy()
			SEFDeletedUnitCount = SEFDeletedUnitCount + 1
		else
			trigger.action.outText("Unit Interment Element "..i.." Is "..SnowfoxUnitInterment[i].." And Was Not Found", 15)
		end	
	end			
else
	DeadUnitsList = SET_UNIT:New():FilterCoalitions("red"):FilterCategories("ground"):FilterActive(true):FilterStart()
	DeadUnitsList:HandleEvent(EVENTS.Dead)		
	SnowfoxUnitInterment = {}	
	UnitIntermentTableLength = 0	
end
--////LOAD STATICS
if file_exists("SnowfoxStaticInterment.lua") then
	
	dofile("SnowfoxStaticInterment.lua")
		
	StaticIntermentTableLength = SEF_GetTableLength(SnowfoxStaticInterment)	
	--trigger.action.outText("Static Table Length Is "..StaticIntermentTableLength, 15)
	
	for i = 1, StaticIntermentTableLength do
		--trigger.action.outText("Static Interment Element "..i.." Is "..SnowfoxStaticInterment[i], 15)
		
		if ( StaticObject.getByName(SnowfoxStaticInterment[i]) ~= nil ) then		
			StaticObject.getByName(SnowfoxStaticInterment[i]):destroy()		
			SEFDeletedStaticCount = SEFDeletedStaticCount + 1
		else
			trigger.action.outText("Static Interment Element "..i.." Is "..SnowfoxStaticInterment[i].." And Was Not Found", 15)
		end	
	end	
else
	SnowfoxStaticInterment = {}
	StaticIntermentTableLength = 0	
end

trigger.action.outText("Persistent World Functions Have Removed "..SEFDeletedUnitCount.." Units and "..SEFDeletedStaticCount.." Static Objects", 15)

---------------------------------------------------------------------------------------------------------------------------------------------------

--SCHEDULE
timer.scheduleFunction(SEF_SaveUnitIntermentTable, 53, timer.getTime() + SaveScheduleUnits)
timer.scheduleFunction(SEF_SaveStaticIntermentTable, 53, timer.getTime() + SaveScheduleUnits)

---------------------------------------------------------------------------------------------------------------------------------------------------

function DeadUnitsList:OnEventDead(EventData)

	local DEADUNITNAME = EventData.IniDCSUnitName
	local DEADUNITCOALITION = EventData.IniCoalition
	local DEADUNITOBJECTCATEGORY = EventData.IniObjectCategory 	-- 1 UNIT / 2 WEAPON / 3 STATIC / 4 BASE / 5 SCENERY / 6 CARGO
	local DEADUNITCATEGORY = EventData.IniCategory				-- 0 AIRPLANE / 1 HELICOPTER / 2 GROUND_UNIT / 3 SHIP / 4 STRUCTURE
	
	--[[
	--Debug Zone
	trigger.action.outText("Dead Unit Name: "..DEADUNITNAME, 15)
	trigger.action.outText("Dead Unit Coalition: "..DEADUNITCOALITION, 15)
	trigger.action.outText("Dead Unit Category: "..DEADUNITCATEGORY, 15)
	trigger.action.outText("Dead Unit Object Category: "..DEADUNITOBJECTCATEGORY, 15)	
	]]--
	
	if ( DEADUNITCOALITION == 1 ) then		
		if ( DEADUNITOBJECTCATEGORY == 1 ) then -- UNIT
			if ( DEADUNITCATEGORY == 2 or DEADUNITCATEGORY == 3 ) then -- GROUND_UNIT or SHIP
				UnitIntermentTableLength = UnitIntermentTableLength + 1				
				SnowfoxUnitInterment[UnitIntermentTableLength] = DEADUNITNAME			
			else
			end
		elseif ( DEADUNITOBJECTCATEGORY == 3 ) then -- STATIC
			StaticIntermentTableLength = StaticIntermentTableLength + 1			
			SnowfoxStaticInterment[StaticIntermentTableLength] = DEADUNITNAME		
		else
		end		
	else
	end
end