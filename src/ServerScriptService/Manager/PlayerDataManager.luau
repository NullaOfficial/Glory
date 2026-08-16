local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local ProfileStore = require(ServerScriptService:WaitForChild("ProfileStore"))
local DataTemplate = require(ReplicatedStorage:WaitForChild("DataTemplate"))

local PlayerStore = ProfileStore.New("PlayerData_v1", DataTemplate)

-- Tabla en memoria: qué perfil le corresponde a cada Player mientras está conectado.
local Profiles: {[Player]: typeof(PlayerStore:StartSessionAsync())} = {}

local PlayerDataManager = {}
PlayerDataManager.LeveledUp = Instance.new("BindableEvent")

local maxLevel = 70
local BASE_MANA = 100
local MANA_PER_INTELLIGENCE = 5
local MANA_REGEN_PER_SECOND = 1

--------------------------------------------------------------------
-- Conexión de sesión
--------------------------------------------------------------------
local function onPlayerAdded(player: Player)
	local profile = PlayerStore:StartSessionAsync(tostring(player.UserId), {
		Cancel = function()
			return player.Parent ~= Players
		end,
	})

	if profile == nil then
		player:Kick("Your data coudn't be loaded. Join again.")
		return
	end

	profile:AddUserId(player.UserId)
	profile:Reconcile()

	profile.OnSessionEnd:Connect(function()
		Profiles[player] = nil
		player:Kick("Your data sesion is closed. Rejoin.")
	end)

	if player.Parent == Players then
		Profiles[player] = profile
		print(player.Name .. " cargó sus datos. Nivel: " .. profile.Data.Level)

		local leaderstats = Instance.new("Folder")
		leaderstats.Name = "leaderstats"
		leaderstats.Parent = player

		local level = Instance.new("IntValue")
		level.Name = "Level"
		level.Parent = leaderstats
		level.Value = profile.Data.Level

		-- Carpeta con datos extra (Clase/Subclase) que otros scripts pueden leer.
		-- Esto SÍ debe crearse por código, aquí, cada vez que un jugador entra.
		local playerInfo = Instance.new("Folder")
		playerInfo.Name = "PlayerInfo"
		playerInfo.Parent = player

		local classValue = Instance.new("StringValue")
		classValue.Name = "Class"
		classValue.Value = profile.Data.Class or "None"
		classValue.Parent = playerInfo

		local subclassValue = Instance.new("StringValue")
		subclassValue.Name = "Subclass"
		subclassValue.Value = profile.Data.Subclass or "None"
		subclassValue.Parent = playerInfo

		local maxMana = BASE_MANA + (profile.Data.Stats.Intelligence * MANA_PER_INTELLIGENCE)
		profile.Data.Mana = math.min(profile.Data.Mana, maxMana) -- por si subió Intelligence y bajó de nivel, o similar

		local manaValue = Instance.new("NumberValue")
		manaValue.Name = "Mana"
		manaValue.Value = profile.Data.Mana
		manaValue.Parent = playerInfo

		local maxManaValue = Instance.new("NumberValue")
		maxManaValue.Name = "MaxMana"
		maxManaValue.Value = maxMana
		maxManaValue.Parent = playerInfo

		-- Regeneración de maná, una vez por segundo mientras el jugador esté conectado
		task.spawn(function()
			while player.Parent == Players and Profiles[player] ~= nil do
				task.wait(1)

				local data = PlayerDataManager.GetData(player)
				if data == nil then
					break
				end

				local currentMaxMana = PlayerDataManager.GetMaxMana(data)
				data.Mana = math.min(data.Mana + MANA_REGEN_PER_SECOND + data.Stats.Intelligence, currentMaxMana)

				manaValue.Value = data.Mana
				maxManaValue.Value = currentMaxMana
			end
		end)
	else
		profile:EndSession()
	end
end

local function onPlayerRemoving(player: Player)
	local profile = Profiles[player]
	if profile ~= nil then
		profile:EndSession()
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

for _, player in Players:GetPlayers() do
	task.spawn(onPlayerAdded, player)
end

function PlayerDataManager.GetData(player: Player)
	local profile = Profiles[player]
	if profile == nil then
		return nil
	end
	return profile.Data
end

function PlayerDataManager.IsDataLoaded(player: Player): boolean
	return Profiles[player] ~= nil
end

function PlayerDataManager.GetMaxMana(data)
	return BASE_MANA + (data.Stats.Intelligence * MANA_PER_INTELLIGENCE)
end

-- Intenta gastar maná. Devuelve true si tenía suficiente (y ya lo descontó),
-- false si no le alcanzaba (y no tocó nada).
function PlayerDataManager.SpendMana(player: Player, amount: number): boolean
	local data = PlayerDataManager.GetData(player)
	if data == nil then
		return false
	end

	if data.Mana < amount then
		return false
	end

	data.Mana -= amount

	local playerInfo = player:FindFirstChild("PlayerInfo")
	if playerInfo then
		local manaValue = playerInfo:FindFirstChild("Mana")
		if manaValue then
			manaValue.Value = data.Mana
		end
	end

	return true
end

local function getXPForLevel(level: number): number
	local BaseXP = 100
	local EXPGrowth = 1.15
	return math.floor(BaseXP * (EXPGrowth ^ (level - 1)))
end

function PlayerDataManager.AddExperience(player: Player, amount: number)
	local data = PlayerDataManager.GetData(player)
	if data == nil then
		return
	end

	data.Experience += amount
	local neededXP = getXPForLevel(data.Level)

	while data.Level < maxLevel and data.Experience >= neededXP do
		data.Experience -= neededXP
		data.Level += 1

		data.Stats.Strength += 1
		data.Stats.Intelligence += 1
		data.Stats.Vitality += 1
		data.Stats.Spirit += 1

		PlayerDataManager.LeveledUp:Fire(player, data.Level)

		neededXP = getXPForLevel(data.Level)
	end

	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		leaderstats.Level.Value = data.Level
	end
end

return PlayerDataManager
