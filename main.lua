
require("./src/startmenu/startmenu")
require("./src/credits/credits")
require("./src/newgame/newgame")


local IsInStartingWindow = false
local IsInNewGame        = false
local IsInLoadGame       = false
local IsInCredits        = false

function InStartMenu()

    IsInStartingWindow = true
    IsInNewGame        = false
    IsInLoadGame       = false
    IsInCredits        = false

end

local function StartNewGame()

    IsInStartingWindow = false
    IsInNewGame        = true

end

local function LoadGame()

    IsInStartingWindow = false
    IsInLoadGame       = true

end

local function Credits()

    ResetCreditsPositionText()
    IsInStartingWindow = false
    IsInCredits        = true

end

function love.load()
    IsInStartingWindow = true
    StartMenuMusic_Start()
    InitializeStartMenu_CallBackFunctions(StartNewGame, LoadGame, Credits)
    InitializeCredits_CallBackFunctions(InStartMenu)
end

local function HandleInput()
    if IsInStartingWindow then HandleInput_StartingWindow() end
end

function love.update()
    HandleInput()
end

function love.draw()

    if IsInStartingWindow then DrawStartingWindow()
    elseif IsInCredits then DrawCreditsScene()
    elseif IsInNewGame then DrawNewGame() end

end

function love.quit()
  print("Thanks for playing! Come back soon!")
end