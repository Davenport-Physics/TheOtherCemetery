local DataToSave = require("src/save/savingdata")

local Scene = {}
local Settings   = require("src/settings/settings")
local transition = false
local video      = nil

function Scene.Draw()

    if video == nil then return end
    love.graphics.draw(video, 0, 0, 0, love.graphics.getWidth()/video:getWidth(), love.graphics.getHeight()/video:getHeight())

end

function Scene.DrawText()

end

function Scene.Update()

    if video == nil then
        video = love.graphics.newVideo("video/daytransitions/DayOne.ogv")
        video:play()
        video:getSource():setVolume(Settings.MasterVolume * Settings.MusicVolume * Settings.SoundEffectsVolume)
        Settings.GlobalScaleOn = false
    end
    if video ~= nil and not video:isPlaying() then
        Settings.GlobalScaleOn  = true
        transition              = true
        DataToSave.CurrentScene = "src/levels/day1/scenes/home/henry-bedroom-scene"
        DataToSave["level"]     = "src/levels/day1/level"
    end

end

function Scene.HandleInput()

end

function Scene.CanTransition()

    return transition

end

function Scene.Clean()

    transition = false
    video      = nil

end

function Scene.Reset()

    transition = false
    video      = nil

end

return Scene