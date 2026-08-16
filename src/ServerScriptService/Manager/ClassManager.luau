local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local ClassDefinitions = require(ReplicatedStorage:WaitForChild("Definitions"):WaitForChild("Class"):WaitForChild("ClassDefinitions"))
local WeaponDefinitions = require(ReplicatedStorage:WaitForChild("Definitions"):WaitForChild("Weapon"):WaitForChild("WeaponDefinitions"))
local PlayerDataManager = require(ServerScriptService:WaitForChild("Manager"):WaitForChild("PlayerDataManager"))
local StartingWeapons = require(ReplicatedStorage:WaitForChild("StartingWeapons"))

local ClassRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ClassSelection")
local SelectStartingClass = ClassRemotes:WaitForChild("PromptClassSelection")
local PromptStartingClassSelection = ClassRemotes:WaitForChild("PromptStartingClassSelection")
local SelectSubclass = ClassRemotes:WaitForChild("SelectSubclass")
local PromptSubclassSelection = ClassRemotes:WaitForChild("PromptSubclassSelection")

local weaponModels = ServerStorage:WaitForChild("StartingWeapons")

local CLASS_UNLOCK_LEVEL = 20

local function giveStartingWeapon(player, className)
	local weaponName = StartingWeapons[className]
	if not weaponName then
		return
	end

	local backpack = player:FindFirstChild("Backpack")
	if not backpack then
		return
	end

	-- Evita duplicar si ya lo tiene (ej: al reconectarse)
	if backpack:FindFirstChild(weaponName) then
		return
	end
	local character = player.Character
	if character and character:FindFirstChild(weaponName) then
		return
	end

	local template = weaponModels:FindFirstChild(weaponName)
	if not template then
		return
	end

	local weapon = template:Clone()
	weapon.Parent = backpack
end


--------------------------------------------------------------------
-- Elección inicial de clase (una sola vez, al empezar a jugar)
--------------------------------------------------------------------
SelectStartingClass.OnServerEvent:Connect(function(player, className)
	local data = PlayerDataManager.GetData(player)
	if data == nil then
		return
	end

	if data.Class ~= nil then
		return
	end

	if not ClassDefinitions[className] then
		return
	end

	data.Class = className
	player.PlayerInfo.Class.Value = className
	giveStartingWeapon(player, className)
end)

--------------------------------------------------------------------
-- Mostrar el GUI de inicio apenas los datos del jugador estén listos
--------------------------------------------------------------------
Players.PlayerAdded:Connect(function(player)
	task.spawn(function()
		while not PlayerDataManager.IsDataLoaded(player) do
			task.wait(0.25)
		end

		local data = PlayerDataManager.GetData(player)
		if data and data.Class == nil then
			PromptStartingClassSelection:FireClient(player)
		elseif data then
			giveStartingWeapon(player, data.Class)
		end
	end)
end)

--------------------------------------------------------------------
-- Cambio de clase automático al cambiar de arma (solo antes de nivel 20)
--------------------------------------------------------------------
local function onCharacterAdded(player, character)
	character.ChildAdded:Connect(function(newChild)
		if not newChild:IsA("Tool") then
			return
		end

		local weaponDef = WeaponDefinitions[newChild.Name]
		if not weaponDef then
			return
		end

		local data = PlayerDataManager.GetData(player)
		if data == nil then
			return
		end

		if data.Level >= CLASS_UNLOCK_LEVEL then
			return
		end

		if data.Class == weaponDef.Class then
			return
		end

		data.Class = weaponDef.Class
		data.Subclass = nil
		
		player.PlayerInfo.Class.Value = weaponDef.Class
		player.PlayerInfo.Subclass.Value = "None"
	end)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		onCharacterAdded(player, character)
	end)
end)

--------------------------------------------------------------------
-- Selección de subclase (nivel 20+, permanente, solo entre las 4 de tu clase actual)
--------------------------------------------------------------------
SelectSubclass.OnServerEvent:Connect(function(player, subclassName)
	local data = PlayerDataManager.GetData(player)
	if data == nil or data.Class == nil then
		return
	end

	if data.Level < CLASS_UNLOCK_LEVEL then
		return
	end

	if data.Subclass ~= nil then
		return
	end

	local classDef = ClassDefinitions[data.Class]
	if not table.find(classDef.Subclasses, subclassName) then
		return
	end

	data.Subclass = subclassName
	
	player.PlayerInfo.Subclass.Value = subclassName
end)

--------------------------------------------------------------------
-- Avisar cuándo mostrar el GUI de subclase, escuchando el BindableEvent
--------------------------------------------------------------------
PlayerDataManager.LeveledUp.Event:Connect(function(player, newLevel)
	if newLevel ~= CLASS_UNLOCK_LEVEL then
		return
	end

	local data = PlayerDataManager.GetData(player)
	if data and data.Class ~= nil and data.Subclass == nil then
		PromptSubclassSelection:FireClient(player, data.Class)
	end
end)
