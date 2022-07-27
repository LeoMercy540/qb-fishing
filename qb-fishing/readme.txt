put this in qb-core shared/items.lua

['fishingrod'] 			 = {['name'] = 'fishingrod', 				['label'] = 'Fishing Rod', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'fishingrod.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
	['fishingbait'] 			 = {['name'] = 'fishingbait', 				['label'] = 'Fishing Bait', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'fishingbait.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
	['fish'] 			 	= {['name'] = 'fish', 				['label'] = 'Fish', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'fish.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
	["salmon"] 			             = {["name"] = "salmon", 				        ["label"] = "salmon",                    ["weight"] = 1111,      ["type"] = "item",      ["image"] = "salmon.png",               ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Fish for Fishing."},
	["goldfish"] 			         = {["name"] = "goldfish", 			        	["label"] = "goldfish",                  ["weight"] = 1111,      ["type"] = "item",      ["image"] = "goldfish.png",             ["unique"] = false,     ["useable"] = true,     ["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Fish for Fishing."},
	['exoticfish'] 			 = {['name'] = 'exoticfish', 				['label'] = 'Exotic Fish', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'fishing-mackerel.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
	['turtle'] 			 		= {['name'] = 'turtle', 				['label'] = 'Turtle', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'turtle.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
	['shark'] 			 		= {['name'] = 'shark', 				['label'] = 'Shark', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'fishing-shark.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
	['dolphin'] 			 = {['name'] = 'dolphin', 				['label'] = 'Dolphin', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'fishing-dolphin.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
	['whale'] 			 = {['name'] = 'whale', 				['label'] = 'Whale', 				['weight'] = 100, 		['type'] = 'item', 		['image'] = 'fishing-whale.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},



Add this to qb-core/client/functions.lua
function QBCore.Functions.SpawnObject(model, coords, cb)
    local model = (type(model) == 'number' and model or GetHashKey(model))

    Citizen.CreateThread(function()
        RequestModel(model)
        local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)
        SetModelAsNoLongerNeeded(model)

        if cb then
            cb(obj)
        end
    end)
end

function QBCore.Functions.SpawnLocalObject(model, coords, cb)
    local model = (type(model) == 'number' and model or GetHashKey(model))

    Citizen.CreateThread(function()
        RequestModel(model)
        local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, true)
        SetModelAsNoLongerNeeded(model)

        if cb then
            cb(obj)
        end
    end)
end

function QBCore.Functions.DeleteObject(object)
    SetEntityAsMissionEntity(object, false, true)
    DeleteObject(object)
end

Dependencies
qb-core:https://github.com/qbcore-framework/qb-core
qb-target:https://github.com/qbcore-framework/qb-target
qb-lock:https://github.com/M-Middy/qb-lock
qb-menu:https://github.com/qbcore-framework/qb-menu