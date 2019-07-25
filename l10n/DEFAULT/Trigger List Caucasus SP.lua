--Trigger list for Caucasus SP

_SETTINGS:SetPlayerMenuOff()

--INIT SCRIPTS START

sp("USA AWACS")
sp("TANKERUS")
sp("TANKERUK")
ctld.activatePickupZone("pickzone1")
-- ctld.activatePickupZone("pickzone2")
-- ctld.activatePickupZone("pickzone3")



local function main()
timer.scheduleFunction(main, {}, timer.getTime() + 1) 


----------AIR MISSIONS!-----------------------------------------------------------
--a2a easy
if trigger.misc.getUserFlag('1') == 1 then
	trigger.action.outText( "<< A2A [Easy] Mission Active >>", 7)
	trigger.action.outSound("AC04 Beep.ogg" )
	a2a_easy_start()
	trigger.action.setUserFlag('1', false)
end

--a2a normal
if trigger.misc.getUserFlag('2') == 1 then
	trigger.action.outText( "<< A2A [Normal] Mission Active >>", 7)
	trigger.action.outSound("AC04 Beep.ogg" )
	a2a_norm_start()
	trigger.action.setUserFlag('2', false)
end

--a2a hard
if trigger.misc.getUserFlag('3') == 1 then
	trigger.action.outText( "<< A2A [Hard] Mission Active >>", 7)
	trigger.action.outSound("AC04 Beep.ogg" )
	a2a_hard_start()
	trigger.action.setUserFlag('3', false)
end
 --bombing add
if trigger.misc.getUserFlag('intercept') == 1 then
	trigger.action.outText( "<< A2A Intercept Mission Active >>", 7)
	trigger.action.outSound("AC04 Beep.ogg" )
	a2a_bombing_start()
	trigger.action.setUserFlag('intercept', false)
end

--a2a random
if trigger.misc.getUserFlag('4') == 1 then
	trigger.action.outText( "<< A2A [Random] Mission Active >>", 7)
	trigger.action.outSound("AC04 Beep.ogg" )
	a2a_all_start()
	trigger.action.setUserFlag('4', false)
end

----------Ground missions!-----------------------------------------------------------

--a2g hard
if trigger.misc.getUserFlag('61') == 1 then
	trigger.action.outText( "<< A2G Hards Mission Active >>", 7)
	trigger.action.outSound("Ui beep.ogg" )
	a2gj_start()
	trigger.action.setUserFlag('61', false)
end

--a2g easy
if trigger.misc.getUserFlag('71') == 1 then
	trigger.action.outText( "<< A2G Easy (Multirole) Mission Active >>", 7)
	trigger.action.outSound("Ui beep.ogg" )
	a2gmr_start()
	trigger.action.setUserFlag('71', false)
end

--a2g helo
if trigger.misc.getUserFlag('81') == 1 then
	trigger.action.outText( "<< A2G Helo Mission Active >>", 7)
	trigger.action.outSound("Ui beep.ogg" )
	a2gh_start()
	trigger.action.setUserFlag('81', false)
end

--a2g ia
if trigger.misc.getUserFlag('111') == 1 then
	trigger.action.outText( "<< A2G Helo Infantry Assault Mission Active >>", 7)
	trigger.action.outSound("Ui beep.ogg" )
	a2gia_start()
	trigger.action.setUserFlag('111', false)
end

--a2g as
if trigger.misc.getUserFlag('91') == 1 then
	trigger.action.outText( "<< Anti-Ship Mission Active >>", 7)
	trigger.action.outSound("Ui beep.ogg" )
	a2gas_start()
	trigger.action.setUserFlag('91', false)
end

----------BACKUP!!-----------------------------------------------------------

if trigger.misc.getUserFlag('f15_backup') == 1 then
	trigger.action.outText( "<< Friendly F-15C CAP Backup Inbound! >>", 7)
	trigger.action.outSound( "radio click.ogg" )
	sp("F15 Backup")
	trigger.action.setUserFlag('f15_backup', false)
end

if trigger.misc.getUserFlag('f16_backup') == 1 then
	trigger.action.outText( "<< Friendly F-16A CAP Backup Inbound! >>", 7)
	trigger.action.outSound( "radio click.ogg" )
	sp("F16 Backup")
	trigger.action.setUserFlag('f16_backup', false)
end

if trigger.misc.getUserFlag('f18_backup') == 1 then
	trigger.action.outText( "<< Friendly F/A-18C CAP Backup Inbound! >>", 7)
	trigger.action.outSound( "radio click.ogg" )
	sp("F18 Backup")
	trigger.action.setUserFlag('f18_backup', false)
end


----------DEBUG!-----------------------------------------------------------


--AWACS
if trigger.misc.getUserFlag('50') == 1 then
	trigger.action.outText( "<< AWACS Reset >>", 7)
	sp("USA AWACS")
	trigger.action.setUserFlag('50', false)
end

if trigger.misc.getUserFlag('51') == 1 then
	trigger.action.outText( "<< Tankers Reset >>", 7)
	sp("TANKERUS")
	sp("TANKERUK")
	trigger.action.setUserFlag('51', false)
end


end
main()

--CCS
MR = {}
MR.Text1 = "---INTEL---> GROUND UNITS at GRID FJ75 [A2G Easy Mission 1] [WPT-1] [LSR 1688]"
MR.Text2 = "---INTEL---> GROUND UNITS at GRID FH66 [A2G Easy Mission 2] [WPT-2] [LSR 1688]"
MR.Text3 = "---INTEL---> GROUND UNITS at GRID GG48 [A2G Easy Mission 3] [WPT-3] [LSR 1688]"
MR.Text4 = "---INTEL---> GROUND UNITS at GRID EJ90 [A2G Easy Mission 4] [WPT-4] [LSR 1688]"
MR.Text5 = "---INTEL---> GROUND UNITS at GRID GH31 [A2G Easy Mission 5] [WPT-5] [LSR 1688]"

MR.Text6 = "---INTEL---> GROUND UNITS at GRID GG29 [A2G Easy Mission 6] [WPT-6] [LSR 1688]"
MR.Text7 = "---INTEL---> GROUND UNITS at GRID GH14 [A2G Easy Mission 7] [WPT-7] [LSR 1688]"
MR.Text8 = "---INTEL---> GROUND UNITS at GRID EJ53 [A2G Easy Mission 8] [WPT-8] [LSR 1688]"
MR.Text9 = "---INTEL---> GROUND UNITS at GRID FJ72 [A2G Easy Mission 9] [WPT-9] [LSR 1688]"
MR.Text10 = "---INTEL---> GROUND UNITS at GRID KN53 [A2G Easy Mission 10] [WPT-10] [LSR 1688]"


AG = {}
AG.Text1 = "---INTEL---> GROUND UNITS at GRID GH12 [A2G Hard Mission 1] [WPT-11] [LSR 1688]"
AG.Text2 = "---INTEL---> GROUND UNITS at GRID FJ36 [A2G Hard Mission 2] [WPT-12] [LSR 1688]"
AG.Text3 = "---INTEL---> GROUND UNITS at GRID GJ21 [A2G Hard Mission 3] [WPT-13] [LSR 1688]"
AG.Text4 = "---INTEL---> GROUND UNITS at GRID EJ79 [A2G Hard Mission 4] [WPT-14] [LSR 1688]"
AG.Text5 = "---INTEL---> GROUND UNITS at GRID FH74 [A2G Hard Mission 5] [WPT-15] [LSR 1688]"

AG.Text6 = "---INTEL---> GROUND UNITS at GRID FK50 [A2G Hard Mission 6] [WPT-16] [LSR 1688]"
AG.Text7 = "---INTEL---> GROUND UNITS at GRID FJ98 [A2G Hard Mission 7] [WPT-17] [LSR 1688]"
AG.Text8 = "---INTEL---> GROUND UNITS at GRID KP69 [A2G Hard Mission 8] [WPT-18] [LSR 1688]"
AG.Text9 = "---INTEL---> GROUND UNITS at GRID EJ94/95 [A2G Hard Mission 9] [WPT-19] [LSR 1688]"
AG.Text10 = "---INTEL---> GROUND UNITS at GRID LP30 [A2G Hard Mission 10] [WPT-20] [LSR 1688]"



AGH = {}
AGH.Text1 = "---INTEL---> GROUND UNITS at GRID FH08 [A2G Helo/Infantry Assault Mission 1] [WPT-21]"
AGH.Text2 = "---INTEL---> GROUND UNITS at GRID FH38 [A2G Helo/Infantry Assault Mission 2] [WPT-22]"
AGH.Text3 = "---INTEL---> GROUND UNITS at GRID FH47 [A2G Helo/Infantry Assault Mission 3] [WPT-23]"
AGH.Text4 = "---INTEL---> GROUND UNITS at GRID FH19 [A2G Helo/Infantry Assault Mission 4] [WPT-24]"
AGH.Text5 = "---INTEL---> GROUND UNITS at GRID FH66 [A2G Helo/Infantry Assault Mission 5] [WPT-25]"

AGH.Text6 = "---INTEL---> GROUND UNITS at GRID FH08 [A2G Helo/Infantry Assault Mission 6] [WPT-26]"
AGH.Text7 = "---INTEL---> GROUND UNITS at GRID FH48 [A2G Helo/Infantry Assault Mission 7] [WPT-27]"
AGH.Text8 = "---INTEL---> GROUND UNITS at GRID FH67 [A2G Helo/Infantry Assault Mission 8] [WPT-28]"
AGH.Text9 = "---INTEL---> GROUND UNITS at GRID FH59 [A2G Helo/Infantry Assault Mission 9] [WPT-29]"
AGH.Text10 = "---INTEL---> GROUND UNITS at GRID FH21 [A2G Helo/Infantry Assault Mission 10] [WPT-30]"


AS = {}
AS.Text1 = "---INTEL---> NAVAL UNITS at GRID EG46 [Anti-Ship Mission 1]"
AS.Text2 = "---INTEL---> NAVAL UNITS at GRID EH34 [Anti-Ship Mission 2]"
AS.Text3 = "---INTEL---> NAVAL UNITS at GRID FH01 [Anti-Ship Mission 3]"
AS.Text4 = "---INTEL---> NAVAL UNITS at GRID FG14 [Anti-Ship Mission 4]"
AS.Text5 = "---INTEL---> NAVAL UNITS at GRID FG66 [Anti-Ship Mission 5]"


-- --normandy
-- MR = {}
-- MR.Text1 = "---INTEL---> GROUND UNITS at GRID XV45 [A2G Easy Mission 1] [Auto LS. 1688] [WPT-] [LS. 1688]"
-- MR.Text2 = "---INTEL---> GROUND UNITS at GRID XA00 [A2G Easy Mission 2] [Auto LS. 1688] [WPT-] [LS. 1688]"
-- MR.Text3 = "---INTEL---> GROUND UNITS at GRID YV05/06 [A2G Easy Mission 3] [Auto LS. 1688] [WPT-] [LS. 1688]"
-- MR.Text4 = "---INTEL---> GROUND UNITS at GRID WV88 [A2G Easy Mission 4] [Auto LS. 1688] [WPT-] [LS. 1688]"
-- MR.Text5 = "---INTEL---> GROUND UNITS at GRID XB20 [A2G Easy Mission 5] [Auto LS. 1688] [WPT-] [LS. 1688]"

-- MR.Text6 = "---INTEL---> GROUND UNITS at GRID XV93 [A2G Easy Mission 6] [Auto LS. 1688] [WPT-] [LS. 1688]"
-- MR.Text7 = "---INTEL---> GROUND UNITS at GRID XV26 [A2G Easy Mission 7] [Auto LS. 1688] [WPT-] [LS. 1688]"
-- MR.Text8 = "---INTEL---> GROUND UNITS at GRID XV95 [A2G Easy Mission 8] [Auto LS. 1688] [WPT-] [LS. 1688]"
-- MR.Text9 = "---INTEL---> GROUND UNITS at GRID BQ98 [A2G Easy Mission 9] [Auto LS. 1688] [WPT-] [LS. 1688]"
-- MR.Text10 = "---INTEL---> GROUND UNITS at GRID XV34 [A2G Easy Mission 10] [Auto LS. 1688] [WPT-] [LS. 1688]"


-- AG = {}
-- AG.Text1 = "---INTEL---> GROUND UNITS at GRID XB73 [A2G Hard Mission 1] [Auto LS. 1688] [WPT-11] [LS. 1688]"
-- AG.Text2 = "---INTEL---> GROUND UNITS at GRID XB11 [A2G Hard Mission 2] [Auto LS. 1688] [WPT-12] [LS. 1688]"
-- AG.Text3 = "---INTEL---> GROUND UNITS at GRID CQ62/63 [A2G Hard Mission 3] [Auto LS. 1688] [WPT-13] [LS. 1688]"
-- AG.Text4 = "---INTEL---> GROUND UNITS at GRID AV95 [A2G Hard Mission 4] [Auto LS. 1688] [WPT-14] [LS. 1688]"
-- AG.Text5 = "---INTEL---> GROUND UNITS at GRID BQ97 [A2G Hard Mission 5] [Auto LS. 1688] [WPT15-] [LS. 1688]"

-- AG.Text6 = "---INTEL---> GROUND UNITS at GRID WV64 [A2G Hard Mission 6] [Auto LS. 1688] [WPT-16] [LS. 1688]"
-- AG.Text7 = "---INTEL---> GROUND UNITS at GRID WV37 [A2G Hard Mission 7] [Auto LS. 1688] [WPT-17] [LS. 1688]"
-- AG.Text8 = "---INTEL---> GROUND UNITS at GRID XV56 [A2G Hard Mission 8] [Auto LS. 1688] [WPT18-] [LS. 1688]"
-- AG.Text9 = "---INTEL---> GROUND UNITS at GRID XB52 [A2G Hard Mission 9] [Auto LS. 1688] [WPT-19] [LS. 1688]"
-- AG.Text10 = "---INTEL---> GROUND UNITS at GRID BQ92 [A2G Hard Mission 10] [Auto LS. 1688] [WPT-20] [LS. 1688]"



-- AGH = {}
-- AGH.Text1 = "---INTEL---> GROUND UNITS at GRID XV95 [A2G Helo/Infantry Assault Mission 1] [WPT-21] [LS. 1688]"
-- AGH.Text2 = "---INTEL---> GROUND UNITS at GRID XV64 [A2G Helo/Infantry Assault Mission 2] [WPT-22] [LS. 1688]"
-- AGH.Text3 = "---INTEL---> GROUND UNITS at GRID XV85 [A2G Helo/Infantry Assault Mission 3] [WPT-23] [LS. 1688]"
-- AGH.Text4 = "---INTEL---> GROUND UNITS at GRID XV76 [A2G Helo/Infantry Assault Mission 4] [WPT-24] [LS. 1688]"
-- AGH.Text5 = "---INTEL---> GROUND UNITS at GRID XV57 [A2G Helo/Infantry Assault Mission 5] [WPT-25] [LS. 1688]"

-- AGH.Text6 = "---INTEL---> GROUND UNITS at GRID XV96 [A2G Helo/Infantry Assault Mission 6] [WPT-26] [LS. 1688]"
-- AGH.Text7 = "---INTEL---> GROUND UNITS at GRID YV06 [A2G Helo/Infantry Assault Mission 7] [WPT27-] [LS. 1688]"
-- AGH.Text8 = "---INTEL---> GROUND UNITS at GRID XV84 [A2G Helo/Infantry Assault Mission 8] [WPT-28] [LS. 1688]"
-- AGH.Text9 = "---INTEL---> GROUND UNITS at GRID XV45/55 [A2G Helo/Infantry Assault Mission 9] [WPT-29] [LS. 1688]"
-- AGH.Text10 = "---INTEL---> GROUND UNITS at GRID XV43 [A2G Helo/Infantry Assault Mission 10] [WPT-30] [LS. 1688]"


-- AS = {}
-- AS.Text1 = "---INTEL---> NAVAL UNITS at GRID EG46 [Anti-Ship Mission 1]"
-- AS.Text2 = "---INTEL---> NAVAL UNITS at GRID EH34 [Anti-Ship Mission 2]"
-- AS.Text3 = "---INTEL---> NAVAL UNITS at GRID FH01 [Anti-Ship Mission 3]"
-- AS.Text4 = "---INTEL---> NAVAL UNITS at GRID FG14 [Anti-Ship Mission 4]"
-- AS.Text5 = "---INTEL---> NAVAL UNITS at GRID FG66 [Anti-Ship Mission 5]"


--NTTR
-- MR = {}
-- MR.Text1 = "---INTEL---> GROUND UNITS at GRID QA22 [A2G Easy Mission 1] [WPT-1] [LS. 1688]"
-- MR.Text2 = "---INTEL---> GROUND UNITS at GRID PA21 [A2G Easy Mission 2] [WPT-2] [LS. 1688]"
-- MR.Text3 = "---INTEL---> GROUND UNITS at GRID PV55 [A2G Easy Mission 3] [WPT-3] [LS. 1688]"
-- MR.Text4 = "---INTEL---> GROUND UNITS at GRID PV69 [A2G Easy Mission 4] [WPT-4] [LS. 1688]"
-- MR.Text5 = "---INTEL---> GROUND UNITS at GRID PV68 [A2G Easy Mission 5] [WPT-5] [LS. 1688]"

-- MR.Text6 = "---INTEL---> GROUND UNITS at GRID QU19 [A2G Easy Mission 6] [WPT-6] [LS. 1688]"
-- MR.Text7 = "---INTEL---> GROUND UNITS at GRID PV58 [A2G Easy Mission 7] [WPT-7] [LS. 1688]"
-- MR.Text8 = "---INTEL---> GROUND UNITS at GRID QV08 [A2G Easy Mission 8] [WPT-8] [LS. 1688]"
-- MR.Text9 = "---INTEL---> GROUND UNITS at GRID QA00 [A2G Easy Mission 9] [WPT-9] [LS. 1688]"
-- MR.Text10 = "---INTEL---> GROUND UNITS at GRID QV02 [A2G Easy Mission 10] [WPT-10] [LS. 1688]"


-- AG = {}
-- AG.Text1 = "---INTEL---> GROUND UNITS at GRID NA17 [A2G Hard Mission 1] [WPT-11] [LS. 1688]"
-- AG.Text2 = "---INTEL---> GROUND UNITS at GRID PV97 [A2G Hard Mission 2] [WPT-12] [LS. 1688]"
-- AG.Text3 = "---INTEL---> GROUND UNITS at GRID QA68 [A2G Hard Mission 3] [WPT-13] [LS. 1688]"
-- AG.Text4 = "---INTEL---> GROUND UNITS at GRID PB02 [A2G Hard Mission 4] [WPT-14] [LS. 1688]"
-- AG.Text5 = "---INTEL---> GROUND UNITS at GRID NA85 [A2G Hard Mission 5] [WPT-15] [LS. 1688]"

-- AG.Text6 = "---INTEL---> GROUND UNITS at GRID PB63 [A2G Hard Mission 6] [WPT-16] [LS. 1688]"
-- AG.Text7 = "---INTEL---> GROUND UNITS at GRID PV26 [A2G Hard Mission 7] [WPT-17] [LS. 1688]"
-- AG.Text8 = "---INTEL---> GROUND UNITS at GRID NA80 [A2G Hard Mission 8] [WPT-18] [LS. 1688]"
-- AG.Text9 = "---INTEL---> GROUND UNITS at GRID TG70 [A2G Hard Mission 9] [WPT-19] [LS. 1688]"
-- AG.Text10 = "---INTEL---> GROUND UNITS at GRID QU18 [A2G Hard Mission 10] [WPT-20] [LS. 1688]"



-- AGH = {}
-- AGH.Text1 = "---INTEL---> GROUND UNITS at GRID PA61 [A2G Helo/Infantry Assault Mission 1] [WPT-21] [LS. 1688]"
-- AGH.Text2 = "---INTEL---> GROUND UNITS at GRID PV69 [A2G Helo/Infantry Assault Mission 2] [WPT-22] [LS. 1688]"
-- AGH.Text3 = "---INTEL---> GROUND UNITS at GRID PA92 [A2G Helo/Infantry Assault Mission 3] [WPT-23] [LS. 1688]"
-- AGH.Text4 = "---INTEL---> GROUND UNITS at GRID PA60 [A2G Helo/Infantry Assault Mission 4] [WPT-24] [LS. 1688]"
-- AGH.Text5 = "---INTEL---> GROUND UNITS at GRID PA91 [A2G Helo/Infantry Assault Mission 5] [WPT-25] [LS. 1688]"

-- AGH.Text6 = "---INTEL---> GROUND UNITS at GRID PV88 [A2G Helo/Infantry Assault Mission 6] [WPT-26] [LS. 1688]"
-- AGH.Text7 = "---INTEL---> GROUND UNITS at GRID PV69 [A2G Helo/Infantry Assault Mission 7] [WPT-27] [LS. 1688]"
-- AGH.Text8 = "---INTEL---> GROUND UNITS at GRID PA51 [A2G Helo/Infantry Assault Mission 8] [WPT-28] [LS. 1688]"
-- AGH.Text9 = "---INTEL---> GROUND UNITS at GRID PV99 [A2G Helo/Infantry Assault Mission 9] [WPT-29] [LS. 1688]"
-- AGH.Text10 = "---INTEL---> GROUND UNITS at GRID PA50 [A2G Helo/Infantry Assault Mission 10] [WPT-30] [LS. 1688]"



-- -- AS = {}
-- -- AS.Text1 = "---INTEL---> NAVAL UNITS at GRID EG46 [Anti-Ship Mission 1] [LS. 1688]"
-- -- AS.Text2 = "---INTEL---> NAVAL UNITS at GRID EH34 [Anti-Ship Mission 2] [LS. 1688]"
-- -- AS.Text3 = "---INTEL---> NAVAL UNITS at GRID FH01 [Anti-Ship Mission 3] [LS. 1688]"
-- -- AS.Text4 = "---INTEL---> NAVAL UNITS at GRID FG14 [Anti-Ship Mission 4] [LS. 1688]"
-- -- AS.Text5 = "---INTEL---> NAVAL UNITS at GRID FG66 [Anti-Ship Mission 5] [LS. 1688]"

--PG
-- MR = {}
-- MR.Text1 = "---INTEL--> GROUND UNITS at GRID CP94, Ras Al Khaimah [A2G Easy (UAE) 1] [WPT-1] [LS. 1688]"
-- MR.Text2 = "---INTEL--> GROUND UNITS at GRID CN20, Sweihan [A2G Easy (UAE) 2] [WPT-2] [LS. 1688]"
-- MR.Text3 = "---INTEL--> GROUND UNITS at GRID CM77, Al Buraimi [A2G Easy (UAE) 3] [WPT-3] [LS. 1688]"
-- MR.Text4 = "---INTEL--> GROUND UNITS at GRID BN30, Abu Dhabi [A2G Easy (UAE) 4] [WPT-4] [LS. 1688]"
-- MR.Text5 = "---INTEL--> GROUND UNITS at GRID DN04, Muzeira [A2G Easy (UAE) 5] [WPT-5] [LS. 1688]"

-- MR.Text6 = "---INTEL--> GROUND UNITS at GRID DN37, Khalba [A2G Easy (UAE) 6] [WPT-6] [LS. 1688]"
-- MR.Text7 = "---INTEL--> GROUND UNITS at GRID CP52, Ar Ramlah [A2G Easy (UAE) 7] [WPT-7] [LS. 1688]"
-- MR.Text8 = "---INTEL--> GROUND UNITS at GRID CN89, Al Dhaid [A2G Easy (UAE) 8] [WPT-8] [LS. 1688]"
-- MR.Text9 = "---INTEL--> GROUND UNITS at GRID DP26, Valley Town [A2G Easy (UAE) 9] [WPT-9] [LS. 1688]"
-- MR.Text10 = "---INTEL--> GROUND UNITS at GRID BM58, Al Mafreq Indus. [A2G Easy (UAE) 10] [WPT-10] [LS. 1688]"


-- AG = {}
-- AG.Text1 = "---INTEL--> GROUND UNITS at GRID CR43, Valley Village [A2G Hard (Iran) 1] [WPT11-] [LS. 1688]"
-- AG.Text2 = "---INTEL--> GROUND UNITS at GRID CR77, Valley River [A2G Hard (Iran) 2] [WPT-12] [LS. 1688]"
-- AG.Text3 = "---INTEL--> GROUND UNITS at GRID CQ34, Gori [A2G Hard (Iran) 3] [WPT-13] [LS. 1688]"
-- AG.Text4 = "---INTEL--> GROUND UNITS at GRID ER00, Minab [A2G Hard (Iran) 4] [WPT-14] [LS. 1688]"
-- AG.Text5 = "---INTEL--> GROUND UNITS at GRID ER13, Dehbarez [A2G Hard (Iran) 5] [WPT-15] [LS. 1688]"

-- AG.Text6 = "---INTEL--> GROUND UNITS at GRID DS34, Valley Town [A2G Hard (Iran) 6] [WPT-16] [LS. 1688]"
-- AG.Text7 = "---INTEL--> GROUND UNITS at GRID DR37, Valley Town [A2G Hard (Iran) 7] [WPT-17] [LS. 1688]"
-- AG.Text8 = "---INTEL--> GROUND UNITS at GRID CR01/11, Dashte Jayhun [A2G Hard (Iran) 8] [WPT-18] [LS. 1688]"
-- AG.Text9 = "---INTEL--> GROUND UNITS at GRID BQ64, Kang [A2G Hard (Iran) 9] [WPT-19] [LS. 1688]"
-- AG.Text10 = "---INTEL--> GROUND UNITS at GRID DR10, Havadarya City [A2G Hard (Iran) 10] [WPT-20] [LS. 1688]"

-- AGH = {}
-- AGH.Text1 = "---INTEL--> GROUND UNITS at GRID CN17, Emirates Hills [A2G Helo/Infantry As. 1] [WPT-21]"
-- AGH.Text2 = "---INTEL--> GROUND UNITS at GRID CN28, Downtown Burj Khalifa [A2G Helo/Infantry As. 2] [WPT-22]"
-- AGH.Text3 = "---INTEL--> GROUND UNITS at GRID BN96, Palm Jebel Ali [A2G Helo/Infantry As. 3] [WPT23-]"
-- AGH.Text4 = "---INTEL--> GROUND UNITS at GRID CN76, Al Madam [A2G Helo/Infantry As. 4] [WPT-24]"
-- AGH.Text5 = "---INTEL--> GROUND UNITS at GRID CN63, Fiqa [A2G Helo/Infantry As. 5] [WPT-25]"
-- AGH.Text6 = "---INTEL--> GROUND UNITS at GRID DQ28, Sistan [A2G Helo/Infantry As. 6] [WPT-26]"
-- AGH.Text7 = "---INTEL--> GROUND UNITS at GRID CQ77, Island Coast [A2G Helo/Infantry As. 7] [WPT-27]"
-- AGH.Text8 = "---INTEL--> GROUND UNITS at GRID DR22, Sarriq-e Meyguni [A2G Helo/Infantry As. 8] [WPT-28]"
-- AGH.Text9 = "---INTEL--> GROUND UNITS at GRID CR91, Keshar e Bala [A2G Helo/Infantry As. 9] [WPT-29]"
-- AGH.Text10 = "---INTEL--> GROUND UNITS at GRID DQ49, Hormoz [A2G Helo/Infantry As. 10] [WPT-30]"

-- AS = {}
-- AS.Text1 = "---INTEL--> NAVAL UNITS at GRID BN79 [Anti-Ship Mission 1]"
-- AS.Text2 = "---INTEL--> NAVAL UNITS at GRID DQ76 [Anti-Ship Mission 2]"
-- AS.Text3 = "---INTEL--> NAVAL UNITS at GRID BQ71 [Anti-Ship Mission 3]"
-- AS.Text4 = "---INTEL--> NAVAL UNITS at GRID DP71 [Anti-Ship Mission 4]"
-- AS.Text5 = "---INTEL--> NAVAL UNITS at GRID DP75 [Anti-Ship Mission 5]"

--loops
function main_ambient()
timer.scheduleFunction(main_ambient, {}, timer.getTime() + math.random(a2a_respawn_time_min, a2a_respawn_time_max))
if a2a_autospawn_enable == true then  --25 min
a2a_all_start()
	trigger.action.outText( "<< Enemy fighters are in the area! >>", 7)
	trigger.action.outSound("AC04 Beep.ogg" )
end
end

--bombing add
function main_bombing()
timer.scheduleFunction(main_bombing, {}, timer.getTime() + math.random(a2a_intercept_respawn_time_min, a2a_intercept_respawn_time_max))
if a2a_intercept_autospawn_enable == true then  --25 min
a2a_bombing_start()
	trigger.action.outText( "<< Enemy Bombers are in the area! >>", 7)
	trigger.action.outSound("AC04 Beep.ogg" )
end
end


function main_sam()
timer.scheduleFunction(main_sam, {}, timer.getTime() + sam_respawn_time )  --120 min
if sam_enable == true then
a2g_sam_start()
end
end

function main_intel()
timer.scheduleFunction(main_intel, {}, timer.getTime() + 1) 




--INTEL TRIGGERS!!!!------------------------------------------------------


if trigger.misc.getUserFlag('100') == 1 then
trigger.action.outText( "LOCATION INTEL REQUEST:\n \nDisplaying active ground attack missions (if any are available)", 8)
end


if trigger.misc.getUserFlag('800') == 1 then
trigger.action.outText( "---> SMOKE/FLARES DEPLOYED AT ALL ACTIVE A2G ZONES.", 8)
end



--to initialize JTACs
trigger.action.setUserFlag('90002', true)

if 
trigger.misc.getUserFlag('100') == 1 or 
trigger.misc.getUserFlag('800') == 1 or
trigger.misc.getUserFlag('90002') == 1 
then

--START ZONE COPY
 _zone = trigger.misc.getZone("MR1")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
			trigger.action.outText( "A2G Easy Mission: \"".. EasyMissionName .. "\"\n"..MR.Text1.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-MR1"):activate()
     trigger.action.setUserFlag('MR1-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('MR1-Inside') == 1 then			
					trigger.action.outText( "<< A2G Easy Mission: \""..EasyMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Easy Mission 1 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('MR1-Inside', false)					
					trigger.action.setUserFlag('MR-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AAA_ZONE")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 335 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
			
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
					trigger.action.outText( "PLEASE DO NOT HOST THIS MISSION ONLINE PUBLICALLY. PLEASE RESTART THE MISSION WITH A PASSWORD FOR PRIVATE USE ONLY.", 5)
					trigger.action.outSound("Ui beep.ogg" )
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("MR2")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Easy Mission: \"".. EasyMissionName .. "\"\n"..MR.Text2.."", 40) --trigger.action.outText( MR.Text2.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-MR2"):activate()
     trigger.action.setUserFlag('MR2-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('MR2-Inside') == 1 then			
					trigger.action.outText( "<< A2G Easy Mission: \""..EasyMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Easy Mission 2 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('MR2-Inside', false)					
					trigger.action.setUserFlag('MR-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("MR3")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Easy Mission: \"".. EasyMissionName .. "\"\n"..MR.Text3.."", 40) --trigger.action.outText( MR.Text3.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-MR3"):activate()
     trigger.action.setUserFlag('MR3-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('MR3-Inside') == 1 then			
					trigger.action.outText( "<< A2G Easy Mission: \""..EasyMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Easy Mission 1 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('MR3-Inside', false)					
					trigger.action.setUserFlag('MR-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("MR4")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Easy Mission: \"".. EasyMissionName .. "\"\n"..MR.Text4.."", 40) --trigger.action.outText( MR.Text4.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-MR4"):activate()
     trigger.action.setUserFlag('MR4-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('MR4-Inside') == 1 then			
					trigger.action.outText( "<< A2G Easy Mission: \""..EasyMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Easy Mission 4 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('MR4-Inside', false)					
					trigger.action.setUserFlag('MR-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("MR5")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Easy Mission: \"".. EasyMissionName .. "\"\n"..MR.Text5.."", 40) --trigger.action.outText( MR.Text5.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-MR5"):activate()
     trigger.action.setUserFlag('MR5-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('MR5-Inside') == 1 then			
					trigger.action.outText( "<< A2G Easy Mission: \""..EasyMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Easy Mission 5 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('MR5-Inside', false)					
					trigger.action.setUserFlag('MR-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("MR6")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Easy Mission: \"".. EasyMissionName .. "\"\n"..MR.Text6.."", 40) --trigger.action.outText( MR.Text6.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-MR6"):activate()
     trigger.action.setUserFlag('MR6-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('MR6-Inside') == 1 then			
					trigger.action.outText( "<< A2G Easy Mission: \""..EasyMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Easy Mission 6 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('MR6-Inside', false)					
					trigger.action.setUserFlag('MR-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("MR7")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Easy Mission: \"".. EasyMissionName .. "\"\n"..MR.Text7.."", 40) --trigger.action.outText( MR.Text7.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-MR7"):activate()
     trigger.action.setUserFlag('MR7-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('MR7-Inside') == 1 then			
					trigger.action.outText( "<< A2G Easy Mission: \""..EasyMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Easy Mission 7 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('MR7-Inside', false)					
					trigger.action.setUserFlag('MR-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("MR8")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Easy Mission: \"".. EasyMissionName .. "\"\n"..MR.Text8.."", 40) --trigger.action.outText( MR.Text8.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-MR8"):activate()
     trigger.action.setUserFlag('MR8-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('MR8-Inside') == 1 then			
					trigger.action.outText( "<< A2G Easy Mission: \""..EasyMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Easy Mission 8 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('MR8-Inside', false)					
					trigger.action.setUserFlag('MR-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("MR9")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Easy Mission: \"".. EasyMissionName .. "\"\n"..MR.Text9.."", 40) --trigger.action.outText( MR.Text9.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-MR9"):activate()
     trigger.action.setUserFlag('MR9-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('MR9-Inside') == 1 then			
					trigger.action.outText( "<< A2G Easy Mission: \""..EasyMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Easy Mission 9 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('MR9-Inside', false)					
					trigger.action.setUserFlag('MR-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("MR10")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Easy Mission: \"".. EasyMissionName .. "\"\n"..MR.Text10.."", 40) --trigger.action.outText( MR.Text10.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-MR10"):activate()
     trigger.action.setUserFlag('MR10-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('MR10-Inside') == 1 then			
					trigger.action.outText( "<< A2G Easy Mission: \""..EasyMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Easy Mission 10 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('MR10-Inside', false)					
					trigger.action.setUserFlag('MR-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AG1")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Hard Mission: \"".. HardMissionName .. "\"\n"..AG.Text1.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AG1"):activate()
     trigger.action.setUserFlag('AG1-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AG1-Inside') == 1 then			
					trigger.action.outText( "<< A2G Hard Mission 1 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AG1-Inside', false)					
					trigger.action.setUserFlag('AG-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AG2")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Hard Mission: \"".. HardMissionName .. "\"\n"..AG.Text2.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AG2"):activate()
     trigger.action.setUserFlag('AG2-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AG2-Inside') == 1 then			
					trigger.action.outText( "<< A2G Hard Mission 2 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AG2-Inside', false)					
					trigger.action.setUserFlag('AG-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AG3")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Hard Mission: \"".. HardMissionName .. "\"\n"..AG.Text3.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AG3"):activate()
     trigger.action.setUserFlag('AG3-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AG3-Inside') == 1 then			
					trigger.action.outText( "<< A2G Hard Mission 3 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AG3-Inside', false)					
					trigger.action.setUserFlag('AG-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AG4")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Hard Mission: \"".. HardMissionName .. "\"\n"..AG.Text4.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AG4"):activate()
     trigger.action.setUserFlag('AG4-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AG4-Inside') == 1 then			
					trigger.action.outText( "<< A2G Hard Mission 4 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AG4-Inside', false)					
					trigger.action.setUserFlag('AG-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AG5")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Hard Mission: \"".. HardMissionName .. "\"\n"..AG.Text5.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AG5"):activate()
     trigger.action.setUserFlag('AG5-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AG5-Inside') == 1 then			
					trigger.action.outText( "<< A2G Hard Mission 5 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AG5-Inside', false)					
					trigger.action.setUserFlag('AG-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AG6")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Hard Mission: \"".. HardMissionName .. "\"\n"..AG.Text6.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AG6"):activate()
     trigger.action.setUserFlag('AG6-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AG6-Inside') == 1 then			
					trigger.action.outText( "<< A2G Hard Mission 6 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AG6-Inside', false)					
					trigger.action.setUserFlag('AG-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AG7")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Hard Mission: \"".. HardMissionName .. "\"\n"..AG.Text7.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AG7"):activate()
     trigger.action.setUserFlag('AG7-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AG7-Inside') == 1 then			
					trigger.action.outText( "<< A2G Hard Mission 7 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AG7-Inside', false)					
					trigger.action.setUserFlag('AG-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AG8")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Hard Mission: \"".. HardMissionName .. "\"\n"..AG.Text8.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AG8"):activate()
     trigger.action.setUserFlag('AG8-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AG8-Inside') == 1 then			
					trigger.action.outText( "<< A2G Hard Mission 8 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AG8-Inside', false)					
					trigger.action.setUserFlag('AG-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AG9")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Hard Mission: \"".. HardMissionName .. "\"\n"..AG.Text9.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AG9"):activate()
     trigger.action.setUserFlag('AG9-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AG9-Inside') == 1 then			
					trigger.action.outText( "<< A2G Hard Mission 9 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AG9-Inside', false)					
					trigger.action.setUserFlag('AG-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AG10")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Hard Mission: \"".. HardMissionName .. "\"\n"..AG.Text10.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AG10"):activate()
     trigger.action.setUserFlag('AG10-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AG10-Inside') == 1 then			
					trigger.action.outText( "<< A2G Hard Mission 10 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AG10-Inside', false)					
					trigger.action.setUserFlag('AG-STARTING', false)					
		 end
--END ZONE PASTE


--START ZONE COPY
 _zone = trigger.misc.getZone("AGH1")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Helo Mission: \"".. HeloMissionName .. "\"\n"..AGH.Text1.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AGH1"):activate()
     trigger.action.setUserFlag('AGH1-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AGH1-Inside') == 1 then			
					trigger.action.outText( "<< A2G Helo/Infanty Assault Mission: \""..HeloMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Helo Mission  1 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AGH1-Inside', false)					
					trigger.action.setUserFlag('AGH-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AGH2")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Helo Mission: \"".. HeloMissionName .. "\"\n"..AGH.Text2.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AGH2"):activate()
     trigger.action.setUserFlag('AGH2-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AGH2-Inside') == 1 then			
					trigger.action.outText( "<< A2G Helo/Infanty Assault Mission: \""..HeloMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Helo Mission  2 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AGH2-Inside', false)					
					trigger.action.setUserFlag('AGH-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AGH3")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Helo Mission: \"".. HeloMissionName .. "\"\n"..AGH.Text3.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AGH3"):activate()
     trigger.action.setUserFlag('AGH3-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AGH3-Inside') == 1 then			
					trigger.action.outText( "<< A2G Helo/Infanty Assault Mission: \""..HeloMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Helo Mission  3 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AGH3-Inside', false)					
					trigger.action.setUserFlag('AGH-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AGH4")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Helo Mission: \"".. HeloMissionName .. "\"\n"..AGH.Text4.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AGH4"):activate()
     trigger.action.setUserFlag('AGH4-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AGH4-Inside') == 1 then			
					trigger.action.outText( "<< A2G Helo/Infanty Assault Mission: \""..HeloMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Helo Mission  4 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AGH4-Inside', false)					
					trigger.action.setUserFlag('AGH-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AGH5")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Helo Mission: \"".. HeloMissionName .. "\"\n"..AGH.Text5.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AGH5"):activate()
     trigger.action.setUserFlag('AGH5-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AGH5-Inside') == 1 then			
					trigger.action.outText( "<< A2G Helo/Infanty Assault Mission: \""..HeloMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Helo Mission  5 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AGH5-Inside', false)					
					trigger.action.setUserFlag('AGH-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AGH6")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Helo Mission: \"".. HeloMissionName .. "\"\n"..AGH.Text6.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AGH6"):activate()
     trigger.action.setUserFlag('AGH6-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AGH6-Inside') == 1 then			
					trigger.action.outText( "<< A2G Helo/Infanty Assault Mission: \""..HeloMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Helo Mission  6 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AGH6-Inside', false)					
					trigger.action.setUserFlag('AGH-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AGH7")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Helo Mission: \"".. HeloMissionName .. "\"\n"..AGH.Text7.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AGH7"):activate()
     trigger.action.setUserFlag('AGH7-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AGH7-Inside') == 1 then			
					trigger.action.outText( "<< A2G Helo/Infanty Assault Mission: \""..HeloMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Helo Mission  7 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AGH7-Inside', false)					
					trigger.action.setUserFlag('AGH-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AGH8")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Helo Mission: \"".. HeloMissionName .. "\"\n"..AGH.Text8.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AGH8"):activate()
     trigger.action.setUserFlag('AGH8-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AGH8-Inside') == 1 then			
					trigger.action.outText( "<< A2G Helo/Infanty Assault Mission: \""..HeloMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Helo Mission  8 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AGH8-Inside', false)					
					trigger.action.setUserFlag('AGH-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AGH9")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Helo Mission: \"".. HeloMissionName .. "\"\n"..AGH.Text9.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AGH9"):activate()
     trigger.action.setUserFlag('AGH9-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AGH9-Inside') == 1 then			
					trigger.action.outText( "<< A2G Helo/Infanty Assault Mission: \""..HeloMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Helo Mission  9 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AGH9-Inside', false)					
					trigger.action.setUserFlag('AGH-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("AGH10")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 914 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "A2G Helo Mission: \"".. HeloMissionName .. "\"\n"..AGH.Text10.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     Group.getByName("JTAC-AGH10"):activate()
     trigger.action.setUserFlag('AGH10-Inside', true)
		 end

		 if _foundRed and trigger.misc.getUserFlag('800') == 1 then			
					trigger.action.smoke (_zone.point, 2)
					trigger.action.signalFlare(_zone.point, 1, 0 )					 
		 end

		 if not _foundRed and trigger.misc.getUserFlag('AGH10-Inside') == 1 then			
					trigger.action.outText( "<< A2G Helo/Infanty Assault Mission: \""..HeloMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< A2G Helo Mission  10 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('AGH10-Inside', false)					
					trigger.action.setUserFlag('AGH-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("ASS1")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 3000 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "Anti-Ship Mission: \"".. ShipMissionName .. "\"\n"..AS.Text1.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     trigger.action.setUserFlag('ASS1-Inside', true)
		 end

		 if not _foundRed and trigger.misc.getUserFlag('ASS1-Inside') == 1 then			
					trigger.action.outText( "<< Anti-Ship Mission: \""..ShipMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< Anti-Ship Mission  1 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('ASS1-Inside', false)					
					trigger.action.setUserFlag('AS-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("ASS2")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 3000 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "Anti-Ship Mission: \"".. ShipMissionName .. "\"\n"..AS.Text2.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     trigger.action.setUserFlag('ASS2-Inside', true)
		 end

		 if not _foundRed and trigger.misc.getUserFlag('ASS2-Inside') == 1 then			
					trigger.action.outText( "<< Anti-Ship Mission: \""..ShipMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< Anti-Ship Mission  2 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('ASS2-Inside', false)					
					trigger.action.setUserFlag('AS-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("ASS3")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 3000 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "Anti-Ship Mission: \"".. ShipMissionName .. "\"\n"..AS.Text3.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     trigger.action.setUserFlag('ASS3-Inside', true)
		 end

		 if not _foundRed and trigger.misc.getUserFlag('ASS3-Inside') == 1 then			
					trigger.action.outText( "<< Anti-Ship Mission: \""..ShipMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< Anti-Ship Mission  1 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('ASS3-Inside', false)					
					trigger.action.setUserFlag('AS-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("ASS4")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 3000 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "Anti-Ship Mission: \"".. ShipMissionName .. "\"\n"..AS.Text4.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     trigger.action.setUserFlag('ASS4-Inside', true)
		 end

		 if not _foundRed and trigger.misc.getUserFlag('ASS4-Inside') == 1 then			
					trigger.action.outText( "<< Anti-Ship Mission: \""..ShipMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< Anti-Ship Mission  4 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('ASS4-Inside', false)					
					trigger.action.setUserFlag('AS-STARTING', false)					
		 end
--END ZONE PASTE

--START ZONE COPY
 _zone = trigger.misc.getZone("ASS5")

      _zone.point = mist.utils.makeVec3GL(_zone.point)
      _zone.point.y = _zone.point.y + 1 -- offset center by 10KM
       _volume = {
        id = world.VolumeType.SPHERE,
        params = {
          point = _zone.point, 
          radius = 3000 -- radius in meters from the size of the zone
        }
      }
       _foundRed = false
--       _foundBlue = true
       _search = function(_unit, _coa)
        pcall(function()    
          if _unit ~= nil
              and _unit:isExist()
              and _unit:isActive()
              and _unit:getLife() > 0
               then
            if _unit:getCoalition() == 1 then
              _foundRed = true
            else
              _foundBlue = true
            end
          end
        end)
        return true
      end
      world.searchObjects(Object.Category.UNIT, _volume, _search)
     
		 if _foundRed and trigger.misc.getUserFlag('100') == 1 then
						trigger.action.outText( "Anti-Ship Mission: \"".. ShipMissionName .. "\"\n"..AS.Text5.."", 40)
    		 end
			 
--SPAWN JTAC		 
 		 if _foundRed then
     trigger.action.setUserFlag('ASS5-Inside', true)
		 end

		 if not _foundRed and trigger.misc.getUserFlag('ASS5-Inside') == 1 then			
					trigger.action.outText( "<< Anti-Ship Mission: \""..ShipMissionName.."\" complete! >>", 10) --trigger.action.outText( "<< Anti-Ship Mission  5 Complete >>", 5)
					trigger.action.outSound("Ace Combat Mission Accomplished.ogg" )
					trigger.action.setUserFlag('ASS5-Inside', false)					
					trigger.action.setUserFlag('AS-STARTING', false)					
		 end
--END ZONE PASTE


end

trigger.action.setUserFlag('100', false)
trigger.action.setUserFlag('800', false)

--to initialize JTACs
trigger.action.setUserFlag('90002', false)



end
main_intel()
-- timer.scheduleFunction(function() 
-- end, nil, timer.getTime() + 3  )

--a2g jet
function a2gj_text_start()

trigger.action.outText( "<< Air to Ground Hard Mission Initializing >>", 10)
trigger.action.outSound( "radio click.ogg" )
trigger.action.setUserFlag('61', true)
trigger.action.setUserFlag('6', false)
trigger.action.setUserFlag('AG-STARTING', true)
end

function a2gj_text_start_auto()
timer.scheduleFunction(function() 
trigger.action.outText( "<< Air to Ground Hard Mission Auto-Starting >>", 10)
trigger.action.outSound( "radio click.ogg" )
end, nil, timer.getTime() + 3  )
trigger.action.setUserFlag('61', true)
trigger.action.setUserFlag('6', false)
trigger.action.setUserFlag('AG-STARTING', true)
end

function a2gj_text_fail()
trigger.action.outText( "<< There is already a mission of this type currently active. >>\n \nYou can only spawn one of each A2G mission type at a time.\n \nPlease complete this mission type before spawning a new one.", 10)
trigger.action.outSound( "BD_00006 back square.ogg" )
trigger.action.setUserFlag('6', false)
end

--MR
function mr_text_start()
trigger.action.outText( "<< Air to Ground Easy Mission Initializing >>", 10)
trigger.action.outSound( "radio click.ogg" )
trigger.action.setUserFlag('71', true)
trigger.action.setUserFlag('7', false)
trigger.action.setUserFlag('MR-STARTING', true)
end

function mr_text_start_auto()
timer.scheduleFunction(function() 
trigger.action.outText( "<< Air to Ground Easy Mission Auto-Starting >>", 10)
trigger.action.outSound( "radio click.ogg" )
end, nil, timer.getTime() + 3  )
trigger.action.setUserFlag('71', true)
trigger.action.setUserFlag('7', false)
trigger.action.setUserFlag('MR-STARTING', true)
end



function mr_text_fail()
trigger.action.outText( "<< There is already a mission of this type currently active. >>\n \nYou can only spawn one of each A2G mission type at a time.\n \nPlease complete this mission type before spawning a new one.", 10)
trigger.action.outSound( "BD_00006 back square.ogg" )
trigger.action.setUserFlag('7', false)
end

--helo
function a2gh_text_start()
trigger.action.outText( "<< Air to Ground Mission [Helos] Initializing >>", 10)
trigger.action.outSound( "radio click.ogg" )
trigger.action.setUserFlag('81', true)
trigger.action.setUserFlag('8', false)
trigger.action.setUserFlag('AGH-STARTING', true)
end

function a2gh_text_start_auto()
timer.scheduleFunction(function() 
trigger.action.outText( "<< Air to Ground Mission [Helos] Auto-Starting >>", 10)
trigger.action.outSound( "radio click.ogg" )
end, nil, timer.getTime() + 3  )
trigger.action.setUserFlag('81', true)
trigger.action.setUserFlag('8', false)
trigger.action.setUserFlag('AGH-STARTING', true)
end


function a2gh_text_fail()
trigger.action.outText( "<< There is already a mission of this type currently active. >>\n \nYou can only spawn one of each A2G mission type at a time.\n \nPlease complete this mission type before spawning a new one.", 10)
trigger.action.outSound( "BD_00006 back square.ogg" )
trigger.action.setUserFlag('8', false)
end

--helo ia
function a2gia_text_start()
trigger.action.setUserFlag('10', false)
trigger.action.setUserFlag('AGH-STARTING', true)
trigger.action.outText( "<< Infantry Assault Mission [Helos] Initializing >>", 10)
trigger.action.outSound( "radio click.ogg" )
trigger.action.setUserFlag('111', true)
end

function a2gia_text_start_auto()
timer.scheduleFunction(function() 
trigger.action.outText( "<< Infantry Assault Mission [Helos] Auto-Starting >>", 10)
trigger.action.outSound( "radio click.ogg" )
end, nil, timer.getTime() + 3  )
trigger.action.setUserFlag('AGH-STARTING', true)
trigger.action.setUserFlag('111', true)
trigger.action.setUserFlag('10', false)
end

function a2gia_text_fail()
trigger.action.outText( "<< There is already a mission of this type currently active. >>\n \nYou can only spawn one of each A2G mission type at a time.\n \nPlease complete this mission type before spawning a new one.", 10)
trigger.action.outSound( "BD_00006 back square.ogg" )
trigger.action.setUserFlag('10', false)
end

--as
function a2gas_text_start()
trigger.action.outText( "<< Anti-Ship Mission Initializing >>", 10)
trigger.action.outSound( "radio click.ogg" )
trigger.action.setUserFlag('91', true)
trigger.action.setUserFlag('9', false)
trigger.action.setUserFlag('AS-STARTING', true)
end

function a2gas_text_start_auto()
timer.scheduleFunction(function() 
trigger.action.outText( "<< Anti-Ship Mission Auto-Starting >>", 10)
trigger.action.outSound( "radio click.ogg" )
end, nil, timer.getTime() + 3  )
trigger.action.setUserFlag('91', true)
trigger.action.setUserFlag('9', false)
trigger.action.setUserFlag('AS-STARTING', true)
end


function a2gas_text_fail()
trigger.action.outText( "<< There is already a mission of this type currently active. >>\n \nYou can only spawn one of each A2G mission type at a time.\n \nPlease complete this mission type before spawning a new one.", 10)
trigger.action.outSound( "BD_00006 back square.ogg" )
trigger.action.setUserFlag('9', false)
end


trigger.action.setUserFlag('INIT_TIME', true)
--trigger.action.setUserFlag('MISSONS_START_COMPLETE', true)

if trigger.misc.getUserFlag('INIT_TIME') == 1 then

	timer.scheduleFunction(function() 
	trigger.action.outText(	"<< Mission Tasking/Spawning Menu Added to your F10 - Other Menu >>", 15)
	end, nil, timer.getTime() + 5  )
	
	if a2g_hard_autostart == true then
	timer.scheduleFunction(function() 
	a2gj_text_start_auto()
	end, nil, timer.getTime() + 20  )
	end
	
	if a2g_helo_autostart == true then
	timer.scheduleFunction(function() 
	a2gh_text_start_auto()
	end, nil, timer.getTime() + 30  )
	end
	
	if a2g_helo_inf_autostart == true then
	timer.scheduleFunction(function() 
	a2gia_text_start_auto()
	end, nil, timer.getTime() + 40  )
	end
	
	if a2g_easy_autostart == true then
	timer.scheduleFunction(function() 
	mr_text_start_auto()
	end, nil, timer.getTime() + 50  )
	end
	
	-- timer.scheduleFunction(function() 
	-- smz_text_start_auto()
	-- end, nil, timer.getTime() + 66  )
	
	if antiship_autostart == true then
	timer.scheduleFunction(function() 
	a2gas_text_start_auto()
	end, nil, timer.getTime() + 60  ) --supposed to be 200
	end
	
	timer.scheduleFunction(function() 
	trigger.action.setUserFlag('MISSONS_START_COMPLETE', true)
	trigger.action.outText(	"<< If auto-spawning missions are disabled, you can now manually start ground missions as desired. >>", 15)
--	end, nil, timer.getTime() + 225  )
	end, nil, timer.getTime() + 87  )
	
	timer.scheduleFunction(function() 
	main_ambient()
	end, nil, timer.getTime() + 240  )
	--bombing add
	timer.scheduleFunction(function() 
	main_bombing()
	end, nil, timer.getTime() + 900  )
	
	timer.scheduleFunction(function() 
	main_sam()
	end, nil, timer.getTime() + 600  )

	
end




local function main_start_missions()
timer.scheduleFunction(main_start_missions, {}, timer.getTime() + 1 ) 

if trigger.misc.getUserFlag('MISSONS_START_COMPLETE') == 1 then

--MR Manual
if
trigger.misc.getUserFlag('MR-STARTING') == 0 and
trigger.misc.getUserFlag('MR1-Inside') == 0 and
trigger.misc.getUserFlag('MR2-Inside') == 0 and
trigger.misc.getUserFlag('MR3-Inside') == 0 and
trigger.misc.getUserFlag('MR4-Inside') == 0 and
trigger.misc.getUserFlag('MR5-Inside') == 0 and
trigger.misc.getUserFlag('MR6-Inside') == 0 and
trigger.misc.getUserFlag('MR7-Inside') == 0 and
trigger.misc.getUserFlag('MR8-Inside') == 0 and
trigger.misc.getUserFlag('MR9-Inside') == 0 and
trigger.misc.getUserFlag('MR10-Inside') == 0 and
trigger.misc.getUserFlag('7') == 1 then
mr_text_start()
end

if
a2g_easy_autostart == true and
trigger.misc.getUserFlag('MR-STARTING') == 0 and
trigger.misc.getUserFlag('MR1-Inside') == 0 and
trigger.misc.getUserFlag('MR2-Inside') == 0 and
trigger.misc.getUserFlag('MR3-Inside') == 0 and
trigger.misc.getUserFlag('MR4-Inside') == 0 and
trigger.misc.getUserFlag('MR5-Inside') == 0 and
trigger.misc.getUserFlag('MR6-Inside') == 0 and
trigger.misc.getUserFlag('MR7-Inside') == 0 and
trigger.misc.getUserFlag('MR8-Inside') == 0 and
trigger.misc.getUserFlag('MR9-Inside') == 0 and
trigger.misc.getUserFlag('MR10-Inside') == 0 then
--trigger.misc.getUserFlag('7') == 1 then
mr_text_start_auto()
end


--MR FAIL
if
trigger.misc.getUserFlag('MR1-Inside') == 1 and
trigger.misc.getUserFlag('7') == 1 then
mr_text_fail()
end

if
trigger.misc.getUserFlag('MR2-Inside') == 1 and
trigger.misc.getUserFlag('7') == 1 then
mr_text_fail()
end

if
trigger.misc.getUserFlag('MR3-Inside') == 1 and
trigger.misc.getUserFlag('7') == 1 then
mr_text_fail()
end

if
trigger.misc.getUserFlag('MR4-Inside') == 1 and
trigger.misc.getUserFlag('7') == 1 then
mr_text_fail()
end

if
trigger.misc.getUserFlag('MR5-Inside') == 1 and
trigger.misc.getUserFlag('7') == 1 then
mr_text_fail()
end

if
trigger.misc.getUserFlag('MR6-Inside') == 1 and
trigger.misc.getUserFlag('7') == 1 then
mr_text_fail()
end

if
trigger.misc.getUserFlag('MR7-Inside') == 1 and
trigger.misc.getUserFlag('7') == 1 then
mr_text_fail()
end

if
trigger.misc.getUserFlag('MR8-Inside') == 1 and
trigger.misc.getUserFlag('7') == 1 then
mr_text_fail()
end

if
trigger.misc.getUserFlag('MR9-Inside') == 1 and
trigger.misc.getUserFlag('7') == 1 then
mr_text_fail()
end

if
trigger.misc.getUserFlag('MR10-Inside') == 1 and
trigger.misc.getUserFlag('7') == 1 then
mr_text_fail()
end

--AG Manual
if
trigger.misc.getUserFlag('AG-STARTING') == 0 and
trigger.misc.getUserFlag('AG1-Inside') == 0 and
trigger.misc.getUserFlag('AG2-Inside') == 0 and
trigger.misc.getUserFlag('AG3-Inside') == 0 and
trigger.misc.getUserFlag('AG4-Inside') == 0 and
trigger.misc.getUserFlag('AG5-Inside') == 0 and
trigger.misc.getUserFlag('AG6-Inside') == 0 and
trigger.misc.getUserFlag('AG7-Inside') == 0 and
trigger.misc.getUserFlag('AG8-Inside') == 0 and
trigger.misc.getUserFlag('AG9-Inside') == 0 and
trigger.misc.getUserFlag('AG10-Inside') == 0 and
trigger.misc.getUserFlag('6') == 1 then
a2gj_text_start()
end

if
a2g_hard_autostart == true and
trigger.misc.getUserFlag('AG-STARTING') == 0 and
trigger.misc.getUserFlag('AG1-Inside') == 0 and
trigger.misc.getUserFlag('AG2-Inside') == 0 and
trigger.misc.getUserFlag('AG3-Inside') == 0 and
trigger.misc.getUserFlag('AG4-Inside') == 0 and
trigger.misc.getUserFlag('AG5-Inside') == 0 and
trigger.misc.getUserFlag('AG6-Inside') == 0 and
trigger.misc.getUserFlag('AG7-Inside') == 0 and
trigger.misc.getUserFlag('AG8-Inside') == 0 and
trigger.misc.getUserFlag('AG9-Inside') == 0 and
trigger.misc.getUserFlag('AG10-Inside') == 0 then
--trigger.misc.getUserFlag('6') == 1 then
a2gj_text_start_auto()
end


--AG FAIL
if
trigger.misc.getUserFlag('AG1-Inside') == 1 and
trigger.misc.getUserFlag('6') == 1 then
a2gj_text_fail()
end

if
trigger.misc.getUserFlag('AG2-Inside') == 1 and
trigger.misc.getUserFlag('6') == 1 then
a2gj_text_fail()
end

if
trigger.misc.getUserFlag('AG3-Inside') == 1 and
trigger.misc.getUserFlag('6') == 1 then
a2gj_text_fail()
end

if
trigger.misc.getUserFlag('AG4-Inside') == 1 and
trigger.misc.getUserFlag('6') == 1 then
a2gj_text_fail()
end

if
trigger.misc.getUserFlag('AG5-Inside') == 1 and
trigger.misc.getUserFlag('6') == 1 then
a2gj_text_fail()
end

if
trigger.misc.getUserFlag('AG6-Inside') == 1 and
trigger.misc.getUserFlag('6') == 1 then
a2gj_text_fail()
end

if
trigger.misc.getUserFlag('AG7-Inside') == 1 and
trigger.misc.getUserFlag('6') == 1 then
a2gj_text_fail()
end

if
trigger.misc.getUserFlag('AG8-Inside') == 1 and
trigger.misc.getUserFlag('6') == 1 then
a2gj_text_fail()
end

if
trigger.misc.getUserFlag('AG9-Inside') == 1 and
trigger.misc.getUserFlag('6') == 1 then
a2gj_text_fail()
end

if
trigger.misc.getUserFlag('AG10-Inside') == 1 and
trigger.misc.getUserFlag('6') == 1 then
a2gj_text_fail()
end

--AG Manual
if
trigger.misc.getUserFlag('AGH-STARTING') == 0 and
trigger.misc.getUserFlag('AGH1-Inside') == 0 and
trigger.misc.getUserFlag('AGH2-Inside') == 0 and
trigger.misc.getUserFlag('AGH3-Inside') == 0 and
trigger.misc.getUserFlag('AGH4-Inside') == 0 and
trigger.misc.getUserFlag('AGH5-Inside') == 0 and
trigger.misc.getUserFlag('AGH6-Inside') == 0 and
trigger.misc.getUserFlag('AGH7-Inside') == 0 and
trigger.misc.getUserFlag('AGH8-Inside') == 0 and
trigger.misc.getUserFlag('AGH9-Inside') == 0 and
trigger.misc.getUserFlag('AGH10-Inside') == 0 and
trigger.misc.getUserFlag('8') == 1 then
a2gh_text_start()
end

if
a2g_helo_autostart == true and
trigger.misc.getUserFlag('AGH-STARTING') == 0 and
trigger.misc.getUserFlag('AGH1-Inside') == 0 and
trigger.misc.getUserFlag('AGH2-Inside') == 0 and
trigger.misc.getUserFlag('AGH3-Inside') == 0 and
trigger.misc.getUserFlag('AGH4-Inside') == 0 and
trigger.misc.getUserFlag('AGH5-Inside') == 0 and
trigger.misc.getUserFlag('AGH6-Inside') == 0 and
trigger.misc.getUserFlag('AGH7-Inside') == 0 and
trigger.misc.getUserFlag('AGH8-Inside') == 0 and
trigger.misc.getUserFlag('AGH9-Inside') == 0 and
trigger.misc.getUserFlag('AGH10-Inside') == 0 then
--trigger.misc.getUserFlag('8') == 1 then
a2gh_text_start_auto()
end



--AG FAIL
if
trigger.misc.getUserFlag('AGH1-Inside') == 1 and
trigger.misc.getUserFlag('8') == 1 then
a2gh_text_fail()
end

if
trigger.misc.getUserFlag('AGH2-Inside') == 1 and
trigger.misc.getUserFlag('8') == 1 then
a2gh_text_fail()
end

if
trigger.misc.getUserFlag('AGH3-Inside') == 1 and
trigger.misc.getUserFlag('8') == 1 then
a2gh_text_fail()
end

if
trigger.misc.getUserFlag('AGH4-Inside') == 1 and
trigger.misc.getUserFlag('8') == 1 then
a2gh_text_fail()
end

if
trigger.misc.getUserFlag('AGH5-Inside') == 1 and
trigger.misc.getUserFlag('8') == 1 then
a2gh_text_fail()
end

if
trigger.misc.getUserFlag('AGH5-Inside') == 1 and
trigger.misc.getUserFlag('8') == 1 then
a2gh_text_fail()
end

if
trigger.misc.getUserFlag('AGH6-Inside') == 1 and
trigger.misc.getUserFlag('8') == 1 then
a2gh_text_fail()
end

if
trigger.misc.getUserFlag('AGH7-Inside') == 1 and
trigger.misc.getUserFlag('8') == 1 then
a2gh_text_fail()
end

if
trigger.misc.getUserFlag('AGH8-Inside') == 1 and
trigger.misc.getUserFlag('8') == 1 then
a2gh_text_fail()
end

if
trigger.misc.getUserFlag('AGH9-Inside') == 1 and
trigger.misc.getUserFlag('8') == 1 then
a2gh_text_fail()
end

if
trigger.misc.getUserFlag('AGH10-Inside') == 1 and
trigger.misc.getUserFlag('8') == 1 then
a2gh_text_fail()
end

--AG Manual
if
trigger.misc.getUserFlag('AGH-STARTING') == 0 and
trigger.misc.getUserFlag('AGH1-Inside') == 0 and
trigger.misc.getUserFlag('AGH2-Inside') == 0 and
trigger.misc.getUserFlag('AGH3-Inside') == 0 and
trigger.misc.getUserFlag('AGH4-Inside') == 0 and
trigger.misc.getUserFlag('AGH5-Inside') == 0 and
trigger.misc.getUserFlag('AGH6-Inside') == 0 and
trigger.misc.getUserFlag('AGH7-Inside') == 0 and
trigger.misc.getUserFlag('AGH8-Inside') == 0 and
trigger.misc.getUserFlag('AGH9-Inside') == 0 and
trigger.misc.getUserFlag('AGH10-Inside') == 0 and
trigger.misc.getUserFlag('10') == 1 then
a2gia_text_start()
end

if
a2g_helo_inf_autostart == true and
trigger.misc.getUserFlag('AGH-STARTING') == 0 and
trigger.misc.getUserFlag('AGH1-Inside') == 0 and
trigger.misc.getUserFlag('AGH2-Inside') == 0 and
trigger.misc.getUserFlag('AGH3-Inside') == 0 and
trigger.misc.getUserFlag('AGH4-Inside') == 0 and
trigger.misc.getUserFlag('AGH5-Inside') == 0 and
trigger.misc.getUserFlag('AGH6-Inside') == 0 and
trigger.misc.getUserFlag('AGH7-Inside') == 0 and
trigger.misc.getUserFlag('AGH8-Inside') == 0 and
trigger.misc.getUserFlag('AGH9-Inside') == 0 and
trigger.misc.getUserFlag('AGH10-Inside') == 0 then
--trigger.misc.getUserFlag('10') == 1 then
a2gia_text_start_auto()
end


--AG FAIL
if
trigger.misc.getUserFlag('AGH1-Inside') == 1 and
trigger.misc.getUserFlag('10') == 1 then
a2gia_text_fail()
end

if
trigger.misc.getUserFlag('AGH2-Inside') == 1 and
trigger.misc.getUserFlag('10') == 1 then
a2gia_text_fail()
end

if
trigger.misc.getUserFlag('AGH3-Inside') == 1 and
trigger.misc.getUserFlag('10') == 1 then
a2gia_text_fail()
end

if
trigger.misc.getUserFlag('AGH4-Inside') == 1 and
trigger.misc.getUserFlag('10') == 1 then
a2gia_text_fail()
end

if
trigger.misc.getUserFlag('AGH5-Inside') == 1 and
trigger.misc.getUserFlag('10') == 1 then
a2gia_text_fail()
end

if
trigger.misc.getUserFlag('AGH6-Inside') == 1 and
trigger.misc.getUserFlag('10') == 1 then
a2gia_text_fail()
end

if
trigger.misc.getUserFlag('AGH7-Inside') == 1 and
trigger.misc.getUserFlag('10') == 1 then
a2gia_text_fail()
end

if
trigger.misc.getUserFlag('AGH8-Inside') == 1 and
trigger.misc.getUserFlag('10') == 1 then
a2gia_text_fail()
end

if
trigger.misc.getUserFlag('AGH9-Inside') == 1 and
trigger.misc.getUserFlag('10') == 1 then
a2gia_text_fail()
end

if
trigger.misc.getUserFlag('AGH10-Inside') == 1 and
trigger.misc.getUserFlag('10') == 1 then
a2gia_text_fail()
end


--AG Manual
if
trigger.misc.getUserFlag('AS-STARTING') == 0 and
trigger.misc.getUserFlag('ASS1-Inside') == 0 and
trigger.misc.getUserFlag('ASS2-Inside') == 0 and
trigger.misc.getUserFlag('ASS3-Inside') == 0 and
trigger.misc.getUserFlag('ASS4-Inside') == 0 and
trigger.misc.getUserFlag('ASS5-Inside') == 0 and
trigger.misc.getUserFlag('9') == 1 then
a2gas_text_start()
end

if
antiship_autostart == true and
trigger.misc.getUserFlag('AS-STARTING') == 0 and
trigger.misc.getUserFlag('ASS1-Inside') == 0 and
trigger.misc.getUserFlag('ASS2-Inside') == 0 and
trigger.misc.getUserFlag('ASS3-Inside') == 0 and
trigger.misc.getUserFlag('ASS4-Inside') == 0 and
trigger.misc.getUserFlag('ASS5-Inside') == 0 then
--trigger.misc.getUserFlag('9') == 1 then
a2gas_text_start_auto()
end

--AG FAIL
if
trigger.misc.getUserFlag('ASS1-Inside') == 1 and
trigger.misc.getUserFlag('9') == 1 then
a2gas_text_fail()
end

if
trigger.misc.getUserFlag('ASS2-Inside') == 1 and
trigger.misc.getUserFlag('9') == 1 then
a2gas_text_fail()
end

if
trigger.misc.getUserFlag('ASS3-Inside') == 1 and
trigger.misc.getUserFlag('9') == 1 then
a2gas_text_fail()
end

if
trigger.misc.getUserFlag('ASS4-Inside') == 1 and
trigger.misc.getUserFlag('9') == 1 then
a2gas_text_fail()
end

if
trigger.misc.getUserFlag('ASS5-Inside') == 1 and
trigger.misc.getUserFlag('9') == 1 then
a2gas_text_fail()
end

end

end
main_start_missions()

trigger.action.outText("Trigger LUA File Loaded...", 10)
env.info('TRIGGER LUA FILE LOAD SUCCESSFUL... ok')