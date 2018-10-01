local Settings = {}

Settings.Controls =
{

    UP    = "w",
    DOWN  = "s",
    LEFT  = "a",
    RIGHT = "d",

}

Settings.PlayerSaveName = ""

function Settings.SetPlayerSaveName(name)

    if name ~= nil then
        Settings.PlayerSaveName = name
    end

end

function Settings.SetPlayerControls(controls)

    if controls ~= nil then
        Settings.Controls = controls
    end

end

local camera_x_offset = 0
local camera_y_offset = 0
function Settings.DrawCameraFunctions(x_translation, y_translation, scale)

    camera_x_offset = math.floor( love.graphics.getWidth() * .5 )
    camera_y_offset = math.floor( love.graphics.getHeight() * .5 )

    love.graphics.translate(-(x_translation * scale) + camera_x_offset, -(scale * y_translation) + camera_y_offset)
    love.graphics.scale(scale)

end

return Settings