
local FuneralScene  = {}
local TiledMapClass = require("src/map/tiledmap")

local MapData = require("src/levels/day0/maps/funeral")
local FuneralHomeMap = TiledMapClass:new(MapData)

local CharacterClass = require("src/character/character")
local FemaleCharacter = CharacterClass:new("tiles/Characters/Females/F_01.png", 90, 75, 16, 17, 10)

function FuneralScene.GetMap()

    return FuneralHomeMap

end

function FuneralScene.GetCollisionObjs()

    return FuneralHomeMap:GetCollisionObjects()

end

function FuneralScene.GetCharacters()

    return {}

end

function FuneralScene.GetPlayerCharacter()

    return FemaleCharacter

end

return FuneralScene