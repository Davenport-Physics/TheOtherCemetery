require("src/shared/cache")
local utf8 = require("utf8")

local DataToSave  = require("src/save/savingdata")
local Saves       = require("src/save/saving")
local ButtonClass = require("src/button/button")

local BackgroundVideo_s_x = 1
local BackgroundVideo_s_y = 1
local BackgroundVideo     = love.graphics.newVideo("video/menus/NewLoadMenu.ogv")
local NewGameGui          = getImageFromCache("pics/newgame/newgame-2.png")


local NewGameGui_x_pos = 0
local NewGameGui_y_pos = 0

local PartialSaveData = nil

local BackButton  = ButtonClass:newImage("pics/share/buttons/backbutton.png", 10, 10, .3, .3)
BackButton:SetSoundWhenClicked("sound/startmenu/click/click.ogg")

local SaveGameButtons =
{
    ButtonClass:newWithoutImage(-10000, -10000, 750, 125),
    ButtonClass:newWithoutImage(-10000, -10000, 750, 125),
    ButtonClass:newWithoutImage(-10000, -10000, 750, 125)
}
SaveGameButtons[1]:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
SaveGameButtons[2]:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
SaveGameButtons[3]:SetSoundWhenClicked("sound/startmenu/click/click.ogg")


local YesOverwrite  = ButtonClass:newWithoutImage(-10000, -10000, 192, 84)
local NoOverwrite   = ButtonClass:newWithoutImage(-10000, -10000, 192, 84)
YesOverwrite:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
NoOverwrite:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
local OverWrite     = getImageFromCache("pics/overwrite/overwrite.png")
local DrawOverWrite = false

local WriteText     = "Press enter to start"
local DrawWriteText = false
local WriteTextIdx  = nil

local Font                  = love.graphics.newFont(30)
local NextTimeForMouseClick = love.timer.getTime() + .05

local GameHandlerCallback = nil
local current_save_idx    = nil

local function YesOverwriteCallBack()

    DrawOverWrite = false
    DrawWriteText = true
    WriteTextIdx  = current_save_idx
    DataToSave.SaveName = ""
    DataToSave.File = "save" .. current_save_idx

end

local function NoOverwriteCallBack()

    DrawOverWrite = false

end

YesOverwrite:SetCallback(YesOverwriteCallBack)
NoOverwrite:SetCallback(NoOverwriteCallBack)

local function SaveGameButtonsCallback(save_idx)

    current_save_idx = save_idx
    if PartialSaveData[save_idx].SaveName ~= "empty" then
        DrawOverWrite = true
        return
    end
    DrawWriteText = true
    WriteTextIdx  = save_idx
    DataToSave.SaveName = ""
    DataToSave.File  = "save" .. save_idx .. ".lua"

end

SaveGameButtons[1]:SetCallback(function() SaveGameButtonsCallback(1) end)
SaveGameButtons[2]:SetCallback(function() SaveGameButtonsCallback(2) end)
SaveGameButtons[3]:SetCallback(function() SaveGameButtonsCallback(3) end)

local function DrawBackButton()

    BackButton:Draw()

end

local function HandleBackgroundDrawing()

    love.graphics.draw(BackgroundVideo, 0, 0, 0, BackgroundVideo_s_x, BackgroundVideo_s_y)

end

local function HandleNewGuiDrawing()

    love.graphics.draw(NewGameGui, NewGameGui_x_pos, NewGameGui_y_pos)

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

local function HandlePartialSaveDrawing()

    local SaveName
    local PlayTime
    for i = 1, 3 do
        if DrawWriteText and WriteTextIdx == i then
            SaveName = DataToSave.SaveName .. FlickerBar()
            PlayTime = {hours = 0, minutes = 0, seconds = 0}
        else
            SaveName = PartialSaveData[i].SaveName
            PlayTime = PartialSaveData[i].PlayTime
        end
        local playtime_string = table.concat({"Play time: ", PlayTime.hours, ":", PlayTime.minutes, ":", tonumber(string.format("%.f",PlayTime.seconds))})
        love.graphics.print("Save file: " .. SaveName, NewGameGui_x_pos + 50, NewGameGui_y_pos + 140 * (i))
        love.graphics.print(playtime_string, NewGameGui_x_pos + 400, NewGameGui_y_pos + 140 * (i))
    end

end

local function HandleWriteDrawing()
    if DrawWriteText then
        love.graphics.print(WriteText, NewGameGui_x_pos + NewGameGui:getWidth()*.5, NewGameGui_y_pos + NewGameGui:getHeight())
    end
end

local function HandleOverWriteDrawing()

    if not DrawOverWrite then return end
    local t_width  = NewGameGui_x_pos + NewGameGui:getWidth()*.5 - OverWrite:getWidth()*.5
    local t_height = NewGameGui_y_pos + NewGameGui:getHeight()*.5 - OverWrite:getHeight()*.5
    love.graphics.draw(OverWrite, t_width, t_height)

end

function NewGameHandler_Draw()

    love.graphics.setFont(Font)
    HandleBackgroundDrawing()
    HandleNewGuiDrawing()
    DrawBackButton()
    HandlePartialSaveDrawing()
    HandleWriteDrawing()
    HandleOverWriteDrawing()

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

local function UpdateOverWriteButtons()

    if not DrawOverWrite then return end
    local t_x = NewGameGui_x_pos + NewGameGui:getWidth()*.5  - OverWrite:getWidth()*.5 + 4
    local t_y = NewGameGui_y_pos + NewGameGui:getHeight()*.5 - OverWrite:getHeight()*.5 + 56

    YesOverwrite.x_pos = t_x
    YesOverwrite.y_pos = t_y
    NoOverwrite.x_pos  = t_x + 198
    NoOverwrite.y_pos  = t_y

end

local function UpdateBackgroundVideo()

    if not BackgroundVideo:isPlaying() then
        BackgroundVideo:rewind()
        BackgroundVideo:play()
    end
    BackgroundVideo_s_x = love.graphics.getWidth()/BackgroundVideo:getWidth()
    BackgroundVideo_s_y = love.graphics.getHeight()/BackgroundVideo:getHeight()

end

function NewGameHandler_Update()

    NewGameGui_x_pos     = love.graphics.getWidth()*.5  - NewGameGui:getWidth()*.5
    NewGameGui_y_pos     = love.graphics.getHeight()*.5 - NewGameGui:getHeight()*.5
    UpdateSaveButtonPositions()
    UpdateOverWriteButtons()
    UpdateBackgroundVideo()

end


function NewGame_textinput(t)

    if not DrawWriteText then return end
    if #DataToSave.SaveName >= 10 then return end
    DataToSave.SaveName = DataToSave.SaveName .. t

end

local function HandleReturnKeyPressed()

    StoreSaveData("save" .. WriteTextIdx .. ".lua")
    DrawWriteText = false
    local temp_name = DataToSave.SaveName
    DataToSave.ResetValues()
    DataToSave.SaveName = temp_name
    DataToSave.File = "save" .. WriteTextIdx .. ".lua"
    GameHandlerCallback()

end

function NewGame_keypressed(key)

    if not DrawWriteText then return end
    if key == "backspace" then
        local byteoffset = utf8.offset(DataToSave.SaveName, -1)
        if byteoffset then
            DataToSave.SaveName = string.sub(DataToSave.SaveName, 1, byteoffset - 1)
        end
    end
    if key == "return" then
        HandleReturnKeyPressed()
    end

end

local function HandleOverwriteInput()

    YesOverwrite:HandleMouseClick()
    NoOverwrite:HandleMouseClick()

end

function NewGameHandler_Input()

    BackButton:HandleMouseClick()
    if not DrawOverWrite and love.timer.getTime() > NextTimeForMouseClick then
        for i = 1, 3 do
            SaveGameButtons[i]:HandleMouseClick()
        end
        NextTimeForMouseClick = love.timer.getTime() + .05
    end
    if DrawOverWrite then
        NextTimeForMouseClick = love.timer.getTime() + 1
        HandleOverwriteInput()
    end

end

function InitializeNewGame_CallBackFunctions(InStartMenu, GameHandle)

    BackButton:SetCallback(function() BackgroundVideo:pause(); InStartMenu() end)
    GameHandlerCallback = function() BackgroundVideo:pause(); GameHandle() end

end

function ResetNewGame()

    DrawWriteText    = false
    PartialSaveData  = GetPartialDataFromSaves()
    NextTimeForMouseClick = love.timer.getTime() + 1
    DrawOverWrite    = false
    DrawWriteText    = false
    WriteTextIdx     = nil
    NewGameGui_x_pos = 0
    NewGameGui_y_pos = 0
    BackgroundVideo:rewind()
    BackgroundVideo:play()

end