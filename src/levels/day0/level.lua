local DataToSave = require("src/save/savingdata")
local Level = {}

local Scene_idx = 1
local Scenes =
{

    "src/levels/day0/scenes/intro",
    "src/levels/day0/scenes/FuneralHome",
    "src/levels/day0/scenes/henry-bedroom-scene"

}

local Scene = nil
local transition_to_next_level = false

function Level.Draw()

    if Scene == nil then return end
    Scene.Draw()

end

function Level.DrawText()

    if Scene == nil then return end
    Scene.DrawText()

end

local CanTransition = nil
local function SetUpTransition()

    DataToSave.CurrentScene = CanTransition[1]
    Scene = require(CanTransition[1])
    Scene.Reset()
    if #CanTransition == 3 then
        Scene.SetPlayerCharPosition(CanTransition[2], CanTransition[3])
    end

end

local function DetermineSceneFromSaveData()

    local temp_idx
    Scene = require(DataToSave.CurrentScene)
    Scene.Reset()

end

function Level.Update()

    if Scene == nil then
        DetermineSceneFromSaveData()
    end
    CanTransition = Scene.CanTransition()
    if type(CanTransition) == "table" then
        Scene.Clean()
        SetUpTransition()
    elseif type(CanTransition) == "boolean" and CanTransition then
        transition_to_next_level = true
    else
        Scene.Update()
    end

end

function Level.CanTransition()

    return transition_to_next_level

end

function Level.HandleInput()

    if Scene == nil then return end
    Scene.HandleInput()

end

function Level.Reset()

    Scene_idx = 1
    Scene = nil
    transition_to_next_level = false
    CanTransition = nil

end

return Level