
require("src/startmenu/startmenu")
require("src/credits/credits")
require("src/newgame/newgame")
require("src/save/saving")
require("src/loadgame/loadgamehandler")


local Settings = require("src/settings/settings")

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

    {Draw = DrawStartingWindow   , Input = HandleInput_StartingWindow, Update = Update_StartMenu},
    {Draw = NewGameHandler_Draw  , Input = NewGameHandler_Input      , Update = NewGameHandler_Update},
    {Draw = LoadGameHandler_Draw , Input = LoadGameHandler_Input     , Update = LoadGameHandler_Update},
    {Draw = function() end       , Input = function() end            , Update = function() end},
    {Draw = DrawCreditsScene     , Input = HandleInput_Credits       , Update = function() end},
    {Draw = function() end       , Input = function() end            , Update = function() end}

}

local CURRENT_CONTEXT = CONTEXT_INDEX.STARTING_WINDOW

local CANVAS = love.graphics.newCanvas(2000, 2000)

local function InStartMenu()

    StartMenuMusic_Start()
    CURRENT_CONTEXT = CONTEXT_INDEX.STARTING_WINDOW

end

local function StartNewGame()

    love.audio.stop()
    InitializePartialSaveDataForNewGame()
    CURRENT_CONTEXT = CONTEXT_INDEX.NEW_GAME

end

local function LoadGame()

    InitializePartialSaveDataForLoadGame()
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

    LoadSettings()
    love.graphics.setDefaultFilter( "nearest", "nearest", 16 )
    StartMenuMusic_Start()
    InitializeLoadGame_CallBackFunctions(InStartMenu)
    InitializeNewGame_CallBackFunctions(InStartMenu)
    InitializeStartMenu_CallBackFunctions(StartNewGame, LoadGame, Options, Credits, Quit)
    InitializeCredits_CallBackFunctions(InStartMenu)
    love.window.setTitle("Diconnected")
    love.window.setMode(Settings.Window_Width, Settings.Window_Height, {resizable=true, vsync=true, minwidth=800, minheight=600})
    --love.window.setFullscreen(true, "desktop")

end

function love.update()

    Settings.UpdateWindow()
    Settings.UpdateScale()
    CONTEXT_FUNCTIONS[CURRENT_CONTEXT].Input()
    CONTEXT_FUNCTIONS[CURRENT_CONTEXT].Update()

end

local function SetCanvas()

    love.graphics.setCanvas(CANVAS)

        love.graphics.clear()
        CONTEXT_FUNCTIONS[CURRENT_CONTEXT].Draw()

    love.graphics.setCanvas()

    if Settings.GlobalScaleOn then

        love.graphics.translate(Settings.X_Canvas_Translation, Settings.Y_Canvas_Translation)
        love.graphics.scale(Settings.Scale, Settings.Scale)

    end

end

function love.draw()

    if CURRENT_CONTEXT == CONTEXT_INDEX.GAME then

        SetCanvas()
        love.graphics.draw(CANVAS, 0, 0)

    else

        CONTEXT_FUNCTIONS[CURRENT_CONTEXT].Draw()

    end

end

function love.quit()

    StoreSettings()
    print("Thanks for playing! Come back soon!")

end