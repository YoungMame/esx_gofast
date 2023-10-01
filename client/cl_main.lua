ESX = exports["es_extended"]:getSharedObject()

language = Config.locale
local inDialog = false
local drugProp
local inGofast = false
local waiting = false
local dealerPed = nil

if Config.showBlip then
    local blip = AddBlipForCoord(Config.Ped.coords.x, Config.Ped.coords.y, Config.Ped.coords.z)
    SetBlipSprite(blip, Config.Blip.sprite)
    SetBlipColour(blip, Config.Blip.color)
    SetBlipDisplay(blip, Config.Blip.display)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(Config.Blip.label)
    EndTextCommandSetBlipName(blip)
end

CreateThread(function()


    local hash = Config.Ped.model
    local coords = vector3(Config.Ped.coords.x, Config.Ped.coords.y, Config.Ped.coords.z - 1.0)
    local heading = Config.Ped.coords.w

    local ped = createDealer(hash, coords, heading)

    while true do
        local ms = 1000
        if #(GetEntityCoords(PlayerPedId()) - coords) < 1.3 and inDialog == false and inGofast == false then
            ms = 0
            ESX.ShowHelpNotification(Config.Locales[language]['click_request'])
            if IsControlJustPressed(0, 51) then
                startDialog()
            end
        end
        Wait(ms)
    end
end)

function createDealer(hash, coords, heading)

    CreateThread(function()
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Wait(10)
        end
        local ped = CreatePed(4, hash, coords, false, false)
        SetEntityHeading(ped, heading)
        SetEntityAsMissionEntity(ped, true, true)
        SetPedHearingRange(ped, 0.0)
        SetPedSeeingRange(ped, 0.0)
        SetPedAlertness(ped, 0.0)
        SetPedFleeAttributes(ped, 0, 0)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedCombatAttributes(ped, 46, true)
        SetPedFleeAttributes(ped, 0, 0)
        FreezeEntityPosition(ped, true)

        dealerPed = ped
    end)
end

function drawTxt(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
  end

function waitingF()
    CreateThread(function()
        waiting = true
        Wait(Config.Waiting)
        waiting = false
    end)
end

function createDrugCar(callback)
    local carToReturn
    local table = Config.Cars[math.random(1, #Config.Cars)]
    local greg = ESX.Game.SpawnVehicle(table.model, vector3(Config.carSpawn.x, Config.carSpawn.y, Config.carSpawn.z), Config.carSpawn.w, function(car) 
        CreateThread(function()
            RequestModel(table.prop)
            while not HasModelLoaded(table.prop) do
                Wait(10)
            end          
            drugProp = CreateObject(table.prop, 0.0, 0.0, 0.0, true, false)
            AttachEntityToEntity(drugProp, car, GetEntityBoneIndexByName(car, "chassis"), table.xPos, table.yPos, table.zPos, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            if callback then
                callback(car)
            end
        end)
    end)
end

function startGofast()
    if inGofast == true then return end
    inGofast = true
    local drugCar = nil
    local route = Config.Routes[math.random(1, #Config.Routes)]
    local routeCoords = vector3(route.coords.x, route.coords.y, route.coords.z - 1.0)
    local playerPed = PlayerPedId()
    createDealer('cs_manuel', vector3(route.pedCoords.x, route.pedCoords.y, route.pedCoords.z - 1.0), route.pedCoords.w)
    createDrugCar(function(cb)
        drugCar = cb
    end)


    local blip = AddBlipForCoord(routeCoords)
    SetBlipColour(blip, 5)
    SetBlipDisplay(blip, 4)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(Config.Locales[language]['destination'])
    EndTextCommandSetBlipName(blip)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 5)

    CreateThread(function()
        if Config.showText then
            while inGofast do
                drawTxt(Config.Locales[language]['go_to']..'~y~'..route.label, 0, {240, 240, 240, 190}, 0.5, 0.44, 0.9)
                Wait(1)
            end
        end
    end)

    CreateThread(function()
        local firstA = false
        local secondA = false
        local seconds = 0
        while inGofast do
            Wait(1000)
            seconds = seconds + 1
            if route.time - seconds < 120 and firstA == false then
                firstA = true
                ESX.ShowNotification(Config.Locales[language]['2min_left'])
            end
            if route.time - seconds < 30 and secondA == false then
                secondA = true
                ESX.ShowNotification(Config.Locales[language]['30sec_left'])
            end
            if seconds > route.time then 
                inGofast = false
                ESX.ShowHelpNotification(Config.Locales[language]['time_elapsed'])
                TaskLeaveVehicle(playerPed, true, 256)
                Wait(600)
                SetVehicleDoorsLockedForAllPlayers(drugCar, true)
                RemoveBlip(blip)
                FreezeEntityPosition(dealerPed, false)
                TaskWanderStandard(dealerPed, 10.0, 10)
            end
        end
    end)

    CreateThread(function()
        ESX.ShowHelpNotification(Config.Locales[language]['warning'])
        if Config.sendPoliceAlert then
            TriggerServerEvent('esx_gofast:sendPoliceAlert', GetDisplayNameFromVehicleModel(GetEntityModel(drugCar)))
        end
        while inGofast do
            Wait(1000)
            if not IsVehicleDriveable(drugCar) then 
                inGofast = false
                ESX.ShowHelpNotification(Config.Locales[language]['car_destroyed'])
                TaskLeaveVehicle(playerPed, true, 256)
                Wait(600)
                SetVehicleDoorsLockedForAllPlayers(drugCar, true)
                RemoveBlip(blip)
                return
            end
            if #(GetEntityCoords(drugCar) - routeCoords) < 10 then

                RemoveBlip(blip)

                SetVehicleForwardSpeed(drugCar, 0)
                Wait(200)
                TaskLeaveVehicle(playerPed, drugCar, 256)

                Wait(1000)


                TriggerServerEvent('esx_gofast:endGofast', true, 'notorious', VehToNet(drugCar), routeCoords)
                inGofast = false

                SetVehicleDoorsLockedForAllPlayers(drugCar, true)
                FreezeEntityPosition(dealerPed, false)

                Wait(100)

                TaskEnterVehicle(dealerPed, drugCar,  -1, 1, 2.0001, 1)

                SetVehRadioStation(drugCar, 'RADIO_08_MEXICAN')
                Wait(3000)

                TaskVehicleDriveToCoord(dealerPed, drugCar, 300.0, 300.0, 30.0, 16.0, 0, GetEntityModel(drugCar), 411, 12.0)

                Wait(120000)

                TaskWanderStandard(dealerPed, 10.0, 10)
            end
        end
    end)
end

function startDialog()
    inDialog = true
    CreateThread(function()
        while inDialog do
            ESX.ShowHelpNotification(Config.Locales[language]['pay_request']..Config.guarantee..Config.Locales[language]['pay_request2'])
            if IsControlJustPressed(0, 51) then
                ESX.TriggerServerCallback('esx_gofast:startGofast', function(cb) 
                    if cb == true then
                        startGofast()
                    elseif cb == false then
                       ESX.ShowNotification(Config.Locales[language]['not_enough_money'])
                    elseif cb == 'time' then
                        ESX.ShowNotification(Config.Locales[language]['not_enough_waiting'])
                    else
                        ESX.ShowNotification(Config.Locales[language]['not_enough_cops'])
                    end
                end, waiting)
                inDialog = false
            end
            if #(GetEntityCoords(PlayerPedId()) - vector3(Config.Ped.coords.x, Config.Ped.coords.y, Config.Ped.coords.z)) > 2.0 then inDialog = false end
            Wait(0)
        end
    end)
end

