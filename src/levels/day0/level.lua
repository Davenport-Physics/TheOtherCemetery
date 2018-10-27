local DataToSave = require("src/save/savingdata")
local Level = {}

local Scene_idx = 1
local Scenes =
{

    "src/levels/day0/scenes/intro",
    "src/levels/day0/scenes/FuneralHome",
    "src/levels/day0/scenes/henry-bedroom-scene",
    --"src/levels/day0/scenes/runner-example",
    --"src/levels/day0/scenes/battle-example"

}

local Scene = nil
local transition_to_next_level = false

function Level.Draw()

    if Scene == nil then return end
    Scene.Draw()

end

local CanTransition = nil
local function SetUpTransition()

    Scene = require(CanTransition[1])
    if #CanTransition == 3 then
        Scene.SetPlayerCharPosition(CanTransition[2], CanTransition[3])
    end

end

local function DetermineSceneFromSaveData()

    local temp_idx
    if not DataToSave.Day0Events["BedroomSceneConveration"] then
        temp_idx = 3
    end
    if not DataToSave.Day0Events["FuneralScenePlayed"] then
        temp_idx = 2
    end
    if not DataToSave.Day0Events["IntroPlayed"] then
        temp_idx = 1
    end
    print(tostring(DataToSave.Day0Events["BedroomSceneConveration"]))
    Scene = require(Scenes[temp_idx])
    Scene.Reset()

end

function Level.Update()

    if Scene == nil then
        DetermineSceneFromSaveData()
    end
    CanTransition = Scene.CanTransition()
    if type(CanTransition) == "table" then
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