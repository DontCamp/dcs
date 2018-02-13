

spawnmsg = {}

spawnmsg.message = ""

-- Handles all world events
spawnmsg.eventHandler = {}
function spawnmsg.eventHandler:onEvent(_event)
    local status, err = pcall(function(_event)

        if _event == nil or _event.initiator == nil then
            return false

        elseif _event.id == 15 then --player entered unit

            if  _event.initiator:getName() then

                if spawnmsg.message ~= "" then
                    spawnmsg.displayMessageToGroup(_event.initiator,spawnmsg.message , 20,false)
                end

            end

            return true
        end
    end, _event)
    if (not status) then
        env.error(string.format("Error while handling event %s", err),false)
    end
end

function spawnmsg.getGroupId(_unit)

    local _unitDB =  mist.DBs.unitsById[tonumber(_unit:getID())]
    if _unitDB ~= nil and _unitDB.groupId then
        return _unitDB.groupId
    end

    return nil
end
function spawnmsg.displayMessageToGroup(_unit, _text, _time,_clear)

    local _groupId = spawnmsg.getGroupId(_unit)

    if _groupId then
        if _clear == true then
            trigger.action.outTextForGroup(_groupId, _text, _time,_clear)
        else
            trigger.action.outTextForGroup(_groupId, _text, _time)
        end
    end

end
world.addEventHandler(spawnmsg.eventHandler)

env.info("Message On Spawn event handler added")