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
local CameraClass     = require("src/camera/camera")

local BackgroundWindSound = getSoundFromCache("sound/ambiance/creepy-wind/creepy-wind-a.wav")
local BackgroundDeadSound = getSoundFromCache("sound/ambiance/moaning-dead/moaning-of-the-dead-a.wav")

local cameras     =
{
    CameraClass:new(18*16, 45*16, .2, 0, .015),
    CameraClass:new(74*16, 16*16, 0, -.2, .015)
}
local should_cameras_pan =
{
    true,
    true
}
local transition   = false
local Map          = TiledMapClass:new(require("src/levels/day1/maps/city-ruined"))

local NPCs  = {}
local World = WorldClass:new(Map, NPCs, nil, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(cameras[1])

local function MoveCameraOne()

    cameras[1]:Update()
    if cameras[1].x_pos >= 26*16 then
        should_cameras_pan[1] = false
        World:SetEntityToTrackForCamera(cameras[2])
    end

end

local function MoveCameraTwo()

    cameras[2]:Update()
    if cameras[2].y_pos <= 10*16 then
        should_cameras_pan[2] = false
    end

end

local function MoveCameras()

    if should_cameras_pan[1] then
        MoveCameraOne()
    elseif should_cameras_pan[2] then
        MoveCameraTwo()
    else
        transition = {"something"}
    end

end

local function UpdateSounds()

    if not BackgroundWindSound:isPlaying() then
        BackgroundWindSound:setVolume(.5)
        BackgroundWindSound:play()
    end
    if not should_cameras_pan[1] and not BackgroundDeadSound:isPlaying() then
        BackgroundDeadSound:setVolume(.35)
        BackgroundDeadSound:play()
    end

end

function Scene.Update()

    World:Update()
    MoveCameras()
    UpdateSounds()

end

function Scene.Draw()

    World:Draw()

end

function Scene.HandleInput()

    --World:HandleInput()

end

function Scene.CanTransition()

    return transition

end

function Scene.Reset()

end

function Scene.SetPlayerCharPosition()

end

return Scene