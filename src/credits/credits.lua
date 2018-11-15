require("src/shared/cache")
local BackGroundImage = getImageFromCache("tiles/autumn-platformer-tileset/png/elements/background.png")
local CreditMusic     = love.audio.newSource("sound/credits/credits.ogg", "stream")

local next_time_to_draw_scrawl = love.timer.getTime()
local Font                     = love.graphics.newFont(15)

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

    {Title = "Lead Developer" , Credit = "Emma Marie Davenport"},
    {Title = "Lead Designer"  , Credit = "Emma Marie Davenport"},
    {Title = "Lead Writer"    , Credit = "Emma Marie Davenport"},
    {Title = "Lead Everything", Credit = "Emma Marie Davenport"},
    {Title = "", Credit = ""},
    {Title = "Special Thanks to", Credit = "Friends and Family"},
    {Title = "Special Thanks to", Credit = "You, the player!"},

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
    love.graphics.setFont(Font)
    for i = 1, #People do

        love.graphics.print(People[i].Title, half_window_width, y_position_text + displacement)
        love.graphics.print(People[i].Credit, half_window_width+15, y_position_text+30 + displacement)
        displacement = displacement + 60

    end
    SetNextTimeAndIncrementYText()
    CheckIfCreditsShouldStop()

end

function DrawCreditsScene()

    DrawBackground()
    DrawCreditsScrawl()
    DrawBackButton()

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