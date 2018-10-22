local Saves       = require("src/save/saving")
local ButtonClass = require("src/button/button")

local LoadGameBackground = love.graphics.newImage("tiles/autumn-platformer-tileset/png/elements/background.png")
local LoadGameGui        = love.graphics.newImage("pics/loadgame/LoadGame.png")

local LoadGameBackground_sx = love.graphics.getWidth()/LoadGameBackground:getWidth()
local LoadGameBackground_sy = love.graphics.getHeight()/LoadGameBackground:getHeight()

local LoadGameGui_x_pos = 0
local LoadGameGui_y_pos = 0

local PartialSaveData = nil

local BackButton  = ButtonClass:newImage("pics/share/buttons/backbutton.png", 10, 10, .2, .2)
BackButton:SetSoundWhenClicked("sound/startmenu/click/click.ogg")

local SaveGameButtons =
{
    ButtonClass:newWithoutImage(0, 0, 1, 1, 750, 125),
    ButtonClass:newWithoutImage(0, 0, 1, 1, 750, 125),
    ButtonClass:newWithoutImage(0, 0, 1, 1, 750, 125)
}
SaveGameButtons[1]:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
SaveGameButtons[2]:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
SaveGameButtons[3]:SetSoundWhenClicked("sound/startmenu/click/click.ogg")

local function DrawBackButton()

    BackButton:Draw()

end

local function HandleBackgroundDrawing()

    love.graphics.draw(LoadGameBackground, 0, 0, 0, LoadGameBackground_sx, LoadGameBackground_sy)

end

local function HandleLoadGuiDrawing()

    love.graphics.draw(LoadGameGui, LoadGameGui_x_pos, LoadGameGui_y_pos)

end

local function HandlePartialSaveDrawing()

    for i = 1, 3 do
        love.graphics.print("Save file: " .. PartialSaveData[i].SaveName, LoadGameGui_x_pos + 50, LoadGameGui_y_pos + 160 * (i) - 20 *(i - 1))
        love.graphics.print("Play time: " .. PartialSaveData[i].PlayTime, LoadGameGui_x_pos + 400, LoadGameGui_y_pos + 160 * (i) - 20 *(i - 1))
    end

end

function LoadGameHandler_Draw()

    HandleBackgroundDrawing()
    HandleLoadGuiDrawing()
    DrawBackButton()
    HandlePartialSaveDrawing()

end

local SaveGameButtonsx_pos = 0
local function UpdateSaveButtonPositions()

    SaveGameButtonsx_pos     = LoadGameGui_x_pos + 24
    SaveGameButtons[1].x_pos = SaveGameButtonsx_pos
    SaveGameButtons[2].x_pos = SaveGameButtonsx_pos
    SaveGameButtons[3].x_pos = SaveGameButtonsx_pos

    SaveGameButtons[1].y_pos = LoadGameGui_y_pos + 120
    SaveGameButtons[2].y_pos = LoadGameGui_y_pos + 257
    SaveGameButtons[3].y_pos = LoadGameGui_y_pos + 402

end

function LoadGameHandler_Update()

    LoadGameGui_x_pos     = love.graphics.getWidth()*.5 - LoadGameGui:getWidth()*.5
    LoadGameGui_y_pos     = love.graphics.getHeight()*.5 - LoadGameGui:getHeight()*.5
    LoadGameBackground_sx = love.graphics.getWidth()/LoadGameBackground:getWidth()
    LoadGameBackground_sy = love.graphics.getHeight()/LoadGameBackground:getHeight()
    UpdateSaveButtonPositions()

end

function LoadGameHandler_Input()

    BackButton:HandleMouseClick()
    for i = 1, 3 do
        SaveGameButtons[i]:HandleMouseClick()
    end

end

function InitializeLoadGame_CallBackFunctions(InStartMenu)

    BackButton:SetCallback(InStartMenu)

end

function InitializePartialSaveDataForLoadGame()

    PartialSaveData = GetPartialDataFromSaves()

end