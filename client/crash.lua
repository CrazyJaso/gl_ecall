local previousSpeed = 0.0

CreateThread(function()

    while true do

        Wait(100)

        local ped = PlayerPedId()

        if not IsPedInAnyVehicle(ped,false) then
            previousSpeed = 0.0
            goto continue
        end

        local vehicle = GetVehiclePedIsIn(ped,false)

        if GetPedInVehicleSeat(vehicle,-1) ~= ped then
            goto continue
        end

        local speed = GetEntitySpeed(vehicle) * 3.6

        if previousSpeed == 0 then
            previousSpeed = speed
        end

        local delta = previousSpeed - speed

        if delta >= Config.MinimumSpeedLoss and previousSpeed >= Config.MinimumSpeed then

            GL.Debug(("Crash erkannt %.1f km/h Verlust"):format(delta))

            TriggerEvent("gl_ecall:start",{
                vehicle = vehicle,
                delta = delta,
                speed = previousSpeed
            })

        end

        previousSpeed = speed

        ::continue::

    end

end)