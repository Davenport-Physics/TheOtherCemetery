local DataToSave = require("src/save/savingdata")
local Level = {}

local Scene_idx = 1
local Scenes =
{
    "src/levels/day1/scenes/home/henry-bedroom-scene",
    "src/levels/day1/scenes/home/home-lobby",
    "src/levels/day1/scenes/city/city"
}

local Scene = require(Scenes[1])
local transition_to_next_level = false
function Level.Draw()

    Scene.Draw()

end

function Level.DrawText()

    if Scene == nil then return end
    Scene.DrawText()

end

local CanTransition = nil
local function SetUpTransition()

    DataToSave.CurrentScene = CanTransition[1]
    DataToSave.CurrentScene   = CanTransition[1]
    Scene = require(CanTransition[1])
    Scene.Reset()
    if #CanTransition == 3 then
        Scene.SetPlayerCharPosition(CanTransition[2], CanTransition[3])
    end

end

local function DetermineSceneFromDataToSave()

    Scene = require(DataToSave.CurrentScene)
    Scene.Reset()

end

function Level.Update()

    CanTransition = Scene.CanTransition()
    if type(CanTransition) == "table" then
        SetUpTransition()
    elseif type(CanTransition) == "boolean" and CanTransition then
        transition_to_next_level = true
    end
    Scene.Update()

end

function Level.CanTransition()

    return transition_to_next_level

end

function Level.HandleInput()

    Scene.HandleInput()

end

function Level.Reset()

    Scene_idx = 1
    transition_to_next_level = false
    CanTransition = nil

end

return Level