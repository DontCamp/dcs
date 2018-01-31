-- DCS - Bomb in Zone
-- Version 1.0


biz = {}

biz.bombZones = {

    {
        -- GROUP NAME for the unit whos waypoints enclose the target
        name = "runway zone 1",
        flag = 1000,
    },
    {
        name = "runway zone 2", -- GROUP NAME for the unit whos waypoints enclose the target
        flag = 1000,

    }
}


-- Handles all world events
biz.eventHandler = {}
function biz.eventHandler:onEvent(_eventDCS)

    if _eventDCS == nil or _eventDCS.initiator == nil then
        return true
    end


    local status, err = pcall(function(_event)

        if _event.id == world.event.S_EVENT_SHOT then

            local _weapon = _event.weapon:getTypeName()

            if string.match(_weapon, "weapons.bombs") --all bombs
            then

                local _ordnance =  _event.weapon

                env.info("Tracking ".._weapon.." - ".._ordnance:getName())
                local _temp = _ordnance:getPoint()
                local _lastBombPos =  {x = _temp.x, y = _temp.y, z= _temp.z }

                local trackBomb = function(_previousPos)

                    -- when the pcall returns a failure the weapon has hit
                    local _status,_bombPos =  pcall(function()
                        -- env.info("protected")
                        return _ordnance:getPoint()
                    end)

                    if  _status then
                        --ok! still in the air
                        _lastBombPos = {x = _bombPos.x, y = _bombPos.y, z= _bombPos.z }

                        return timer.getTime() + 0.005 -- check again !
                    else
                        --hit
                        -- get closet target to last position
                        for _,_targetZone in pairs(biz.bombZones) do

                            if mist.pointInPolygon(_lastBombPos,_targetZone.polygon) then
                                env.info("Bomb in zone ".._targetZone.name)

                                local _flag = tonumber(trigger.misc.getUserFlag(_targetZone.flag))

                                trigger.action.setUserFlag(_targetZone.flag, _flag+1)

                             --   env.info("Set Flag ".._targetZone.flag)

                                return nil
                            end
                        end

                        env.info("Bomb missed zone")

                    end

                    return nil
                end

                timer.scheduleFunction(trackBomb, nil, timer.getTime() + 0.1)
            end


            return true
        end


    end, _eventDCS)

    if (not status) then
        env.error(string.format("Error while handling event %s", err),false)
    end
end



for _,_targetZone in pairs(biz.bombZones) do

    if Group.getByName(_targetZone.name) then
        local _points = mist.getGroupPoints(_targetZone.name)

        env.info("Done for: ".._targetZone.name)
        _targetZone.polygon = _points
    else
        env.info("Couldn't find: ".._targetZone.name)
        _targetZone.polygon = nil
    end


end

world.addEventHandler(biz.eventHandler)
env.info("Bomb in Poly Zone Loaded")


