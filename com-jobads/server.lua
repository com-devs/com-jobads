local QBCore = exports['qb-core']:GetCoreObject()

local com-jobads = {
    -- Lisa tööd mis saavad /ad kasutada
    "burgershot",
    "job_name_2",
    "job_name_3"
}

-- Checkib kas mängijal whitelisted job [ local com-jobads = { ]
local function IsPlayerWhitelisted(jobName)
    for _, com-jobads in ipairs(com-jobads) do
        if com-jobads == jobName then
            return true
        end
    end
    return false
end

RegisterServerEvent("com-jobads:advertise")
AddEventHandler("com-jobads:advertise", function(message, isOpen)
    local player = QBCore.Functions.GetPlayer(source)

    if player then
        local job = player.PlayerData.job

        if job and IsPlayerWhitelisted(job.name) then
            local jobLabel = job.label
            local playerName = GetPlayerName(source)

            if isOpen then
                -- Näidake reklaami avatud ettevõttena
                TriggerClientEvent("chatMessage", -1, "^7" .. jobLabel .. ": " .. message)
            else
                -- LAMP -- errori fiximiseks!!
                TriggerClientEvent("chatMessage", -1, "^7" .. jobLabel .. ": " .. message)
            end
        else
            -- Player does not have a whitelisted job
            TriggerClientEvent("chatMessage", source, "^1Viga: ^7Selle käsu kasutamiseks peab teil olema lubatud töökoht.")
        end
    else
        -- Kui ei leia, et mängija sees [juhtub siis kui keegi executoriga moddidega proovib exploitida]
        TriggerClientEvent("chatMessage", source, "^1Viga: ^7Mängija andmeid ei leitud. Veenduge, et olete ilusti sisse laadinud.")
    end
end)






