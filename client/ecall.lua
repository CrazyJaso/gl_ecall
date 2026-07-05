local active = false

local function ShowECall(vehicle, plate, seconds)
    SetNuiFocus(false, false)

    SendNUIMessage({
        action = "show",
        vehicle = vehicle,
        plate = plate,
        seconds = seconds
    })
end

local function UpdateECall(seconds)
    SendNUIMessage({
        action = "update",
        seconds = seconds
    })
end

local function SentECall()
    SendNUIMessage({
        action = "sent"
    })
end

local function CancelECall()
    SendNUIMessage({
        action = "cancel"
    })
end

local function HideECall()
    SendNUIMessage({
        action = "hide"
    })
end

RegisterNetEvent("gl_ecall:countdown", function()

    if active then return end
    active = true

    local ped = PlayerPedId()

    if not IsPedInAnyVehicle(ped, false) then
        active = false
        return
    end

    local veh = GetVehiclePedIsIn(ped, false)

    local display = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
    local model = GetLabelText(display)

    if model == "NULL" or model == display then
        model = display
    end

    local plate = GetVehicleNumberPlateText(veh)

    if not plate or plate == "" then
        plate = "Unbekannt"
    end

    local seconds = Config.Countdown

    ShowECall(model, plate, seconds)

    while seconds > 0 do

        local startTime = GetGameTimer()

        while GetGameTimer() - startTime < 1000 do

            Wait(0)

            if IsControlJustReleased(0, Config.CancelKey) then

                CancelECall()

                Wait(1500)

                HideECall()

                active = false

                TriggerEvent("gl_ecall:reset")

                return

            end

        end

        seconds = seconds - 1

        UpdateECall(seconds)

    end

    TriggerServerEvent("gl_ecall:send", {
        coords = GetEntityCoords(ped),
        heading = GetEntityHeading(veh),
        plate = plate,
        model = model
    })

    SentECall()

    Wait(3000)

    HideECall()

    active = false

    TriggerEvent("gl_ecall:reset")

end)