local Level = {}

local Scene_idx = 1
local Scenes =
{

    require("src/levels/day0/scenes/intro"),
    require("src/levels/day0/scenes/FuneralHome"),
    require("src/levels/day0/scenes/henry-bedroom-scene")

}

function Level.Draw()

    Scenes[Scene_idx].Draw()

end

function Level.Update()

    if Scenes[Scene_idx].CanTransition() then
        Scene_idx = Scene_idx + 1
    end
    if #Scenes < Scene_idx then
        print("STUB FIGURE OUT WHAT TO DO NEXT")
    end
    Scenes[Scene_idx].Update()

end

function Level.HandleInput()

    Scenes[Scene_idx].HandleInput()

end

return Level