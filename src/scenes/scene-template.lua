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
local Map        = TiledMapClass:new(require("src/levels/day1/maps/school/butchery"))

local NPCs = {}

local Henry = CharacterClass:newMale("M_08", 5, 7, 9, .075); Henry:FaceUp();
local World = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

function Scene.Update()

    World:Update()

end

function Scene.Draw()

    World:Draw()

end

function Scene.DrawText()

end

function Scene.HandleInput()

    World:HandleInput()

end

function Scene.Clean()

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
    Henry:FaceDown()

end

return Scene