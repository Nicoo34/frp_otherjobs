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



function PlayAnim()
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_HAND")
    local playerPed = PlayerPedId()

    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_PICKAXE_WALL'), 40000, true, false, false, false)
end



RegisterNetEvent("FRP:COTON:StartAnimTraitement")
AddEventHandler("FRP:COTON:StartAnimTraitement",
    function()

    local playerPed = PlayerPedId()


     PlayAnim()

end
)


RegisterNetEvent("FRP:COTON:StartAnimTransformation")
AddEventHandler("FRP:COTON:StartAnimTransformation",
    function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    if IsPedMale(playerPed) then
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_BUCKET_PICKUP_FULL'), 40000, true, false, false, false)

    else
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_BUCKET_PICKUP_FULL'), 40000, true, false, false, false)

    end
end
)
RegisterNetEvent('FRP:COTON:PROGRESS')
AddEventHandler('FRP:COTON:PROGRESS', function(timer, text)
 progbar:startUI(timer, text)

 end
)
Citizen.CreateThread(
    function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for _, v in pairs(Config.Recolte) do               
                if getDistance(coords, v) < 2 then
                  Traitement(false)
                end
         end
    end
end
)


function Traitement(istraitement)
    if istraitement then
    DrawTxt("Appuyez sur ALT commencer à traiter ", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000)
    if IsControlJustReleased(0, 0x8AAA0AD4) then
        local W = math.random(8000,15000)
            Citizen.Wait(1)
            FreezeEntityPosition(playerPed,true)
            TriggerServerEvent("FRP:MINING:TRAITEMENT")
            Citizen.Wait(W)
            FreezeEntityPosition(playerPed,false)
            ClearPedTasks(playerPed)
            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)

    end
    else
        DrawTxt("Appuyez sur ALT commencer à récolter du cotton", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000) 
        if IsControlJustReleased(0, 0x8AAA0AD4) then
            local W = math.random(8000,15000)
                TriggerServerEvent("FRP:RECOLTE:COTON")
                Citizen.Wait(10000)
                TriggerServerEvent("FRP:RECOLTE:COTON")
                Citizen.Wait(10000)
                TriggerServerEvent("FRP:RECOLTE:COTON")
                FreezeEntityPosition(playerPed,true)
                Citizen.Wait(W)
                FreezeEntityPosition(playerPed,false)
                DeleteObject(entity)
                ClearPedTasks(playerPed)
                SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
        end

    end
end

Citizen.CreateThread(
    function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for _, v in pairs(Config.Traitement) do
                if getDistance(coords, v) < 2 then
                    Traitement(true)
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
        for _, v in pairs(Config.Transformation) do
                if getDistance(coords, v) < 2 then
                    DrawTxt("Appuyez sur ALT commencer à transformer ", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000)
                    if IsControlJustReleased(0, 0x8AAA0AD4) then
                        local W = math.random(8000,15000)
                            Citizen.Wait(1)
                            FreezeEntityPosition(playerPed,true)
                            TriggerServerEvent("FRP:COTON:TRANSFORMATION")
                            Citizen.Wait(W)
                            FreezeEntityPosition(playerPed,false)
                            ClearPedTasks(playerPed)
                            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
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
                    DrawTxt("Appuyez sur ALT pour revendre ", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000)
                    if IsControlJustReleased(0, 0x8AAA0AD4) then
                        TriggerServerEvent("FRP:COTON:REVENTE")
                    end
                end
         end
    end
end
)



