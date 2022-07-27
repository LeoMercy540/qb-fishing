local QBCore = exports['qb-core']:GetCoreObject()

-- Eventos
QBCore.Functions.CreateUseableItem("fishingrod", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('qb-fishing:client:StartFishing', source)
    end
end)

RegisterNetEvent('qb-fishing:server:usebait', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local quantity = 1

    Player.Functions.RemoveItem('fishingbait', quantity)
end)

RegisterNetEvent('qb-fishing:server:CatchFish', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local quantity = math.random(1, 5)
    local prob = math.random(1, 100)

    if prob < 50 and prob < 30 then
        if Player.Functions.AddItem("fish", quantity) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["fish"], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, 'You have full pockets.', 'error')
        end  
    elseif prob >= 40 and prob < 80 then
        if Player.Functions.AddItem("shark", quantity) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["shark"], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, 'You have full pockets.', 'error')
        end
    elseif prob >= 10 and prob < 20 then
        if Player.Functions.AddItem("goldfish", quantity) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["goldfish"], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, 'You have full pockets.', 'error')
        end
    elseif prob >= 90 and prob < 100 then
        if Player.Functions.AddItem("salmon", quantity) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["salmon"], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, 'You have full pockets.', 'error')
        end
    elseif prob >= 60 and prob < 40 then
        if Player.Functions.AddItem("whale", quantity) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["whale"], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, 'You have full pockets.', 'error')
        end
    elseif prob >= 30 and prob < 10 then
        if Player.Functions.AddItem("dolphin", quantity) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["dolphin"], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, 'You have full pockets.', 'error')
        end
    elseif prob >= 80 and prob < 30 then
        if Player.Functions.AddItem("turtle", quantity) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["turtle"], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, 'You have full pockets.', 'error')
        end
    elseif prob >= 40 and prob < 90 then
        if Player.Functions.AddItem("exoticfish", quantity) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["exoticfish"], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, 'You have full pockets.', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'you dont catch any fish.', 'error')
    end
end)

local ItemList = {
    ["fish"] =  10,
    ["exoticfish"] =  100,
    ["turtle"] =  250,
    ["salmon"] =  750,
    ["goldfish"] =  1000,
    ["shark"] =  750,
    ["whale"] =  1000,
    ["dolphin"] =  500,
}

RegisterNetEvent('qb-fishing:server:sellfish', function()
    local src = source
    local price = 0
    local Player = QBCore.Functions.GetPlayer(src)
    
    local xItem = Player.Functions.GetItemsByName(ItemList)
    if xItem ~= nil then
        for k, v in pairs(Player.PlayerData.items) do
            if Player.PlayerData.items[k] ~= nil then
                if ItemList[Player.PlayerData.items[k].name] ~= nil then
                    price = price + (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)

        Player.Functions.AddMoney("cash", price, "sold-fish")
            TriggerClientEvent('QBCore:Notify', src, "You sell some fish for $"..price)
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont/'t have anything to sell..")
    end
end)

RegisterNetEvent('qb-fishing:server:RemoveMoney', function()
	local src = source
	local cash = 'bank'
	local price = 1000
	local Player = QBCore.Functions.GetPlayer(src)
		
	Player.Functions.RemoveMoney(cash, price)
end)
