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

local Scene = require(Scenes[1])

local transition_to_next_level = false

function Level.Draw()

    Scene.Draw()

end

function Level.Update()

    if Scene.CanTransition() then
        Scene_idx = Scene_idx + 1
        Scene = nil
        if Scenes[Scene_idx] ~= nil then
            Scene = require(Scenes[Scene_idx])
        end
    end
    if Scene == nil then
        transition_to_next_level = true
        print("STUB FIGURE OUT WHAT TO DO NEXT")
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