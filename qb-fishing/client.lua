local QBCore = exports['qb-core']:GetCoreObject()


-- Eventos
RegisterNetEvent('qb-fishing:client:OpenShopMenu', function(data)
    exports['qb-menu']:openMenu({
        {
            header = "Fishing Shop",
            isMenuHeader = true,
        },
        {
            header = "Rent a Boat",
            txt = "Price: <br> 1000$",
            params = {
                event = "qb-fishing:client:RentBoat",
            }
        },
        {
            header = "< Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    })
end)

RegisterNetEvent('qb-fishing:client:BuyRod', function(data)
    TriggerServerEvent('qb-fishing:server:BuyRod')
    TriggerEvent('qb-fishing:client:OpenMenu')
end)

RegisterNetEvent('qb-fishing:client:BuyBait', function(data)
    TriggerServerEvent('qb-fishing:server:BuyBait')
    TriggerEvent('qb-fishing:client:OpenMenu')
end)

RegisterNetEvent('qb-fishing:client:RentBoat', function(data)
    local vehicle = 'suntrap'
    local coords = vector4(-3431.89, 997.15, 0.34, 27.26)
    TriggerServerEvent('qb-fishing:server:RemoveMoney')
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetVehicleNumberPlateText(veh, "FISH"..tostring(math.random(1000, 9999)))
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        --SetEntityHeading(veh, coords.h)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true) 
end)



RegisterNetEvent('qb-fishing:client:OpenStore', function(data)
    QBCore.Functions.Progressbar('fishing_store', 'TALKING TO EMPLOYEE...', 1000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Play When Done
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "monkeyopening", 0.1)
        TriggerEvent('qb-fishing:client:OpenMenu')
    end)
end)

RegisterNetEvent('qb-fishing:client:SaleMenu', function(data)
    QBCore.Functions.Progressbar('fishing_store', 'TALKING TO EMPLOYEE...', 1000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Play When Done
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "monkeyopening", 0.1)
        exports['qb-menu']:openMenu({
            {
                header = "Sell Fish Employee",
                isMenuHeader = true,
            },
            {
                header = "Sell All Fish",
                txt = "You'll sell all fish that you have on you",
                params = {
                    event = "qb-fishing:client:SellFish",
                }
            },
            {
                header = "< Close",
                txt = "",
                params = {
                    event = "qb-menu:closeMenu",
                }
            },
        })
    end)
end)

RegisterNetEvent('qb-fishing:client:SellFish', function(data)
    TriggerServerEvent('qb-fishing:server:sellfish')
end)


RegisterNetEvent('qb-fishing:client:StartFishing', function(data)
    local ped = PlayerPedId()
    local time = math.random(1000, 5000)
    local pos = GetEntityCoords(ped)

    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem and GetWaterHeight(pos.x, pos.y, pos.z-2, pos.z - 3.0) then
            local ped = PlayerPedId()
            local animDict = "amb@world_human_stand_fishing@idle_a"
            local animName = "idle_c" 
            local pedPos = GetEntityCoords(ped)
            local fishingRodHash = `prop_fishing_rod_01`
            local bone = GetPedBoneIndex(ped, 18905)
					
	    Wait(500)
            RequestAnimDict(animDict)
			while not HasAnimDictLoaded(animDict) do
				Wait(100)
			end
			TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, 1.0, 11, 0, 0, 0, 0)   
            rodHandle = CreateObject(fishingRodHash, pedPos, true)
            AttachEntityToEntity(rodHandle, ped, bone, 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)
            Wait(time)
            local success = exports['qb-lock']:StartLockPickCircle(5,20)
            if success then
                TriggerServerEvent('qb-fishing:server:CatchFish')
                ClearPedTasks(ped)
                DeleteObject(rodHandle)
                DeleteEntity(fishingRodHash)
            else
                TriggerServerEvent('qb-fishing:server:usebait')
                QBCore.Functions.Notify('The fish scape...', 'error', 7500)
                ClearPedTasks(ped)
                DeleteObject(rodHandle)
                DeleteEntity(fishingRodHash)
            end
        else
        QBCore.Functions.Notify("You dont have any fishing bait or not near water...", "error")
        end
      end, 'fishingbait')
end)


RegisterNetEvent("qb-fishing:FishingShop")
AddEventHandler("qb-fishing:FishingShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Fishing Shop", Config.fishingitems)
end)

-- Threads
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-3424.57, 972.55, 8.35)
	SetBlipSprite(blip, 317)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.7)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 4) 
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Fishing Shop")
    EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-1793.83, -1198.79, 13.02)
	SetBlipSprite(blip, 475)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.7)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 4) 
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Sell Fish")
    EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
    RequestModel(`s_m_y_dockwork_01`)
      while not HasModelLoaded(`s_m_y_dockwork_01`) do
      Wait(1)
    end
      labboss = CreatePed(2, `s_m_y_dockwork_01`, -3424.95, 970.97, 7.35, 94.24, false, false) -- change here the cords for the ped 
      SetPedFleeAttributes(labboss, 0, 0)
      SetPedDiesWhenInjured(labboss, false)
      TaskStartScenarioInPlace(labboss, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
      SetPedKeepTask(labboss, true)
      SetBlockingOfNonTemporaryEvents(labboss, true)
      SetEntityInvincible(labboss, true)
      FreezeEntityPosition(labboss, true)
end)

CreateThread(function()
    RequestModel(`s_m_m_linecook`)
      while not HasModelLoaded(`s_m_m_linecook`) do
      Wait(1)
    end
      labboss = CreatePed(2, `s_m_m_linecook`, -1793.91, -1198.98, 12.02, 332.67, false, false) -- change here the cords for the ped 
      SetPedFleeAttributes(labboss, 0, 0)
      SetPedDiesWhenInjured(labboss, false)
      TaskStartScenarioInPlace(labboss, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
      SetPedKeepTask(labboss, true)
      SetBlockingOfNonTemporaryEvents(labboss, true)
      SetEntityInvincible(labboss, true)
      FreezeEntityPosition(labboss, true)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("FishingShop", vector3(-3424.95, 970.97, 7.35), 1, 1, {
        name="Fishing Shop",
        heading=94.24,
        debugpoly = false,
    }, {
        options = {
            {
                event = "qb-fishing:FishingShop",
                icon = "fas fa-shop",
                label = "Open Fishing Shop",
            },
            {
                event = "qb-fishing:client:OpenShopMenu",
                icon = "fas fa-shop",
                label = "Rent a boat",
            },
        },
        distance = 1.5
    })
        
    exports['qb-target']:AddBoxZone("FishSell", vector3(-1793.91, -1198.98, 12.02), 1, 1, {
        name="FishSell",
        heading=332.67,
        debugpoly = false,
    }, {
        options = {
            {
            event = "qb-fishing:client:SaleMenu",
            icon = "fas fa-dollar",
            label = "Sell Fish",
            },
        },
        distance = 1.5
    })
end)

