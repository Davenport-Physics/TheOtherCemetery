
local StartMenuSound = love.audio.newSource("sound/startmenu/startmenu_slow.mp3", "static")

local ButtonClass = require("src/button/button")
local Buttons = 
{

    NewGame  = ButtonClass:newImage("pics/startmenu/newgame.png", 75, 450, .3, .3),
    LoadGame = ButtonClass:newImage("pics/startmenu/loadgame.png", 275, 450, .3, .3),
    Credits  = ButtonClass:newImage("pics/startmenu/credits.png", 475, 450, .3, .3)

}
Buttons.NewGame:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.LoadGame:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.Credits:SetSoundWhenClicked("sound/startmenu/click/click.ogg")

function StartMenuMusic_Start()

    love.audio.play(StartMenuSound)

end

function StartMenuMusic_Stop()

    love.audio.stop(StartMenuSound)

end

function InitializeStartMenu_CallBackFunctions(StartNewGame, LoadGame, Credits)

    Buttons.NewGame:SetCallback(StartNewGame)
    Buttons.LoadGame:SetCallback(LoadGame)
    Buttons.Credits:SetCallback(Credits)

end

local function HandleInput_StartingWindow_MouseDown_NewGame()

    Buttons.NewGame:HandleMouseClick()

end

local function HandleInput_StartingWindow_MouseDown_LoadGame()

    Buttons.LoadGame:HandleMouseClick()

end

local function HandleInput_StartingWindow_MouseDown_Credits()

    Buttons.Credits:HandleMouseClick()

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