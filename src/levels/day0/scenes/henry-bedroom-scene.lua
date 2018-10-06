local Scene = {}

local CharacterClass = require("src/character/character")
local MapData        = require("src/levels/day0/maps/henry-bedroom")
local TiledMapClass  = require("src/map/tiledmap")
local TiledMap       = TiledMapClass:new(MapData)

local AnnaChar  = CharacterClass:new("tiles/Characters/Females/F_01.png", 128, 102, 16, 17, 6):
local HenryChar = CharacterClass:new("tiles/Characters/Males/M_08.png", 112, 172, 16, 17, 0); HenryChar:WalkRight(true);

function Scene.GetMap()

    return TiledMap

end

function Scene.GetCollisionObjs()

    return TiledMap:GetCollisionObjects()

end

function Scene.GetCharacters()

    return {AnnaChar, HenryChar}

end

function Scene.GetPlayerCharacter()

    return nil

end

return Scene