local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local BlockState = require(ServerScriptService:WaitForChild("BlockingSystem"):WaitForChild("BlockState"))
local SetBlocking = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Combat"):WaitForChild("SetBlocking")

SetBlocking.OnServerEvent:Connect(function(player, isBlocking)
	BlockState.SetBlocking(player, isBlocking == true)
end)

Players.PlayerRemoving:Connect(function(player)
	BlockState.SetBlocking(player, false)
end)
