require("src/shared/cache")

local Background   = getImageFromCache("tiles/autumn-platformer-tileset/png/elements/background.png")
local VideoMenu    = getImageFromCache("options/Video.png")
local SoundMenu    = getImageFromCache("options/Sound.png")
local ControlsMenu = getImageFromCache("options/Controls.png")
local CheckMark    = getImageFromCache("options/checkmark.png")
local SliderButton = getImageFromCache("options/sliderbutton.png")

local Sliders =
{
    MasterVolume = 1,
    MusicVolume  = .5,
    SoundEffects = .5
}

local MENUS =
{
    VIDEO = 1,
    SOUND = 2,
    CONTROLS = 3
}

local CurrentMenu = MENUS.VIDEO

local background_scale_x
local background_scale_y
local function DrawBackground()

    background_scale_x = love.graphics.getWidth()/Background:getWidth()
    background_scale_y = love.graphics.getHeight()/love.graphics.getHeight()
    love.graphics.draw(Background, 0, 0, 0, background_scale_x, background_scale_y)

end

local menu_x
local menu_y
local function DrawMenu()

    menu_x = love.graphics.getWidth()*.5  - VideoMenu:getWidth()*.5
    menu_y = love.graphics.getHeight()*.5 - VideoMenu:getHeight()*.5
    if CurrentMenu == MENUS.VIDEO then
        love.graphics.draw(VideoMenu, menu_x, menu_y)
    elseif CurrentMenu == MENUS.SOUND then
        love.graphics.draw(SoundMenu, menu_x, menu_y)
    elseif CurrentMenu == MENUS.CONTROLS then
        love.graphics.draw(ControlsMenu, menu_x, menu_y)
    end

end

function Options_Draw()

    DrawBackground()
    DrawMenu()

end

function Options_Update()

end

function Options_HandleInput()

end