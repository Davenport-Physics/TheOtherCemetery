local Settings = {}

Settings.Controls =
{

    UP    = "w",
    DOWN  = "s",
    LEFT  = "a",
    RIGHT = "d",
    ATTACK_BUTTON = "space"

}

Settings.PlayerSaveName       = ""
Settings.Window_Width         = love.graphics.getWidth()
Settings.Window_Height        = love.graphics.getHeight()
Settings.Window_Width_old     = Settings.Window_Width
Settings.Window_Height_old    = Settings.Window_Height_old
Settings.Scale                = 3 * (Settings.Window_Height/Settings.Window_Width)*(600/800)
Settings.Scale_x              = 3 * (love.graphics.getWidth()/800)
Settings.Scale_y              = 3 * (love.graphics.getHeight()/600)
Settings.GlobalScaleOn        = true
Settings.X_Canvas_Translation = 0
Settings.Y_Canvas_Translation = 0
Settings.MasterVolume         = 1
Settings.MusicVolume          = 1
Settings.Fullscreen           = false
Settings.BUILD                = false

function Settings.CheckIfResolutionChanged()

    if Settings.Window_Width_old ~= Settings.Window_Width then
        return true
    end
    if Settings.Window_Height_old ~= Settings.Window_Height then
        return true
    end

    return false

end

function Settings.UpdateScale()

    if Settings.CheckIfResolutionChanged() then

        Settings.Window_Width_old  = Settings.Window_Width
        Settings.Window_Height_old = Settings.Window_Height
        Settings.Scale_x = 3 * (love.graphics.getWidth()/800)
        Settings.Scale_y = 3 * (love.graphics.getHeight()/600)
        Settings.Scale = 3 * (Settings.Window_Height/Settings.Window_Width)*(800/600)

    end

end

function Settings.UpdateWindow()

    Settings.Window_Width  = love.graphics.getWidth()
    Settings.Window_Height = love.graphics.getHeight()

end

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

    camera_x_offset = love.graphics.getWidth()  * .5
    camera_y_offset = love.graphics.getHeight() * .5

    Settings.X_Canvas_Translation = -(x_translation * Settings.Scale) + camera_x_offset
    Settings.Y_Canvas_Translation = -(y_translation * Settings.Scale) + camera_y_offset

end

return Settings