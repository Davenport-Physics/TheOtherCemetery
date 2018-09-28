
local FuneralScene  = {}
local TiledMapClass = require("src/map/tiledmap")

local MapData = require("src/levels/day0/maps/funeral")
local FuneralHomeMap = TiledMapClass:new(MapData)

function FuneralScene.GetMap()

    return FuneralHomeMap

end

function FuneralScene.GetEntities()

    return nil

end

function FuneralScene.GetCharacters()

    return {}

end

function FuneralScene.GetPlayerCharacter()

    return nil

end

return FuneralScene