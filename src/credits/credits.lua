local BackGroundImage = love.graphics.newImage("tiles/autumn-platformer-tileset/png/elements/background.png")
local CreditMusic     = love.audio.newSource("sound/credits/credits.ogg", "static")

local next_time_to_draw_scrawl = love.timer.getTime()

local CharacterClass = require("src/character/character")
local FemaleCharacter = CharacterClass:new("tiles/Characters/Females/F_01.png", 300, 300, 16, 17)
local function DrawCharacter()

    FemaleCharacter:WalkRight(true)
    FemaleCharacter:Draw()

end

local ButtonClass = require("src/button/button")
local BackButton  = ButtonClass:newImage("pics/share/buttons/backbutton.png", 10, 10, .2, .2)
BackButton:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
local function DrawBackButton()

    BackButton:Draw()

end

local StartMenu_CallBack
function InitializeCredits_CallBackFunctions(StartMenu)

    StartMenu_CallBack = function()

        StartMenu()
        FemaleCharacter:ResetPositionToOriginal()
        ResetCreditsPositionText()
        love.audio.stop(CreditMusic)

    end

    BackButton:SetCallback(StartMenu_CallBack)

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

    if y_position_text <= -150 then

        StartMenu_CallBack()

    end

end

local function SetNextTimeAndIncrementYText()

    if next_time_to_draw_scrawl <= love.timer.getTime() then

        y_position_text          = y_position_text - 1
        next_time_to_draw_scrawl = love.timer.getTime() + .02

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
    SetNextTimeAndIncrementYText()
    CheckIfCreditsShouldStop()

end

function DrawCreditsScene()

    DrawBackground()
    DrawCreditsScrawl()
    DrawBackButton()
    DrawCharacter()

end

function ResetCreditsPositionText()

    y_position_text = 600

end

function StartCreditMusic()

    love.audio.play(CreditMusic)

end

function HandleInput_Credits()

    BackButton:HandleMouseClick()

end