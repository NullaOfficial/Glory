local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")

local DmgEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Staff"):WaitForChild("ShowStaffDamage")
local CastFireball = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Staff"):WaitForChild("CastFireball")
CastFireball.Sandboxed = true

local PlayerDataManager = require(ServerScriptService:WaitForChild("Manager"):WaitForChild("PlayerDataManager"))
local BodyPartMultipliers = require(ReplicatedStorage:WaitForChild("BodyPartMultipliers"))

local BASE_SPELL_DAMAGE = 10
local FIREBALL_MANA_COST = 2
local DAMAGE_PER_INTELLIGENCE = 2
local PROJECTILE_SPEED = 100
local MAX_DISTANCE = 500
local COOLDOWN = 0.7

local DUMMY_XP_REWARD = 500

local lastAttacker = {}
local trackedHumanoids = {}

local lastCastTime = {}

local function onDummyDied(humanoid)
	local attacker = lastAttacker[humanoid]
	if attacker then
		PlayerDataManager.AddExperience(attacker, DUMMY_XP_REWARD)
	end
	lastAttacker[humanoid] = nil
end

local function fireProjectile(player, character, targetPosition, data)
	local staff = character:FindFirstChild("WoodenStaff")
	if not staff then
		return
	end

	local handle = staff:FindFirstChild("Handle")
	if not handle then
		return
	end

	local origin = handle.Position
	local direction = (targetPosition - origin)
	if direction.Magnitude == 0 then
		return
	end
	direction = direction.Unit

	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = {character}

	local fireball = Instance.new("Part")
	fireball.Shape = Enum.PartType.Ball
	fireball.Size = Vector3.new(1, 1, 1)
	fireball.Material = Enum.Material.Neon
	fireball.Color = Color3.fromRGB(255, 110, 20)
	fireball.CanCollide = false
	fireball.Anchored = true
	fireball.CFrame = CFrame.new(origin)
	fireball.Parent = workspace

	local traveled = 0

	local connection
	connection = RunService.Heartbeat:Connect(function(deltaTime)
		local step = PROJECTILE_SPEED * deltaTime

		local result = workspace:Raycast(fireball.Position, direction * step, raycastParams)
		if result then
			local hitPart = result.Instance
			local hitHumanoid = hitPart.Parent:FindFirstChildOfClass("Humanoid")

			if hitHumanoid then
				-- El multiplicador se calcula AQUÍ, porque solo ahora sabemos
				-- qué parte golpeó de verdad (a diferencia de la espada, que
				-- ya lo sabía desde que se disparó el evento).
				local multiplier = BodyPartMultipliers[hitPart.Name] or BodyPartMultipliers.Default
				local baseDamage = BASE_SPELL_DAMAGE + (data.Stats.Intelligence * DAMAGE_PER_INTELLIGENCE)
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
			end

			connection:Disconnect()
			fireball:Destroy()
			return
		end

		fireball.CFrame = fireball.CFrame + (direction * step)
		traveled += step

		if traveled >= MAX_DISTANCE then
			connection:Disconnect()
			fireball:Destroy()
		end
	end)
end

CastFireball.OnServerEvent:Connect(function(player, targetPosition)
	if typeof(targetPosition) ~= "Vector3" then
		return
	end

	local now = os.clock()
	if now - (lastCastTime[player] or 0) < COOLDOWN then
		return
	end
	lastCastTime[player] = now

	local character = player.Character
	if not character then
		return
	end

	local data = PlayerDataManager.GetData(player)
	if data == nil then
		return
	end

	fireProjectile(player, character, targetPosition, data)
	
	if not PlayerDataManager.SpendMana(player, FIREBALL_MANA_COST) then
		return -- no tiene suficiente maná, ignora el intento
	end

	fireProjectile(player, character, targetPosition, data)
end)
