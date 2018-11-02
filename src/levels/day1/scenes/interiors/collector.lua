local DataToSave = require("src/save/savingdata")
local Shared     = require("src/shared/shared")
local Scene = {}

local Settings        = require("src/settings/settings")
local EntityClass     = require("src/entity/entity")
local WorldClass      = require("src/world/world")
local DoorClass       = require("src/entity/door")
local CharacterClass  = require("src/character/character")
local TiledMapClass   = require("src/map/tiledmap")
local WalkerClass     = require("src/characterwalker/walker-generic")
local TextBubbleClass = require("src/character/textbubbles")
local DialogClass     = require("src/dialog/dialog")
local DoorsHandler    = require("src/entity/doorhandler")

local transition = false
local Map        = TiledMapClass:new(require("src/levels/maps/interiors/collector/collector"))

local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 11*16, 12*16, 16, 17, 6, .05); Henry:WalkUp();
local NPCs  = {}
local World = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local ExitDoor = DoorClass:new(10*16, 13*16, 3*16, 16, "src/levels/day1/scenes/city/city", 17*16, 41*16)
--local DeepDoor = DoorClass:new(12*16, 5*16, 16, 16, "")

local Doors = DoorsHandler:new({ExitDoor}, Henry)

local function UpdateDoorTransitions()

    transition = Doors:CheckForCollisions()
    if type(transition) == "table" then
        DataToSave.CurrentScene = transition[1]
    end

end

function Scene.Update()

    World:Update()
    UpdateDoorTransitions()

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

function Scene.Reset()

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:WalkDown(true)

end

return Scene