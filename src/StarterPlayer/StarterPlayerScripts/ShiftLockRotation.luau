local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local shiftLockEnabled = false
local waist = nil

local crosshair = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGUI"):WaitForChild("Crosshair")

local SHIFT_LOCK_CAMERA_OFFSET = Vector3.new(2, 0, 0)

local function setCameraOffset(offset)
	local character = LocalPlayer.Character
	if not character then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.CameraOffset = offset
	end
end

local function toggleShiftLock()
	shiftLockEnabled = not shiftLockEnabled
	LocalPlayer:SetAttribute("ShiftLockEnabled", shiftLockEnabled)

	if shiftLockEnabled then
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		UserInputService.MouseIconEnabled = false
		crosshair.Visible = true
		setCameraOffset(SHIFT_LOCK_CAMERA_OFFSET)
	else
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		UserInputService.MouseIconEnabled = true
		crosshair.Visible = false
		setCameraOffset(Vector3.new(0, 0, 0))
		local character = LocalPlayer.Character

		local character = LocalPlayer.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.AutoRotate = true
			end
		end
	end
end

local function onCharacterAdded(character)
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.AutoRotate = true

	local upperTorso = character:WaitForChild("UpperTorso")
	waist = upperTorso:FindFirstChild("Waist")

	if waist then
		waist.IsKinematic = true
	end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	if input.KeyCode == Enum.KeyCode.RightAlt then
		toggleShiftLock()
	end
end)

RunService:BindToRenderStep("ShiftLockRotation", Enum.RenderPriority.Camera.Value + 1, function()
	if not shiftLockEnabled then
		return
	end

	local character = LocalPlayer.Character
	if not character then
		return
	end

	local rootPart = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not rootPart or not humanoid then
		return
	end

	humanoid.AutoRotate = false

	local lookVector = camera.CFrame.LookVector
	local flatLook = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
	rootPart.CFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + flatLook)
end)

RunService.PreSimulation:Connect(function()
	if not shiftLockEnabled or not waist then
		return
	end

	local lookVector = camera.CFrame.LookVector
	local pitch = math.asin(lookVector.Y)
	waist.Transform = waist.Transform * CFrame.Angles(pitch, 0, 0)
end)

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
if LocalPlayer.Character then
	onCharacterAdded(LocalPlayer.Character)
end
