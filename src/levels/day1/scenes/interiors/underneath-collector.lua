require("src/shared/cache")
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

local BackgroundSound = getStreamSoundFromCache("sound/ambiance/violin-coming/horror-violin.wav")

local transition = false
local Map        = TiledMapClass:new(require("src/levels/maps/interiors/collector/underneath/underneath"))

local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 7*16, 27*16, 16, 17, 6, .05); Henry:WalkUp();
local NPCs  = {}
local World = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local DoorObjs =
{
    DoorClass:new(6*16, 28*16, 3*16, 16, "src/levels/day1/scenes/interiors/collector", 11*16, 5*16), -- Exit Door
    DoorClass:new(7*16, 11*16, 16, 16, "src/levels/day1/scenes/interiors/shrinetodead", 5*16, 7*16)
}
local Doors = DoorsHandler:new(DoorObjs, Henry)

local function UpdateDoorTransition()

    transition = Doors:CheckForCollisions()
    if type(transition) == "table" then
        DataToSave.CurrentScene = transition[1]
    end

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

    if type(transition) == "table" then
        BackgroundSound:stop()
    end
    return transition

end

function Scene.Reset()

    BackgroundSound:setVolume(.25)
    BackgroundSound:play()

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:FaceUp()

end

return Scene