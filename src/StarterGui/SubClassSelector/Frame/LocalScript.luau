local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ClassDefinitions = require(ReplicatedStorage:WaitForChild("Definitions"):WaitForChild("Class"):WaitForChild("ClassDefinitions"))

local ClassRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ClassSelection")
local SelectSubclass = ClassRemotes:WaitForChild("SelectSubclass")
local PromptSubclassSelection = ClassRemotes:WaitForChild("PromptSubclassSelection")

local screenGui = script.Parent.Parent
local frame = script.Parent
screenGui.Enabled = false
frame.Visible = true

local buttons = {
	frame:WaitForChild("Subclass1"),
	frame:WaitForChild("Subclass2"),
	frame:WaitForChild("Subclass3"),
	frame:WaitForChild("Subclass4"),
}

local assignedSubclass = {} -- [botón] = nombre de subclase que representa ahora mismo

for _, button in ipairs(buttons) do
	button.Activated:Connect(function()
		local subclassName = assignedSubclass[button]
		if not subclassName then
			return
		end

		SelectSubclass:FireServer(subclassName)
		screenGui.Enabled = false
	end)
end

PromptSubclassSelection.OnClientEvent:Connect(function(currentClass)
	local classDef = ClassDefinitions[currentClass]
	if not classDef then
		return
	end

	for i, button in ipairs(buttons) do
		local subclassName = classDef.Subclasses[i]
		button.Text = subclassName
		assignedSubclass[button] = subclassName
	end

	screenGui.Enabled = true
end)
