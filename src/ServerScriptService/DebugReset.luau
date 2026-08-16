local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerDataManager = require(ServerScriptService:WaitForChild("Manager"):WaitForChild("PlayerDataManager"))

Players.PlayerAdded:Connect(function(player)
	while not PlayerDataManager.IsDataLoaded(player) do
		task.wait(0.25)
	end

	local data = PlayerDataManager.GetData(player)

	data.Level = 1
	data.Experience = 0
	data.Stats.Strength = 1
	data.Stats.Intelligence = 1
	data.Stats.Vitality = 1
	data.Stats.Spirit = 1
	data.Class = nil
	data.Subclass = nil

	player.leaderstats.Level.Value = 1

	print(player.Name .. " reseteado a nivel 1")
end)
