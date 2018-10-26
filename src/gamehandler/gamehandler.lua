local SaveData = require("src/save/savingdata")

local Game = {}

local Level_idx = 1
local Levels    =
{

    "src/levels/day0/level",
    "src/levels/day1/level"

}

local Level = nil
function Game.Draw()

    Level.Draw()

end

function Game.Update()

    CanTransition = Level.CanTransition()
    if Level.CanTransition() then
        Level_idx = Level_idx + 1
        Level     = require(Levels[Level_idx])
    end
    Level.Update()

end

function Game.HandleInput()

    Level.HandleInput()

end

local function DetermineCurrentLevel()

    for i = 0, #SaveData.level do
        if not SaveData.level["day" .. tostring(i)] then
            Level = require(Levels[i+1])
            return
        end
    end
    print("Warning: All Levels seem to be complete with selected save")

end

function Game.InitializeGameHandler()

    DetermineCurrentLevel()
    Level_idx = 1

end

return Game