local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local SheathDefinitions = require(ReplicatedStorage:WaitForChild("Definitions"):WaitForChild("Sheath"):WaitForChild("SheathDefinitions"))
local sheathModels = ServerStorage:WaitForChild("SheathModels")

local function attachSheath(character, weaponName)
	local def = SheathDefinitions[weaponName]
	if not def then
		return nil
	end

	local template = sheathModels:FindFirstChild(def.ModelName)
	local bodyPart = character:FindFirstChild(def.AttachTo)
	if not template or not bodyPart then
		return nil
	end

	local sheath = template:Clone()
	sheath.Parent = character

	if sheath:IsA("Model") then
		if not sheath.PrimaryPart then
			warn(def.ModelName .. " no tiene PrimaryPart asignado en Studio — asígnalo para poder posicionarlo.")
			sheath:Destroy()
			return nil
		end

		-- Mueve el modelo ENTERO de una vez, manteniendo sus partes en su
		-- posición relativa original entre ellas.
		sheath:PivotTo(bodyPart.CFrame * def.Offset)

		-- Suelda CADA parte del modelo al cuerpo, no solo una.
		for _, part in sheath:GetDescendants() do
			if part:IsA("BasePart") then
				local weld = Instance.new("WeldConstraint")
				weld.Part0 = bodyPart
				weld.Part1 = part
				weld.Parent = part
			end
		end
	else
		-- Es una sola parte (BasePart suelto, no Model)
		sheath.CFrame = bodyPart.CFrame * def.Offset

		local weld = Instance.new("WeldConstraint")
		weld.Part0 = bodyPart
		weld.Part1 = sheath
		weld.Parent = sheath
	end

	return sheath
end

local function setupWeaponVisual(character, tool)
	if not SheathDefinitions[tool.Name] then
		return
	end

	local sheath = nil

	if tool.Parent ~= character then
		sheath = attachSheath(character, tool.Name)
	end

	tool.Unequipped:Connect(function()
		if not sheath then
			sheath = attachSheath(character, tool.Name)
		end
	end)

	tool.Equipped:Connect(function()
		if sheath then
			sheath:Destroy()
			sheath = nil
		end
	end)
end

local function onCharacterAdded(character)
	character.ChildAdded:Connect(function(child)
		if child:IsA("Tool") then
			setupWeaponVisual(character, child)
		end
	end)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(onCharacterAdded)
end)
