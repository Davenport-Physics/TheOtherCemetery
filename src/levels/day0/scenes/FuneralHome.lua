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

local FuneralHomeFloorMap = MapClass:new(FuneralHomeFloorData, FuneralHomeFloorDataLocation)

local SeatingPlatformImage = love.graphics.newImage("tiles/zombie-tileset/Objects/PNG/objects_house_0042_Layer-42.png")
local SeatingPlatformEntites =
{

    {EntityClass:newWithImage(SeatingPlatformImage, 100, 200, false)},


}

local CharactersInScene = {}
local PlayerCharacter = {}

function GetMap()

    return FuneralHomeFloorMap

end

function GetEntities()

    return SeatingPlatformEntites

end

function GetCharacters()

    return CharactersInScene

end

function GetPlayerCharacter()

    return PlayerCharacter

end