local introsequence = nil
local Settings = require("src/settings/settings")

local function InitIntroSequence()

    introsequence = love.graphics.newVideo("video/introicon.ogv")
    introsequence:getSource():setVolume(Settings.MasterVolume * Settings.MusicVolume)
    introsequence:play()


end

local callback
local function CheckIfShouldEnd()

    if not introsequence:isPlaying() then
        introsequence = nil
        callback()
    end

end

function InitIntroIconCallback(func)

    callback = func

end

local s_x
local s_y
function DrawIntroSequence()

    if introsequence == nil then
        InitIntroSequence()
    end
    s_x = love.graphics.getWidth()/introsequence:getWidth()
    s_y = love.graphics.getHeight()/introsequence:getHeight()
    love.graphics.draw(introsequence, 0, 0, 0, s_x, s_y)
    CheckIfShouldEnd()

end