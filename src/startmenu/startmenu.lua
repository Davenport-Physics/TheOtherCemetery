
local StartMenuSound = love.audio.newSource("sound/startmenu/startmenu_slow.mp3", "static")

local ButtonClass = require("src/button/button")
local Buttons = 
{

    NewGame  = ButtonClass:newImage("pics/startmenu/newgame.png", 25, 450),
    LoadGame = ButtonClass:newImage("pics/startmenu/loadgame.png", 200, 450),
    Credits  = ButtonClass:newImage("pics/startmenu/credits.png", 375, 450),
    Options  = ButtonClass:newImage("pics/startmenu/options.png", 550, 450),
    Quit     = ButtonClass:newImage("pics/startmenu/quit.png", 625, 10)

}
Buttons.NewGame:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.LoadGame:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.Credits:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.Options:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.Quit:SetSoundWhenClicked("sound/startmenu/click/click.ogg")

function StartMenuMusic_Start()

    love.audio.play(StartMenuSound)

end

function StartMenuMusic_Stop()

    love.audio.stop(StartMenuSound)

end

function InitializeStartMenu_CallBackFunctions(StartNewGame, LoadGame, Options, Credits, Quit)

    Buttons.NewGame:SetCallback(StartNewGame)
    Buttons.LoadGame:SetCallback(LoadGame)
    Buttons.Credits:SetCallback(Credits)
    Buttons.Quit:SetCallback(Quit)

end

function HandleInput_StartingWindow()

    Buttons.NewGame:HandleMouseClick()
    Buttons.LoadGame:HandleMouseClick()
    Buttons.Credits:HandleMouseClick()
    Buttons.Options:HandleMouseClick()
    Buttons.Quit:HandleMouseClick()

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

local function DrawButtons()

    Buttons.NewGame:Draw()
    Buttons.LoadGame:Draw()
    Buttons.Credits:Draw()
    Buttons.Options:Draw()
    Buttons.Quit:Draw()

end

local function DrawMisc()

    love.graphics.draw(StartingWindowPics.BackGround, 0, 0, 0, .15, .15)
    love.graphics.draw(StartingWindowText.Name, 200, 100)
    love.graphics.draw(StartingWindowText.MadeWith, 300, 200)

end

function DrawStartingWindow()

    DrawMisc()
    DrawButtons()

end