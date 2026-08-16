local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local ShowDamage = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Sword"):WaitForChild("ShowSwordDamage")
local ShowDamage2 = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Staff"):WaitForChild("ShowStaffDamage")

local function createDamageLabel(amount: number, hitPart: BasePart)
	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 90, 0, 40)
	billboard.StudsOffset = Vector3.new(math.random(-10, 10) / 10, 2, 0) -- un poco random para que no se encimen golpes seguidos
	billboard.AlwaysOnTop = true
	billboard.Adornee = hitPart
	billboard.Parent = hitPart

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = tostring(amount)
	label.TextScaled = true
	label.Font = Enum.Font.GothamBold
	label.TextColor3 = Color3.new(1, 0, 0)
	label.TextStrokeTransparency = 0
	label.Parent = billboard

	local tweenInfo = TweenInfo.new(1)
	local moveTween = TweenService:Create(billboard, tweenInfo, {StudsOffset = Vector3.new(0, 1, 0)})
	local fadeTween = TweenService:Create(label, tweenInfo, {TextTransparency = 1, TextStrokeTransparency = 1})
	
	moveTween:Play()
	fadeTween:Play()
	
	moveTween.Completed:Connect(function()
		billboard:Destroy()
	end)
end

ShowDamage.OnClientEvent:Connect(function(amount, hitPart)
	if not hitPart then
		return
	end
	createDamageLabel(amount, hitPart)
end)

ShowDamage2.OnClientEvent:Connect(function(amount, hitPart)
	if not hitPart then
		return
	end
	createDamageLabel(amount, hitPart)
end)
