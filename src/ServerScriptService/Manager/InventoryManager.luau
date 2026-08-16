local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local ItemDefinitions = require(ReplicatedStorage:WaitForChild("Definitions"):WaitForChild("Inventory"):WaitForChild("ItemDefinitions"))
local PlayerDataManager = require(ServerScriptService:WaitForChild("Manager"):WaitForChild("PlayerDataManager"))

local InventoryManager = {}

function InventoryManager.AddItem(player: Player, itemId: string, amount: number)
	amount = amount or 1

	local data = PlayerDataManager.GetData(player)
	if data == nil then
		return false
	end

	if not ItemDefinitions[itemId] then
		return false -- item inválido, ignora
	end

	data.Inventory[itemId] = (data.Inventory[itemId] or 0) + amount
	return true
end

-- Equipa un item que esté en el Inventory, moviendo al slot correspondiente.
-- Si ya había algo en ese slot, lo regresa al Inventory (nunca se pierde nada).
function InventoryManager.EquipItem(player: Player, itemId: string)
	local data = PlayerDataManager.GetData(player)
	if data == nil then
		return false
	end

	local itemDef = ItemDefinitions[itemId]
	if not itemDef then
		return false
	end

	local currentCount = data.Inventory[itemId] or 0
	if currentCount <= 0 then
		return false -- no lo tiene, ignora (evita exploits pidiendo equipar algo que no posee)
	end

	local slot = itemDef.Slot
	local previousItemId = data.Equipped[slot]

	-- Saca 1 del inventario
	data.Inventory[itemId] = currentCount - 1
	if data.Inventory[itemId] <= 0 then
		data.Inventory[itemId] = nil -- limpia la entrada en vez de dejar un 0 guardado
	end

	-- Si había algo puesto antes en ese slot, regresa ESO al inventario
	if previousItemId then
		data.Inventory[previousItemId] = (data.Inventory[previousItemId] or 0) + 1
	end

	data.Equipped[slot] = itemId
	return true
end

function InventoryManager.UnequipItem(player: Player, slot: string)
	local data = PlayerDataManager.GetData(player)
	if data == nil then
		return false
	end
	
	if not data.Equipped[slot] then
		return false
	end
	
	local itemId = data.Equipped[slot]
	data.Equipped[slot] = nil
	
	data.Inventory[itemId] = (data.Inventory[itemId] or 0) + 1
	return true
end

return InventoryManager
