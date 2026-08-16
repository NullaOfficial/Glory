script.Parent.Visible = true

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ClassRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ClassSelection")
local SelectStartingClass = ClassRemotes:WaitForChild("PromptClassSelection")
local PromptStartingClassSelection = ClassRemotes:WaitForChild("PromptStartingClassSelection")

local screenGui = script.Parent.Parent
local frame = script.Parent

screenGui.Enabled = false

for _, button in frame:GetChildren() do
	if button:IsA("TextButton") then
		button.Activated:Connect(function()
			SelectStartingClass:FireServer(button.Name)
			screenGui.Enabled = false
		end)
	end
end

PromptStartingClassSelection.OnClientEvent:Connect(function()
	screenGui.Enabled = true
end)
