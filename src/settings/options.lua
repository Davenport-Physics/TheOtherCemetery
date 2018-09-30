
local BackGroundImage = love.graphics.newImage("tiles/autumn-platformer-tileset/png/elements/background.png")

local ButtonClass = require("src/button/button")
local Buttons =
{

    Resolution = ButtonClass:newImage()

}

function HandleInput_Input()



end

function Draw_Options()

    love.graphics.draw(BackGroundImage, 0, 0, 0, .3, .3)

end