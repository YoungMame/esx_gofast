ESX = exports["es_extended"]:getSharedObject()
local language = Config.locale

RegisterNetEvent('esx_gofast:endGofast')

AddEventHandler('esx_gofast:endGofast', function(inGofast, mdp, carNet, point)
    local xPlayer = ESX.GetPlayerFromId(source)
    if inGofast ~= true or mdp ~= 'notorious' or #(GetEntityCoords(NetworkGetEntityFromNetworkId(carNet))-point) > 20 then --[[DropPlayer(source, 'cheating')]] print('cheat') return end
    local pay = math.random(Config.Pay.min, Config.Pay.max)
    xPlayer.addMoney(pay+Config.guarantee)
    TriggerClientEvent('esx:showNotification', source, Config.Locales[language]['get_paid']..pay.."$")
end)

ESX.RegisterServerCallback('esx_gofast:startGofast', function(source, cb, waiting)
    local xPlayer = ESX.GetPlayerFromId(source)
    local copNumber = 0
    if xPlayer.getMoney() < Config.guarantee then cb(false) return end
    if waiting ~= false then cb('time') return end
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer2.job.name == "police" or xPlayer2.job.name == "sheriff" then copNumber = copNumber + 1 end
    end
    if copNumber < Config.minCopsCount then cb('cop') return end
    cb(true)
    xPlayer.removeMoney(Config.guarantee)
 end)

 RegisterNetEvent('esx_gofast:sendPoliceAlert')

 AddEventHandler('esx_gofast:sendPoliceAlert', function(carModel)
    if Config.useESXService then
        TriggerEvent('esx_service:notifyAllInService', Config.Locales[language]['police_alert']..carModel..Config.Locales[language]['police_alert'], 'ambulance')
    else
        local players = ESX.GetPlayers()
        for i = 1, #players do
            local xPlayer = ESX.GetPlayerFromId(players[i])
            if xPlayer.job.name == 'police' then
                TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'DISPATCH', 'Go-fast', Config.Locales[language]['police_alert']..carModel..Config.Locales[language]['police_alert'], 'CHAR_CHAT_CALL', 9)
            end
        end
    end
 end)