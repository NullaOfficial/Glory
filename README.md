Intro
====

**This is the official GitHub repository owned by the Glory team. Updates for the Glory game on Roblox will be posted here.**

Folder Structure
====

### **This is the Folder Structure:**

```
Glory/
├── models/
├── schemes/
├── src/
│    ├── ReplicatedStorage
│    │   ├── Definitions (Folder)
│    │   │   ├── Class (Folder)
│    │   │   │   └── ClassDefinitions (ModuleScript).lua
│    │   │   ├── Weapon (Folder)
│    │   │   │   └── WeaponDefinitions (ModuleScript).lua
│    │   │   ├── Sheath (Folder)
│    │   │   │   └── SheathDefinitions (ModuleScript).lua
│    │   │   └── Item (Folder)
│    │   │       └── ItemDefinitions (ModuleScript).lua
│    │   ├── Remotes (Folder)
│    │   │   ├── ClassSelection (Folder)
│    │   │   │   ├── PromptClassSelection (RemoteEvent)
│    │   │   │   ├── PromptStartingClassSelection (RemoteEvent)
│    │   │   │   ├── PromptSubclassSelection (RemoteEvent)
│    │   │   │   └── SelectSubclass (RemoteEvent)
│    │   │   ├── Combat (Folder)
│    │   │   │   └── SetBlocking (RemoteEvent)
│    │   │   ├── Inventory (Folder)
│    │   │   │   ├── EquipItem (RemoteEvent)
│    │   │   │   └── UnequipItem (RemoteEvent)
│    │   │   ├── Staff (Folder)
│    │   │   │   ├── ShowStaffDamage (RemoteEvent)
│    │   │   │   └── CastFireball (RemoteEvent)
│    │   │   └── Sword (Folder)
│    │   │       ├── ShowSwordDamage (RemoteEvent)
│    │   │       └── SwordHit (RemoteEvent)
│    │   ├── BodyPartMultipliers (ModuleScript).lua
│    │   ├── DataTemplate (ModuleScript).lua
│    │   ├── RayCastHitboxv4 (ModuleScript).lua
│    │   └── StartingWeapons (ModuleScript).lua
│    │
│    ├── ServerScriptService
│    │   ├── BlockingSystem (Folder)
│    │   │   ├── BlockManager (Script).lua
│    │   │   └── BlockState (ModuleScript).lua
│    │   ├── Handler (Folder)
│    │   │   ├── InventoryHandler (Script).lua
│    │   │   └── WeaponSheathHandler (Script).lua
│    │   ├── Manager (Folder)
│    │   │   ├── ClassManager (Script).lua
│    │   │   ├── InventoryManager (ModuleScript).lua
│    │   │   └── PlayerDataManager (ModuleScript).lua
│    │   ├── StarterWeaponCombatHandler (Folder)
│    │   │   ├── StaffCombatHandler (Script).lua
│    │   │   └── SwordCombatHandler (Script).lua
│    │   ├── DebugReset (Script).lua
│    │   ├── HeadBillboardGUI (Script).lua
│    │   └── ProfileStore (ModuleScript).lua
│    │
│    ├── ServerStorage
│    │   ├── SheathModels (Folder)
│    │   │   ├── WoodenStaff_Sheath (Model)
│    │   │   └── WoodenSword_Sheath (Model)
│    │   └── StartingWeapons (Folder)
│    │       ├── WoodenStaff (Tool)
│    │       └── WoodenSword (Tool)
│    │
│    ├── StarterGui
│    │   ├── ClassSelector (ScreenGui)
│    │   ├── MainGUI (ScreenGui)
│    │   └── SubClassSelector (ScreenGui)
│    │
│    └── StarterPlayer
│        ├── StarterCharacterScripts (Folder)
│        │   └── DmgGUI (LocalScript).lua
│        └── StarterPlayerScripts (Folder)
|            ├── ShiftLockController (LocalScript).lua
│            └── ToolHotbar (LocalScript).lua
└── g-photos/
```

System Attribute & Item Specification:
===

### **Comparative Attribute Matrix: Weapons vs. Armor / Accessories**

| # | Attribute / Property | Category | Weapons | Armor & Accessories | Technical Description & Game Impact |
| :-: | :--- | :--- | :-: | :-: | :--- |
| **1** | `Tier` | Core Meta | **Yes** | **Yes** | Progression rank of the item (`Tier 1` to `Tier 10`). |
| **2** | `Rarity` | Core Meta | **Yes** | **Yes** | Quality rank / UI Color (`White`, `Green`, `Blue`, `Purple`, `Orange`, `Silver`). |
| **3** | `LevelReq` | Requirements | **Yes** | **Yes** | Minimum level required to equip the item. |
| **4** | `Weight` | Physical | **Yes** | **Yes** | Item weight in kg. Higher values reduce `MovementSpeed` or increase stamina cost. |
| **5** | `Durability` / `MaxDurability` | System | **Yes** | **Yes** | Current/Max durability. Reaching `0` severely penalizes item performance. |
| **6** | `PhysicalAttack` | Base Offense | **Yes** | **No** | Base flat physical damage value dealt by melee or ranged weapons. |
| **7** | `MagicAttack` | Base Offense | **Yes** | **No** | Base flat magical damage value dealt by spells and magic weapons. |
| **8** | `PhysicalDefense` | Base Defense | **No** | **Yes** | Flat physical damage mitigation granted by armor. |
| **9** | `MagicResistance` | Base Defense | **No** | **Yes** | Flat magical damage mitigation granted by armor/accessories. |
| **10** | `MaxHP` / `MaxMP` | Vitals Bonus | **Optional** | **Yes** | Direct flat addition to maximum Health or Mana points. |
| **11** | `HPRegen` / `MPRegen` | Vitals Bonus | **Optional** | **Yes** | Regeneration rate of Health or Mana per second (`/s`). |
| **12** | `PhysArmorPen` / `MagicArmorPen` | Offense Penetration | **Yes** | **Rare** | Ignores a flat amount or percentage of the target's physical/magic defense. |
| **13** | `AttackSpeed` | Combat Pacing | **Yes** | **Yes** | Percentage modifier to attack animation execution speed (`+0.05` = `+5%`). |
| **14** | `CastSpeed` | Spell Pacing | **Yes** | **Yes** | Percentage reduction to skill cast/channeling duration. |
| **15** | `CDR` | Skill Utility | **Yes** | **Yes** | Cooldown Reduction (`CDR`). Reduces the cooldown timer of skills. |
| **16** | `AttackRange` | Offense Range | **Yes** | **No** | Extends the reach of basic attacks in studs/meters. |
| **17** | `CastRange` | Spell Range | **Yes** | **Yes** | Extends the max targeting/projectile range of spells. |
| **18** | `HealRange` / `HealPower` | Support Utility | **Yes** | **Yes** | Extends healing skill reach and scales total HP restored by heals/shields. |
| **19** | `PrimaryStats` | Base Attributes | **Yes** | **Yes** | Flat additions to `Strength`, `Intelligence`, `Vitality`, or `Spirit`. |
| **20** | `PhysCritRate` / `MagicCritRate` | Critical Utility | **Yes** | **Yes** | Percentage chance to score a physical or magical critical strike (`+0.10` = `10%`). |
| **21** | `PhysCritDamage` / `MagicCritDamage` | Critical Utility | **Yes** | **Yes** | Damage multiplier bonus on critical hits (`+0.30` = `+30%` extra dmg). |
| **22** | `MovementSpeed` | Mobility | **Penalty** | **Modifier** | Modifies character base movement speed (`-0.02` for heavy plate, `+0.05` for cloaks). |
| **23** | `Tenacity` | Defense Utility | **No** | **Yes** | Crowd Control (CC) reduction percentage (reduces duration of stuns, slows, freezes). |
| **24** | `Evasion` | Defense Utility | **No** | **Yes** | Percentage chance to completely dodge physical incoming attacks. |
| **25** | `BlockRate` / `BlockAbsorb` | Shield Utility | **Yes** *(Parry)* | **Yes** | Chance to trigger a block and percentage of damage absorbed during block. |
| **26** | `Lifesteal` / `SpellVamp` | Sustain | **Yes** | **Rare** | Converts a percentage of physical or magical damage dealt into self-healing. |

Tier & Rarity System Specification:
===

### **Tier System (Equipment Progression Ranks)**

*The **Tier** defines the item's level range, base attribute scaling, and progression phase in the game.*

| Tier Rank | Target Level Range | Progression Phase & Acquisition Source | Attribute Multiplier |
| :-: | :-: | :--- | :-: |
| **Tier 1** | Lv. 1 – 19 | Starter Zone / Basic Village Quests & Shops | $1.0\times$ |
| **Tier 2** | Lv. 20 – 34 | Early Dungeons / Intermediate Area Quests | $1.5\times$ |
| **Tier 3** | Lv. 35 – 49 | Mid-Game Dungeons & Wild Elite Enemies | $2.2\times$ |
| **Tier 4** | Lv. 50 – 64 | High-Level Dungeons & World Bosses | $3.2\times$ |
| **Tier 5** | Lv. 65 – 70 | End-Game Raids & Max-Level Competitive Content | $4.5\times$ |

### **Rarity System (Item Quality & Color Hierarchy):**

*The **Rarity** dictates the color of the item border in the UI, the number of bonus stats, and unique passive effects.*

| Color / Rarity | UI Hex Code | Source / Acquisition Method | Bonus Stats Count | Special Effects / Properties |
| :--- | :-: | :--- | :-: | :--- |
| **White** *(Common)* | `#FFFFFF` | Generic Vendors / Low-Level Drops | 0 | None. Flat base stats only. |
| **Green** *(Quest)* | `#55FF55` | Quest Rewards (Villages & Outposts) | 1 | Slight primary stat bonuses. |
| **Blue** *(Dungeon)* | `#5555FF` | Dungeon Bosses & Mainstream Drops | 2 | Standard competitive mid-tier gear. |
| **Purple** *(Elite)* | `#AA00AA` | Wild Bosses & Extreme Dungeons | 3–4 | High stat values + advanced secondary bonuses. |
| **Orange** *(Epic/Legendary)*| `#FFAA00` | Ultra-Rare World Bosses / Raid Drops | 4–5 | Peak system gear + unique skill passives. |
| **Silver** *(Self-Made)* | `#C0C0C0` | Player Crafted via Equipment Editor | Custom | Unlimited custom stat allocations & custom skills. |

