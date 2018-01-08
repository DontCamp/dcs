env.info('Initiating Custom GROUND MOOSE for TTI ok')

TemplateTable_GROUND = { 
"aa_ural",
"aa_shilka",
"aa_tunguska",
"ar_t90",
"ar_t80",
"ar_t72",
"ar_btr",
"ar_bmp",
"ua_fuel",
"fort_bunk1",
"fort_bunk2",
"ua_transport1",
"ua_transport2",
"ua_transport3",
 }
 
TemplateTable_EASY_GROUND = { 
"aa_ural",
"ar_t90",
"ar_t80",
"ar_t72",
"ar_btr",
"ua_fuel",
"ua_transport1",
"ua_transport2",
"ua_transport3",
 } 
 
-- TemplateTable_SEA = { 
-- "ship_pyotr",
-- "ship_molniya",
-- "ship_neus",
 -- }
env.info('template init ground ok')


AG1 				= 		ZONE:New( "AG1" ) 
AG2 				= 		ZONE:New( "AG2" ) 
AG3 				= 		ZONE:New( "AG3" ) 
AG4 				= 		ZONE:New( "AG4" ) 
AG5 				= 		ZONE:New( "AG5" ) 

MR1 				= 		ZONE:New( "MR1" ) 
MR2 				= 		ZONE:New( "MR2" ) 
MR3 				= 		ZONE:New( "MR3" ) 
MR4 				= 		ZONE:New( "MR4" ) 
MR5 				= 		ZONE:New( "MR5" ) 

AGH1 				= 		ZONE:New( "AGH1" ) 
AGH2 				= 		ZONE:New( "AGH2" ) 
AGH3 				= 		ZONE:New( "AGH3" ) 
AGH4 				= 		ZONE:New( "AGH4" ) 
AGH5 				= 		ZONE:New( "AGH5" ) 

-- ASS1 				= 		ZONE:New( "ASS1" ) 
-- ASS2 				= 		ZONE:New( "ASS2" ) 
-- ASS3					= 		ZONE:New( "ASS3" ) 
-- ASS4					= 		ZONE:New( "ASS4" ) 
-- ASS5 				= 		ZONE:New( "ASS5" ) 

env.info('Zone ground init ok')

--NORMAL
A2GJ = SPAWN:New( "A2G_Init" )
	:InitLimit( 80000, 50000 )
	:InitRandomizeTemplate( TemplateTable_GROUND )

-- A2GAS = SPAWN:New( "A2GAS_Init" )
	-- :InitLimit( 80000, 50000 )
	-- :InitRandomizeTemplate( TemplateTable_SEA )

A2GMR = SPAWN:New( "A2GMR_Init" )
	:InitLimit( 80000, 50000 )
	:InitRandomizeTemplate( TemplateTable_EASY_GROUND )
	
A2GH = SPAWN:New( "A2GH_Init" )
	:InitLimit( 80000, 50000 )
	:InitRandomizeTemplate( TemplateTable_EASY_GROUND )

	
env.info('spawn objects ground init co ok')


function a2gj_start()
	local switch = math.random (1,5) 

if switch == 1 then
a2gj1_start()

elseif switch ==2 then
a2gj2_start()

elseif switch ==3  then
a2gj3_start()

elseif switch ==4  then
a2gj4_start()

elseif switch ==5  then
a2gj5_start()
	end
end

function a2gmr_start()
	local switch = math.random (1,5) 

if switch == 1 then
a2gmr1_start()

elseif switch ==2 then
a2gmr2_start()

elseif switch ==3  then
a2gmr3_start()

elseif switch ==4  then
a2gmr4_start()

elseif switch ==5  then
a2gmr5_start()
	end
end

-- function a2gas_start()
	-- local switch = math.random (1,5) 

-- if switch == 1 then
-- a2gas1_start()

-- elseif switch ==2 then
-- a2gas2_start()

-- elseif switch ==3  then
-- a2gas3_start()

-- elseif switch ==4  then
-- a2gas4_start()

-- elseif switch ==5  then
-- a2gas5_start()
	-- end
-- end

function a2gh_start()
	local switch = math.random (1,5) 

if switch == 1 then
a2gh1_start()

elseif switch ==2 then
a2gh2_start()

elseif switch ==3  then
a2gh3_start()

elseif switch ==4  then
a2gh4_start()

elseif switch ==5  then
a2gh5_start()
	end
end

function a2gj1_start()  --1 per group
for i=1, 25 do
	A2GJ:SpawnInZone( AG1, true )
end
end

function a2gj2_start()  --1 per group
for i=1, 25 do
	A2GJ:SpawnInZone( AG2, true )
end
end

function a2gj3_start()  --1 per group
for i=1, 25 do
	A2GJ:SpawnInZone( AG3, true )
end
end

function a2gj4_start()  --1 per group
for i=1, 25 do
	A2GJ:SpawnInZone( AG4, true )
end
end

function a2gj5_start()  --1 per group
for i=1, 25 do
	A2GJ:SpawnInZone( AG5, true )
end
end

function a2gmr1_start()  --1 per group
for i=1, 18 do
	A2GMR:SpawnInZone( MR1, true )
end
end

function a2gmr2_start()  --1 per group
for i=1, 18 do
	A2GMR:SpawnInZone( MR2, true )
end
end

function a2gmr3_start()  --1 per group
for i=1, 18 do
	A2GMR:SpawnInZone( MR3, true )
end
end

function a2gmr4_start()  --1 per group
for i=1, 18 do
	A2GMR:SpawnInZone( MR4, true )
end
end

function a2gmr5_start()  --1 per group
for i=1, 18 do
	A2GMR:SpawnInZone( MR5, true )
end
end

-- function a2gas1_start()  --1 per group
	-- A2GAS:SpawnInZone( ASS1, true )
	-- A2GAS:SpawnInZone( ASS1, true )
-- end


-- function a2gas2_start()  --1 per group
	-- A2GAS:SpawnInZone( ASS2, true )
	-- A2GAS:SpawnInZone( ASS2, true )
-- end


-- function a2gas3_start()  --1 per group
	-- A2GAS:SpawnInZone( ASS3, true )
	-- A2GAS:SpawnInZone( ASS3, true )
-- end


-- function a2gas4_start()  --4 per group
	-- A2GAS:SpawnInZone( ASS4, true )
	-- A2GAS:SpawnInZone( ASS4, true )
-- end


-- function a2gas5_start()  --5 per group
	-- A2GAS:SpawnInZone( ASS5, true )
	-- A2GAS:SpawnInZone( ASS5, true )
-- end

function a2gh1_start()  --1 per group
for i=1, 18 do
	A2GH:SpawnInZone(  AGH1, true )
end
end

function a2gh2_start()  --1 per group
for i=1, 18 do
	A2GH:SpawnInZone(  AGH2, true )
end
end

function a2gh3_start()  --1 per group
for i=1, 18 do
	A2GH:SpawnInZone( AGH3, true )
end
end

function a2gh4_start()  --1 per group
for i=1, 18 do
	A2GH:SpawnInZone( AGH4, true )
end
end

function a2gh5_start()  --1 per group
for i=1, 18 do
	A2GH:SpawnInZone( AGH5, true )
end
end

env.info('functions ground init ok')


env.info('Deadly GROUND scripting complete')