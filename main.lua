
require("./src/startmenu/startmenu")


local IsInStartingWindow = false
function love.load()
    IsInStartingWindow = true
    StartMenuMusic_Start()
end

local function HandleInput()
    if IsInStartingWindow then HandleInput_StartingWindow() end
end

function love.update()
    HandleInput()
end

function love.draw()

    if IsInStartingWindow then
        DrawStartingWindow()
    end

end

function love.quit()
  print("Thanks for playing! Come back soon!")
end