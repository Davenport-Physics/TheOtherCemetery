
require("./src/startmenu/startmenu")
require("./src/credits/credits")
require("./src/newgame/newgame")


local IsInStartingWindow = false
local IsInNewGame        = false
local IsInLoadGame       = false
local IsInCredits        = false

local function ResetIsInVars()

    IsInStartingWindow = false
    IsInNewGame        = false
    IsInLoadGame       = false
    IsInCredits        = false

end

local function InStartMenu()

    ResetIsInVars()
    love.audio.stop()
    StartMenuMusic_Start()
    IsInStartingWindow = true

end

local function StartNewGame()

    ResetIsInVars()
    love.audio.stop()
    IsInNewGame = true


end

local function LoadGame()

    ResetIsInVars()
    IsInLoadGame       = true

end

local function Credits()

    ResetIsInVars()
    love.audio.stop()
    ResetCreditsPositionText()
    StartCreditMusic()
    IsInCredits        = true

end

function love.load()

    IsInStartingWindow = true
    StartMenuMusic_Start()
    InitializeStartMenu_CallBackFunctions(StartNewGame, LoadGame, Credits)
    InitializeCredits_CallBackFunctions(InStartMenu)

end

local function HandleInput()

    if IsInStartingWindow then HandleInput_StartingWindow()
    elseif IsInCredits then HandleInput_Credits()
    elseif IsInNewGame then HandleInput_NewGame() end

end

function love.update()

    HandleInput()

end

function love.draw()

    if IsInStartingWindow then DrawStartingWindow()
    elseif IsInCredits then DrawCreditsScene()
    elseif IsInNewGame then DrawNewGame() end
    --love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 500, 10)


end

function love.quit()
  print("Thanks for playing! Come back soon!")
end