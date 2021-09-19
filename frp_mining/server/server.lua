local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('FRP:RECOLTE:MINING')
AddEventHandler('FRP:RECOLTE:MINING', 
function()	
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()
    local Character = User:getCharacter()
    local count = math.random(1, 3)
    local MineCoal = false

            Inventory:addItem("raw_coal", count * 2)
            
            User:notify("item", "raw_coal", count * 2)
   
end
)


RegisterServerEvent("FRP:MINING:TRAITEMENT")
AddEventHandler(
    "FRP:MINING:TRAITEMENT",
    function()
    
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local rawcoal = false
        local HaveRawCoal = true
        local amountraw = 1
        

     while HaveRawCoal do

        if Inventory:getItemAmount("raw_coal") >= 3 then
            Inventory:removeItem(-1, "raw_coal", -3)
     
            Inventory:addItem("coal", amountraw)
            rawcoal = true
            TriggerClientEvent("FRP:MINING:StartAnimTraitement", _source)

            User:notify("alert", "Traitement en cours...")
        --    Citizen.CreateThread(
          --      while 
           --è )
            TriggerClientEvent("FRP:MINING:PROGRESS", _source, 19000, "Traitement en cours")
            Citizen.Wait(20000)
            User:notify("item", "coal", amountraw)
        else 
            User:notify("error", "Vous n'avez pas assez de matériaux à traiter!")
            HaveRawCoal = false
        end     
       end
    end
)


RegisterServerEvent("FRP:MINING:TRANSFORMATION")
AddEventHandler(
    "FRP:MINING:TRANSFORMATION",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local coal = false
        local HaveCoal = true
        local amountbag = 1

     while HaveCoal do

        if Inventory:getItemAmount("coal") >= 10 then
            Inventory:removeItem(-1, "coal", -10)
            Inventory:addItem("coalbag", amountbag)
            coal = true
            TriggerClientEvent("FRP:MINING:StartAnimTraitement", _source)

            User:notify("alert", "Traitement en cours...")
        --    Citizen.CreateThread(
          --      while 
           --è )
            TriggerClientEvent("FRP:MINING:PROGRESS", _source, 19000, "Transformation en cours")
            Citizen.Wait(20000)
            User:notify("item", "coalbag", amountbag)
        else 
            User:notify("error", "Vous n'avez pas assez de matériaux à traiter!")
            HaveCoal = false
        end     
       end
    
end
)

RegisterServerEvent("FRP:MINING:REVENTE")
AddEventHandler(
    "FRP:MINING:REVENTE",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local bagcoal = false
        local Coalbag = true
        local amount = 10000
        

     while Coalbag do

        if Inventory:getItemAmount("coalbag") >= 1 then
            Inventory:removeItem(-1, "coalbag", 1)
            Inventory:addItem("money", amount)
            bagcoal = true

            User:notify("alert", "Revente en cours...")
        --    Citizen.CreateThread(
          --      while 
           --è )
            TriggerClientEvent("FRP:MINING:PROGRESS", _source, 4900, "Revente en cours")
            Citizen.Wait(5000)
            User:notify("item", "money", amount)
            
        else 
            User:notify("error", "Vous n'avez pas assez de matériaux à traiter!")
            Coalbag = false
        end     
    end   
end
)