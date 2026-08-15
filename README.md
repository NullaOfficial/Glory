Intro
====

Este es el repositorio oficial de GitHub propiedad del equipo de Glory, acá se estará publicando las actualizaciones que tiene el juego Glory en Roblox.

Estructura de carpetas
====

Esta es la estructura de carpetas de nuestro repositorio:

```
Glory/
├── models/
├── schemes/
├── src/
│	/src
│  ├── ReplicatedStorage
│  │   ├── Definitions (Folder)
│  │   │   ├── Class (Folder)
│  │   │   │   └── ClassDefinitions (ModuleScript).lua
│  │   │   ├── Weapon (Folder)
│  │   │   │   └── WeaponDefinitions (ModuleScript).lua
│  │   │   ├── Sheath (Folder)
│  │   │   │   └── SheathDefinitions (ModuleScript).lua
│  │   │   └── Inventory (Folder)
│  │   │       └── ItemDefinitions (ModuleScript).lua
│  │   ├── Remotes (Folder)
│  │   │   ├── ClassSelection (Folder)
│  │   │   │   ├── PromptClassSelection (RemoteEvent)
│  │   │   │   ├── PromptStartingClassSelection (RemoteEvent)
│  │   │   │   ├── PromptSubclassSelection (RemoteEvent)
│  │   │   │   └── SelectSubclass (RemoteEvent)
│  │   │   ├── Combat (Folder)
│  │   │   │   └── SetBlocking (RemoteEvent)
│  │   │   ├── Inventory (Folder)
│  │   │   │   ├── EquipItem (RemoteEvent)
│  │   │   │   └── UnequipItem (RemoteEvent)
│  │   │   ├── Staff (Folder)
│  │   │   │   ├── ShowStaffDamage (RemoteEvent)
│  │   │   │   └── CastFireball (RemoteEvent)
│  │   │   └── Sword (Folder)
│  │   │       ├── ShowSwordDamage (RemoteEvent)
│  │   │       └── SwordHit (RemoteEvent)
│  │   ├── BodyPartMultipliers (ModuleScript).lua
│  │   ├── DataTemplate (ModuleScript).lua
│  │   ├── RayCastHitboxv4 (ModuleScript).lua
│  │   └── StartingWeapons (ModuleScript).lua
│  │
│  ├── ServerScriptService
│  │   ├── BlockingSystem (Folder)
│  │   │   ├── BlockManager (Script).lua
│  │   │   └── BlockState (ModuleScript).lua
│  │   ├── Handler (Folder)
│  │   │   ├── InventoryHandler (Script).lua
│  │   │   └── WeaponSheathHandler (Script).lua
│  │   ├── Manager (Folder)
│  │   │   ├── ClassManager (Script).lua
│  │   │   ├── InventoryManager (ModuleScript).lua
│  │   │   └── PlayerDataManager (ModuleScript).lua
│  │   ├── StarterWeaponCombatHandler (Folder)
│  │   │   ├── StaffCombatHandler (Script).lua
│  │   │   └── SwordCombatHandler (Script).lua
│  │   ├── DebugReset (Script).lua
│  │   ├── HeadBillboardGUI (Script).lua
│  │   └── ProfileStore (ModuleScript).lua
│  │
│  ├── ServerStorage
│  │   ├── SheathModels (Folder)
│  │   │   ├── WoodenStaff_Sheath (Model)
│  │   │   └── WoodenSword_Sheath (Model)
│  │   └── StartingWeapons (Folder)
│  │       ├── WoodenStaff (Tool)
│  │       └── WoodenSword (Tool)
│  │
│  ├── StarterGui
│  │   ├── ClassSelector (ScreenGui)
│  │   ├── MainGUI (ScreenGui)
│  │   └── SubClassSelector (ScreenGui)
│  │
│  └── StarterPlayer
│      ├── StarterCharacterScripts (Folder)
│      │   ├── DmgGUI (LocalScript).lua
│      │   └── ShiftLockController (LocalScript).lua
│      └── StarterPlayerScripts (Folder)
│          └── ToolHotbar (LocalScript).lua
└── g-photos/
