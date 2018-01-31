CPS 				= 		ZONE:New("CPS")

TemplateTable_EASY = { 
"mig21_easy", 
"f5_easy", 
"mig31_easy", 
"f4_easy",
 } -- x1 Per Group

TemplateTable_NORMAL = { 
"su27_norm", 
"su33_norm", 
"mig29_norm", 
"m2k_norm", 
"f16_norm", 
"f4_norm", 
"f18_norm",
} -- x2 Per Group

TemplateTable_HARD = { 
"su27_hard", 
"su33_hard", 
"mig29_hard", 
"f15_hard", 
"f16_hard", 
} 

TemplateTable_ALL = { 
"su27_hard", 
"su33_hard", 
"mig29_hard", 
"f15_hard", 
"f16_hard", 
"su27_norm", 
"su33_norm", 
"mig29_norm", 
"m2k_norm", 
"f16_norm", 
"f4_norm", 
"f18_norm",
"mig21_easy", 
"f5_easy", 
"mig31_easy", 
"f4_easy",
} 

A2A_Easy = SPAWN:New( "A2A_Spawn_Init_EASY" )
	:InitLimit( 500, 500 )
	:InitRandomizeTemplate( TemplateTable_EASY )
	:InitRepeatOnLanding()
	:InitRandomizeRoute( 1, 1, 20000 ) 				
	

A2A_Norm = SPAWN:New( "A2A_Spawn_Init_NORM" )
	:InitLimit( 500, 500 )
	:InitRandomizeTemplate( TemplateTable_NORMAL )
	:InitRepeatOnLanding()
	:InitRandomizeRoute( 1, 1, 20000 ) 
env.info('Spawn norm ok')


A2A_Hard = SPAWN:New( "A2A_Spawn_Init_HARD" )
	:InitLimit( 500, 500 )
	:InitRandomizeTemplate( TemplateTable_HARD )
	:InitRepeatOnLanding()
	:InitRandomizeRoute( 1, 1, 20000 ) 		
	
A2A_ALL = SPAWN:New( "A2A_Spawn_Init_ALL" )
	:InitLimit( 500, 500 )
	:InitRandomizeTemplate( TemplateTable_ALL )
	:InitRepeatOnLanding()
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
	
function sp(groupName)
	group = SPAWN:New(groupName)
	:InitRepeatOnLanding()
	group:Spawn()
end