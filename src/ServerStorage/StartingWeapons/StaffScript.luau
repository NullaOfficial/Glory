-- Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Player = game:GetService("Players")
local LocalPlayer = Player.LocalPlayer

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local camera = workspace.CurrentCamera

local Staff = script.Parent

local animator = humanoid:WaitForChild("Animator")

-- Animations

local idleanim = script:WaitForChild("Idle")
local animationTrackIdle = animator:LoadAnimation(idleanim)

local walkinganim = script:WaitForChild("Walking")
local animationTrackWalking = animator:LoadAnimation(walkinganim)

local runninganim = script:WaitForChild("Running")
local animationTrackRunning = animator:LoadAnimation(runninganim)

local blocking = script:WaitForChild("Blocking")
local animationTrackBlocking = animator:LoadAnimation(blocking)

-- Animaciones de "canalizar" el hechizo (reusa los objetos Combo1-4 que ya tenías)

local cast1 = script:WaitForChild("Combo1")
local animationTrackCast1 = animator:LoadAnimation(cast1)

local cast2 = script:WaitForChild("Combo2")
local animationTrackCast2 = animator:LoadAnimation(cast2)

local cast3 = script:WaitForChild("Combo3")
local animationTrackCast3 = animator:LoadAnimation(cast3)

local cast4 = script:WaitForChild("Combo4")
local animationTrackCast4 = animator:LoadAnimation(cast4)

local castAnims = {animationTrackCast1, animationTrackCast2, animationTrackCast3, animationTrackCast4}
local castWaits = {0.7, 0.7, 0.7, 0.7}

-- Booleans

local isEquipped = false
local isBlocking = false
local isCasting = false
local shiftLockConnection = nil

-- Combo variable (para rotar entre las 4 animaciones de cast)

local castCombo = 1

-- RemoteEvents

local CastFireball = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Staff"):WaitForChild("CastFireball")
local SetBlocking = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Combat"):WaitForChild("SetBlocking")

local SPELL_RANGE = 500

-- Main Code

local function stopMovementAnims()
	animationTrackIdle:Stop()
	animationTrackWalking:Stop()
	animationTrackRunning:Stop()
end

-- Clic izquierdo: reproduce animación de canalizar Y dispara el hechizo
Staff.Activated:Connect(function()
	if isCasting or not isEquipped or isBlocking then
		return
	end

	isCasting = true

	castAnims[castCombo]:Play()

	local targetPoint = camera.CFrame.Position + (camera.CFrame.LookVector * SPELL_RANGE)
	CastFireball:FireServer(targetPoint)

	task.wait(castWaits[castCombo])

	isCasting = false

	if castCombo < 4 then
		castCombo += 1
	else
		castCombo = 1
	end
end)

-- Clic derecho: bloquear mientras se mantiene presionado
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseButton2 and isEquipped and not isBlocking then
		isBlocking = true
		SetBlocking:FireServer(true)
		animationTrackBlocking:Play()
		animationTrackBlocking.Looped = true
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.MouseButton2 and isBlocking then
		isBlocking = false
		SetBlocking:FireServer(false)
		animationTrackBlocking:Stop()
	end
end)

humanoid.Running:Connect(function(speed)

	if not isEquipped then return end

	if speed > 9 then

		if not animationTrackRunning.IsPlaying then
			animationTrackIdle:Stop()
			animationTrackWalking:Stop()
			animationTrackRunning:Play()
			animationTrackRunning.Looped = true
		end
	elseif speed > 0.75 and speed < 15 then

		if not animationTrackWalking.IsPlaying then
			animationTrackIdle:Stop()
			animationTrackRunning:Stop()
			animationTrackWalking:Play()
			animationTrackWalking.Looped = true
		end
	else
		if not animationTrackIdle.IsPlaying then
			animationTrackWalking:Stop()
			animationTrackRunning:Stop()
			animationTrackIdle:Play()
			animationTrackIdle.Looped = true
		end
	end
end)

Staff.Equipped:Connect(function()
	if not LocalPlayer:GetAttribute("ShiftLockEnabled") then
		Staff.Parent = LocalPlayer.Backpack
		return
	end

	isEquipped = true

	local currentSpeed = humanoid.WalkSpeed
	if humanoid.MoveDirection.Magnitude > 0 then
		if currentSpeed > 15 then
			animationTrackRunning:Play()
			animationTrackRunning.Looped = true
		else
			animationTrackWalking:Play()
			animationTrackWalking.Looped = true
		end
	else
		animationTrackIdle:Play()
		animationTrackIdle.Looped = true
	end

	shiftLockConnection = LocalPlayer:GetAttributeChangedSignal("ShiftLockEnabled"):Connect(function()
		if not LocalPlayer:GetAttribute("ShiftLockEnabled") then
			Staff.Parent = LocalPlayer.Backpack
		end
	end)
end)

Staff.Unequipped:Connect(function()
	isEquipped = false
	stopMovementAnims()

	if isBlocking then
		isBlocking = false
		SetBlocking:FireServer(false)
		animationTrackBlocking:Stop()
	end

	if shiftLockConnection then
		shiftLockConnection:Disconnect()
		shiftLockConnection = nil
	end
end)
