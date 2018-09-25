

local BackGroundImage = love.graphics.newImage("tiles/autumn-platformer-tileset/png/elements/background.png")
local CreditMusic     = love.audio.newSource("sound/credits/credits.ogg", "static")


local StartMenu_CallBack
function InitializeCredits_CallBackFunctions(StartMenu)
    StartMenu_CallBack = StartMenu
end

local function DrawBackground()
    love.graphics.draw(BackGroundImage, 0, 0, 0, .3, .3)
end

local People = 
{

    ["Lead Developer"] = "Emma Marie Davenport",
    ["Lead Designer"]  = "Emma Marie Davenport",
    ["Artists"]        = "Various Sources",
    ["Music & Sounds"] = "Various Sources"

}

local y_position_text = 600
local function CheckIfCreditsShouldStop()
    if y_position_text <= -100 then
        StartMenu_CallBack()
    end
end

local function DrawCreditsScrawl()

    local half_window_width = math.floor((love.graphics.getWidth()-50)*.5)
    local displacement = 0
    for title, person in pairs(People) do

        love.graphics.print(title, half_window_width, y_position_text + displacement)
        love.graphics.print(person, half_window_width+15, y_position_text+10 + displacement)
        displacement = displacement + 30

    end
    y_position_text = y_position_text - 1
    love.timer.sleep(.03)
    CheckIfCreditsShouldStop()

end

function DrawCreditsScene()
    DrawBackground()
    DrawCreditsScrawl()
end

function ResetCreditsPositionText()
    y_position_text = 600
end

function StartCreditMusic()
    love.audio.play(CreditMusic)
end