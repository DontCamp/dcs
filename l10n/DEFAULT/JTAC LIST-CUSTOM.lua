
function jtac_smoke_on()

if jtac_smoke_targets == true then
JTACAutoLase('JTAC-AG1', 1688, true,"all" )
JTACAutoLase('JTAC-AG2', 1688, true,"all" )
JTACAutoLase('JTAC-AG3', 1688, true,"all" )
JTACAutoLase('JTAC-AG4', 1688, true,"all" )
JTACAutoLase('JTAC-AG5', 1688, true,"all" )

JTACAutoLase('JTAC-AG6', 1688, true,"all" )
JTACAutoLase('JTAC-AG7', 1688, true,"all" )
JTACAutoLase('JTAC-AG8', 1688, true,"all" )
JTACAutoLase('JTAC-AG9', 1688, true,"all" )
JTACAutoLase('JTAC-AG10', 1688, true,"all" )

JTACAutoLase('JTAC-MR1', 1688, true,"all" )
JTACAutoLase('JTAC-MR2', 1688, true,"all" )
JTACAutoLase('JTAC-MR3', 1688, true,"all" )
JTACAutoLase('JTAC-MR4', 1688, true,"all" )
JTACAutoLase('JTAC-MR5', 1688, true,"all" )

JTACAutoLase('JTAC-MR6', 1688, true,"all" )
JTACAutoLase('JTAC-MR7', 1688, true,"all" )
JTACAutoLase('JTAC-MR8', 1688, true,"all" )
JTACAutoLase('JTAC-MR9', 1688, true,"all" )
JTACAutoLase('JTAC-MR10', 1688, true,"all" )

JTACAutoLase('JTAC-AGH1', 1688, true,"all" )
JTACAutoLase('JTAC-AGH2', 1688, true,"all" )
JTACAutoLase('JTAC-AGH3', 1688, true,"all" )
JTACAutoLase('JTAC-AGH4', 1688, true,"all" )
JTACAutoLase('JTAC-AGH5', 1688, true,"all" )

JTACAutoLase('JTAC-AGH6', 1688, true,"all" )
JTACAutoLase('JTAC-AGH7', 1688, true,"all" )
JTACAutoLase('JTAC-AGH8', 1688, true,"all" )
JTACAutoLase('JTAC-AGH9', 1688, true,"all" )
JTACAutoLase('JTAC-AGH10', 1688, true,"all" )
trigger.action.outText("JTACs are set to SMOKE LASED TARGETS\n\nThese settings are configurable in the MISSION EDITOR. Check out the settings config tutorial text file that came with the mission for more details!", 10)
end

end

function jtac_smoke_off()

if jtac_smoke_targets == false then
JTACAutoLase('JTAC-AG1', 1688, false,"all" )
JTACAutoLase('JTAC-AG2', 1688, false,"all" )
JTACAutoLase('JTAC-AG3', 1688, false,"all" )
JTACAutoLase('JTAC-AG4', 1688, false,"all" )
JTACAutoLase('JTAC-AG5', 1688, false,"all" )

JTACAutoLase('JTAC-AG6', 1688, false,"all" )
JTACAutoLase('JTAC-AG7', 1688, false,"all" )
JTACAutoLase('JTAC-AG8', 1688, false,"all" )
JTACAutoLase('JTAC-AG9', 1688, false,"all" )
JTACAutoLase('JTAC-AG10', 1688, false,"all" )

JTACAutoLase('JTAC-MR1', 1688, false,"all" )
JTACAutoLase('JTAC-MR2', 1688, false,"all" )
JTACAutoLase('JTAC-MR3', 1688, false,"all" )
JTACAutoLase('JTAC-MR4', 1688, false,"all" )
JTACAutoLase('JTAC-MR5', 1688, false,"all" )

JTACAutoLase('JTAC-MR6', 1688, false,"all" )
JTACAutoLase('JTAC-MR7', 1688, false,"all" )
JTACAutoLase('JTAC-MR8', 1688, false,"all" )
JTACAutoLase('JTAC-MR9', 1688, false,"all" )
JTACAutoLase('JTAC-MR10', 1688, false,"all" )

JTACAutoLase('JTAC-AGH1', 1688, false,"all" )
JTACAutoLase('JTAC-AGH2', 1688, false,"all" )
JTACAutoLase('JTAC-AGH3', 1688, false,"all" )
JTACAutoLase('JTAC-AGH4', 1688, false,"all" )
JTACAutoLase('JTAC-AGH5', 1688, false,"all" )

JTACAutoLase('JTAC-AGH6', 1688, false,"all" )
JTACAutoLase('JTAC-AGH7', 1688, false,"all" )
JTACAutoLase('JTAC-AGH8', 1688, false,"all" )
JTACAutoLase('JTAC-AGH9', 1688, false,"all" )
JTACAutoLase('JTAC-AGH10', 1688, false,"all" )
trigger.action.outText("JTACs are set to NOT SMOKE LASED TARGETS\n\nThese settings are configurable in the MISSION EDITOR. Check out the settings config tutorial text file that came with the mission for more details!", 10)
end

end

jtac_smoke_off()
jtac_smoke_on()