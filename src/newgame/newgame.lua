
local utf8 = require("utf8")
local Game = require("src/gamehandler/gamehandler")
Game.InitializeGameHandler()

local Saves       = require("src/save/saving")
local ButtonClass = require("src/button/button")

local NewGameBackground = love.graphics.newImage("tiles/autumn-platformer-tileset/png/elements/background.png")
local NewGameGui        = love.graphics.newImage("pics/newgame/newgame.png")

local NewGameBackground_sx = love.graphics.getWidth()/NewGameBackground:getWidth()
local NewGameBackground_sy = love.graphics.getHeight()/NewGameBackground:getHeight()

local NewGameGui_x_pos = 0
local NewGameGui_y_pos = 0

local PartialSaveData = nil

local BackButton  = ButtonClass:newImage("pics/share/buttons/backbutton.png", 10, 10, .2, .2)
BackButton:SetSoundWhenClicked("sound/startmenu/click/click.ogg")

local SaveGameButtons =
{
    ButtonClass:newWithoutImage(-10000, -10000, 1, 1, 750, 125),
    ButtonClass:newWithoutImage(-10000, -10000, 1, 1, 750, 125),
    ButtonClass:newWithoutImage(-10000, -10000, 1, 1, 750, 125)
}
SaveGameButtons[1]:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
SaveGameButtons[2]:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
SaveGameButtons[3]:SetSoundWhenClicked("sound/startmenu/click/click.ogg")

local WriteText     = "Press enter to start"
local DrawWriteText = false

local Font = love.graphics.newFont(30)

local function SaveGameButtonsCallback(save_idx)

    if PartialSaveData[save_idx].SaveName ~= "empty" then
        print("Save to New does not exist STUB: SaveGameButtonsCallback")
        return
    end
    DrawWriteText = true

end

SaveGameButtons[1]:SetCallback(function() SaveGameButtonsCallback(1) end)
SaveGameButtons[2]:SetCallback(function() SaveGameButtonsCallback(2) end)
SaveGameButtons[3]:SetCallback(function() SaveGameButtonsCallback(3) end)

local function DrawBackButton()

    BackButton:Draw()

end

local function HandleBackgroundDrawing()

    love.graphics.draw(NewGameBackground, 0, 0, 0, NewGameBackground_sx, NewGameBackground_sy)

end

local function HandleNewGuiDrawing()

    love.graphics.draw(NewGameGui, NewGameGui_x_pos, NewGameGui_y_pos)

end

local function HandlePartialSaveDrawing()

    for i = 1, 3 do
        love.graphics.print("Save file: " .. PartialSaveData[i].SaveName, NewGameGui_x_pos + 50, NewGameGui_y_pos + 160 * (i) - 20 *(i - 1))
        love.graphics.print("Play time: " .. PartialSaveData[i].PlayTime, NewGameGui_x_pos + 400, NewGameGui_y_pos + 160 * (i) - 20 *(i - 1))
    end

end

local function HandleWriteDrawing()
    if DrawWriteText then
        love.graphics.print(WriteText, NewGameGui_x_pos + NewGameGui:getWidth()*.5, NewGameGui_y_pos + NewGameGui:getHeight() - 60)
    end
end

function NewGameHandler_Draw()

    love.graphics.setFont(Font)
    HandleBackgroundDrawing()
    HandleNewGuiDrawing()
    DrawBackButton()
    HandlePartialSaveDrawing()
    HandleWriteDrawing()

end

local SaveGameButtonsx_pos = 0
local function UpdateSaveButtonPositions()

    SaveGameButtonsx_pos     = NewGameGui_x_pos + 24
    SaveGameButtons[1].x_pos = SaveGameButtonsx_pos
    SaveGameButtons[2].x_pos = SaveGameButtonsx_pos
    SaveGameButtons[3].x_pos = SaveGameButtonsx_pos

    SaveGameButtons[1].y_pos = NewGameGui_y_pos + 120
    SaveGameButtons[2].y_pos = NewGameGui_y_pos + 257
    SaveGameButtons[3].y_pos = NewGameGui_y_pos + 402

end

function NewGameHandler_Update()

    NewGameGui_x_pos     = love.graphics.getWidth()*.5  - NewGameGui:getWidth()*.5
    NewGameGui_y_pos     = love.graphics.getHeight()*.5 - NewGameGui:getHeight()*.5
    NewGameBackground_sx = love.graphics.getWidth()/NewGameBackground:getWidth()
    NewGameBackground_sy = love.graphics.getHeight()/NewGameBackground:getHeight()
    UpdateSaveButtonPositions()

end

function NewGameHandler_Input()

    -- TODO ADD DELAY FOR MOUSE CLICK HANDLING
    BackButton:HandleMouseClick()
    for i = 1, 3 do
        SaveGameButtons[i]:HandleMouseClick()
    end

end

function InitializeNewGame_CallBackFunctions(InStartMenu)

    BackButton:SetCallback(InStartMenu)

end

function InitializePartialSaveDataForNewGame()

    PartialSaveData = GetPartialDataFromSaves()

end

function SetWriteTextToFalse()
    DrawWriteText = false
end