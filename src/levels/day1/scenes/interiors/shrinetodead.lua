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

local BackgroundSound = getStreamSoundFromCache("sound/ambiance/creepy-wind/creepy-wind-a.wav")

local transition = false
local Map        = TiledMapClass:new(require("src/levels/maps/interiors/collector/underneath/shrinetodead"))

local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 5*16, 7*16, 16, 17, 9, .075); Henry:WalkUp();
local NPCs  = {}
local World = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local doors =
{
    DoorClass:new(4*16, 8*16, 2*16, 16, "src/levels/day1/scenes/interiors/underneath-collector", 7*16, 13*16)
}

local doorshandler = DoorsHandler:new(doors, Henry)

local function UpdateDoorTransition()

    transition = doorshandler:CheckForCollisions()
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

    BackgroundSound:setVolume(.2)
    BackgroundSound:play()

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:FaceUp()

end

return Scene