local Scene = {}

local CharacterClass = require("src/character/character")
local MapData        = require("src/levels/day0/maps/henry-bedroom")
local TiledMapClass  = require("src/map/tiledmap")
local TiledMap       = TiledMapClass:new(MapData)

local AnnaChar = 

function Scene.GetMap()

    return TiledMap

end

function Scene.GetCollisionObjs()

    return TiledMap:GetCollisionObjects()

end

function Scene.GetCharacters()

    return {}

end

function Scene.GetPlayerCharacter()

    return nil

end

return Scene