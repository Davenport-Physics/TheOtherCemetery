
local Scene = {}

local IntroMusic = nil
local AnnaDialog = nil

local CameraPanning = true
local IntroVideo    = nil

local transition = false

function Scene.Draw()

    if IntroVideo == nil then return end
    love.graphics.scale(.35)
    love.graphics.draw(IntroVideo, 0, 0)

end

function Scene.HandleInput()

end

local function Intro_Update_CheckForNil()

    if IntroVideo == nil then

        IntroVideo = love.graphics.newVideo("video/intro/intro.ogv")
        IntroMusic = love.audio.newSource("sound/intro/Mournful_Departure.mp3", "static")
        IntroVideo:play()
        IntroVideo:getSource():setVolume(.5)

    end

end

local function Intro_Update_CheckToStartSecondaryMusicSource()

    if IntroVideo:isPlaying() and not IntroMusic:isPlaying() then

        if IntroVideo:getSource():getDuration() - 5 <= IntroVideo:getSource():tell() then

            IntroMusic:play()
            IntroMusic:seek(IntroVideo:getSource():tell())
            IntroMusic:setVolume(.25)

        end

    end

end

local function Intro_Update_CheckForPlayback()

    if not IntroVideo:isPlaying() then

        IntroVideo     = nil
        AnnaDialog     = love.audio.newSource("sound/intro/anna-dialog/anna-intro.mp3", "static")
        AnnaDialog:play()
        transition = true

    end

end

function Scene.Update()

    Intro_Update_CheckForNil()
    Intro_Update_CheckToStartSecondaryMusicSource()
    Intro_Update_CheckForPlayback()


end

function Scene.CanTransition()

    return transition

end

return Scene