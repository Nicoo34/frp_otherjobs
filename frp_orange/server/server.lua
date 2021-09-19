local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('FRP:RECOLTE:ORANGE')
AddEventHandler('FRP:RECOLTE:ORANGE', 
function()	
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()
    local Character = User:getCharacter()
    local count = math.random(1, 3)


            Inventory:addItem("orange", count * 2)
            
            User:notify("item", "orange", count * 2)
   
end
)


RegisterServerEvent("FRP:ORANGE:TRAITEMENT")
AddEventHandler(
    "FRP:ORANGE:TRAITEMENT",
    function()
    
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local orange = false
        local HaveOrange = true
        local amountraw = 1
        

     while HaveOrange do

        if Inventory:getItemAmount("orange") >= 3 then
            Inventory:removeItem(-1, "orange", -3)
     
            Inventory:addItem("orange_juice", amountraw)
            orange = true

            User:notify("alert", "Traitement en cours...")

            TriggerClientEvent("FRP:ORANGE:PROGRESS", _source, 19000, "Traitement en cours")
            Citizen.Wait(20000)
            User:notify("item", "orange_juice", amountraw)
        else 
            User:notify("error", "Vous n'avez pas assez de matériaux à traiter!")
            HaveOrange = false
        end     
       end
    end
)


RegisterServerEvent("FRP:ORANGE:TRANSFORMATION")
AddEventHandler(
    "FRP:ORANGE:TRANSFORMATION",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local orangeclean = false
        local HaveOrangeClean = true
        local amountbag = 1

     while HaveOrangeClean do

        if Inventory:getItemAmount("orange_juice") >= 10 then
            Inventory:removeItem(-1, "orange_juice", -10)
            Inventory:addItem("orangebag", amountbag)
            orangeclean = true

            User:notify("alert", "Traitement en cours...")

            TriggerClientEvent("FRP:MINING:PROGRESS", _source, 19000, "Transformation en cours")
            Citizen.Wait(20000)
            User:notify("item", "orangebag", amountbag)
        else 
            User:notify("error", "Vous n'avez pas assez de matériaux à traiter!")
            HaveOrangeClean = false
        end     
       end
    
end
)

RegisterServerEvent("FRP:ORANGE:REVENTE")
AddEventHandler(
    "FRP:ORANGE:REVENTE",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local orangebag = false
        local HaveOrangeBag = true
        local amount = 10000
        

     while HaveOrangeBag do

        if Inventory:getItemAmount("orangebag") >= 1 then
            Inventory:removeItem(-1, "orangebag", 1)
            Inventory:addItem("money", amount)
            orangebag = true

            User:notify("alert", "Revente en cours...")

            TriggerClientEvent("FRP:ORANGE:PROGRESS", _source, 4900, "Revente en cours")
            Citizen.Wait(5000)
            User:notify("item", "money", amount)
            
        else 
            User:notify("error", "Vous n'avez pas assez de matériaux à traiter!")
            HaveOrangeBag = false
        end     
    end   
end
)