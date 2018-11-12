
require("src/intro/intro")
require("src/startmenu/startmenu")
require("src/credits/credits")
require("src/newgame/newgame")
require("src/save/saving")
require("src/loadgame/loadgamehandler")
require("src/options/options")
require("src/gamehandler/gamehandler")

local DataToSave = require("src/save/savingdata") 
local Settings   = require("src/settings/settings")

local CONTEXT_INDEX =
{

    STARTING_WINDOW = 1,
    NEW_GAME        = 2,
    LOAD_GAME       = 3,
    GAME            = 4,
    CREDITS         = 5,
    OPTIONS         = 6,
    INTRO           = 7

}

local CONTEXT_FUNCTIONS =
{

    -- Starting Window
    {
        Draw       = DrawStartingWindow,
        DrawText   = function() end,
        Input      = HandleInput_StartingWindow,
        TextInput  = function() end,
        KeyPressed = function() end,
        Update     = Update_StartMenu
    },
    -- New Game
    {
        Draw       = NewGameHandler_Draw,
        DrawText   = function() end,
        Input      = NewGameHandler_Input,
        TextInput  = NewGame_textinput,
        KeyPressed = NewGame_keypressed,
        Update     = NewGameHandler_Update
    },
    -- Load Game
    {
        Draw       = LoadGameHandler_Draw,
        DrawText   = function() end,
        Input      = LoadGameHandler_Input,
        TextInput  = function() end,
        KeyPressed = function() end,
        Update     = LoadGameHandler_Update
    },
    -- Game
    {
        Draw       = Game_Draw,
        DrawText   = Game_DrawText,
        Input      = Game_HandleInput,
        TextInput  = function() end,
        KeyPressed = function() end,
        Update     = Game_Update
    },
    -- Credits
    {
        Draw       = DrawCreditsScene,
        DrawText   = function() end,
        Input      = HandleInput_Credits,
        TextInput  = function() end,
        KeyPressed = function() end,
        Update     = function() end
    },
    -- Options
    {
        Draw       = Options_Draw,
        DrawText   = function() end,
        Input      = Options_HandleInput,
        TextInput  = Options_textinput,
        KeyPressed = Options_keypressed,
        Update     = Options_Update
    },
    -- Intro
    {
        Draw       = DrawIntroSequence,
        DrawText   = function() end,
        Input      = function() end,
        TextInput  = function() end,
        KeyPressed = function() end,
        Update     = function() end
    }

}

local CURRENT_CONTEXT = CONTEXT_INDEX.INTRO

local CANVAS = love.graphics.newCanvas(2000, 2000)

local function InStartMenu()

    if CURRENT_CONTEXT == CONTEXT_INDEX.GAME then
        love.audio.stop()
    end
    StartMenuMusic_Start()
    CURRENT_CONTEXT = CONTEXT_INDEX.STARTING_WINDOW

end

local function StartNewGame()

    ResetNewGame()
    CURRENT_CONTEXT = CONTEXT_INDEX.NEW_GAME

end

local function LoadGame()

    ResetLoadGame()
    CURRENT_CONTEXT = CONTEXT_INDEX.LOAD_GAME

end

local function Game()

    love.audio.stop()
    Game_InitializeGameHandler()
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

    StoreSettings()
    os.exit()

end

function love.load()

    LoadSettings()
    love.graphics.setDefaultFilter( "linear", "nearest", 16 )
    InitIntroIconCallback(InStartMenu)
    InitializeLoadGame_CallBackFunctions(InStartMenu, Game)
    InitializeNewGame_CallBackFunctions(InStartMenu , Game)
    InitializeStartMenu_CallBackFunctions(StartNewGame, LoadGame, Options, Credits, Quit)
    InitializeCredits_CallBackFunctions(InStartMenu)
    love.window.setTitle("Diconnected")
    love.window.setMode(Settings.Window_Width, Settings.Window_Height, {resizable=true, vsync=true, minwidth=1152, minheight=648})
    love.window.setFullscreen(Settings.Fullscreen)

end

local function CheckEventPool()

    for n, a, b, c, d, e, f in love.event.poll() do
        if n == "startmenu" then
            InStartMenu()
        elseif n == "quit" then
            Quit()
        end
    end

end

local function IncrementPlayTimer(dt)

    if CURRENT_CONTEXT == CONTEXT_INDEX.GAME then
        DataToSave.PlayTime = DataToSave.PlayTime + tonumber(string.format("%.2f", dt))
    end

end

function love.update(dt)

    if love.window.isMinimized() then return end
    Settings.UpdateWindow()
    Settings.UpdateScale()
    CONTEXT_FUNCTIONS[CURRENT_CONTEXT].Input()
    CONTEXT_FUNCTIONS[CURRENT_CONTEXT].Update()
    CheckEventPool()
    IncrementPlayTimer(dt)

end

function love.textinput(t)

    CONTEXT_FUNCTIONS[CURRENT_CONTEXT].TextInput(t)

end

function love.keypressed(key)

    CONTEXT_FUNCTIONS[CURRENT_CONTEXT].KeyPressed(key)

end

local function SetCanvas()
    love.graphics.push()
    love.graphics.setCanvas(CANVAS)
        love.graphics.clear()
        CONTEXT_FUNCTIONS[CURRENT_CONTEXT].Draw()
    love.graphics.setCanvas()
    if Settings.GlobalScaleOn then
        love.graphics.translate(Settings.X_Canvas_Translation, Settings.Y_Canvas_Translation)
        love.graphics.scale(Settings.Scale, Settings.Scale)
    end
    love.graphics.draw(CANVAS, 0, 0)
    love.graphics.pop()
end

local function SetText()

    if not Settings.GlobalScaleOn then return end
    CONTEXT_FUNCTIONS[CURRENT_CONTEXT].DrawText()

end

function love.draw()

    if love.window.isMinimized() then return end
    if CURRENT_CONTEXT == CONTEXT_INDEX.GAME then
        SetCanvas()
        SetText()
    else
        CONTEXT_FUNCTIONS[CURRENT_CONTEXT].Draw()
    end

end

function love.quit()

    StoreSettings()
    os.exit()

end