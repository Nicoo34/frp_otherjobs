local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local progbar = exports['progressBars']


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
      SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 10)
    DisplayText(str, x, y)
end


local square = math.sqrt
function getDistance(a, b) 
    local x, y, z = a.x-b.x, a.y-b.y, a.z-b.z
    return square(x*x+y*y+z*z)
end



function LoadModel(model)
    local attempts = 0
    while attempts < 100 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
        attempts = attempts + 1
    end
    return IsModelValid(model)
end

function MineAttach()
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_HAND")
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    if IsPedMale(playerPed) then
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_PICKAXE_WALL'), 40000, true, false, false, false)

    else
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_PICKAXE_WALL'), 40000, true, false, false, false)

    end

end

RegisterNetEvent("FRP:GOLDMINING:StartAnimTraitement")
AddEventHandler("FRP:GOLDMINING:StartAnimTraitement",
    function()
        print("anim")
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    if IsPedMale(playerPed) then
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_BUCKET_PICKUP_FULL'), 40000, true, false, false, false)

    else
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_BUCKET_PICKUP_FULL'), 40000, true, false, false, false)

    end
end
)


RegisterNetEvent('FRP:GOLDMINING:PROGRESS')
AddEventHandler('FRP:GOLDMINING:PROGRESS', function(timer, text)
 progbar:startUI(timer, text)

 end
)


function recoltegold()
    local playerPed = PlayerPedId()
    local countdown = math.random(8000,15000)
    FreezeEntityPosition(playerPed,true)
    Citizen.Wait(countdown)
    FreezeEntityPosition(playerPed,false)
    ClearPedTasks(playerPed)
    SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
end
function goldminingprocess()
    Citizen.Wait(10000)
    TriggerServerEvent("FRP:RECOLTE:GOLDMINING")
    Citizen.Wait(10000)
    TriggerServerEvent("FRP:RECOLTE:GOLDMINING")
    Citizen.Wait(10000)
    TriggerServerEvent("FRP:RECOLTE:GOLDMINING")
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local W = math.random(8000,15000)
        for _, v in pairs(Config.Recolte) do           
                if getDistance(coords, v) < 2 then
                    DrawTxt("Appuyez sur ALT commencer à récolter ", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000) 
                    if IsControlJustReleased(0, 0x8AAA0AD4) then
                            MineAttach()
                            goldminingprocess()
                            recoltegold()
                    end
                end
         end
    end
end
)

local traitement = true
local transformation = true
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        if traitement then
            traitement = true
            for _, v in pairs(Config.Traitement) do
                if getDistance(coords, v) < 2 then
                  DrawTxt("Appuyez sur ALT commencer à traiter ", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000)
                end
            end
        end
        if transformation then
            DrawTxt("Appuyez sur ALT pour faire fondre l'or ", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000)
        end
    end
end
)

function processoptimized()
    local playerPed = PlayerPedId()
    local countdown = math.random(8000,15000)
    FreezeEntityPosition(playerPed,true)
    Citizen.Wait(countdown)
    FreezeEntityPosition(playerPed,false)
    ClearPedTasks(playerPed)
    SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local countdown = math.random(8000,15000)
        local authPlayer = true 

    
        for _, v in pairs(Config.Traitement) do
            if getDistance(coords, v) < 2 then

                if isleadergold or isemployeegold then
                    authPlayer = true
                end

                if authPlayer then   
                    if IsControlJustReleased(0, 0x8AAA0AD4) then       
                        TriggerServerEvent("FRP:GOLDMINING:TRAITEMENT")
                        processoptimized()                      
                    end
                end
            end
        end
            Citizen.Wait(1000)
        end
    end
)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        for _, v in pairs(Config.Transformation) do 
                if getDistance(coords, v) < 2 then
                    if IsControlJustReleased(0, 0x8AAA0AD4) then
                        TriggerServerEvent("FRP:GOLDMINING:TRANSFORMATION")
                        processoptimized()
                    end
                end
            end
         end
    end
)




Citizen.CreateThread(
    function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for _, v in pairs(Config.Revente) do
                if getDistance(coords, v) < 2 then
                    DrawTxt("Appuyez sur ALT pour vendre l'or", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000)
                    if IsControlJustReleased(0, 0x8AAA0AD4) then
                        TriggerServerEvent("FRP:GOLDMINING:REVENTE")
                        processoptimized()
                    end
                end
            end
         end
    end
)

