local SaveData = require("src/save/savingdata")

local Level_idx = 1
local Levels    =
{

    "src/levels/day0/level",
    "src/levels/day1/level"

}

local Level = nil
function Game_Draw()

    Level.Draw()

end

function Game_Update()

    local CanTransition = Level.CanTransition()
    if CanTransition then
        print("Transitioning to " .. Level_idx + 1)
        if Level ~= nil then Level.Reset() end
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
            print("starting on day " .. i)
            Level = require(Levels[i+1])
            Level.Reset()
            return
        end
    end
    print("Warning: All Levels seem to be complete with selected save")

end

function Game_InitializeGameHandler()

    Level_idx = 1
    Level     = nil
    DetermineCurrentLevel()

end
