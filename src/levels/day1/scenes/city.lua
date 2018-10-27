local DataToSave = require("src/save/savingdata")
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

local HomeDoor = DoorClass:new(49 * 16, 60 * 16, 16, 16, "src/levels/day1/scenes/home-lobby", 2*16, 7*16)

local World   = WorldClass:new(Map, {}, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local transition = false

local function DoorCollisionChecks()

    transition = HomeDoor:CheckForCollision(Henry:GetCenterPosition())
    if type(transition) == "table" then
        DataToSave.CurrentScene = transition[1]
    end

end

function Scene.Update()

    World:Update()
    DoorCollisionChecks()

end

function Scene.Draw()

    World:Draw()

end

function Scene.HandleInput()

    World:HandleInput()

end

function Scene.CanTransition()

    return transition

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:WalkDown(true)

end

function Scene.Reset()

end

return Scene