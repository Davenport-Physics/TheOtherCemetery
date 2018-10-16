local Level = {}

local Scene_idx = 1
local Scenes =
{

    "src/levels/day0/scenes/intro",
    --"src/levels/day0/scenes/FuneralHome",
    --"src/levels/day0/scenes/henry-bedroom-scene",
    --"src/levels/day0/scenes/runner-example",
    --"src/levels/day0/scenes/battle-example"

}

local Scene = require(Scenes[1])

local transition_to_next_level = false

function Level.Draw()

    Scene.Draw()

end

local CanTransition = nil
local function SetUpTransition()

    Scene = require(CanTransition[1])
    if #CanTransition == 3 then
        Scene.SetPlayerCharPosition(CanTransition[2], CanTransition[3])
    end

end

function Level.Update()

    CanTransition = Scene.CanTransition()
    if type(CanTransition) == "table" then
        SetUpTransition()
    elseif type(Scene.CanTransition) == "bool" and Scene.CanTransition() then
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

return Level