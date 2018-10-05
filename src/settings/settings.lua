local Settings = {}

Settings.Controls =
{

    UP    = "w",
    DOWN  = "s",
    LEFT  = "a",
    RIGHT = "d",

}

Settings.PlayerSaveName = ""
Settings.Scale  = 3
Settings.X_Canvas_Translation = 0
Settings.Y_Canvas_Translation = 0

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
function Settings.DrawCameraFunctions(x_translation, y_translation)

    camera_x_offset = math.floor( love.graphics.getWidth()  * .5 )
    camera_y_offset = math.floor( love.graphics.getHeight() * .5 )

    local x = -(x_translation * Settings.Scale) + camera_x_offset
    local y = -(Settings.Scale * y_translation) + camera_y_offset

    Settings.X_Canvas_Translation = x
    Settings.Y_Canvas_Translation = y
    --love.graphics.translate(x, y)
    --love.graphics.scale(Settings.Scale, Settings.Scale)

end

return Settings