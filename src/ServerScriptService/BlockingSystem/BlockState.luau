local BlockState = {}
local blocking = {} -- [Player] = true/false
 
function BlockState.SetBlocking(player: Player, isBlocking: boolean)
	blocking[player] = isBlocking
end
 
function BlockState.IsBlocking(player: Player): boolean
	return blocking[player] == true
end
 
return BlockState
 
