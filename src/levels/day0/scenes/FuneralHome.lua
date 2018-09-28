
local FuneralScene = {}

local MapClass    = require("src/map/map")
local EntityClass = require("src/entity/entity")


local FuneralHomeFloorDataLocation = "tiles/zombie-tileset/Objects/PNG/"
local FlText = "objects_house_0041_Layer-42"
local FuneralHomeFloorData ={}

for y = 1, 22 do

    FuneralHomeFloorData[y] = {}
    for x = 1, 11 do
        FuneralHomeFloorData[y][x] = FlText
    end

end

local FuneralHomeFloorMap = MapClass:new(FuneralHomeFloorData, FuneralHomeFloorDataLocation, .1, .1)

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

    return nil--SeatingPlatformEntites

end

function FuneralScene.GetCharacters()

    return CharactersInScene

end

function FuneralScene.GetPlayerCharacter()

    return nil

end

return FuneralScene