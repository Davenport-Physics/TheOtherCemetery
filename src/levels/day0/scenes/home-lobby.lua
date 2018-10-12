local Scene = {}

local Settings       = require("src/settings/settings")
local EntityClass    = require("src/entity/entity")
local WorldClass     = require("src/world/world")
local DoorClass      = require("src/entity/door")
local CharacterClass = require("src/character/character")
local TiledMapClass  = require("src/map/tiledmap")

local MapData = require("src/levels/day0/maps/home-lobby")
local Map     = TiledMapClass:new(MapData)

local Anna  = CharacterClass:new("tiles/Characters/Females/F_01.png", 13 * 16, 5 * 16, 16, 17, 2, .05);
local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 2 * 16, 7 * 16, 16, 17, 6, .05);

local World = WorldClass:new(Map, {Anna}, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local BedroomDoor    = DoorClass:new(2*16, 4*16, 2*16, 3*16, "src/levels/day0/scenes/henry-bedroom-scene", 12*16, 5*16)
local LeaveHouseDoor = DoorClass:new(2*16, 13*16, 2*16, 16, "src/levels/day0/scenes/city", 10 * 16, 11 * 16)

local transition = false

local function CheckDoorCollisions()

    if type(BedroomDoor:CheckForCollision(Henry.x_pos, Henry.y_pos)) == "table" then
        transition = BedroomDoor:CheckForCollision(Henry.x_pos, Henry.y_pos)
    end
    if type(LeaveHouseDoor:CheckForCollision(Henry.x_pos, Henry.y_pos)) == "table" then
        transition = LeaveHouseDoor:CheckForCollision(Henry.x_pos, Henry.y_pos)
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