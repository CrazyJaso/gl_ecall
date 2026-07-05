GL = {}

GL.ActiveCall = false
GL.LastCrash = 0

function GL.Debug(msg)
    if Config.Debug then
        print(("[gl_ecall] %s"):format(msg))
    end
end

RegisterNetEvent('gl_ecall:start', function(data)
    if GL.ActiveCall then return end

    GL.ActiveCall = true

    TriggerEvent('gl_ecall:countdown', data)
end)

RegisterNetEvent('gl_ecall:reset', function()
    GL.ActiveCall = false
end)