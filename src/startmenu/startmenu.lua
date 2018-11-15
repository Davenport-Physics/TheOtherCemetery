
require("src/shared/cache")
local Settings       = require("src/settings/settings")
local StartMenuSound = getSoundFromCache("sound/startmenu/sadpiano.mp3")

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
    Website  = ButtonClass:newImage("pics/social/website.png", 350, 544),
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

local about_path = "file:///"..love.filesystem.getWorkingDirectory().."/LoveGame/about/index.html"
local function SetAboutPath()

    if Settings.BUILD then
        about_path = "file:///"..love.filesystem.getWorkingDirectory().."/about/index.html"
    end

end

function InitializeStartMenu_CallBackFunctions(StartNewGame, LoadGame, Options, Credits, Quit)

    Buttons.NewGame:SetCallback(StartNewGame)
    Buttons.LoadGame:SetCallback(LoadGame)
    Buttons.Credits:SetCallback(Credits)
    Buttons.Options:SetCallback(Options)
    Buttons.Quit:SetCallback(Quit)
    Buttons.Twitter:SetCallback(function() love.window.minimize(); love.system.openURL("https://twitter.com/DSectorStudios") end)
    Buttons.Website:SetCallback(function() love.window.minimize(); love.system.openURL("https://www.darksectorstudios.com/") end)
    Buttons.YouTube:SetCallback(function() love.window.minimize(); love.system.openURL("https://www.youtube.com/channel/UCIW4bSzn44v08ttyRMT5z2w?view_as=subscriber") end)
    SetAboutPath()
    Buttons.About:SetCallback(function()   love.window.minimize(); love.system.openURL(about_path) end)

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

    Name     = getImageFromCache("pics/startmenu/startmenutext.png"),
    MadeWith = love.graphics.newText(love.graphics.newFont(25), "A game made with LÖVE"),
    Version  = love.graphics.newText(love.graphics.newFont(25), "Alpha 3")

}

local StartingWindowPics  =
{
    BackGround = getImageFromCache("tiles/autumn-platformer-tileset/png/elements/background.png"),
}

local BackgroundVideo = love.graphics.newVideo("video/StartMenuVideo.ogv")

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

    BackGroundScale_x = love.graphics.getWidth()/BackgroundVideo:getWidth()
    BackGroundScale_y = love.graphics.getHeight()/BackgroundVideo:getHeight()
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

local function DrawBackgroundVideo()

    if not BackgroundVideo:isPlaying() then
        BackgroundVideo:rewind()
        BackgroundVideo:play()
    end
    love.graphics.draw(BackgroundVideo, 0, 0, 0, BackGroundScale_x, BackGroundScale_y)

end

local function DrawMisc()

    love.graphics.draw(StartingWindowText.Name, love.graphics.getWidth()*.5 - 375, 125, 0, .2, .2)
    love.graphics.draw(StartingWindowText.Version, 10, 15)

end



function DrawStartingWindow()

    DrawBackgroundVideo()
    DrawMisc()
    DrawButtons()

end