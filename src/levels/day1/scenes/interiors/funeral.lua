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
local Map        = TiledMapClass:new(require("src/levels/maps/city/interiors/funeral"))

local ExitDoor = DoorClass:new(8 * 16, 17 * 16, 2*16, 16, "src/levels/day1/scenes/city/city", 53*16, 38*16)

local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 8*16, 16*16, 16, 17, 9, .075); Henry:WalkUp();
local NPCs  = {}
local World = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local function UpdateDoorTransition()

    transition = ExitDoor:CheckForCollision(Henry:GetCenterPosition())

end

function Scene.Update()

    World:Update()
    UpdateDoorTransition()

end

function Scene.Draw()

    World:Draw()

end

function Scene.DrawText()

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
    Henry:FaceUp()

end

return Scene