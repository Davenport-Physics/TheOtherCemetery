
local DataToSave = require("src/save/savingdata")

local Scene = {}

local Settings = require("src/settings/settings")
local IntroMusic = nil
local AnnaDialog = nil
local IntroVideo = nil

local scale_x = 1
local scale_y = 1

local transition = false

function Scene.Draw()

    if IntroVideo == nil then return end
    love.graphics.draw(IntroVideo, 0, 0, 0, scale_x, scale_y)

end

function Scene.HandleInput()

    if love.keyboard.isDown("space") and IntroVideo ~= nil then
        IntroVideo:pause()
    end

end

local function DetermineScalingFactors()

    if IntroVideo ~= nil then
        scale_x = (love.graphics.getWidth()/IntroVideo:getWidth())
        scale_y = (love.graphics.getHeight()/IntroVideo:getHeight())
    end

end

local function Intro_Update_CheckForNil()

    if IntroVideo == nil then

        IntroVideo = love.graphics.newVideo("video/intro/intro.ogv")
        IntroMusic = love.audio.newSource("sound/intro/Mournful_Departure.mp3", "static")
        IntroVideo:play()
        IntroMusic:play()
        IntroMusic:setVolume(.25)
        IntroVideo:getSource():setVolume(.5)
        Settings.GlobalScaleOn = false

    end

end

local function Intro_Update_CheckForPlayback()

    if not IntroVideo:isPlaying() then

        IntroVideo     = nil
        AnnaDialog     = love.audio.newSource("sound/intro/anna-dialog/anna-intro.mp3", "static")
        AnnaDialog:play()
        transition     = {"src/levels/day0/scenes/FuneralHome"}
        Settings.GlobalScaleOn = true
        DataToSave.Day0Events["IntroPlayed"] = true

    end

end

function Scene.Update()


    Intro_Update_CheckForNil()
    Intro_Update_CheckForPlayback()
    DetermineScalingFactors()

end

function Scene.CanTransition()

    return transition

end

return Scene