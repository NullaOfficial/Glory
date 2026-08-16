-- Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Player = game:GetService("Players")
local LocalPlayer = Player.LocalPlayer

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local RayCastHitbox = require(ReplicatedStorage:WaitForChild("RaycastHitboxV4"))

local Sword = script.Parent

local animator = humanoid:WaitForChild("Animator")

local HitboxPart = Sword:WaitForChild("Hitbox")
local NewHitbox = RayCastHitbox.new(HitboxPart)

-- Animations

local idleanim = script:WaitForChild("Idle")
local animationTrackIdle = animator:LoadAnimation(idleanim)

local walkinganim = script:WaitForChild("Walking")
local animationTrackWalking = animator:LoadAnimation(walkinganim)

local runninganim = script:WaitForChild("Running")
local animationTrackRunning = animator:LoadAnimation(runninganim)

-- Combos

local combo1 = script:WaitForChild("Combo1")
local animationTrack1 = animator:LoadAnimation(combo1)

local combo2 = script:WaitForChild("Combo2")
local animationTrack2 = animator:LoadAnimation(combo2)

local combo3 = script:WaitForChild("Combo3")
local animationTrack3 = animator:LoadAnimation(combo3)

local combo4 = script:WaitForChild("Combo4")
local animationTrack4 = animator:LoadAnimation(combo4)

local blocking = script:WaitForChild("Blocking")
local animationTrackBlocking = animator:LoadAnimation(blocking)

local comboAnims = {animationTrack1, animationTrack2, animationTrack3, animationTrack4}
local comboWaits = {0.5, 0.5, 0.5, 0.9}

-- Booleans

local isAttacking = false
local isEquipped = false
local shiftLockConnection = nil
local isBlocking = false

-- Combo variables

local combo = 1
local combo_timer = 1
local lastAttackTime = 0

-- RemoteEvent

local SwordHit = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Sword"):WaitForChild("SwordHit")
local SetBlocking = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Combat"):WaitForChild("SetBlocking")

-- Main Code

local function isShiftLockActive(): boolean
	return UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
end

NewHitbox.OnHit:Connect(function(hitPart, hitHum)
	local myHum = character:FindFirstChildOfClass("Humanoid")

	if not myHum then 
		return 
	end

	if myHum == hitHum then
		return
	end

	SwordHit:FireServer(hitHum, hitPart)
end)

local function stopMovementAnims()
	animationTrackIdle:Stop()
	animationTrackWalking:Stop()
	animationTrackRunning:Stop()
end

Sword.Activated:Connect(function()
	if isAttacking or not isEquipped or isBlocking then
		return
	end


	if os.clock() - lastAttackTime > combo_timer then
		combo = 1
	end

	isAttacking = true
	lastAttackTime = os.clock()

	comboAnims[combo]:Play()
	humanoid.WalkSpeed = 3
	NewHitbox:HitStart()

	task.wait(comboWaits[combo])

	NewHitbox:HitStop()
	humanoid.WalkSpeed = 9
	isAttacking = false

	if combo < 4 then
		combo += 1
	else
		combo = 1
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

Sword.Equipped:Connect(function()
	if not LocalPlayer:GetAttribute("ShiftLockEnabled") then
		Sword.Parent = LocalPlayer.Backpack
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
			Sword.Parent = LocalPlayer.Backpack
		end
	end)
end)

Sword.Unequipped:Connect(function()
	isEquipped = false
	stopMovementAnims()
	animationTrack1:Stop()

	if shiftLockConnection then
		shiftLockConnection:Disconnect()
		shiftLockConnection = nil
	end

	if isBlocking then
		isBlocking = false
		SetBlocking:FireServer(false)
		animationTrackBlocking:Stop()
	end
end)

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
