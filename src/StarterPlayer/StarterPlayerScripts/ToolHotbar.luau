local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end

	if input.KeyCode ~= Enum.KeyCode.One then
		return
	end

	local character = LocalPlayer.Character
	if not character then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end

	local equippedTool = character:FindFirstChildWhichIsA("Tool")
	if equippedTool then
		humanoid:UnequipTools()
		return
	end

	local backpack = LocalPlayer:FindFirstChild("Backpack")
	if not backpack then
		return
	end

	local tool = backpack:FindFirstChildWhichIsA("Tool")
	if tool then
		humanoid:EquipTool(tool)
	end
end)
