
require("src/shared/cache")
local Settings = require("src/settings/settings")
local StartMenuSound = getStreamSoundFromCache("sound/startmenu/sadpiano.mp3")

local ButtonClass = require("src/button/button")
local Buttons =
{

    NewGame  = ButtonClass:newImage("pics/startmenu/newgame.png", 25, 450),
    LoadGame = ButtonClass:newImage("pics/startmenu/loadgame.png", 200, 450),
    Credits  = ButtonClass:newImage("pics/startmenu/credits.png", 375, 450),
    Options  = ButtonClass:newImage("pics/startmenu/options.png", 550, 450),
    Quit     = ButtonClass:newImage("pics/startmenu/quit.png", 625, 20),
    Twitter  = ButtonClass:newImage("pics/social/twitter.png", 100, 550),
    YouTube  = ButtonClass:newImage("pics/social/youtube.png", 250, 542.5),
    Website  = ButtonClass:newImage("pics/social/Website.png", 350, 544),
    About    = ButtonClass:newImage("pics/about.png", 450, 544)

}
Buttons.NewGame:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.LoadGame:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.Credits:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.Options:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.Twitter:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.YouTube:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.Website:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
Buttons.About:SetSoundWhenClicked("sound/startmenu/click/click.ogg")

function StartMenuMusic_Start()

    StartMenuSound:setLooping(true)
    StartMenuSound:setVolume(.5)
    StartMenuSound:play()

end

function StartMenuMusic_Stop()

    StartMenuSound:stop()

end

function InitializeStartMenu_CallBackFunctions(StartNewGame, LoadGame, Options, Credits, Quit)

    Buttons.NewGame:SetCallback(StartNewGame)
    Buttons.LoadGame:SetCallback(LoadGame)
    Buttons.Credits:SetCallback(Credits)
    Buttons.Quit:SetCallback(Quit)
    Buttons.Twitter:SetCallback(function() love.window.minimize(); love.system.openURL("https://twitter.com/DSectorStudios") end)
    Buttons.Website:SetCallback(function() love.window.minimize(); love.system.openURL("https://www.darksectorstudios.com/") end)
    Buttons.YouTube:SetCallback(function() love.window.minimize(); love.system.openURL("https://www.youtube.com/channel/UCIW4bSzn44v08ttyRMT5z2w?view_as=subscriber") end)
    Buttons.About:SetCallback(function()   love.window.minimize(); love.system.openURL("file:///"..love.filesystem.getWorkingDirectory().."/LoveGame/about/index.html") end)

end

function HandleInput_StartingWindow()

    Buttons.NewGame:HandleMouseClick()
    Buttons.LoadGame:HandleMouseClick()
    Buttons.Credits:HandleMouseClick()
    Buttons.Options:HandleMouseClick()
    Buttons.Quit:HandleMouseClick()
    Buttons.Twitter:HandleMouseClick()
    Buttons.YouTube:HandleMouseClick()
    Buttons.Website:HandleMouseClick()
    Buttons.About:HandleMouseClick()

end


local StartingWindowText =
{

    Name     = love.graphics.newText(love.graphics.newFont(65), "Disconnected"),
    MadeWith = love.graphics.newText(love.graphics.newFont(25), "A game made with Love"),
    Version  = love.graphics.newText(love.graphics.newFont(25), "Alpha 2")

}

local StartingWindowPics  =
{
    BackGround = getImageFromCache("tiles/autumn-platformer-tileset/png/elements/background.png"),
}

local function DrawButtons()

    Buttons.NewGame:Draw()
    Buttons.LoadGame:Draw()
    Buttons.Credits:Draw()
    Buttons.Options:Draw()
    Buttons.Quit:Draw()
    Buttons.Twitter:Draw()
    Buttons.YouTube:Draw()
    Buttons.Website:Draw()
    Buttons.About:Draw()

end

local BackGroundScale_x = 1
local BackGroundScale_y = 1
function Update_StartMenu()

    BackGroundScale_x = love.graphics.getWidth()/StartingWindowPics.BackGround:getWidth()
    BackGroundScale_y = love.graphics.getHeight()/StartingWindowPics.BackGround:getHeight()
    Buttons.NewGame.x_pos  = love.graphics.getWidth()*.5 - (25 + 350)
    Buttons.LoadGame.x_pos = Buttons.NewGame.x_pos  + 175
    Buttons.Credits.x_pos  = Buttons.LoadGame.x_pos + 175
    Buttons.Options.x_pos  = Buttons.Credits.x_pos  + 175
    Buttons.Quit.x_pos     = Buttons.Options.x_pos

    Buttons.Twitter.x_pos  = Buttons.NewGame.x_pos  + 75
    Buttons.YouTube.x_pos  = Buttons.Twitter.x_pos  + 150
    Buttons.Website.x_pos  = Buttons.YouTube.x_pos  + 125
    Buttons.About.x_pos    = Buttons.Website.x_pos  + 100

end

local function DrawMisc()

    love.graphics.draw(StartingWindowPics.BackGround, 0, 0, 0, BackGroundScale_x, BackGroundScale_y)
    love.graphics.draw(StartingWindowText.Name, love.graphics.getWidth()*.5 - 200, 125)
    love.graphics.draw(StartingWindowText.MadeWith, love.graphics.getWidth()*.5 - 175, 200)
    love.graphics.draw(StartingWindowText.Version, 10, 15)

end

function DrawStartingWindow()

    DrawMisc()
    DrawButtons()

end