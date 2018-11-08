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

local transition = false
local Map        = TiledMapClass:new(require("src/levels/maps/school/school"))

local BackgroundMusic = getStreamSoundFromCache("sound/ambiance/school/school.wav")

local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 7*16, 27*16, 16, 17, 9, .075); Henry:WalkUp();
local NPCs  = {}
local World = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local ClassroomDoor      = DoorClass:new(7 * 16, 11 * 16, 16, 16, "src/levels/day1/scenes/school/school-room", 10 * 16, 13 * 16)
local ExitDoor           = DoorClass:new(6 * 16, 28 * 16, 3*16, 16, "src/levels/day1/scenes/city/city", 37*16, 6*16)

local function CheckClassroomDoor()
    if type(ClassroomDoor:CheckForCollision(Henry:GetCenterPosition())) == "table" then
        transition = ClassroomDoor:CheckForCollision(Henry:GetCenterPosition())
        DataToSave.CurrentScene = transition[1]
    end
end

local function CheckExitDoor()
    if type(ExitDoor:CheckForCollision(Henry:GetCenterPosition())) == "table" then
        transition = ExitDoor:CheckForCollision(Henry:GetCenterPosition())
        DataToSave.CurrentScene = transition[1]
    end
end

local function CheckForDoorTransitions()

    if not DataToSave["Day1Events"].WentToSchool then
        CheckClassroomDoor()
    end
    if type(transition) == "table" then return end
    CheckExitDoor()

end

local function UpdateSounds()

    if not BackgroundMusic:isPlaying() then
        BackgroundMusic:setVolume(1)
        BackgroundMusic:setLooping(true)
        BackgroundMusic:play()
    end

end


function Scene.Update()

    World:Update()
    CheckForDoorTransitions()
    UpdateSounds()

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
        love.audio.stop()
    end
    return transition

end

function Scene.Reset()

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition  = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:FaceUp()

end

return Scene