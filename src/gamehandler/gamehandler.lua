local Game = {}

local Level_idx = 1
local Levels =
{

    "src/levels/day0/level",
    "src/levels/day1/level"

}

local Level = require(Levels[Level_idx])
function Game.Draw()

    Level.Draw()

end

function Game.Update()

    CanTransition = Level.CanTransition()
    if type(CanTransition) == "bool" and CanTransition then
        Level_idx = Level_idx + 1
        Level     = require(Levels[Level_idx])
    end
    Level.Update()

end

function Game.HandleInput()

    Level.HandleInput()
    
end

return Game