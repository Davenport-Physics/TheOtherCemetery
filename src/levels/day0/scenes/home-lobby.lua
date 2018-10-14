local Scene = {}

local Settings       = require("src/settings/settings")
local EntityClass    = require("src/entity/entity")
local WorldClass     = require("src/world/world")
local DoorClass      = require("src/entity/door")
local CharacterClass = require("src/character/character")
local TiledMapClass  = require("src/map/tiledmap")

local MapData = require("src/levels/day0/maps/home-lobby")
local Map     = TiledMapClass:new(MapData)

local Anna  = CharacterClass:new("tiles/Characters/Females/F_01.png", 7 * 16, 4 * 16, 16, 17, 2, .05);
local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 2 * 16, 6 * 16, 16, 17, 6, .05);

local World = WorldClass:new(Map, {Anna}, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local BedroomDoor    = DoorClass:new(2*16, 5*16, 16, 16, "src/levels/day0/scenes/henry-bedroom-scene", 7*16, 4*16)
local LeaveHouseDoor = DoorClass:new(2*16, 8*16, 2*16, 16, "src/levels/day0/scenes/city", 49 * 16, 61 * 16)

local transition = false

local function CheckDoorCollisions()

    if type(BedroomDoor:CheckForCollision(Henry:GetCenterPosition())) == "table" then
        transition = BedroomDoor:CheckForCollision(Henry:GetCenterPosition())
    elseif type(LeaveHouseDoor:CheckForCollision(Henry:GetCenterPosition())) == "table" then
        transition = LeaveHouseDoor:CheckForCollision(Henry:GetCenterPosition())
    end

end

function Scene.Update()

    World:Update()
    CheckDoorCollisions()

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

return Scene