local QBCore = exports['qb-core']:GetCoreObject()

local isJobOpen = true -- LAMP remosin ara
local adCooldown = 300 -- Cooldown /ad kasutamisel (300 sekundit = 5 minutit)
local isCooldownActive = false

RegisterCommand("ad", function(source, args, rawCommand)
    if not isCooldownActive then
        local message = table.concat(args, " ")

        if message ~= "" then
            if isJobOpen then
                -- LAMP POLE VAJA [ara remo]
                TriggerServerEvent("com-jobads:advertise", message, true)
            else
                -- lamp pole vaja [ara remo]
                TriggerServerEvent("com-jobads:advertise", message, false)
            end

            isCooldownActive = true
            Citizen.SetTimeout(adCooldown * 1000, function()
                isCooldownActive = false
            end)
        else
            -- Mängija ei lisa lõppu sõnumi
            TriggerEvent("chatMessage", "^1Viga: ^7Palun saatke oma kuulutuse sõnum.")
        end
    else
        TriggerEvent("chatMessage", "^1Viga: ^7Enne käsu /ad uuesti kasutamist oodake 5min.")
    end
end)




