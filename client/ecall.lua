local countdownActive = false

RegisterNetEvent('gl_ecall:countdown', function(data)

    if countdownActive then return end

    countdownActive = true

    local seconds = Config.Countdown

    while seconds > 0 do

        lib.notify({
            title = 'Automatischer eCall',
            description = ('Ein Notruf wird in %s Sekunden abgesetzt.\n\nDrücke [G] zum Abbrechen.'):format(seconds),
            type = 'warning',
            duration = 1000
        })

        Wait(1000)

        if IsControlJustReleased(0, Config.CancelKey) then

            lib.notify({
                title = 'eCall',
                description = 'Automatischer Notruf wurde abgebrochen.',
                type = 'error'
            })

            countdownActive = false
            TriggerEvent('gl_ecall:reset')
            return
        end

        seconds = seconds - 1
    end

    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)

    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

    TriggerServerEvent('gl_ecall:send', {
        coords = coords,
        heading = heading,
        plate = plate,
        model = model
    })

    lib.notify({
        title = 'eCall',
        description = 'Der automatische Notruf wurde gesendet.',
        type = 'success'
    })

    countdownActive = false
    TriggerEvent('gl_ecall:reset')

end)