local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('FRP:RECOLTE:GOLDMINING')
AddEventHandler('FRP:RECOLTE:GOLDMINING', 
function()	
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()
    local Character = User:getCharacter()
    local count = math.random(1, 3)


            Inventory:addItem("rockgold", count * 2)
            
            User:notify("item", "rockgold", count * 2)
   
end
)


RegisterServerEvent("FRP:GOLDMINING:TRAITEMENT")
AddEventHandler(
    "FRP:GOLDMINING:TRAITEMENT",
    function()
    
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local rock = false
        local HaveRock = true
        local nuggetcount = math.random(0, 2)

     while HaveRock do

        if Inventory:getItemAmount("rockgold") >= 3 then
            Inventory:removeItem(-1, "rockgold", -3)
     
            Inventory:addItem("goldnugget", nuggetcount)
            rock = true
            TriggerClientEvent("FRP:GOLDMINING:StartAnimTraitement", _source)

            User:notify("alert", "Traitement en cours...")

            TriggerClientEvent("FRP:GOLDMINING:PROGRESS", _source, 19000, "Traitement en cours")
            Citizen.Wait(20000)
            User:notify("item", "goldnugget", nuggetcount)
        else 
            User:notify("error", "Vous n'avez pas assez de matériaux à traiter!")
            HaveRock = false
        end     
       end
    end
)

RegisterServerEvent("FRP:GOLDMINING:TRANSFORMATION")
AddEventHandler(
    "FRP:GOLDMINING:TRANSFORMATION",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()
        local amountbar = 1
        local goldnugget = false
        local HaveGoldNugget = true

     while HaveGoldNugget do

        if Inventory:getItemAmount("goldnugget") >= 50 then
            Inventory:removeItem(-1, "goldnugget", -50)
            Inventory:addItem("gold", amountbar)
            goldnugget = true

            User:notify("alert", "Traitement en cours...")

            TriggerClientEvent("FRP:GOLDMINING:PROGRESS", _source, 19000, "Traitement en cours")
            Citizen.Wait(20000)
            User:notify("item", "gold", amountbar)
        else 
            User:notify("error", "Vous n'avez pas assez de matériaux à traiter!")
            HaveGoldNugget = false
        end     
       end
    
end
)


RegisterServerEvent("FRP:GOLDMINING:REVENTE")
AddEventHandler(
    "FRP:GOLDMINING:REVENTE",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local gold = false
        local HaveGold = true
        local amount = 10000
        

     while HaveGold do

        if Inventory:getItemAmount("gold") >= 1 then
            Inventory:removeItem(-1, "gold", 1)
            Inventory:addItem("money", amount)
            gold = true

            User:notify("alert", "Revente en cours...")
        --    Citizen.CreateThread(
          --      while 
           --è )
           TriggerClientEvent("FRP:GOLDMINING:PROGRESS", _source, 19000, "Traitement en cours")
            Citizen.Wait(5000)
            User:notify("item", "money", amount)
            
        else 
            User:notify("error", "Vous n'avez pas assez de matériaux à traiter!")
            HaveGold = false
        end     
    end   
end
)