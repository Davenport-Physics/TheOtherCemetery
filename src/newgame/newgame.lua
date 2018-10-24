
local utf8 = require("utf8")

local DataToSave  = require("src/save/savingdata")
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
local WriteTextIdx  = nil

local Font = love.graphics.newFont(30)
local NextTimeForMouseClick = love.timer.getTime() + .15

local GameHandlerCallback = nil

local function SaveGameButtonsCallback(save_idx)

    if PartialSaveData[save_idx].SaveName ~= "empty" then
        print("Save to New does not exist STUB: SaveGameButtonsCallback")
        return
    end
    DrawWriteText = true
    WriteTextIdx  = save_idx
    DataToSave.SaveName = ""

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

    local SaveName = ""
    local PlayTime = ""
    for i = 1, 3 do
        if DrawWriteText and WriteTextIdx == i then
            SaveName = DataToSave.SaveName
            PlayTime = 0
        else
            SaveName = PartialSaveData[i].SaveName
            PlayTime = PartialSaveData[i].PlayTime
        end
        love.graphics.print("Save file: " .. SaveName, NewGameGui_x_pos + 50, NewGameGui_y_pos + 160 * (i) - 20 *(i - 1))
        love.graphics.print("Play time: " .. PlayTime, NewGameGui_x_pos + 400, NewGameGui_y_pos + 160 * (i) - 20 *(i - 1))
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


function love.textinput(t)

    if not DrawWriteText then return end
    if #DataToSave.SaveName >= 10 then return end
    DataToSave.SaveName = DataToSave.SaveName .. t

end

function love.keypressed(key)

    if not DrawWriteText then return end
    if key == "backspace" then
        local byteoffset = utf8.offset(DataToSave.SaveName, -1)
        if byteoffset then
            DataToSave.SaveName = string.sub(DataToSave.SaveName, 1, byteoffset - 1)
        end
    end
    if key == "return" then

        GameHandlerCallback()

    end

end

function NewGameHandler_Input()

    BackButton:HandleMouseClick()
    if love.timer.getTime() > NextTimeForMouseClick then
        for i = 1, 3 do
            SaveGameButtons[i]:HandleMouseClick()
        end
        NextTimeForMouseClick = love.timer.getTime() + .15
    end

end

function InitializeNewGame_CallBackFunctions(InStartMenu, GameHandle)

    BackButton:SetCallback(InStartMenu)
    GameHandlerCallback = GameHandle

end

function ResetNewGame()

    DrawWriteText = false
    PartialSaveData = GetPartialDataFromSaves()
    NextTimeForMouseClick = love.timer.getTime() + .15

end