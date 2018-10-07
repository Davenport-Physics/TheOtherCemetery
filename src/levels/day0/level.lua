local Level = {}

local Scene_idx = 1
local Scenes =
{

    "src/levels/day0/scenes/intro",
    "src/levels/day0/scenes/FuneralHome",
    "src/levels/day0/scenes/henry-bedroom-scene"

}

local Scene = require(Scenes[1])

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
    if #Scenes < Scene_idx then
        print("STUB FIGURE OUT WHAT TO DO NEXT")
    end
    Scene.Update()

end

function Level.HandleInput()

    Scene.HandleInput()

end

return Level