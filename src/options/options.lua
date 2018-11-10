require("src/shared/cache")
local Settings    = require("src/settings/settings")
local ButtonClass = require("src/button/button")

local Background   = getImageFromCache("tiles/autumn-platformer-tileset/png/elements/background.png")
local VideoMenu    = getImageFromCache("pics/options/Video.png")
local SoundMenu    = getImageFromCache("pics/options/Sound.png")
local ControlsMenu = getImageFromCache("pics/options/Controls.png")
local CheckMark    = getImageFromCache("pics/options/checkmark.png")
local SliderButton = getImageFromCache("pics/options/sliderbutton.png")

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

local MasterVolumeSlider_r_x = {349 + Settings.MasterVolume*368}
local MusicVolumeSlider_r_x  = {349 + Settings.MusicVolume*368}
local SoundEffectsSlider_r_x = {349 + Settings.SoundEffectsVolume*368}
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

    Settings.MasterVolume = math.min(1, tonumber(string.format("%.2f", 2*(MasterVolumeSlider_r_x[1]-349)/(349+368))))
    Settings.MusicVolume  = math.min(1, tonumber(string.format("%.2f", 2*(MusicVolumeSlider_r_x[1]-349)/(349+368))))
    Settings.SoundEffectsVolume = math.min(1, tonumber(string.format("%.2f", 2*(SoundEffectsSlider_r_x[1]-349)/(349+368))))

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

function love.keypressed(key, scancode, isrepeat)

    if key ~= "return" then return end
    if not GetText then return end
    GetText = false

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
    elseif slider[1] > 349 + 368 then
        slider[1] = 349 + 368
    end

end
local function MoveSlider(slider)

    slider[1] = love.mouse.getX() - menu_x - SliderButton:getWidth()*.5
    ConstrainSliderPosition(slider)

end
local function ToggleGetText(control)

    GetText = true
    ControlToChange = control

end
Buttons.VideoMenuSwitch:SetCallback(ToggleCurrentMenuToVideo)
Buttons.SoundMenuSwitch:SetCallback(ToggleCurrentMenuToSound)
Buttons.ControlsMenuSwitch:SetCallback(ToggleCurrentMenuToControls)
Buttons.Check:SetCallback(ToggleCheckFullScreen)
Buttons.MasterVolumeSlider:SetCallback(function() MoveSlider(MasterVolumeSlider_r_x); CurrentSlider_r_x = MasterVolumeSlider_r_x; slider_moving = true end)
Buttons.MusicVolumeSlider:SetCallback(function() MoveSlider(MusicVolumeSlider_r_x); CurrentSlider_r_x = MusicVolumeSlider_r_x; slider_moving = true end )
Buttons.SoundEffectsSlider:SetCallback(function() MoveSlider(SoundEffectsSlider_r_x); CurrentSlider_r_x = SoundEffectsSlider_r_x; slider_moving = true end)
Buttons.BackButton:SetCallback(function() love.event.push("startmenu") end)

Buttons.UpButton:SetCallback(function() ToggleGetText("Up") end)
Buttons.DownButton:SetCallback(function() ToggleGetText("Down") end)
Buttons.RightButton:SetCallback(function() ToggleGetText("Right") end)
Buttons.LeftButton:SetCallback(function() ToggleGetText("Left") end)

local background_scale_x
local background_scale_y
local function DrawBackground()

    love.graphics.draw(Background, 0, 0, 0, background_scale_x, background_scale_y)

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

local LargeFont = love.graphics.newFont(40)
local function DrawControlText()

    love.graphics.push()
        love.graphics.setFont(LargeFont)
        love.graphics.print({{0,0,0,1}, Settings.Controls.UP}, 431 + menu_x + 35, 148.4 + menu_y + 15)
        love.graphics.print({{0,0,0,1}, Settings.Controls.DOWN}, 431 + menu_x + 35, 243.6 + menu_y + 15)
        love.graphics.print({{0,0,0,1}, Settings.Controls.LEFT}, 431 + menu_x + 35, 339.2 + menu_y + 15)
        love.graphics.print({{0,0,0,1}, Settings.Controls.RIGHT}, 431 + menu_x + 35, 432.5 + menu_y + 15)
    love.graphics.pop()

end

local MediumFont = love.graphics.newFont(30)
local function DrawPressEnterText()

    if not GetText then return end
    love.graphics.push()
        love.graphics.setFont(MediumFont)
        love.graphics.print("Press enter to set new key", 300 + menu_x, 525 + menu_y)
    love.graphics.pop()

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
        MasterVolumeSlider_r_x[1] = 349 + Settings.MasterVolume*368
        MusicVolumeSlider_r_x[1]  = 349 + Settings.MusicVolume*368
        SoundEffectsSlider_r_x[1] = 349 + Settings.SoundEffectsVolume*368
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

    background_scale_x = love.graphics.getWidth()/Background:getWidth()
    background_scale_y = love.graphics.getHeight()/love.graphics.getHeight()
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

function Options_Draw()

    DrawBackground()
    DrawMenu()
    Buttons.BackButton:Draw()

end

function Options_Update()

    UpdateOffsets()
    UpdateSliders()

end

function Options_HandleInput()

    HandleInputOfAppropriateButtons()

end