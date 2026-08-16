local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local InventoryManager = require(ServerScriptService:WaitForChild("Manager"):WaitForChild("InventoryManager"))

local InventoryRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Inventory")
local EquipItemRemote = InventoryRemotes:WaitForChild("EquipItem")
local UnequipItemRemote = InventoryRemotes:WaitForChild("UnequipItem")

EquipItemRemote.OnServerEvent:Connect(function(player, itemId)
	if typeof(itemId) ~= "string" then
		return
	end
	InventoryManager.EquipItem(player, itemId)
end)

UnequipItemRemote.OnServerEvent:Connect(function(player, slot)
	if typeof(slot) ~= "string" then
		return
	end
	InventoryManager.UnequipItem(player, slot)
end)
