local Level = {}

local Scene_idx = 1
local Scenes =
{

    --"src/levels/day0/scenes/intro",
    --"src/levels/day0/scenes/FuneralHome",
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


    if type(Scene.CanTransition()) == "string" then

        Scene = require(Scene.CanTransition())

    elseif type(Scene.CanTransition) == "bool" and Scene.CanTransition() then

        transition_to_next_level = true

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