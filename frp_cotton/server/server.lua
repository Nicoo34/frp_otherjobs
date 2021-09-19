local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('FRP:RECOLTE:COTON')
AddEventHandler('FRP:RECOLTE:COTON', 
function()	
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()
    local Character = User:getCharacter()
    local count = math.random(1, 3)

            Inventory:addItem("cotton", count * 2)
            
            User:notify("item", "cotton", count * 2)
   
end
)


RegisterServerEvent("FRP:MINING:COTON")
AddEventHandler(
    "FRP:MINING:COTON",
    function()
    
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local cotton = false
        local HaveCotton = true
        local amountraw = 1
        

     while HaveCotton do

        if Inventory:getItemAmount("cotton") >= 3 then
            Inventory:removeItem(-1, "cotton", -3)
     
            Inventory:addItem("cotton_flower", amountraw)
            cotton = true

            User:notify("alert", "Traitement en cours...")
        --    Citizen.CreateThread(
          --      while 
           --è )
            TriggerClientEvent("FRP:COTON:PROGRESS", _source, 19000, "Traitement en cours")
            Citizen.Wait(20000)
            User:notify("item", "cotton_flower", amountraw)
        else 
            User:notify("error", "Vous n'avez pas assez de matériaux à traiter!")
            HaveCotton = false
        end     
       end
    end
)


RegisterServerEvent("FRP:COTON:TRANSFORMATION")
AddEventHandler(
    "FRP:COTON:TRANSFORMATION",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local cottonflower = false
        local HaveCottonFlower = true
        local amountbag = 1

     while HaveCottonFlower do

        if Inventory:getItemAmount("cotton_flower") >= 10 then
            Inventory:removeItem(-1, "cotton_flower", -10)
            Inventory:addItem("cottonbag", amountbag)
            cottonflower = true

            User:notify("alert", "Traitement en cours...")
        --    Citizen.CreateThread(
          --      while 
           --è )
            TriggerClientEvent("FRP:MINING:PROGRESS", _source, 19000, "Transformation en cours")
            Citizen.Wait(20000)
            User:notify("item", "cottonbag", amountbag)
        else 
            User:notify("error", "Vous n'avez pas assez de matériaux à traiter!")
            HaveCottonFlower = false
        end     
       end
    
end
)

RegisterServerEvent("FRP:COTON:REVENTE")
AddEventHandler(
    "FRP:COTON:REVENTE",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local cottonbag = false
        local HaveCottonBag = true
        local amount = 10000
        

     while HaveCottonBag do

        if Inventory:getItemAmount("cottonbag") >= 1 then
            Inventory:removeItem(-1, "cottonbag", 1)
            Inventory:addItem("money", amount)
            cottonbag = true

        --    Citizen.CreateThread(
          --      while 
           --è )
            TriggerClientEvent("FRP:MINING:PROGRESS", _source, 4900, "Revente en cours")
            Citizen.Wait(5000)
            User:notify("item", "money", amount)
            
        else 
            User:notify("error", "Vous n'avez pas assez de matériaux à traiter!")
            HaveCottonBag = false
        end     
    end   
end
)