
local FuneralScene = {}

local MapClass    = require("src/map/map")
local EntityClass = require("src/entity/entity")


local FuneralHomeFloorDataLocation = "tiles/autumn-platformer-tileset/png/elements/"
local FuneralHomeFloorData =
{

    {"box1","box1", "box1","box1", "box1","box1", "box1","box1"},
    {"box1","box1", "box1","box1", "box1","box1", "box1","box1"},
    {"box1","box1", "box1","box1", "box1","box1", "box1","box1"},
    {"box1","box1", "box1","box1", "box1","box1", "box1","box1"},

}

local FuneralHomeFloorMap = MapClass:new(FuneralHomeFloorData, FuneralHomeFloorDataLocation, .3, .3)

local SeatingPlatformImage = love.graphics.newImage("tiles/zombie-tileset/Objects/PNG/objects_house_0041_Layer-42.png")
local SeatingPlatformEntites =
{

    EntityClass:newWithImage(SeatingPlatformImage, 100, 200, .1, .1, false),


}
local CharactersInScene = {}

function FuneralScene.GetMap()

    return FuneralHomeFloorMap

end

function FuneralScene.GetEntities()

    return SeatingPlatformEntites

end

function FuneralScene.GetCharacters()

    return CharactersInScene

end

function FuneralScene.GetPlayerCharacter()

    return nil

end

return FuneralScene