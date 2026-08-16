return {
	Level = 1, -- Max nivel 70
	Experience = 0,
	Gold = 100,
	Mana = 100,
	Class = nil,    -- se llena en el GUI inicial al empezar a jugar, y cambia solo cuando cambias de arma
	Subclass = nil, -- se llena al llegar a nivel 20, eligiendo entre las 4 subclases de tu Class actual

	Stats = {
		Strength = 1,	-- Daño con melee (Espada en general y pistolas en general)
		Intelligence = 1,	-- Daño con magia (Baston en general)
		Vitality = 1, -- Vida del jugador
		Spirit = 1,	-- Resistencia al daño mágico
		UnspentPoints = 4,
	},
	
	DerivedStats = {
		MaxHP = 100,             -- Calculado con Vitality
		MaxMP = 50,              -- Calculado con Intelligence/Spirit
		Defense = 0,             -- Suma de Armor Stats + Vitality
		MagicResistance = 0,     -- Suma de Armor Stats + Spirit
		MovementSpeed = 16,      -- Base de Roblox (16) + modificadores de ítems
		AttackSpeed = 1.0,       -- Multiplicador base (1.0 = 100%)
		PhysCritRate = 0.05,     -- 5% Base
		PhysCritDamage = 1.5,    -- 150% de daño base
		MagicCritRate = 0.05,    -- 5% Base
		MagicCritDamage = 1.5,   -- 150% de daño base
	},

	Inventory = {},

	Equipped = {
		Weapon = nil,
		Headwear = nil,
		Shoulder = nil,
		UpperBody = nil,
		Waist = nil,
		LowerBody = nil,
		Cloak = nil,
		Necklance = nil,
		LeftHandRing = nil,
		RightHandRing = nil,
	}
}
