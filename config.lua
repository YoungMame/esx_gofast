Config = {}

Config.showBlip = false
Config.showText = true

Config.Blip = {
    label = "Go fast",
    sprite = 7,
    color = 5,
    scale = 0.9,
    display = 4
}

Config.minCopsCount = 0
Config.useESXService = true
Config.sendPoliceAlert = false
Config.guarantee = 15000
Config.Pay = {
    min = 2000,
    max = 3500
}
Config.Waiting = 10*60000

Config.Ped = {
    coords = vector4(951.7, -3085.9, 5.9, 85.7),
    model = 's_m_m_dockwork_01'
}

Config.carSpawn = vector4(959.3, -3089.3, 5.6, 269.0)

Config.Cars = {                  --If you add a car think to change prop coord's
    {model = 'rhinehart', prop = 'bkr_prop_weed_bigbag_02a', xPos = 0.0, yPos = -1.7, zPos = 0.0},
    {model = 'kuruma', prop = 'bkr_prop_weed_bigbag_02a', xPos = 0.0, yPos = -1.8, zPos = -0.2},
    {model = 'argento', prop = 'bkr_prop_weed_bigbag_02a', xPos = 0.0, yPos = -1.8, zPos = 0.15},
    {model = 'tailgater2', prop = 'bkr_prop_weed_bigbag_02a', xPos = 0.0, yPos = -1.7, zPos = 0.15},
    {model = 'dubsta2', prop = 'bkr_prop_weed_bigbag_02a', xPos = 0.0, yPos = -1.7, zPos = 0.15},
    {model = 'rebla', prop = 'bkr_prop_weed_bigbag_02a', xPos = 0.0, yPos = -1.7, zPos = 0.15},
    {model = 'schwarzer', prop = 'bkr_prop_weed_bigbag_02a', xPos = 0.0, yPos = -1.7, zPos = 0.18},
    {model = 'nebula', prop = 'bkr_prop_weed_bigbag_02a', xPos = 0.0, yPos = -1.7, zPos = 0.18},
    {model = 'zion3', prop = 'bkr_prop_weed_bigbag_02a', xPos = 0.0, yPos = -1.7, zPos = 0.14}

}

Config.Routes = {
    {label = 'Paleto Bay', coords = vector3(-344.1, 6161.1, 31.2), pedCoords = vector4(-337.5, 6159.9, 31.5, 79.4), time = 600},
    {label = 'Grapeseed', coords = vector3(2036.5, 4977.9, 40.35), pedCoords = vector4(2040.9, 4986.5, 40.4, 218.3), time = 600},
    {label = 'Mont Gordo', coords = vector3(3327.3, 5151.7, 18.3), pedCoords = vector4(3317.6, 5159.4, 18.4, 223.9), time = 600},
    {label = 'Sandy Shores', coords = vector3(911.1, 3644.6, 32.7), pedCoords = vector4(911.1, 3644.6, 32.7, 187.0), time = 600},
    {label = 'Nort Chumash', coords = vector3(-2200.0, 4254.4, 47.7), pedCoords = vector4(-2193.2, 4250.5, 48.0, 124.7), time = 660}
}

Config.locale = 'fr'

Config.Locales = {       
    ['en'] = {    --I'am not a native english speaker, you can edit this at your own choice
        ['click_request'] = "Click ~INPUT_CONTEXT~ to start a go-fast",
        ['pay_request'] = "Click ~INPUT_CONTEXT~ to pay ~g~",
        ['pay_request2'] = "$~s~ as a gurantee for the cargo",
        ['not_enough_money'] = "~r~You do not have enough money to pay the dealer!",
        ['not_enough_waiting'] = "~r~You already done a go-fast not long ago!",
        ['not_enough_cops'] = "~r~There is not enough cops in the city",
        ['go_to'] = "Go to ",
        ['warning'] = "Be carefull while driving, some cops can be on the route!",
        ['car_destroyed'] = "The car got destroyed!",
        ['car_consficated'] = "The car got confiscated!",
        ['time_elapsed'] = "Time elapsed!",
        ['2min_left'] = "2 mins left!",
        ['30sec_left'] = "30 seconds left!",
        ['get_paid'] = "You got paid ~g~",
        ['police_alert'] = "A ",
        ['police_alert2'] = " is transporting an illegal cargo in direction of ",
        ['destination'] = "Destination"
    },
    ['fr'] = {    --I'am not a native english speaker, you can edit this at your own choice
        ['click_request'] = "Appuyer sur ~INPUT_CONTEXT~ pour commencer un go-fast",
        ['pay_request'] = "Appuyer sur ~INPUT_CONTEXT~ pour payer ~g~",
        ['pay_request2'] = "$~s~ comme garantie pour la marchandise",
        ['not_enough_money'] = "~r~Vous n'avez pas assez d'argent pour payer le trafiquant!",
        ['not_enough_waiting'] = "~r~Vous avez déja fait un go-fast il n'y a pas longtemps!",
        ['not_enough_cops'] = "~r~Il n'y a pas assez de flics en ville!",
        ['go_to'] = "Rendez vous à ~y~",
        ['warning'] = "Soyez prudent durant le trajet, des flics peuvent se trouver sur le chemin!",
        ['car_destroyed'] = "Le véhicule a été détruit!",
        ['car_consficated'] = "Le véhicule a été confisqué!",
        ['time_elapsed'] = "Temps ecoulé!",
        ['2min_left'] = "2 minutes restantes!",
        ['30sec_left'] = "30 secondes restantes!",
        ['get_paid'] = "Vous avez été payé ~g~",
        ['police_alert'] = "Une ",
        ['police_alert2'] = "  transportant une marchandise illégale a été aperçue roulant en direction de ",
        ['destination'] = "Destination"
    }
}