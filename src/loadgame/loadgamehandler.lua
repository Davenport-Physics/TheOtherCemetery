local ButtonClass = require("src/button/button")

local LoadGameBackground = love.graphics.newImage("tiles/autumn-platformer-tileset/png/elements/background.png")
local LoadGameGui        = love.graphics.newImage("pics/loadgame/LoadGame.png")

local LoadGameBackground_sx = love.graphics.getWidth()/LoadGameBackground:getWidth()
local LoadGameBackground_sy = love.graphics.getHeight()/LoadGameBackground:getHeight()

local LoadGameGui_x_pos = 0
local LoadGameGui_y_pos = 0

local BackButton  = ButtonClass:newImage("pics/share/buttons/backbutton.png", 10, 10, .2, .2)
BackButton:SetSoundWhenClicked("sound/startmenu/click/click.ogg")

local function DrawBackButton()

    BackButton:Draw()

end

local function HandleBackgroundDrawing()

    love.graphics.draw(LoadGameBackground, 0, 0, 0, LoadGameBackground_sx, LoadGameBackground_sy)

end

local function HandleLoadGuiDrawing()

    LoadGameGui_x_pos = love.graphics.getWidth()*.5 - LoadGameGui:getWidth()*.5
    LoadGameGui_y_pos = love.graphics.getHeight()*.5 - LoadGameGui:getHeight()*.5
    love.graphics.draw(LoadGameGui, LoadGameGui_x_pos, LoadGameGui_y_pos)

end

function LoadGameHandler_Draw()

    HandleBackgroundDrawing()
    HandleLoadGuiDrawing()
    DrawBackButton()

end

function LoadGameHandler_Update()

    LoadGameBackground_sx = love.graphics.getWidth()/LoadGameBackground:getWidth()
    LoadGameBackground_sy = love.graphics.getHeight()/LoadGameBackground:getHeight()

end

function LoadGameHandler_Input()

    BackButton:HandleMouseClick()

end

function InitializeLoadGame_CallBackFunctions(InStartMenu)

    BackButton:SetCallback(InStartMenu)

end