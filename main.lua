
require("./src/startmenu/startmenu")
require("./src/credits/credits")
require("./src/newgame/newgame")



local CONTEXT_INDEX =
{

    STARTING_WINDOW = 1,
    NEW_GAME        = 2,
    LOAD_GAME       = 3,
    GAME            = 4,
    CREDITS         = 5,
    OPTIONS         = 6

}

local CONTEXT_FUNCTIONS =
{

    {Draw = DrawStartingWindow, Input = HandleInput_StartingWindow},
    {Draw = DrawNewGame       , Input = HandleInput_NewGame},
    {Draw = function() end    , Input = function() end},
    {Draw = function() end    , Input = function() end},
    {Draw = DrawCreditsScene  , Input = HandleInput_Credits},
    {Draw = function() end    , Input = function() end}

}

local CURRENT_CONTEXT = CONTEXT_INDEX.STARTING_WINDOW

local function InStartMenu()
    love.audio.stop()
    StartMenuMusic_Start()
    CURRENT_CONTEXT = CONTEXT_INDEX.STARTING_WINDOW
end

local function StartNewGame()
    love.audio.stop()
    CURRENT_CONTEXT = CONTEXT_INDEX.NEW_GAME
end

local function LoadGame()
    CURRENT_CONTEXT = CONTEXT_INDEX.LOAD_GAME
end

local function Game()
    love.audio.stop()
    CURRENT_CONTEXT = CONTEXT_INDEX.GAME
end

local function Credits()
    love.audio.stop()
    ResetCreditsPositionText()
    StartCreditMusic()
    CURRENT_CONTEXT = CONTEXT_INDEX.CREDITS
end

local function Options()
    CURRENT_CONTEXT = CONTEXT_INDEX.OPTIONS
end

local function Quit()
    love.event.quit()
end

function love.load()
    StartMenuMusic_Start()
    InitializeStartMenu_CallBackFunctions(StartNewGame, LoadGame, Options, Credits, Quit)
    InitializeCredits_CallBackFunctions(InStartMenu)
end

local function HandleInput()
    CONTEXT_FUNCTIONS[CURRENT_CONTEXT].Input()
end

function love.update()
    HandleInput()
end

function love.draw()
    CONTEXT_FUNCTIONS[CURRENT_CONTEXT].Draw()
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 500, 10)
end

function love.quit()
  print("Thanks for playing! Come back soon!")
end