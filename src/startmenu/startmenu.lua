
local StartMenuSound = love.audio.newSource("sound/startmenu/startmenu_slow.mp3", "static")
local StartMenuClick = love.audio.newSource("sound/startmenu/click/click.ogg", "static")

function StartMenuMusic_Start()
    love.audio.play(StartMenuSound)
end

function StartMenuMusic_Stop()
    love.audio.stop(StartMenuSound)
end

local StartNewGame_CallBack
local LoadGame_CallBack
local Credits_CallBack
function InitializeStartMenu_CallBackFunctions(StartNewGame, LoadGame, Credits)

    StartNewGame_CallBack = StartNewGame
    LoadGame_CallBack     = LoadGame
    Credits_CallBack      = Credits

end

local function HandleMenuClickSound()
    love.audio.play(StartMenuClick)
    love.timer.sleep(.5)
    love.audio.stop(StartMenuClick)
end

local ButtonClass = require("src/button/button")
local Buttons = 
{

    NewGame  = ButtonClass:newImage("pics/startmenu/newgame.png", 75, 450, .3, .3),
    LoadGame = ButtonClass:newImage("pics/startmenu/loadgame.png", 275, 450, .3, .3),
    Credits  = ButtonClass:newImage("pics/startmenu/credits.png", 475, 450, .3, .3)

}

local function HandleInput_StartingWindow_MouseDown_NewGame()

    if Buttons.NewGame:CheckMouseClick() then
        HandleMenuClickSound()
        StartNewGame_CallBack()
    end

end

local function HandleInput_StartingWindow_MouseDown_LoadGame()

    if Buttons.LoadGame:CheckMouseClick() then
        HandleMenuClickSound()
        LoadGame_CallBack()
    end

end

local function HandleInput_StartingWindow_MouseDown_Credits()

    if Buttons.Credits:CheckMouseClick() then
        HandleMenuClickSound()
        Credits_CallBack()
    end

end

local function HandleInput_StartingWindow_MouseDown()

    HandleInput_StartingWindow_MouseDown_NewGame()
    HandleInput_StartingWindow_MouseDown_LoadGame()
    HandleInput_StartingWindow_MouseDown_Credits()

end

function HandleInput_StartingWindow()

    if love.mouse.isDown(1) then
        HandleInput_StartingWindow_MouseDown()
    end

end


local StartingWindowText =
{

    Name     = love.graphics.newText(love.graphics.newFont(65), "Prototype"),
    MadeWith = love.graphics.newText(love.graphics.newFont(15), "A game made with Love")

}

local StartingWindowPics  =
{
    BackGround = love.graphics.newImage("tiles/autumn-platformer-tileset/png/elements/background.png"),
}

function DrawStartingWindow()

    love.graphics.draw(StartingWindowPics.BackGround, 0, 0, 0, .15, .15)
    love.graphics.draw(StartingWindowText.Name, 200, 100)
    love.graphics.draw(StartingWindowText.MadeWith, 300, 200)
    Buttons.NewGame:Draw()
    Buttons.LoadGame:Draw()
    Buttons.Credits:Draw()
end