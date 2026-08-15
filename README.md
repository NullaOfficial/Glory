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
│	├── ReplicatedStorage
│	│   ├── Definitions
│	│   │   ├── Class
│	│   │   │   └── ClassDefinitions.lua
│	│   │   ├── Weapon
│	│   │   │   └── WeaponDefinitions.lua
│	│   │   ├── Sheath
│	│   │   │   └── SheathDefinitions.lua
│	│   │   └── Inventory
│	│   │       └── ItemDefinitions.lua
│	│   ├── Remotes
│	│   │   ├── ClassSelection
│	│   │   ├── Combat
│	│   │   ├── Inventory
│	│   │   ├── Staff
│	│   │   └── Sword
│	│   ├── BodyPartMultipliers.lua
│	│   ├── DataTemplate.lua
│	│   ├── RayCastHitboxv4.lua
│	│   └── StartingWeapons.lua
│	│
│	├── ServerScriptService
│	│   ├── BlockingSystem
│	│   │   ├── BlockManager.server.lua
│	│   │   └── BlockState.lua
│	│   ├── Handler
│	│   │   ├── InventoryHandler.server.lua
│	│   │   └── WeaponSheathHandler.server.lua
│	│   ├── Manager
│	│   │   ├── ClassManager.server.lua
│	│   │   ├── InventoryManager.lua
│	│   │   └── PlayerDataManager.lua
│	│   ├── StarterWeaponCombatHandler
│	│   │   ├── StaffCombatHandler.server.lua
│	│   │   └── SwordCombatHandler.server.lua
│	│   ├── DebugReset.server.lua
│	│   ├── HeadBillboardGUI.server.lua
│	│   └── ProfileStore.lua
│	│
│	├── ServerStorage
│	│   ├── SheathModels
│	│   └── StartingWeapons
│	│
│	└── StarterPlayer
│	    ├── StarterCharacterScripts
│	    │   ├── DmgGUI.client.lua
│	    │   └── ShiftLockController.client.lua
│	    └── StarterPlayerScripts
│	        └── ToolHotbar
└── g-photos/
