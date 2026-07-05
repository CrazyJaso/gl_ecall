local active = false

local function ShowECall(seconds)
    SetNuiFocus(false, false)

    SendNUIMessage({
        action = "show",
        seconds = seconds
    })
end

local function UpdateECall(seconds)
    SendNUIMessage({
        action = "update",
        seconds = seconds
    })
end

local function HideECall()
    SendNUIMessage({
        action = "hide"
    })
end

RegisterNetEvent("gl_ecall:countdown", function(data)

    if active then return end

    active = true

    local seconds = Config.Countdown

    ShowECall(seconds)

    while seconds > 0 do

        Wait(1000)

        seconds -= 1

        UpdateECall(seconds)

        if IsControlJustReleased(0, Config.CancelKey) then

            HideECall()

            lib.notify({
                title = "eCall",
                description = "Notruf wurde abgebrochen.",
                type = "error"
            })

            active = false
            TriggerEvent("gl_ecall:reset")
            return
        end
    end

    HideECall()

    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped,false)

    TriggerServerEvent("gl_ecall:send",{
        coords = GetEntityCoords(ped),
        heading = GetEntityHeading(veh),
        plate = GetVehicleNumberPlateText(veh),
        model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
    })

    lib.notify({
        title="eCall",
        description="Automatischer Notruf wurde gesendet.",
        type="success"
    })

    active = false

    TriggerEvent("gl_ecall:reset")

end)