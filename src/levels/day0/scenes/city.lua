local Scene = {}

local Settings       = require("src/settings/settings")
local EntityClass    = require("src/entity/entity")
local WorldClass     = require("src/world/world")
local DoorClass      = require("src/entity/door")
local CharacterClass = require("src/character/character")
local TiledMapClass  = require("src/map/tiledmap")

local MapData = require("src/levels/day0/maps/city")
local Map     = TiledMapClass:new(MapData)

local Henry   = CharacterClass:new("tiles/Characters/Males/M_08.png", 49 * 16, 62 * 16, 16, 17, 6, .05);

local World   = WorldClass:new(Map, {}, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local transition = false
function Scene.Update()

    World:Update()

end

function Scene.Draw()

    World:Draw()

end

function Scene.HandleInput()

    World:HandleInput()

end

function Scene.CanTransition()

    return false

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:WalkDown(true)

end

return Scene