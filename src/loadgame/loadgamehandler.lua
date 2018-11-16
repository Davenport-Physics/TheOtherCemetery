require("src/shared/cache")
local Saves       = require("src/save/saving")
local ButtonClass = require("src/button/button")

local BackgroundVideo    = love.graphics.newVideo("video/menus/NewLoadMenu.ogv")
local LoadGameBackground = getImageFromCache("tiles/autumn-platformer-tileset/png/elements/background.png")
local LoadGameGui        = getImageFromCache("pics/loadgame/LoadGame-2.png")

local Background_sx = love.graphics.getWidth()/BackgroundVideo:getWidth()
local Background_sy = love.graphics.getHeight()/BackgroundVideo:getHeight()

local LoadGameGui_x_pos = 0
local LoadGameGui_y_pos = 0

local PartialSaveData = nil

local BackButton  = ButtonClass:newImage("pics/share/buttons/backbutton.png", 10, 10, .2, .2)
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

local GameHandlerCallback = nil

local function SaveGameButtonsCallback(save_idx)

    print(PartialSaveData[save_idx].SaveName)
    if PartialSaveData[save_idx].SaveName == "empty" then
        print("Save to load does not exist STUB: SaveGameButtonsCallback")
        return
    end
    print(PartialSaveData[save_idx].File)
    LoadSaveData(PartialSaveData[save_idx].File)
    GameHandlerCallback()

end

SaveGameButtons[1]:SetCallback(function() SaveGameButtonsCallback(1) end)
SaveGameButtons[2]:SetCallback(function() SaveGameButtonsCallback(2) end)
SaveGameButtons[3]:SetCallback(function() SaveGameButtonsCallback(3) end)


local Font                  = love.graphics.newFont(30)
local NextTimeForMouseClick = love.timer.getTime() + .05

local function DrawBackButton()

    BackButton:Draw()

end

local function HandleBackgroundDrawing()

    love.graphics.draw(BackgroundVideo, 0, 0, 0, Background_sx, Background_sx)

end

local function HandleLoadGuiDrawing()

    love.graphics.draw(LoadGameGui, LoadGameGui_x_pos, LoadGameGui_y_pos)

end

local function HandlePartialSaveDrawing()

    local PlayTime
    local playtime_string
    for i = 1, 3 do
        PlayTime        = PartialSaveData[i].PlayTime
        playtime_string = table.concat({"Play time: ", PlayTime.hours, ":", PlayTime.minutes, ":", tonumber(string.format("%.f",PlayTime.seconds))})
        love.graphics.print("Save file: " .. PartialSaveData[i].SaveName, LoadGameGui_x_pos + 50, LoadGameGui_y_pos + 140 * (i))
        love.graphics.print(playtime_string, LoadGameGui_x_pos + 400, LoadGameGui_y_pos + 140 * (i))
    end
    
end

function LoadGameHandler_Draw()

    love.graphics.setFont(Font)
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

local function UpdateBackgroundVideo()

    if not BackgroundVideo:isPlaying() then

        BackgroundVideo:rewind()
        BackgroundVideo:play()

    end

end

function LoadGameHandler_Update()

    LoadGameGui_x_pos = love.graphics.getWidth()*.5  - LoadGameGui:getWidth()*.5
    LoadGameGui_y_pos = love.graphics.getHeight()*.5 - LoadGameGui:getHeight()*.5
    Background_sx     = love.graphics.getWidth()/BackgroundVideo:getWidth()
    Background_sy     = love.graphics.getHeight()/BackgroundVideo:getHeight()
    UpdateSaveButtonPositions()
    UpdateBackgroundVideo()

end

function LoadGameHandler_Input()

    -- TODO ADD DELAY FOR MOUSE CLICK HANDLING
    BackButton:HandleMouseClick()
    if love.timer.getTime() >= NextTimeForMouseClick then
        for i = 1, 3 do
            SaveGameButtons[i]:HandleMouseClick()
        end
        NextTimeForMouseClick = love.timer.getTime() + .05
    end

end

function InitializeLoadGame_CallBackFunctions(InStartMenu, game)

    BackButton:SetCallback(function() BackgroundVideo:pause(); InStartMenu(); end)
    GameHandlerCallback = function()  BackgroundVideo:pause(); game(); end

end

function ResetLoadGame()

    NextTimeForMouseClick = love.timer.getTime() + .1
    PartialSaveData = GetPartialDataFromSaves()

end