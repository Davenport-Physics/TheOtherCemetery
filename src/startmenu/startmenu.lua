
local StartMenuSound = love.audio.newSource("sound/startmenu/startmenu.ogg", "static")

function StartMenuMusic_Start()
    love.audio.play(StartMenuSound)
end

function StartMenuMusic_Stop()
    love.audio.stop(StartMenuSound)
end

local function IsBetweenRange(value, low, high)

    if value >= low and value <= high then
        return true
    end

    return false

end

local function HandleInput_StartingWindow_MouseDown_NewGame()

    if IsBetweenRange(love.mouse.getX(), 75, 225) and IsBetweenRange(love.mouse.getY(), 450, 550) then

    end

end

local function HandleInput_StartingWindow_MouseDown_LoadGame()

end

local function HandleInput_StartingWindow_MouseDown_Credits()

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
    NewGame  = love.graphics.newImage("pics/startmenu/newgame.png"),
    LoadGame = love.graphics.newImage("pics/startmenu/loadgame.png"),
    Credits  = love.graphics.newImage("pics/startmenu/credits.png")
}
function DrawStartingWindow()

    love.graphics.draw(StartingWindowText.Name, 200, 100)
    love.graphics.draw(StartingWindowText.MadeWith, 300, 200)
    love.graphics.draw(StartingWindowPics.NewGame,75, 450, 0, .3, .3)
    love.graphics.draw(StartingWindowPics.LoadGame, 275, 450, 0, .3, .3)
    love.graphics.draw(StartingWindowPics.Credits, 475, 450, 0, .3, .3)

end