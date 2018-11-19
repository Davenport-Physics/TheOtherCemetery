require("src/shared/cache")
local utf8 = require("utf8")
local Settings    = require("src/settings/settings")
local ButtonClass = require("src/button/button")

local BackgroundVideo = love.graphics.newVideo("video/RandomSequence.ogv")
local VideoMenu       = getImageFromCache("pics/options/Video.png")
local SoundMenu       = getImageFromCache("pics/options/Sound.png")
local ControlsMenu    = getImageFromCache("pics/options/Controls.png")
local CheckMark       = getImageFromCache("pics/options/checkmark.png")
local SliderButton    = getImageFromCache("pics/options/sliderbutton.png")

local Buttons =
{
    Check              = ButtonClass:newWithoutImage(553.3, 176.4, 25, 25),
    VideoMenuSwitch    = ButtonClass:newWithoutImage(10.5, 10.5, 211, 93.5),
    SoundMenuSwitch    = ButtonClass:newWithoutImage(221.5, 10.5, 211, 92),
    ControlsMenuSwitch = ButtonClass:newWithoutImage(432.5, 10.5, 211, 92),
    MasterVolumeSlider = ButtonClass:newImage("pics/options/sliderbutton.png", 349, 184.8),
    MusicVolumeSlider  = ButtonClass:newImage("pics/options/sliderbutton.png", 349, 293.9),
    SoundEffectsSlider = ButtonClass:newImage("pics/options/sliderbutton.png", 349, 398),
    BackButton         = ButtonClass:newImage("pics/share/buttons/backbutton.png", 10, 10, .25, .25),
    UpButton           = ButtonClass:newWithoutImage(431, 148.4, 97.5, 78.6),
    DownButton         = ButtonClass:newWithoutImage(431, 243.6, 97.5, 78.6),
    LeftButton         = ButtonClass:newWithoutImage(431, 339.2, 97.5, 78.6),
    RightButton        = ButtonClass:newWithoutImage(431, 432.5, 97.5, 78.6)
}
Buttons.VideoMenuSwitch:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.SoundMenuSwitch:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.ControlsMenuSwitch:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.Check:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.BackButton:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.UpButton:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.DownButton:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.LeftButton:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.RightButton:SetSoundWhenClicked("sound/startmenu/click/click.ogg")

Buttons.MasterVolumeSlider.avoid_callback_timer = true
Buttons.MusicVolumeSlider.avoid_callback_timer  = true
Buttons.SoundEffectsSlider.avoid_callback_timer = true

local MasterVolumeSlider_r_x = {349 + Settings.MasterVolume*349}
local MusicVolumeSlider_r_x  = {349 + Settings.MusicVolume*349}
local SoundEffectsSlider_r_x = {349 + Settings.SoundEffectsVolume*349}
local CurrentSlider_r_x = nil
local slider_moving  = false
local did_not_update = true

local GetText         = false
local ControlToChange = false

--388.2

local MENUS =
{
    VIDEO = 1,
    SOUND = 2,
    CONTROLS = 3
}

local menu_x = 0
local menu_y = 0

local fullscreen_queued = false
local function UpdateSettings()

    Settings.MasterVolume = math.min(1, tonumber(string.format("%.2f", 2*(MasterVolumeSlider_r_x[1]-349)/(349+349))))
    Settings.MusicVolume  = math.min(1, tonumber(string.format("%.2f", 2*(MusicVolumeSlider_r_x[1]-349)/(349+349))))
    Settings.SoundEffectsVolume = math.min(1, tonumber(string.format("%.2f", 2*(SoundEffectsSlider_r_x[1]-349)/(349+349))))

end

function love.mousereleased(x, y, button)

    if fullscreen_queued and button == 1 then
        fullscreen_queued = false
        love.window.setFullscreen(Settings.Fullscreen)
    elseif slider_moving and button == 1 then
        slider_moving     = false
        CurrentSlider_r_x = nil
    end

end

local new_control = ""

local function AnyControlRepeats()

    for key, value in pairs(Settings.Controls) do
        if new_control == value then return true end
    end

end

local function SwitchControl()

    if ControlToChange == "Up" then
        Settings.Controls.UP = new_control
    elseif ControlToChange == "Down" then
        Settings.Controls.DOWN = new_control
    elseif ControlToChange == "Left" then
        Settings.Controls.LEFT = new_control
    elseif ControlToChange == "Right" then
        Settings.Controls.RIGHT = new_control
    end

end

local function HandleControlChange()

    if #new_control ~= 1 then return end
    if AnyControlRepeats() then return end
    SwitchControl()
    GetText = false
    ControlToChange = ""

end

function Options_keypressed(key, scancode, isrepeat)

    if not GetText then return end
    if key == "backspace" then
        local byteoffset = utf8.offset(new_control, -1)
        if byteoffset then
            new_control = string.sub(new_control, 1, byteoffset - 1)
        end
    elseif key == "return" then
        HandleControlChange()
    end

end

function Options_textinput(t)

    if #new_control >= 1 and t > 1 then return end
    new_control = new_control .. t

end

local CurrentMenu = MENUS.VIDEO
local function ToggleCurrentMenuToVideo()
    CurrentMenu = MENUS.VIDEO
end
local function ToggleCurrentMenuToSound()
    CurrentMenu = MENUS.SOUND
end
local function ToggleCurrentMenuToControls()
    CurrentMenu = MENUS.CONTROLS
end
local function ToggleCheckFullScreen()
    Settings.Fullscreen = not Settings.Fullscreen
    fullscreen_queued = true
end

local function ConstrainSliderPosition(slider)

    if slider[1] < 349 then
        slider[1] = 349
    elseif slider[1] > 349 + 349 then
        slider[1] = 349 + 349
    end

end
local function MoveSlider(slider)

    slider[1] = love.mouse.getX() - menu_x - SliderButton:getWidth()*.5
    ConstrainSliderPosition(slider)

end
local function ToggleGetText(control)

    GetText = true
    ControlToChange = control
    new_control = ""

end
Buttons.VideoMenuSwitch:SetCallback(ToggleCurrentMenuToVideo)
Buttons.SoundMenuSwitch:SetCallback(ToggleCurrentMenuToSound)
Buttons.ControlsMenuSwitch:SetCallback(ToggleCurrentMenuToControls)
Buttons.Check:SetCallback(ToggleCheckFullScreen)
Buttons.MasterVolumeSlider:SetCallback(function() MoveSlider(MasterVolumeSlider_r_x); CurrentSlider_r_x = MasterVolumeSlider_r_x; slider_moving = true end)
Buttons.MusicVolumeSlider:SetCallback(function() MoveSlider(MusicVolumeSlider_r_x); CurrentSlider_r_x = MusicVolumeSlider_r_x; slider_moving = true end )
Buttons.SoundEffectsSlider:SetCallback(function() MoveSlider(SoundEffectsSlider_r_x); CurrentSlider_r_x = SoundEffectsSlider_r_x; slider_moving = true end)
Buttons.BackButton:SetCallback(function() BackgroundVideo:pause(); love.event.push("startmenu"); end)

Buttons.UpButton:SetCallback(function() ToggleGetText("Up") end)
Buttons.DownButton:SetCallback(function() ToggleGetText("Down") end)
Buttons.RightButton:SetCallback(function() ToggleGetText("Right") end)
Buttons.LeftButton:SetCallback(function() ToggleGetText("Left") end)

local background_scale_x
local background_scale_y
local function DrawBackground()

    love.graphics.draw(BackgroundVideo, 0, 0, 0, background_scale_x, background_scale_y)

end

local function DrawVideoMenu()

    love.graphics.draw(VideoMenu, menu_x, menu_y)
    if Settings.Fullscreen then
        love.graphics.draw(CheckMark, menu_x+552.3, menu_y+176.4)
    end

end

local VolumeFont = love.graphics.newFont(14)
local function DrawVolumeText()

    love.graphics.push()
        love.graphics.setFont(VolumeFont)
        love.graphics.print({{0,0,0,1} ,Settings.MasterVolume*100}, menu_x + 349 + 400, Buttons.MasterVolumeSlider.y_pos)
        love.graphics.print({{0,0,0,1} ,Settings.MusicVolume*100}, menu_x + 349 + 400, Buttons.MusicVolumeSlider.y_pos)
        love.graphics.print({{0,0,0,1} ,Settings.SoundEffectsVolume*100}, menu_x + 349 + 400, Buttons.SoundEffectsSlider.y_pos)
    love.graphics.pop()

end

local function DrawSoundMenu()

    love.graphics.draw(SoundMenu, menu_x, menu_y)
    Buttons.MasterVolumeSlider:Draw()
    Buttons.MusicVolumeSlider:Draw()
    Buttons.SoundEffectsSlider:Draw()
    DrawVolumeText()

end

local BarTime   = .2
local NoBarTime = 0
local function BarHandle()

    BarTime = BarTime - love.timer.getDelta()
    if BarTime <= 0 then
        NoBarTime = 1
    end
    return "|"

end

local function NoBarHandle()

    NoBarTime = NoBarTime - love.timer.getDelta()
    if NoBarTime <= 0 then
        BarTime = .375
    end
    return ""

end

local function FlickerBar()

    if BarTime > 0 then
        return BarHandle()
    elseif NoBarTime > 0 then
        return NoBarHandle()
    end
    return ""

end

local function DrawCorrectControlText(control, ctrl_str, x, y)

    if ControlToChange == ctrl_str then
        love.graphics.print({{0,0,0,1}, new_control .. FlickerBar()}, x, y)
    else
        love.graphics.print({{0,0,0,1}, control}, x, y)
    end

end

local LargeFont = love.graphics.newFont(40)
local function DrawControlText()

    love.graphics.setFont(LargeFont)
    DrawCorrectControlText(Settings.Controls.UP, "Up", 431 + menu_x + 35, 148.4 + menu_y + 15)
    DrawCorrectControlText(Settings.Controls.DOWN, "Down", 431 + menu_x + 35, 243.6 + menu_y + 15)
    DrawCorrectControlText(Settings.Controls.LEFT, "Left", 431 + menu_x + 35, 339.2 + menu_y + 15)
    DrawCorrectControlText(Settings.Controls.RIGHT, "Right", 431 + menu_x + 35, 432.5 + menu_y + 15)

end

local MediumFont = love.graphics.newFont(30)
local function DrawPressEnterText()

    if not GetText then return end
    love.graphics.setFont(MediumFont)
    love.graphics.print("Press enter to set new key", 300 + menu_x, 525 + menu_y)

end

local function DrawControlsMenu()

    love.graphics.draw(ControlsMenu, menu_x, menu_y)
    DrawControlText()
    DrawPressEnterText()

end

local function DrawMenu()

    if CurrentMenu == MENUS.VIDEO then
        DrawVideoMenu()
    elseif CurrentMenu == MENUS.SOUND then
        DrawSoundMenu()
    elseif CurrentMenu == MENUS.CONTROLS then
        DrawControlsMenu()
    end

end

local function UpdateOffsetsControls()

    Buttons.UpButton.x_pos    = 431 + menu_x
    Buttons.UpButton.y_pos    = 148.4 + menu_y
    Buttons.DownButton.x_pos  = 431 + menu_x
    Buttons.DownButton.y_pos  = 243.6 + menu_y
    Buttons.LeftButton.x_pos  = 431 + menu_x
    Buttons.LeftButton.y_pos  = 339.2 + menu_y
    Buttons.RightButton.x_pos = 431 + menu_x
    Buttons.RightButton.y_pos = 432.5 + menu_y

end

local function UpdateOffsetsSliders()

    if did_not_update then
        MasterVolumeSlider_r_x[1] = 349 + Settings.MasterVolume*349
        MusicVolumeSlider_r_x[1]  = 349 + Settings.MusicVolume*349
        SoundEffectsSlider_r_x[1] = 349 + Settings.SoundEffectsVolume*349
        did_not_update = false
    end
    Buttons.MasterVolumeSlider.x_pos = menu_x + MasterVolumeSlider_r_x[1]
    Buttons.MasterVolumeSlider.y_pos = menu_y + 179.8
    Buttons.MusicVolumeSlider.x_pos  = menu_x + MusicVolumeSlider_r_x[1]
    Buttons.MusicVolumeSlider.y_pos  = menu_y + 288.9
    Buttons.SoundEffectsSlider.x_pos = menu_x + SoundEffectsSlider_r_x[1]
    Buttons.SoundEffectsSlider.y_pos = menu_y + 393

end

local function UpdateOffsetsButtons()

    Buttons.Check.x_pos = 553.3 + menu_x
    Buttons.Check.y_pos = 176.4 + menu_y
    Buttons.VideoMenuSwitch.x_pos = 10.5     + menu_x
    Buttons.VideoMenuSwitch.y_pos = 10.5     + menu_y
    Buttons.SoundMenuSwitch.x_pos = 221.5    + menu_x
    Buttons.SoundMenuSwitch.y_pos = 10.5     + menu_y
    Buttons.ControlsMenuSwitch.x_pos = 432.5 + menu_x
    Buttons.ControlsMenuSwitch.y_pos = 10.5  + menu_y

end

local function UpdateOffsets()

    background_scale_x = love.graphics.getWidth()/BackgroundVideo:getWidth()
    background_scale_y = love.graphics.getHeight()/BackgroundVideo:getHeight()
    menu_x = love.graphics.getWidth()*.5  - VideoMenu:getWidth()*.5
    menu_y = love.graphics.getHeight()*.5 - VideoMenu:getHeight()*.5
    UpdateOffsetsButtons()
    UpdateOffsetsSliders()
    UpdateOffsetsControls()

end

local function UpdateSliders()

    if slider_moving then
        CurrentSlider_r_x[1] = love.mouse.getX() - menu_x
        ConstrainSliderPosition(CurrentSlider_r_x)
        UpdateSettings()
    end

end

local function HandleInputVideo()

    Buttons.Check:HandleMouseClick()
    Buttons.SoundMenuSwitch:HandleMouseClick()
    Buttons.ControlsMenuSwitch:HandleMouseClick()

end

local function HandleInputSound()

    if slider_moving then return end
    Buttons.VideoMenuSwitch:HandleMouseClick()
    Buttons.ControlsMenuSwitch:HandleMouseClick()
    Buttons.MasterVolumeSlider:HandleMouseClick()
    Buttons.MusicVolumeSlider:HandleMouseClick()
    Buttons.SoundEffectsSlider:HandleMouseClick()

end

local function HandleInputControls()

    Buttons.SoundMenuSwitch:HandleMouseClick()
    Buttons.VideoMenuSwitch:HandleMouseClick()
    Buttons.UpButton:HandleMouseClick()
    Buttons.DownButton:HandleMouseClick()
    Buttons.LeftButton:HandleMouseClick()
    Buttons.RightButton:HandleMouseClick()

end

local function HandleInputOfAppropriateButtons()

    Buttons.BackButton:HandleMouseClick()
    if CurrentMenu == MENUS.VIDEO then
        HandleInputVideo()
    elseif CurrentMenu == MENUS.SOUND then
        HandleInputSound()
    elseif CurrentMenu == MENUS.CONTROLS then
        HandleInputControls()
    end

end


local function UpdateBackgroundVideo()

    if not BackgroundVideo:isPlaying() then
        BackgroundVideo:rewind()
        BackgroundVideo:play()
    end

end

local StartMenuMusic = nil
local function UpdateStartMenuSounds()

    if StartMenuMusic == nil then
        StartMenuMusic = getSoundFromCache("sound/startmenu/sadpiano.mp3")
    end
    StartMenuMusic:setVolume(Settings.MasterVolume * Settings.MusicVolume)

end

function Options_Draw()

    DrawBackground()
    DrawMenu()
    Buttons.BackButton:Draw()

end

function Options_Update()

    UpdateOffsets()
    UpdateSliders()
    UpdateStartMenuSounds()
    UpdateBackgroundVideo()

end

function Options_HandleInput()

    HandleInputOfAppropriateButtons()

end