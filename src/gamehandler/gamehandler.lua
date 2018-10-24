local SaveData = require("src/save/savingdata")

local Game = {}
local GameReady = false

local Level_idx = 1
local Levels =
{

    "src/levels/day0/level",
    "src/levels/day1/level"

}

local Level = nil --require(Levels[Level_idx])
function Game_Draw()

    Level.Draw()

end

function Game_Update()

    CanTransition = Level.CanTransition()
    if Level.CanTransition() then
        Level_idx = Level_idx + 1
        Level     = require(Levels[Level_idx])
    end
    Level.Update()

end

function Game_HandleInput()

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

function Game_InitializeGameHandler()

    DetermineCurrentLevel()
    GameReady = true

end

return Game