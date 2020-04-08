--///////////////////////////////////////////////
--Name: Operation Snowfox A2A Defence System
--Author: Surrexen    ༼ つ ◕_◕ ༽つ    (づ｡◕‿◕｡)づ
--///////////////////////////////////////////////

--////BLUE AIR DEFENCE
function SEF_BLUEDISPATCHERON()
	--BLUE AIR DISPATCHER
	BLUEDetectionSetGroup = SET_GROUP:New()
	BLUEDetectionSetGroup:FilterPrefixes( { "DF BLUE EWR", "RT AWACS BLUE#" } )
	BLUEDetectionSetGroup:FilterStart()
	BLUEDetection = DETECTION_AREAS:New( BLUEDetectionSetGroup, 30000 )	
	BLUEA2ADispatcher = AI_A2A_DISPATCHER:New( BLUEDetection )
	BLUEA2ADispatcher:SetTacticalDisplay( false )
		
	BLUEA2ADispatcher:SetDefaultFuelThreshold( 0.15 )
	--BLUEA2ADispatcher:SetDefaultDamageThreshold( 0.60 )
	BLUEA2ADispatcher:SetDefaultCapLimit( 1 )
	BLUEA2ADispatcher:SetDefaultTakeoffInAirAltitude(3000)
	
	BLUEA2ADispatcher:SetEngageRadius( 60000 )
	BLUEA2ADispatcher:SetDisengageRadius( 80000 ) 
	
	--trigger.action.outText("Blue Air Dispatcher Is Now Enabled", 15)	
end	

--////BLUE SQUADRONS AND EXECUTION
--BLUE TEMPLATE PLANES
--SQ BLUE F-16C
--SQ BLUE F-14B 
--SQ BLUE F/A-18C

function SEF_KhasabCAP()
		
	if ( GameMode == 0 ) then
		--KHASAB CAP F-16's MULTIPLAYER SETTINGS
		BLUEA2ADispatcher:SetSquadron( "Rogue", AIRBASE.PersianGulf.Khasab, { "SQ BLUE F-16C" } )
		BLUEA2ADispatcher:SetSquadronOverhead( "Rogue", 1)
		BLUEA2ADispatcher:SetSquadronGrouping( "Rogue", 2 )
		BLUEA2ADispatcher:SetSquadronTakeoffInAir( "Rogue" )
		BLUEA2ADispatcher:SetSquadronLandingAtRunway( "Rogue" )
		CAPZoneBlue1 = ZONE:New( "CAP Zone BLUE 1")
		BLUEA2ADispatcher:SetSquadronCap( "Rogue", CAPZoneBlue1, 3000, 11000, 743, 867, 800, 1200, "BARO" )
		BLUEA2ADispatcher:SetSquadronCapInterval( "Rogue", 1, 150, 600, 1 )
	else
		--KHASAB CAP F-16's SINGLEPLAYER SETTINGS
		BLUEA2ADispatcher:SetSquadron( "Rogue", AIRBASE.PersianGulf.Khasab, { "SQ BLUE F-16C" } )
		BLUEA2ADispatcher:SetSquadronOverhead( "Rogue", 1)
		BLUEA2ADispatcher:SetSquadronGrouping( "Rogue", 2 )
		BLUEA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Rogue" )
		BLUEA2ADispatcher:SetSquadronLandingAtRunway( "Rogue" )
		CAPZoneBlue1 = ZONE:New( "CAP Zone BLUE 1")
		BLUEA2ADispatcher:SetSquadronCap( "Rogue", CAPZoneBlue1, 3000, 11000, 743, 867, 800, 1200, "BARO" )
		BLUEA2ADispatcher:SetSquadronCapInterval( "Rogue", 1, 150, 600, 1 )	
	end
		
	trigger.action.outText("Khasab Vipers Are Now Enabled", 15)
	missionCommands.removeItemForCoalition(coalition.side.BLUE, {[1] = "Snowfox Options", [2] = "Snowfox CAP Options", [3] = "Enable Khasab Vipers"})
end	

function SEF_FleetTomcats()	
		
	if ( GameMode == 0 ) then
		--////CARRIER GROUP TOMCATS MULTIPLAYER SETTINGS
		BLUEA2ADispatcher:SetSquadron( "Tomcat", "CVN-74 John C. Stennis", { "SQ BLUE F-14B" } )
		BLUEA2ADispatcher:SetSquadronOverhead( "Tomcat", 1)
		BLUEA2ADispatcher:SetSquadronGrouping( "Tomcat", 2 )
		BLUEA2ADispatcher:SetSquadronTakeoffInAir( "Tomcat" )
		BLUEA2ADispatcher:SetSquadronLandingAtRunway( "Tomcat" )
		
		CAPZoneBlueCarrier = ZONE_GROUP:New("CAP Zone Carrier", GROUP:FindByName( "CVN-74 John C. Stennis" ), 20000)
		BLUEA2ADispatcher:SetSquadronCap( "Tomcat", CAPZoneBlueCarrier, 3000, 11000, 768, 905, 800, 1200, "BARO" )
		BLUEA2ADispatcher:SetSquadronCapInterval( "Tomcat", 1, 150, 600, 1 )
	else
		--////CARRIER GROUP TOMCATS SINGLEPLAYER SETTINGS
		BLUEA2ADispatcher:SetSquadron( "Tomcat", "CVN-74 John C. Stennis", { "SQ BLUE F-14B" } )
		BLUEA2ADispatcher:SetSquadronOverhead( "Tomcat", 1)
		BLUEA2ADispatcher:SetSquadronGrouping( "Tomcat", 2 )
		BLUEA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Tomcat" )
		BLUEA2ADispatcher:SetSquadronLandingAtRunway( "Tomcat" )
		
		CAPZoneBlueCarrier = ZONE_GROUP:New("CAP Zone Carrier", GROUP:FindByName( "CVN-74 John C. Stennis" ), 20000)
		BLUEA2ADispatcher:SetSquadronCap( "Tomcat", CAPZoneBlueCarrier, 3000, 11000, 768, 905, 800, 1200, "BARO" )
		BLUEA2ADispatcher:SetSquadronCapInterval( "Tomcat", 1, 150, 600, 1 )
	end	
		
	trigger.action.outText("Fleet Defence Tomcats Are Now Enabled", 15)
	missionCommands.removeItemForCoalition(coalition.side.BLUE, {[1] = "Snowfox Options", [2] = "Snowfox CAP Options", [3] = "Enable Fleet Tomcats"})
	missionCommands.removeItemForCoalition(coalition.side.BLUE, {[1] = "Snowfox Options", [2] = "Snowfox CAP Options", [3] = "Enable Fleet Hornets"})	
end

function SEF_FleetHornets()
		
	if ( GameMode == 0 ) then
		--////CARRIER GROUP HORNETS MULTIPLAYER SETTINGS
		BLUEA2ADispatcher:SetSquadron( "Hornet", "CVN-74 John C. Stennis", { "SQ BLUE F/A-18C" } )
		BLUEA2ADispatcher:SetSquadronOverhead( "Hornet", 1)
		BLUEA2ADispatcher:SetSquadronGrouping( "Hornet", 2 )
		BLUEA2ADispatcher:SetSquadronTakeoffInAir( "Hornet" )
		BLUEA2ADispatcher:SetSquadronLandingAtRunway( "Hornet" )

		CAPZoneBlueCarrier = ZONE_GROUP:New("CAP Zone Carrier", GROUP:FindByName( "CVN-74 John C. Stennis" ), 20000)
		BLUEA2ADispatcher:SetSquadronCap( "Hornet", CAPZoneBlueCarrier, 3000, 11000, 743, 867, 800, 1200, "BARO" )
		BLUEA2ADispatcher:SetSquadronCapInterval( "Hornet", 1, 150, 600, 1 )
	else
		--////CARRIER GROUP HORNETS SINGLEPLAYER SETTINGS
		BLUEA2ADispatcher:SetSquadron( "Hornet", "CVN-74 John C. Stennis", { "SQ BLUE F/A-18C" } )
		BLUEA2ADispatcher:SetSquadronOverhead( "Hornet", 1)
		BLUEA2ADispatcher:SetSquadronGrouping( "Hornet", 2 )
		BLUEA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Hornet" )
		BLUEA2ADispatcher:SetSquadronLandingAtRunway( "Hornet" )

		CAPZoneBlueCarrier = ZONE_GROUP:New("CAP Zone Carrier", GROUP:FindByName( "CVN-74 John C. Stennis" ), 20000)
		BLUEA2ADispatcher:SetSquadronCap( "Hornet", CAPZoneBlueCarrier, 3000, 11000, 743, 867, 800, 1200, "BARO" )
		BLUEA2ADispatcher:SetSquadronCapInterval( "Hornet", 1, 150, 600, 1 )
	end
	
	trigger.action.outText("Fleet Defence Hornets Are Now Enabled", 15)
	missionCommands.removeItemForCoalition(coalition.side.BLUE, {[1] = "Snowfox Options", [2] = "Snowfox CAP Options", [3] = "Enable Fleet Tomcats"})
	missionCommands.removeItemForCoalition(coalition.side.BLUE, {[1] = "Snowfox Options", [2] = "Snowfox CAP Options", [3] = "Enable Fleet Hornets"})	
end

--=============================================================================================================================================
--////RED AIR DEFENCE

function SEF_REDDISPATCHERON()

	REDDetectionSetGroup = SET_GROUP:New()	
	REDDetectionSetGroup:FilterPrefixes( { "SQ RUS", "SQ IRN", "RT RED" } )
	REDDetectionSetGroup:FilterActive()
	REDDetectionSetGroup:FilterStart()
	REDDetection = DETECTION_AREAS:New( REDDetectionSetGroup, 30000 )	
	REDA2ADispatcher = AI_A2A_DISPATCHER:New( REDDetection )
	REDA2ADispatcher:SetTacticalDisplay( false )
	RedBorderZone = ZONE_POLYGON:New( "RED Border", GROUP:FindByName( "RED Border" ) )
	REDA2ADispatcher:SetBorderZone( RedBorderZone )
	
	REDA2ADispatcher:SetDefaultFuelThreshold( 0.15 )
	--REDA2ADispatcher:SetDefaultDamageThreshold( 0.60 )
	REDA2ADispatcher:SetDefaultCapLimit( 1 )
	REDA2ADispatcher:SetDefaultTakeoffInAirAltitude(3000)
	
	REDA2ADispatcher:SetEngageRadius( 200000 )	
	REDA2ADispatcher:SetDisengageRadius( 250000 )

	--trigger.action.outText("Red Air Dispatcher Is Now Enabled", 15)	
end	

function SEF_REDSQUADRONSMULTIPLAYER()
	
	--////RED SQUADRONS

	--TEMPLATE PLANES
	--SQ IRN F-4E
	--SQ IRN F-5E-3
	--SQ IRN MiG-21Bis
	--SQ IRN MiG-29A

	--SQ RUS MiG-21Bis
	--SQ RUS MiG-29A
	--SQ RUS MiG-29S
	--SQ RUS MiG-31
	--SQ RUS MiG-25PD
	--SQ RUS MiG-23MLD
	--SQ RUS Su-27
	--SQ RUS Su-30
	--SQ RUS Su-33

	--AIRBASES
	-- * AIRBASE.PersianGulf.Abu_Dhabi_International_Airport
	-- * AIRBASE.PersianGulf.Abu_Musa_Island_Airport
	-- * AIRBASE.PersianGulf.Al-Bateen_Airport
	-- * AIRBASE.PersianGulf.Al_Ain_International_Airport
	-- * AIRBASE.PersianGulf.Al_Dhafra_AB
	-- * AIRBASE.PersianGulf.Al_Maktoum_Intl
	-- * AIRBASE.PersianGulf.Al_Minhad_AB
	-- * AIRBASE.PersianGulf.Bandar_e_Jask_airfield
	-- * AIRBASE.PersianGulf.Bandar_Abbas_Intl
	-- * AIRBASE.PersianGulf.Bandar_Lengeh
	-- * AIRBASE.PersianGulf.Dubai_Intl
	-- * AIRBASE.PersianGulf.Fujairah_Intl
	-- * AIRBASE.PersianGulf.Havadarya
	-- * AIRBASE.PersianGulf.Jiroft_Airport
	-- * AIRBASE.PersianGulf.Kerman_Airport
	-- * AIRBASE.PersianGulf.Khasab
	-- * AIRBASE.PersianGulf.Kish_International_Airport
	-- * AIRBASE.PersianGulf.Lar_Airbase
	-- * AIRBASE.PersianGulf.Lavan_Island_Airport
	-- * AIRBASE.PersianGulf.Liwa_Airbase
	-- * AIRBASE.PersianGulf.Qeshm_Island
	-- * AIRBASE.PersianGulf.Ras_Al_Khaimah
	-- * AIRBASE.PersianGulf.Sas_Al_Nakheel_Airport
	-- * AIRBASE.PersianGulf.Sharjah_Intl
	-- * AIRBASE.PersianGulf.Shiraz_International_Airport
	-- * AIRBASE.PersianGulf.Sir_Abu_Nuayr
	-- * AIRBASE.PersianGulf.Sirri_Island
	-- * AIRBASE.PersianGulf.Tunb_Island_AFB
	-- * AIRBASE.PersianGulf.Tunb_Kochak

	-- Alpha   - Bandar Lengeh   - Sector 1	  -- Operating Iranian Planes
	-- Beta    - Lar 			 - Sector 2	  -- Operating Russian Planes
	-- Gamma   - Havadarya	 	 - Sector 3	  -- Operating Iranian Planes
	-- Delta   - Bandar Abbas	 - Sector 4	  -- Operating Russian Planes
	-- Epsilon - Bandar-e-Jask   - Sector 5   -- Operating Iranian Planes
	-- Tau	   - Lar			 - Sector 6   -- Everything

	-- IRN Forces: "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A"
	-- RUS Forces: "SQ RUS MiG-21Bis", "SQ RUS MiG-29A", "SQ RUS MiG-29S", "SQ RUS MiG-23MLD", "SQ RUS MiG-25PD", "SQ RUS MiG-31", "SQ RUS Su-27", "SQ RUS Su-30", "SQ RUS Su-33"

	--////CAP Squadrons
	REDA2ADispatcher:SetSquadron( "Alpha", AIRBASE.PersianGulf.Bandar_Lengeh, { "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A" } )
	REDA2ADispatcher:SetSquadron( "Beta", AIRBASE.PersianGulf.Lar_Airbase, { "SQ RUS MiG-21Bis", "SQ RUS MiG-29A", "SQ RUS MiG-29S", "SQ RUS MiG-23MLD", "SQ RUS MiG-25PD", "SQ RUS MiG-31", "SQ RUS Su-27", "SQ RUS Su-30", "SQ RUS Su-33" } )
	REDA2ADispatcher:SetSquadron( "Gamma", AIRBASE.PersianGulf.Havadarya, { "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A" } )
	REDA2ADispatcher:SetSquadron( "Delta", AIRBASE.PersianGulf.Bandar_Abbas_Intl, { "SQ RUS MiG-21Bis", "SQ RUS MiG-29A", "SQ RUS MiG-29S", "SQ RUS MiG-23MLD", "SQ RUS MiG-25PD", "SQ RUS MiG-31", "SQ RUS Su-27", "SQ RUS Su-30", "SQ RUS Su-33" } )
	REDA2ADispatcher:SetSquadron( "Epsilon", AIRBASE.PersianGulf.Bandar_e_Jask_airfield, { "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A" } )
	REDA2ADispatcher:SetSquadron( "Tau", AIRBASE.PersianGulf.Lar_Airbase, { "SQ RUS MiG-21Bis", "SQ RUS MiG-29A", "SQ RUS MiG-29S", "SQ RUS MiG-23MLD", "SQ RUS MiG-25PD", "SQ RUS MiG-31", "SQ RUS Su-27", "SQ RUS Su-30", "SQ RUS Su-33", "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A" } )

	--////SQUADRON OVERHEAD (1.0-1.5)
	REDA2ADispatcher:SetSquadronOverhead( "Alpha", 1.0)
	REDA2ADispatcher:SetSquadronOverhead( "Beta", 1.0)
	REDA2ADispatcher:SetSquadronOverhead( "Gamma", 1.0)
	REDA2ADispatcher:SetSquadronOverhead( "Delta", 1.0)
	REDA2ADispatcher:SetSquadronOverhead( "Epsilon", 1.0)
	REDA2ADispatcher:SetSquadronOverhead( "Tau", 1.0)

	--////SQUADRON GROUPING (Number of planes to be launched)
	REDA2ADispatcher:SetSquadronGrouping( "Alpha", 2 )
	REDA2ADispatcher:SetSquadronGrouping( "Beta", 2 )
	REDA2ADispatcher:SetSquadronGrouping( "Gamma", 2 )
	REDA2ADispatcher:SetSquadronGrouping( "Delta", 2 )
	REDA2ADispatcher:SetSquadronGrouping( "Epsilon", 2 )
	REDA2ADispatcher:SetSquadronGrouping( "Tau", 2 )

	--////SQUADRON TAKEOFF METHOD
	--REDA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Alpha" )
	--REDA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Beta" )
	--REDA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Gamma" )
	--REDA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Delta" )
	--REDA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Epsilon" )
	--REDA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Tau" )

	--REDA2ADispatcher:SetSquadronTakeoffFromRunway( "Alpha" )
	--REDA2ADispatcher:SetSquadronTakeoffFromRunway( "Beta" )
	--REDA2ADispatcher:SetSquadronTakeoffFromRunway( "Gamma" )
	--REDA2ADispatcher:SetSquadronTakeoffFromRunway( "Delta" )
	--REDA2ADispatcher:SetSquadronTakeoffFromRunway( "Epsilon" )
	--REDA2ADispatcher:SetSquadronTakeoffFromRunway( "Tau" )

	REDA2ADispatcher:SetSquadronTakeoffInAir( "Alpha" )
	REDA2ADispatcher:SetSquadronTakeoffInAir( "Beta" )
	REDA2ADispatcher:SetSquadronTakeoffInAir( "Gamma" )
	REDA2ADispatcher:SetSquadronTakeoffInAir( "Delta" )
	REDA2ADispatcher:SetSquadronTakeoffInAir( "Epsilon" )
	REDA2ADispatcher:SetSquadronTakeoffInAir( "Tau" )

	--////SQUADRON LANDING METHOD
	REDA2ADispatcher:SetSquadronLandingAtRunway( "Alpha" )
	REDA2ADispatcher:SetSquadronLandingAtRunway( "Beta" )
	REDA2ADispatcher:SetSquadronLandingAtRunway( "Gamma" )
	REDA2ADispatcher:SetSquadronLandingAtRunway( "Delta" )
	REDA2ADispatcher:SetSquadronLandingAtRunway( "Epsilon" )
	REDA2ADispatcher:SetSquadronLandingAtRunway( "Tau" )

	--////RED CAP SQUADRON EXECUTION
	--////function AI_A2A_DISPATCHER:SetSquadronCap( SquadronName, Zone, FloorAltitude, CeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, EngageMinSpeed, EngageMaxSpeed, AltType )
	--////function AI_A2A_DISPATCHER:SetSquadronCapInterval( SquadronName, CapLimit, LowInterval, HighInterval, Probability )

	--////CAP ZONES
	CAPZoneRed1 = ZONE:New("CAP Zone RED 1")
	CAPZoneRed2 = ZONE:New("CAP Zone RED 2")
	CAPZoneRed3 = ZONE:New("CAP Zone RED 3")
	CAPZoneRed4 = ZONE:New("CAP Zone RED 4")
	CAPZoneRed5 = ZONE:New("CAP Zone RED 5")
	CAPZoneRed6 = ZONE_POLYGON:New( "CAP Zone RED 6", GROUP:FindByName( "CAP Zone RED 6" ) )

	--////RED CAP SQUADRON EXECUTION
	REDA2ADispatcher:SetSquadronCap( "Alpha", CAPZoneRed1, 1000, 11000, 750, 900, 800, 1200, "BARO" )
	REDA2ADispatcher:SetSquadronCapInterval( "Alpha", 1, 450, 900, 1 )
	REDA2ADispatcher:SetSquadronCap( "Beta", CAPZoneRed2, 2500, 11000, 750, 900, 800, 1200, "BARO" )
	REDA2ADispatcher:SetSquadronCapInterval( "Beta", 1, 450, 900, 1 )
	REDA2ADispatcher:SetSquadronCap( "Gamma", CAPZoneRed3, 1000, 11000, 750, 900, 800, 1200, "BARO" )
	REDA2ADispatcher:SetSquadronCapInterval( "Gamma", 1, 450, 900, 1 )
	REDA2ADispatcher:SetSquadronCap( "Delta", CAPZoneRed4, 1000, 11000, 750, 900, 800, 1200, "BARO" )
	REDA2ADispatcher:SetSquadronCapInterval( "Delta", 1, 450, 900, 1 )
	REDA2ADispatcher:SetSquadronCap( "Epsilon", CAPZoneRed5, 1000, 11000, 750, 900, 800, 1200, "BARO" )
	REDA2ADispatcher:SetSquadronCapInterval( "Epsilon", 1, 450, 900, 1 )
	REDA2ADispatcher:SetSquadronCap( "Tau", CAPZoneRed6, 2500, 11000, 750, 900, 800, 1200, "BARO" )
	REDA2ADispatcher:SetSquadronCapInterval( "Tau", 1, 450, 900, 1 )		
end

function SEF_REDSQUADRONSSINGLEPLAYER()

	--////RED SQUADRONS

	--TEMPLATE PLANES
	--SQ IRN F-4E
	--SQ IRN F-5E-3
	--SQ IRN MiG-21Bis
	--SQ IRN MiG-29A

	--SQ RUS MiG-21Bis
	--SQ RUS MiG-29A
	--SQ RUS MiG-29S
	--SQ RUS MiG-31
	--SQ RUS MiG-25PD
	--SQ RUS MiG-23MLD
	--SQ RUS Su-27
	--SQ RUS Su-30
	--SQ RUS Su-33

	--AIRBASES
	-- * AIRBASE.PersianGulf.Abu_Dhabi_International_Airport
	-- * AIRBASE.PersianGulf.Abu_Musa_Island_Airport
	-- * AIRBASE.PersianGulf.Al-Bateen_Airport
	-- * AIRBASE.PersianGulf.Al_Ain_International_Airport
	-- * AIRBASE.PersianGulf.Al_Dhafra_AB
	-- * AIRBASE.PersianGulf.Al_Maktoum_Intl
	-- * AIRBASE.PersianGulf.Al_Minhad_AB
	-- * AIRBASE.PersianGulf.Bandar_e_Jask_airfield
	-- * AIRBASE.PersianGulf.Bandar_Abbas_Intl
	-- * AIRBASE.PersianGulf.Bandar_Lengeh
	-- * AIRBASE.PersianGulf.Dubai_Intl
	-- * AIRBASE.PersianGulf.Fujairah_Intl
	-- * AIRBASE.PersianGulf.Havadarya
	-- * AIRBASE.PersianGulf.Jiroft_Airport
	-- * AIRBASE.PersianGulf.Kerman_Airport
	-- * AIRBASE.PersianGulf.Khasab
	-- * AIRBASE.PersianGulf.Kish_International_Airport
	-- * AIRBASE.PersianGulf.Lar_Airbase
	-- * AIRBASE.PersianGulf.Lavan_Island_Airport
	-- * AIRBASE.PersianGulf.Liwa_Airbase
	-- * AIRBASE.PersianGulf.Qeshm_Island
	-- * AIRBASE.PersianGulf.Ras_Al_Khaimah
	-- * AIRBASE.PersianGulf.Sas_Al_Nakheel_Airport
	-- * AIRBASE.PersianGulf.Sharjah_Intl
	-- * AIRBASE.PersianGulf.Shiraz_International_Airport
	-- * AIRBASE.PersianGulf.Sir_Abu_Nuayr
	-- * AIRBASE.PersianGulf.Sirri_Island
	-- * AIRBASE.PersianGulf.Tunb_Island_AFB
	-- * AIRBASE.PersianGulf.Tunb_Kochak

	-- Alpha   - Bandar Lengeh   - Sector 1	  -- Operating Iranian Planes
	-- Beta    - Lar 			 - Sector 2	  -- Operating Russian Planes
	-- Gamma   - Havadarya	 	 - Sector 3	  -- Operating Iranian Planes
	-- Delta   - Bandar Abbas	 - Sector 4	  -- Operating Russian Planes
	-- Epsilon - Bandar-e-Jask   - Sector 5   -- Operating Iranian Planes
	-- Tau	   - Lar			 - Sector 6	  -- Everything	

	-- IRN Forces: "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A"
	-- RUS Forces: "SQ RUS MiG-21Bis", "SQ RUS MiG-29A", "SQ RUS MiG-29S", "SQ RUS MiG-23MLD", "SQ RUS MiG-25PD", "SQ RUS MiG-31", "SQ RUS Su-27", "SQ RUS Su-30", "SQ RUS Su-33"

	--////CAP SQUADRONS CONFIGURATION
	REDA2ADispatcher:SetSquadron( "Alpha", AIRBASE.PersianGulf.Bandar_Lengeh, { "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A" } )
	REDA2ADispatcher:SetSquadron( "Beta", AIRBASE.PersianGulf.Lar_Airbase, { "SQ RUS MiG-21Bis", "SQ RUS MiG-29A", "SQ RUS MiG-29S", "SQ RUS MiG-23MLD", "SQ RUS MiG-25PD", "SQ RUS MiG-31", "SQ RUS Su-27", "SQ RUS Su-30", "SQ RUS Su-33" } )
	REDA2ADispatcher:SetSquadron( "Gamma", AIRBASE.PersianGulf.Havadarya, { "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A" } )
	REDA2ADispatcher:SetSquadron( "Delta", AIRBASE.PersianGulf.Bandar_Abbas_Intl, { "SQ RUS MiG-21Bis", "SQ RUS MiG-29A", "SQ RUS MiG-29S", "SQ RUS MiG-23MLD", "SQ RUS MiG-25PD", "SQ RUS MiG-31", "SQ RUS Su-27", "SQ RUS Su-30", "SQ RUS Su-33" } )
	REDA2ADispatcher:SetSquadron( "Epsilon", AIRBASE.PersianGulf.Bandar_e_Jask_airfield, { "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A" } )
	REDA2ADispatcher:SetSquadron( "Tau", AIRBASE.PersianGulf.Lar_Airbase, { "SQ RUS MiG-21Bis", "SQ RUS MiG-29A", "SQ RUS MiG-29S", "SQ RUS MiG-23MLD", "SQ RUS MiG-25PD", "SQ RUS MiG-31", "SQ RUS Su-27", "SQ RUS Su-30", "SQ RUS Su-33", "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A" } )

	--////SQUADRON OVERHEAD (1.0-1.5)

	REDA2ADispatcher:SetSquadronOverhead( "Alpha", 1.0)
	REDA2ADispatcher:SetSquadronOverhead( "Beta", 1.0)
	REDA2ADispatcher:SetSquadronOverhead( "Gamma", 1.0)
	REDA2ADispatcher:SetSquadronOverhead( "Delta", 1.0)
	REDA2ADispatcher:SetSquadronOverhead( "Epsilon", 1.0)
	REDA2ADispatcher:SetSquadronOverhead( "Tau", 1.0)

	--////SQUADRON GROUPING (Number of planes to be launched)

	REDA2ADispatcher:SetSquadronGrouping( "Alpha", 2 )
	REDA2ADispatcher:SetSquadronGrouping( "Beta", 2 )
	REDA2ADispatcher:SetSquadronGrouping( "Gamma", 2 )
	REDA2ADispatcher:SetSquadronGrouping( "Delta", 2 )
	REDA2ADispatcher:SetSquadronGrouping( "Epsilon", 2 )
	REDA2ADispatcher:SetSquadronGrouping( "Tau", 2 )

	--////SQUADRON TAKEOFF METHOD
	REDA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Alpha" )
	REDA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Beta" )
	REDA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Gamma" )
	REDA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Delta" )
	REDA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Epsilon" )
	REDA2ADispatcher:SetSquadronTakeoffFromParkingHot( "Tau" )

	--REDA2ADispatcher:SetSquadronTakeoffFromRunway( "Alpha" )
	--REDA2ADispatcher:SetSquadronTakeoffFromRunway( "Beta" )
	--REDA2ADispatcher:SetSquadronTakeoffFromRunway( "Gamma" )
	--REDA2ADispatcher:SetSquadronTakeoffFromRunway( "Delta" )
	--REDA2ADispatcher:SetSquadronTakeoffFromRunway( "Epsilon" )
	--REDA2ADispatcher:SetSquadronTakeoffFromRunway( "Tau" )

	--REDA2ADispatcher:SetSquadronTakeoffInAir( "Alpha" )
	--REDA2ADispatcher:SetSquadronTakeoffInAir( "Beta" )
	--REDA2ADispatcher:SetSquadronTakeoffInAir( "Gamma" )
	--REDA2ADispatcher:SetSquadronTakeoffInAir( "Delta" )
	--REDA2ADispatcher:SetSquadronTakeoffInAir( "Epsilon" )
	--REDA2ADispatcher:SetSquadronTakeoffInAir( "Tau" )

	--////SQUADRON LANDING METHOD
	REDA2ADispatcher:SetSquadronLandingAtRunway( "Alpha" )
	REDA2ADispatcher:SetSquadronLandingAtRunway( "Beta" )
	REDA2ADispatcher:SetSquadronLandingAtRunway( "Gamma" )
	REDA2ADispatcher:SetSquadronLandingAtRunway( "Delta" )
	REDA2ADispatcher:SetSquadronLandingAtRunway( "Epsilon" )
	REDA2ADispatcher:SetSquadronLandingAtRunway( "Tau" )

	--////RED CAP SQUADRON EXECUTION
	--////function AI_A2A_DISPATCHER:SetSquadronCap( SquadronName, Zone, FloorAltitude, CeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, EngageMinSpeed, EngageMaxSpeed, AltType )
	--////function AI_A2A_DISPATCHER:SetSquadronCapInterval( SquadronName, CapLimit, LowInterval, HighInterval, Probability )

	--////CAP ZONES
	CAPZoneRed1 = ZONE:New("CAP Zone RED 1")
	CAPZoneRed2 = ZONE:New("CAP Zone RED 2")
	CAPZoneRed3 = ZONE:New("CAP Zone RED 3")
	CAPZoneRed4 = ZONE:New("CAP Zone RED 4")
	CAPZoneRed5 = ZONE:New("CAP Zone RED 5")
	CAPZoneRed6 = ZONE_POLYGON:New( "CAP Zone RED 6", GROUP:FindByName( "CAP Zone RED 6" ) )

	--////RED CAP SQUADRON EXECUTION
	REDA2ADispatcher:SetSquadronCap( "Alpha", CAPZoneRed1, 1000, 11000, 750, 900, 800, 1200, "BARO" )
	REDA2ADispatcher:SetSquadronCapInterval( "Alpha", 1, 300, 900, 1 )
	REDA2ADispatcher:SetSquadronCap( "Beta", CAPZoneRed2, 2500, 11000, 750, 900, 800, 1200, "BARO" )
	REDA2ADispatcher:SetSquadronCapInterval( "Beta", 1, 300, 900, 1 )
	REDA2ADispatcher:SetSquadronCap( "Gamma", CAPZoneRed3, 1000, 11000, 750, 900, 800, 1200, "BARO" )
	REDA2ADispatcher:SetSquadronCapInterval( "Gamma", 1, 300, 900, 1 )
	REDA2ADispatcher:SetSquadronCap( "Delta", CAPZoneRed4, 1000, 11000, 750, 900, 800, 1200, "BARO" )
	REDA2ADispatcher:SetSquadronCapInterval( "Delta", 1, 300, 900, 1 )
	REDA2ADispatcher:SetSquadronCap( "Epsilon", CAPZoneRed5, 1000, 11000, 750, 900, 800, 1200, "BARO" )
	REDA2ADispatcher:SetSquadronCapInterval( "Epsilon", 1, 300, 900, 1 )
	REDA2ADispatcher:SetSquadronCap( "Tau", CAPZoneRed6, 2500, 11000, 750, 900, 800, 1200, "BARO" )
	REDA2ADispatcher:SetSquadronCapInterval( "Tau", 1, 300, 900, 1 )	
end

function SEF_CleanUpAirports()
	CleanUpAirports = CLEANUP_AIRBASE:New( { AIRBASE.PersianGulf.Havadarya, 
											 AIRBASE.PersianGulf.Bandar_Lengeh, 
											 AIRBASE.PersianGulf.Lar_Airbase,											  
											 AIRBASE.PersianGulf.Bandar_Abbas_Intl,											  
											 AIRBASE.PersianGulf.Bandar_e_Jask_airfield,
											 
											 AIRBASE.PersianGulf.Khasab,
											 AIRBASE.PersianGulf.Sharjah_Intl,
											 AIRBASE.PersianGulf.Ras_Al_Khaimah_International_Airport											 
											 } )
end

function SEF_BLUEDEFENCENETWORK()
	
	--////ADD TO DEFENCE NETWORK
	BLUEDetectionSetGroup:AddGroupsByName( { 	"CVN-74 John C. Stennis",
												"LHA-1 Tarawa"
												--"Al Dhafra - Patriot",
												--"Al Minhad - Patriot",
												--"Sharjah - Hawk",
												--"Khasab - Hawk"	
												} )	
end

function SEF_REDDEFENCENETWORK()

	--////CREATE MASTER LIST THEN LOOP THROUGH THE ALIVE UNITS AND ADD TO RED DEFENCE NETWORK
	REDDefenceNetworkGroup = SET_GROUP:New()
	REDDefenceNetworkGroup:FilterPrefixes( { 	"DF RED EWR",	
												"Bandar Lengeh - EWR Bandar Lengeh",
												"Havadarya - EWR Tazeyan-e Zir",
												"Havadarya - EWR Havadarya",
												"Bandar Lengeh - EWR Kish",
												"Jask - EWR Jask",
												"Bandar Abbas - Hawk",
												"Bandar Abbas - SA-5",												
												"Bandar Lengeh - SA-11",
												"Havadarya - HQ-2",
												"Lavan Island - Hawk",
												"Seerik - Khordad",
												"Qeshm Island - Mobile Radar", 
												"Sirri Island - Navy 1",
												"Bandar Lengeh - Navy 1",
												"Havadarya - Navy 2",
												"Jask - Navy 1",
												"Seerik - Navy 1",
												"Abu Musa - SAM 1",
												"Sirri Island - SAM 1",
												"Tunb Island - SAM 1",
												"Tunb Kochak - SAM 1",
												"Bandar Lengeh - SAM 1",
												"Qeshm Island - SAM 1",
												"Havadarya - SAM 1",
												"Bandar Abbas - SAM 1",
												"Seerik - SAM 1",
												"Jask - SAM 1",
												"Minab - SAM 1",
												"Bandar Abbas - SAM 2" 
												} )
	REDDefenceNetworkGroup:FilterOnce()
	
	REDDefenceNetworkGroup:ForEachGroupAlive(
		function(RedDefenceGroupCheck)
			RedDefenceGroupName = RedDefenceGroupCheck:GetName()			
			REDDetectionSetGroup:AddGroupsByName( { RedDefenceGroupName } )			
		end
	)	
end

----------------------------------------------------------------------------------------------------------------------------------------------

function SEF_AIRFIELDPERIMETERZONES()
	
	--////The airfield perimeters are set to 75km radius around the airfield (~40nm)	
	BandarLengehPerimeterZone 	= ZONE:New("Bandar Lengeh Perimeter")
	HavadaryaPerimeterZone 		= ZONE:New("Havadarya Perimeter")
	BandarAbbasPerimeterZone 	= ZONE:New("Bandar Abbas Perimeter")
	JaskPerimeterZone 			= ZONE:New("Jask Perimeter")
	--LarPerimeterZone 			= ZONE:New("Lar Perimeter")
	--JiroftPerimeterZone		= ZONE:New("Jiroft Perimeter")	
end

function SEF_AIRFIELDPERIMETERCLIENTS()
	SET_AIRFIELDPERIMETERCLIENTS = SET_CLIENT:New():FilterCoalitions("blue"):FilterActive():FilterStart()
end

function SEF_AIRFIELDPERIMETERZONECLIENTSCANNER(Timeloop, time)
	
	BandarLengehPerimeterCount 	= 0
	HavadaryaPerimeterCount 	= 0
	BandarAbbasPerimeterCount 	= 0
	JaskPerimeterCount 			= 0
	--LarPerimeterCount			= 0
	--JiroftPerimeterCount		= 0
	
	--////Count Clients Inside Airfield Perimeter Zones
	SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(BandarLengehPerimeterZone, function ( GroupObject )
		BandarLengehPerimeterCount = BandarLengehPerimeterCount + 1
		end
	)	
	SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(HavadaryaPerimeterZone, function ( GroupObject )
		HavadaryaPerimeterCount = HavadaryaPerimeterCount + 1
		end
	)	
	SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(BandarAbbasPerimeterZone, function ( GroupObject )
		BandarAbbasPerimeterCount = BandarAbbasPerimeterCount + 1
		end
	)	
	SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(JaskPerimeterZone, function ( GroupObject )
		JaskPerimeterCount = JaskPerimeterCount + 1
		end
	)
	
	--////BANDAR LENGEH			
	if ( BandarLengehPerimeterCount > 0 ) then		
		BandarLengehStatus = "Bandar Lengeh\nAirspace Is Being Contested By The Allies\n"
		REDA2ADispatcher:SetSquadron( "Alpha", AIRBASE.PersianGulf.Lar_Airbase, { "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A" } )	
	else
		BandarLengehStatus = "Bandar Lengeh\nAirspace Is Controlled By Iran\n"
		REDA2ADispatcher:SetSquadron( "Alpha", AIRBASE.PersianGulf.Bandar_Lengeh, { "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A" } )	
	end
	--////HAVADARYA
	if ( HavadaryaPerimeterCount > 0 ) then		
		HavadaryaStatus = "Havadarya\nAirspace Is Being Contested By The Allies\n"		
		REDA2ADispatcher:SetSquadron( "Gamma", AIRBASE.PersianGulf.Lar_Airbase, { "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A" } )	
	else
		HavadaryaStatus = "Havadarya\nAirspace Is Controlled By Iran\n"
		REDA2ADispatcher:SetSquadron( "Gamma", AIRBASE.PersianGulf.Havadarya, { "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A" } )	
	end
	--////BANDAR ABBAS
	if ( BandarAbbasPerimeterCount > 0 ) then		
		BandarAbbasStatus = "Bandar Abbas\nAirspace Is Being Contested By The Allies\n"	
		REDA2ADispatcher:SetSquadron( "Delta", AIRBASE.PersianGulf.Jiroft_Airport, { "SQ RUS MiG-21Bis", "SQ RUS MiG-29A", "SQ RUS MiG-29S", "SQ RUS MiG-23MLD", "SQ RUS MiG-25PD", "SQ RUS MiG-31", "SQ RUS Su-27", "SQ RUS Su-30", "SQ RUS Su-33" } )	
	else
		BandarAbbasStatus = "Bandar Abbas\nAirspace Is Controlled By Iran\n"
		REDA2ADispatcher:SetSquadron( "Delta", AIRBASE.PersianGulf.Bandar_Abbas_Intl, { "SQ RUS MiG-21Bis", "SQ RUS MiG-29A", "SQ RUS MiG-29S", "SQ RUS MiG-23MLD", "SQ RUS MiG-25PD", "SQ RUS MiG-31", "SQ RUS Su-27", "SQ RUS Su-30", "SQ RUS Su-33" } )	
	end
	--////BANDAR-E-JASK
	if ( JaskPerimeterCount > 0 ) then		
		JaskStatus = "Bandar-e-Jask\nAirspace Is Being Contested By The Allies\n"		
		REDA2ADispatcher:SetSquadron( "Epsilon", AIRBASE.PersianGulf.Jiroft_Airport, { "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A" } )	
	else
		JaskStatus = "Bandar-e-Jask\nAirspace Is Controlled By Iran"
		REDA2ADispatcher:SetSquadron( "Epsilon", AIRBASE.PersianGulf.Bandar_e_Jask_airfield, { "SQ IRN F-4E", "SQ IRN F-5E-3", "SQ IRN MiG-21Bis", "SQ IRN MiG-29A" } )	
	end		
	
	--trigger.action.outText("Airfield Status Report".."\n\n"..BandarLengehStatus.."\n"..HavadaryaStatus.."\n"..BandarAbbasStatus.."\n"..JaskStatus, 10)
	return time + 30	
end

----------------------------------------------------------------------------------------------------------------------------------------------
	--////MAIN
			
	--////GET THE GAME MODE SETUP (FLAG 10000 IN MISSION EDITOR TRIGGERS, 0 FOR MULTIPLAYER, 1 FOR SINGLEPLAYER)
	GameMode = trigger.misc.getUserFlag(10000)	
	
	SEF_REDDISPATCHERON()	
	if ( GameMode == 0 ) then
		SEF_REDSQUADRONSMULTIPLAYER()
	else
		SEF_REDSQUADRONSSINGLEPLAYER()
	end
	SEF_BLUEDISPATCHERON()
	SEF_AIRFIELDPERIMETERZONES()
	SEF_AIRFIELDPERIMETERCLIENTS()	
	
	--////Schedule these functions 2 seconds minimum later and adjust defence networks per faction as necessary
	timer.scheduleFunction(SEF_BLUEDEFENCENETWORK, 53, timer.getTime() + 2)
	timer.scheduleFunction(SEF_REDDEFENCENETWORK, 53, timer.getTime() + 3)
	--////Airfield Perimeter scanner	
	timer.scheduleFunction(SEF_AIRFIELDPERIMETERZONECLIENTSCANNER, 53, timer.getTime() + 21)
	
	--SEF_CleanUpAirports()	
----------------------------------------------------------------------------------------------------------------------------------------------