Intro
====

**This is the official GitHub repository owned by the Glory team. Updates for the Glory game on Roblox will be posted here.**

---

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

---

Level Progression & Automated Stat Allocation System
===

### **Global Level Cap**
* **Max Level Cap:** `Level 70`
* **Subclass Progression Threshold:** `Level 20`
* **Base Allocation (Levels 1–20):** **4 Points Total** (+1 to Strength, Intelligence, Spirit, Vitality).
* **Subclass Allocation (Levels 21–70):** **5 Points Total**, distributed according to the active subclass profile.

### **Stat Growth Distributions (Per Level)**

#### 1. Base Classes (Levels 1–20)
*All base classes (`Swordsman`, `Mage`, `Gunner`, `Fighter`, `NightWalker`, `Priest`) use a balanced allocation until selecting a subclass at level 20.*

| Base Class | Level Range | Strength | Intelligence | Spirit | Vitality | Total / Lvl |
| :--- | :-: | :-: | :-: | :-: | :-: | :-: |
| **All Base Classes** | Lv. 1 – 20 | +1 | +1 | +1 | +1 | **4 pts** |

---

#### 2. Subclasses (Levels 21–70)

#### Swordsman Subclasses
| Subclass | Strength | Intelligence | Spirit | Vitality | Total / Lvl |
| :--- | :-: | :-: | :-: | :-: | :-: |
| **Ghostblade** | +3 | +1 | +0 | +1 | **5 pts** |
| **BladeMaster** | +3 | +0 | +1 | +1 | **5 pts** |
| **Berserker** | +4 | +0 | +0 | +1 | **5 pts** |
| **Spellblade** | +2 | +2 | +0 | +1 | **5 pts** |

#### Mage Subclasses
| Subclass | Strength | Intelligence | Spirit | Vitality | Total / Lvl |
| :--- | :-: | :-: | :-: | :-: | :-: |
| **Elementalist** | +0 | +4 | +1 | +0 | **5 pts** |
| **BattleMage** | +2 | +2 | +0 | +1 | **5 pts** |
| **Witch** | +0 | +3 | +1 | +1 | **5 pts** |
| **Summoner** | +0 | +3 | +1 | +1 | **5 pts** |

#### Gunner Subclasses
| Subclass | Strength | Intelligence | Spirit | Vitality | Total / Lvl |
| :--- | :-: | :-: | :-: | :-: | :-: |
| **Sharpshooter** | +3 | +1 | +0 | +1 | **5 pts** |
| **Launcher** | +3 | +0 | +0 | +2 | **5 pts** |
| **Mechanic** | +1 | +3 | +0 | +1 | **5 pts** |
| **Spitfire** | +2 | +2 | +0 | +1 | **5 pts** |

#### Fighter Subclasses
| Subclass | Strength | Intelligence | Spirit | Vitality | Total / Lvl |
| :--- | :-: | :-: | :-: | :-: | :-: |
| **Brawler** | +3 | +0 | +0 | +2 | **5 pts** |
| **QiMaster** | +1 | +3 | +1 | +0 | **5 pts** |
| **Grappler** | +3 | +0 | +0 | +2 | **5 pts** |
| **Striker** | +4 | +0 | +0 | +1 | **5 pts** |

#### NightWalker Subclasses
| Subclass | Strength | Intelligence | Spirit | Vitality | Total / Lvl |
| :--- | :-: | :-: | :-: | :-: | :-: |
| **Assassin** | +4 | +0 | +0 | +1 | **5 pts** |
| **Warlock** | +0 | +3 | +1 | +1 | **5 pts** |
| **Thief** | +3 | +1 | +0 | +1 | **5 pts** |
| **Ninja** | +3 | +1 | +0 | +1 | **5 pts** |

#### Priest Subclasses
| Subclass | Strength | Intelligence | Spirit | Vitality | Total / Lvl |
| :--- | :-: | :-: | :-: | :-: | :-: |
| **Healer** | +0 | +1 | +3 | +1 | **5 pts** |
| **Paladin** | +2 | +0 | +1 | +2 | **5 pts** |
| **Exorcist** | +0 | +3 | +1 | +1 | **5 pts** |
| **Knight** | +2 | +0 | +1 | +2 | **5 pts** |

---

Equipment State & Combat Stance Logic
===

*To separate exploration mode from active combat, weapon draw state is bound directly to ShiftLock (`Right Alt`):*

```
[ Exploration Mode ] (Right Alt Unlocked)
  ├── Free Mouse Cursor / Independent Camera
  ├── Weapons automatically UNEQUIPPED / Sheathed
  └── M1 Attacks and Combat Skills DISABLED

[ Combat Stance ] (Right Alt Locked / ShiftLock Active)
  ├── Camera locked to screen center reticle
  ├── Weapon AUTO-DRAWS to active stance
  └── Full M1, M2, and Skill inputs ENABLED
```

---

Input System & Keybinding Specification
===

*Glory operates as a third-person action ARPG/TPS with free camera directional targeting (no hard auto-lock).*

### Keybinding Layout

| Input / Key | Action / Category | Technical Behavior & Mechanical Description |
| :--- | :--- | :--- |
| **Mouse Delta** | Free Camera | Controls 360° direction and reticle targeting. |
| **M1 (Left Click)** | Basic Attack | Executes primary light attacks and base combo inputs. |
| **M2 (Right Click)** | Block / Parry / Cancel | Activates guard state; cancels active cast animations (Feints). |
| **Mouse Scroll Wheel** | Utility Item Selector | Cycles through assigned quick-use consumable/utility slots (e.g., MP potions, speed scrolls, throwables). |
| **W, A, S, D** | Movement | Standard directional vectors. |
| **Double Tap (W+W, A+A, D+D and S+S.)** | Dash / Evade | Directional dash/dodge consuming stamina. |
| **Spacebar** | Jump | Single jump (Double Jump is class/skill restricted). |
| **Shift / Ctrl** | Slide / Crouch / Evasion | Ground slide execution and low-profile evasive maneuvers. |
| **Right Alt (`RAlt`)** | Toggle ShiftLock | Locks camera to reticle (`LockCenter`). Required to draw weapon. |
| **`Q`, `E`, `R`, `F`, `C`, `V`** | Skill Slots 01 – 06 | Primary low-cooldown skills, combo starters, and launchers. |
| **`1`, `2`, `3`, `4`, `5`, `6`** | Skill Slots 07 – 12 | Secondary utilities, buffs, and mobility skills. |
| **`Ctrl` + (`Q, E, R, F, C, V`)** | Skill Slots 13 – 18 | High-damage subclass skills, AoE, and finisher abilities. |
| **`Left Alt` + (`Q, E, R, F, C, V`)** | Skill Slots 19 – 24 | Ultimate skills, awakenings, and high-tier crowd control. |

---

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

---

Tier & Rarity System Specification:
===

### **Tier System (Equipment Progression Ranks)**

*The **Tier** defines the item's level range, base attribute scaling, and progression phase in the game.*

| Tier Rank | Target Level Range | Progression Phase & Acquisition Source | Attribute Multiplier |
| :-: | :-: | :--- | :-: |
| **Tier 1** | Lv. 1 – 20 | Starter Zone / Basic Village Quests & Shops | $1.0\times$ |
| **Tier 2** | Lv. 21 – 35 | Early Dungeons / Intermediate Area Quests | $1.5\times$ |
| **Tier 3** | Lv. 36 – 50 | Mid-Game Dungeons & Wild Elite Enemies | $2.2\times$ |
| **Tier 4** | Lv. 51 – 65 | High-Level Dungeons & World Bosses | $3.2\times$ |
| **Tier 5** | Lv. 66 – 70 | End-Game Raids & Max-Level Competitive Content | $4.5\times$ |

### **Rarity System (Item Quality & Color Hierarchy):**

*The **Rarity** dictates the color of the item border in the UI, the number of bonus stats, and unique passive effects.*

| Color / Rarity | UI Hex Code | Source / Acquisition Method | Bonus Stats Count | Special Effects / Properties |
| :--- | :-: | :--- | :-: | :--- |
| **White** *(Common)* | `#FFFFFF` | Generic Vendors / Low-Level Drops | 0 | None. Flat base stats only. |
| **Green** *(Quest)* | `#55FF55` | Quest Rewards (Villages & Outposts) | 1 | Slight primary stat bonuses. |
| **Blue** *(Dungeon)* | `#0088ff` | Dungeon Bosses & Mainstream Drops | 2 | Standard competitive mid-tier gear. |
| **Purple** *(Elite)* | `#AA00AA` | Wild Bosses & Extreme Dungeons | 3–4 | High stat values + advanced secondary bonuses. |
| **Orange** *(Epic/Legendary)*| `#FFAA00` | Ultra-Rare World Bosses / Raid Drops | 4–5 | Peak system gear + unique skill passives. |
| **Silver** *(Self-Made)* | `#959595` | Player Crafted via Equipment Editor | Custom | Unlimited custom stat allocations & custom skills. |

---

Self-Made Armor & Equipment Customization System
===

*Armors follow the exact same **Silver / Self-Made** crafting logic as custom weapons in the Equipment Editor:*

* **Material Composition:** Players combine rare drop materials to modify defense thresholds, weight, and elemental resistances.
* **Visual Editor:** Visual aesthetics and model attachments can be adjusted in the editor without affecting base hitboxes.
* **Stat Point Allocation:** Attribute points can be manually allocated to tailor equipment specifically to a player's build (e.g., Strength, Agility, Spirit).

---

Extra (Very Important)
===

### 1. Gunner Auto-Reload & MP Management

*Gunners do not rely on a manual reload key (R). Ammunition is handled automatically as a resource state:*

#### - Automatic Chambering: Firing weapon rounds continuously drains MP per shot.

#### - Special Ammunition: Activating elemental rounds (Freezing, Blazing, Armor-Piercing) reserves or consumes additional MP per projectile.

#### - Uninterrupted Fire: Weapons will auto-chamber and fire without reload delays as long as the player maintains sufficient MP.

---

### 2. Jump & Air Mobility Constraints

*Universal Base Jump: Single jump available via Spacebar across all classes.*

#### - Double Jump (Class Restricted): Restricted exclusively to high-mobility classes (Nightwalker, Ninja, Striker) or specific skills (e.g., Blade Master's Air Step).

#### - Execution: Airborne Spacebar press while possessing the required passive/active perk.

---

### 3. High-Hit Combo Systems & Mechanics (100+ Hit Combos)

*Achieving massive hit counters (e.g., 100+ hits) is not possible through M1 spam due to enemy hit-stun recovery limits. Massive combos rely on three core pillars:*

#### - Launch State (Knock-up): Elevating an enemy using launcher skills (e.g., Upward Strike, Launcher Cannon) or directional inputs (S + M1). Launchers apply upward velocity vectors directly to the victim's root part.

#### - Air Juggle Physics: Striking an airborne enemy applies vertical force and resets their gravity decay, keeping them suspended at height ($Y$-axis).

#### - Multi-Hit Skill Chaining: Integrating multi-strike abilities (rapid bullet bursts, multi-slashes) alongside rapid animation cancels to maintain infinite hit-stun.

---

### 4. Animation Canceling & Feint System

#### - Skill-to-Skill CancellationCancel the recovery frames (end-lag) of an active skill by immediately buffering another skill input:

```
[Skill A Execution] ──► [Impact Frame] ──► [Recovery Frames CANCELLED] ──► [Skill B Triggered]
```

---

#### - Skill Feints / Fake AttacksFake out an opponent by initiating a skill startup animation and instantly canceling it into a block/parry stance via M2:
  
```
[Press Skill Key] ──► [Wind-up Animation] ──► [Press M2 (Block)] ──► [Skill Canceled / Partial CD Applied]
```

---
