CPS 				= 		ZONE:New("CPS")
CPS_bomb1				= 		ZONE:New("CPS_bomb1")
CPS_bomb2				= 		ZONE:New("CPS_bomb2")
CPS_bomb3				= 		ZONE:New("CPS_bomb3")

-- TemplateTable_EASY = { 
-- "mig21_easy", 
-- "f5_easy", 
-- "mig31_easy", 
-- "f4_easy",
-- "mig23_easy",
-- "mig25_easy",
 -- } -- x1 Per Group

-- TemplateTable_NORMAL = { 
-- "su27_norm", 
-- "su33_norm", 
-- "mig29_norm", 
-- "m2k_norm", 
-- "f16_norm", 
-- "f4_norm", 
-- "mig23_norm", 
-- "mig21_norm", 
-- --"f18_norm",
-- } -- x2 Per Group

-- TemplateTable_HARD = { 
-- "su27_hard", 
-- "su33_hard", 
-- "mig29_hard", 
-- "f15_hard", 
-- "f16_hard", 
-- "su30_hard", 
-- } 

-- TemplateTable_ALL = { 
-- "mig21_easy", 
-- "f5_easy", 
-- "mig31_easy", 
-- "f4_easy",
-- "mig23_easy",
-- "mig25_easy",
-- "su27_norm", 
-- "su33_norm", 
-- "mig29_norm", 
-- "m2k_norm", 
-- "f16_norm", 
-- "f4_norm", 
-- "mig23_norm", 
-- "mig21_norm", 
-- "su27_hard", 
-- "su33_hard", 
-- "mig29_hard", 
-- "f15_hard", 
-- "f16_hard", 
-- "su30_hard", 
-- } 
--bombing add
TemplateTable_Bombing = { 
"bombing_1", 
"bombing_2", 
} 

A2A_Easy = SPAWN:New( "A2A_Spawn_Init_EASY" )
	:InitRandomizeTemplate( TemplateTable_EASY )
	:InitRandomizeRoute( 1, 1, 20000 ) 				

A2A_Norm = SPAWN:New( "A2A_Spawn_Init_NORM" )
	:InitRandomizeTemplate( TemplateTable_NORMAL )
	:InitRandomizeRoute( 1, 1, 20000 ) 

A2A_Hard = SPAWN:New( "A2A_Spawn_Init_HARD" )
	:InitRandomizeTemplate( TemplateTable_HARD )
	:InitRandomizeRoute( 1, 1, 20000 ) 		
	
A2A_ALL = SPAWN:New( "A2A_Spawn_Init_ALL" )
	:InitRandomizeTemplate( TemplateTable_ALL )
	:InitRandomizeRoute( 1, 1, 20000 ) 
--bombing add
A2A_BOMBING = SPAWN:New( "A2A_Spawn_Init_Bombing" )
	:InitRandomizeTemplate( TemplateTable_Bombing )
	:InitRandomizeRoute( 1, 1, 20000 ) 
	
function a2a_easy_start()  --1 per group
	A2A_Easy:SpawnInZone( CPS, true, 5000, 10000 )
end

function a2a_norm_start()  --2 per group
	A2A_Norm:SpawnInZone( CPS, true, 5000, 10000 )
end


function a2a_hard_start() --2 per group
	A2A_Hard:SpawnInZone( CPS, true, 5000, 10000 )
end

function a2a_all_start() --2 per group
	A2A_ALL:SpawnInZone( CPS, true, 5000, 10000 )
end
--bombing add
function a2a_bombing_start() --2 per group
	
local switch = math.random (1,3) 

if switch ==1  then
	A2A_BOMBING:SpawnInZone( CPS_bomb1, true, 5000, 10000 )
	A2A_BOMBING:SpawnInZone( CPS_bomb1, true, 5000, 10000 )
	A2A_BOMBING:SpawnInZone( CPS_bomb1, true, 5000, 10000 )


elseif switch ==2 then
	A2A_BOMBING:SpawnInZone( CPS_bomb2, true, 5000, 10000 )
	A2A_BOMBING:SpawnInZone( CPS_bomb2, true, 5000, 10000 )
	A2A_BOMBING:SpawnInZone( CPS_bomb2, true, 5000, 10000 )

elseif switch ==3  then
	A2A_BOMBING:SpawnInZone( CPS_bomb3, true, 5000, 10000 )
	A2A_BOMBING:SpawnInZone( CPS_bomb3, true, 5000, 10000 )
	A2A_BOMBING:SpawnInZone( CPS_bomb3, true, 5000, 10000 )
end
end

function sp(groupName)
	group = SPAWN:New(groupName)
	--:InitRepeatOnLanding()
	group:Spawn()
end

--bombing add
if a2a_autospawn_enable == true then
trigger.action.outText("A2A CAP auto-spawn is ENABLED to spawn every few minutes.\n\nThese settings are configurable in the MISSION EDITOR. Check out the settings config tutorial text file that came with the mission for more details!", 10)
end

if a2a_autospawn_enable == false then
trigger.action.outText("A2A CAP auto-spawn is DISABLED \n\nThese settings are configurable in the MISSION EDITOR. Check out the settings config tutorial text file that came with the mission for more details!", 10)
end

if a2a_intercept_autospawn_enable == true then
trigger.action.outText("Enemy Bombers auto-spawn is ENABLED to spawn every few minutes.\n\nThese settings are configurable in the MISSION EDITOR. Check out the settings config tutorial text file that came with the mission for more details!", 10)
end

if a2a_intercept_autospawn_enable == false then
trigger.action.outText("Enemy Bombers auto-spawn is DISABLED. to spawn every few minutes.\n\nThese settings are configurable in the MISSION EDITOR. Check out the settings config tutorial text file that came with the mission for more details!", 10)
end

trigger.action.outText("AIR LUA File Loaded...", 10)
env.info('Deadly AIR scripting complete')