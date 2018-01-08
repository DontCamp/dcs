
--Final Commands
 
local function A2A_Easy_MenuStart()
	trigger.action.setUserFlag (1, true )
end
local function A2A_Normal_MenuStart()
	trigger.action.setUserFlag (2, true )
end
local function A2A_Hard_MenuStart()
	trigger.action.setUserFlag (3, true )
end
local function A2A_ALL_MenuStart() --107thonly
	trigger.action.setUserFlag (4, true )
end

-- A2G
local function A2G_HARD_MenuStart()
	trigger.action.setUserFlag (6, true )
end
local function A2G_MR_MenuStart()
	trigger.action.setUserFlag (7, true )
end
local function A2G_Helo_MenuStart()
	trigger.action.setUserFlag (8, true )
end
-- local function A2G_AS_MenuStart()
	-- trigger.action.setUserFlag (9, true )
-- end

local function LOCATION_INTEL()
	trigger.action.setUserFlag (100, true )
end

local function SMOKE_INTEL()
	trigger.action.setUserFlag (800, true )
end

local function AWACS_RESET()
	trigger.action.setUserFlag (50, true )
end

local function TANKERS_RESET()
	trigger.action.setUserFlag (51, true )
end

local function MISSION_RS()
	trigger.action.setUserFlag (666, true )
end

local function MISSION_EN()
	trigger.action.setUserFlag (667, true )
end



mainMenu = MENU_COALITION:New(coalition.side.BLUE, "MISSION/TASK SPAWNING MENU")           
a2gMenu = MENU_COALITION:New(coalition.side.BLUE, "Air-to-Ground", mainMenu)
a2aMenu = MENU_COALITION:New(coalition.side.BLUE, "Air-to-Air", mainMenu)
intelmenu = MENU_COALITION:New(coalition.side.BLUE, "Location Intel Menu", mainMenu)
debugmenu = MENU_COALITION:New(coalition.side.BLUE, "Debug Menu", mainMenu)
--a2a
MENU_COALITION_COMMAND:New( coalition.side.BLUE, "[[ A2G Hard Mission ]]", a2gMenu, A2G_HARD_MenuStart )
MENU_COALITION_COMMAND:New( coalition.side.BLUE, "[[ A2G Easy Mission ]]", a2gMenu, A2G_MR_MenuStart )
MENU_COALITION_COMMAND:New( coalition.side.BLUE, "[[ A2G Helo Mission ]]", a2gMenu, A2G_Helo_MenuStart )
--MENU_COALITION_COMMAND:New( coalition.side.BLUE, "[[ Anti-Ship Mission ]]", a2gMenu, A2G_AS_MenuStart )
--a2g
MENU_COALITION_COMMAND:New( coalition.side.BLUE, "[[ A2A Easy Mission ]]", a2aMenu, A2A_Easy_MenuStart )
MENU_COALITION_COMMAND:New( coalition.side.BLUE, "[[ A2A Normal Mission ]]", a2aMenu, A2A_Normal_MenuStart )
MENU_COALITION_COMMAND:New( coalition.side.BLUE, "[[ A2A Hard Mission ]]", a2aMenu, A2A_Hard_MenuStart )
MENU_COALITION_COMMAND:New( coalition.side.BLUE, "[[ A2A Random Mission ]]", a2aMenu, A2A_ALL_MenuStart )

MENU_COALITION_COMMAND:New( coalition.side.BLUE, "[[ Ground Target Location Intel ]]", intelmenu, LOCATION_INTEL )
MENU_COALITION_COMMAND:New( coalition.side.BLUE, "[[ Smoke Active Target Areas ]]", intelmenu, SMOKE_INTEL )

MENU_COALITION_COMMAND:New( coalition.side.BLUE, "[[ Reset AWACS ]]", debugmenu, AWACS_RESET )
MENU_COALITION_COMMAND:New( coalition.side.BLUE, "[[ Reset Tankers ]]", debugmenu, TANKERS_RESET )
MENU_COALITION_COMMAND:New( coalition.side.BLUE, "[[ Reset Mission ]]", debugmenu, MISSION_RS )
MENU_COALITION_COMMAND:New( coalition.side.BLUE, "[[ End Mission ]]", debugmenu, MISSION_EN )


-- JTACAutoLase('JTAC-AG1', 1688, true,"all" )
-- JTACAutoLase('JTAC-AG2', 1688, true,"all" )
-- JTACAutoLase('JTAC-AG3', 1688, true,"all" )
-- JTACAutoLase('JTAC-AG4', 1688, true,"all" )
-- JTACAutoLase('JTAC-AG5', 1688, true,"all" )

-- JTACAutoLase('JTAC-MR1', 1688, true,"all" )
-- JTACAutoLase('JTAC-MR2', 1688, true,"all" )
-- JTACAutoLase('JTAC-MR3', 1688, true,"all" )
-- JTACAutoLase('JTAC-MR4', 1688, true,"all" )
-- JTACAutoLase('JTAC-MR5', 1688, true,"all" )

-- JTACAutoLase('JTAC-AGH1', 1688, true,"all" )
-- JTACAutoLase('JTAC-AGH2', 1688, true,"all" )
-- JTACAutoLase('JTAC-AGH3', 1688, true,"all" )
-- JTACAutoLase('JTAC-AGH4', 1688, true,"all" )
-- JTACAutoLase('JTAC-AGH5', 1688, true,"all" )