local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local SwordHit = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Sword"):WaitForChild("SwordHit")
local DmgEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Sword"):WaitForChild("ShowSwordDamage")
SwordHit.Sandboxed = true

local PlayerDataManager = require(ServerScriptService:WaitForChild("Manager"):WaitForChild("PlayerDataManager"))
local BodyPartMultipliers = require(ReplicatedStorage:WaitForChild("BodyPartMultipliers"))

local BASE_DAMAGE = 10
local DAMAGE_PER_STRENGTH = 2
local DUMMY_XP_REWARD = 500

local lastAttacker = {}
local trackedHumanoids = {}

local function onDummyDied(humanoid)
	local attacker = lastAttacker[humanoid]
	if attacker then
		PlayerDataManager.AddExperience(attacker, DUMMY_XP_REWARD)
	end
	lastAttacker[humanoid] = nil
end

SwordHit.OnServerEvent:Connect(function(player, hitHumanoid, hitPart)
	if not hitHumanoid or not hitHumanoid:IsA("Humanoid") then
		return
	end

	if not hitPart or not hitPart:IsA("BasePart") then
		return
	end

	-- Validación: la parte golpeada debe pertenecer de verdad al mismo personaje
	-- que ese Humanoid, para que un exploit no pueda mandar "Head" mintiendo.
	if hitPart.Parent ~= hitHumanoid.Parent then
		return
	end

	local data = PlayerDataManager.GetData(player)
	if data == nil then
		return
	end

	local multiplier = BodyPartMultipliers[hitPart.Name] or BodyPartMultipliers.Default
	
	if hitPart.Name == "Head" then
		multiplier = BodyPartMultipliers.Head
	elseif hitPart.Name == "UpperTorso" then
		multiplier = BodyPartMultipliers.UpperTorso
	elseif hitPart.Name == "LowerTorso" then
		multiplier = BodyPartMultipliers.LowerTorso
	elseif hitPart.Name == "LeftUpperArm" then
		multiplier = BodyPartMultipliers.LeftUpperArm
	elseif hitPart.Name == "RightUpperArm" then
		multiplier = BodyPartMultipliers.RightUpperArm
	elseif hitPart.Name == "LeftLowerArm" then
		multiplier = BodyPartMultipliers.LeftLowerArm
	elseif hitPart.Name == "RightLowerArm" then
		multiplier = BodyPartMultipliers.RightLowerArm
	elseif hitPart.Name == "LeftUpperLeg" then
		multiplier = BodyPartMultipliers.LeftUpperLeg
	elseif hitPart.Name == "RightUpperLeg" then
		multiplier = BodyPartMultipliers.RightUpperLeg
	elseif hitPart.Name == "LeftLowerLeg" then
		multiplier = BodyPartMultipliers.LeftLowerLeg
	elseif hitPart.Name == "RightLowerLeg" then
		multiplier = BodyPartMultipliers.RightLowerLeg
	end

	local baseDamage = BASE_DAMAGE + (data.Stats.Strength * DAMAGE_PER_STRENGTH)
	local finalDamage = math.floor(baseDamage * multiplier)

	hitHumanoid:TakeDamage(finalDamage)
	
	DmgEvent:FireClient(player, finalDamage, hitPart)

	lastAttacker[hitHumanoid] = player

	if not trackedHumanoids[hitHumanoid] then
		trackedHumanoids[hitHumanoid] = true
		hitHumanoid.Died:Connect(function()
			onDummyDied(hitHumanoid)
		end)
	end
end)
