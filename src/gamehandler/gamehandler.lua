local DataToSave = require("src/save/savingdata")
local inspect    = require("src/debug/inspect")

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

function Game_DrawText()

    Level.DrawText()

end

function Game_Update()

    local CanTransition = Level.CanTransition()
    if CanTransition then
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

    Level = require(DataToSave.level)
    Level.Reset()

end

function Game_InitializeGameHandler()

    Level_idx = 1
    Level     = nil
    DetermineCurrentLevel()

end
