

local StarterMapTileDirectory = "tiles/autumn-platformer-tileset/png/tiles"
local StarterMap =
{

    {"12","12","12","12","12","17","01","01","18","12","12"},
    {"12","12","12","12","12","17","01","01","18","12","12"},
    {"12","12","12","12","12","17","01","01","18","12","12"},
    {"12","12","12","12","12","17","01","01","18","12","12"},
    {"12","12","12","12","12","17","01","01","18","12","12"},
    {"12","12","12","12","12","17","01","01","18","12","12"},
    {"12","12","12","12","12","17","01","01","18","12","12"},
    {"12","12","12","12","12","17","01","01","18","12","12"},

}

local MapClass = require("src/map/map")
local MapImage = MapClass:new(StarterMap, StarterMapTileDirectory, .15, .15)

local CharacterClass = require("src/character/character")
local FemaleCharacter = CharacterClass:new("tiles/Characters/Females/F_01.png", 75, 75, 16, 17, 10)


local Day0 = require("src/levels/day0/level")

function DrawNewGame()

    love.graphics.translate(-(FemaleCharacter.x_pos * 3) + math.floor(love.graphics.getWidth()/2), -(3 * FemaleCharacter.y_pos) + math.floor(love.graphics.getHeight()/2))
    love.graphics.scale(3)
    Day0.Draw()
    --MapImage:Draw()
    FemaleCharacter:Draw()

end

function HandleInput_NewGame()

    if love.keyboard.isDown("w") then
        FemaleCharacter:WalkUp(true)
    elseif love.keyboard.isDown("s") then
        FemaleCharacter:WalkDown(true)
    elseif love.keyboard.isDown("a") then
        FemaleCharacter:WalkLeft(true)
    elseif love.keyboard.isDown("d") then
        FemaleCharacter:WalkRight(true)
    end


end