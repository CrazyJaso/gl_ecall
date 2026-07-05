RegisterNetEvent('gl_ecall:send', function(data)

    local src = source

    print(("[gl_ecall] eCall von %s"):format(src))

    -- EmergencyDispatch Integration
    TriggerEvent(
        'emergencydispatch:emergencycall:new',
        "ambulance",
        ("Automatischer eCall\nFahrzeug: %s\nKennzeichen: %s"):format(
            data.model,
            data.plate
        ),
        data.coords,
        true
    )

end)