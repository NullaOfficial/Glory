local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemDefinitions = require(ReplicatedStorage:WaitForChild("Definitions"):WaitForChild("Item"):WaitForChild("ItemDefinitions"))

local StatCalculator = {}

local BASE_MANA = 100
local MANA_PER_INTELLIGENCE = 5

function StatCalculator.GetDerivedStats(data)
	local stats = data.Stats

	local derived = {
		-- Vitales
		MaxHP = 100 + (stats.Vitality * 10),
		MaxMP = BASE_MANA + (stats.Intelligence * MANA_PER_INTELLIGENCE),
		HPRegen = 1,
		MPRegen = 1,

		-- Ataque
		PhysicalAttack = 0, -- lo aporta el arma equipada, no los stats base
		MagicAttack = 0,
		PhysArmorPen = 0,
		MagicArmorPen = 0,

		-- Defensa
		PhysicalDefense = stats.Vitality * 1,
		MagicResistance = stats.Spirit * 1,

		-- Ritmo de combate
		AttackSpeed = 1.0,
		CastSpeed = 1.0,
		CDR = 0,

		-- Alcance
		AttackRange = 0,
		CastRange = 0,
		HealRange = 0,
		HealPower = 1.0,

		-- Críticos
		PhysCritRate = 0.05,
		PhysCritDamage = 1.5,
		MagicCritRate = 0.05,
		MagicCritDamage = 1.5,

		-- Movilidad y utilidad defensiva
		MovementSpeed = 9, -- WalkSpeed base de Roblox
		Tenacity = 0,
		Evasion = 0,
		BlockRate = 0,
		BlockAbsorb = 0.75, -- coincide con tu SetBlocking actual (reduce daño al 25% = absorbe 75%)

		-- Sustain
		Lifesteal = 0,
		SpellVamp = 0,
	}

	-- Suma los bonos de cada item equipado
	for _, itemId in pairs(data.Equipped) do
		if itemId then
			local itemDef = ItemDefinitions[itemId]
			if itemDef and itemDef.Stats then
				for statName, bonus in pairs(itemDef.Stats) do
					if derived[statName] ~= nil then
						derived[statName] += bonus
					end
				end
			end
		end
	end

	return derived
end

return StatCalculator
