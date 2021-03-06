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

local transition       = false
local Map              = TiledMapClass:new(require("src/levels/maps/school/school-room"))
local StationaryEntity = EntityClass:newMinimal(9*16, 10*16)

local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 12*16, 9*16, 16, 17, 9, .075); Henry:WalkUp();
local NPCs  =
{
    CharacterClass:new("tiles/Characters/Males/M_05.png"  , 11*16, 9*16, 16, 17, 4, .025),
}
NPCs[1]:WalkRight()
local World = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(StationaryEntity)
World:SetHandleInputCallback(function() end)

local TextAfterWakingUp =
{
    TextBubbleClass:newSpeaking(Henry,   "AHHHH!!!"),
    TextBubbleClass:newSpeaking(NPCs[1], "Henry it's alright."),
    TextBubbleClass:newSpeaking(NPCs[1], "You were just \nsleeping."),
    TextBubbleClass:newSpeaking(NPCs[1], "Go home Henry."),
}
local Dialog = DialogClass:new(TextAfterWakingUp, 3)
local CameraTrackingChanged = false

local ExitDoor = DoorClass:new(9*16, 14*16, 3*16, 16, "src/levels/day1/scenes/school/school", 7*16, 12*16)

local function CheckForDoorTransitions()

    transition = ExitDoor:CheckForCollision(Henry:GetCenterPosition())
    if type(transition) == "table" then
        DataToSave.CurrentScene = transition[1]
    end

end

local function SwitchCameraTrackingToHenryIfPossible()

    if Dialog:IsFinished() and not CameraTrackingChanged then

        World:SetEntityToTrackForCamera(Henry)
        CameraTrackingChanged = true
        DataToSave["Day1Events"].WentToSchool = true
        World:SetHandleInputCallback(nil)

    end

end

local function DrawDialogIfPossible()

    if not Dialog:IsFinished() then
        Dialog:Draw()
    end

end

function Scene.Update()

    World:Update()
    SwitchCameraTrackingToHenryIfPossible()
    CheckForDoorTransitions()

end

function Scene.Draw()

    World:Draw()

end

function Scene.DrawText()

    DrawDialogIfPossible()

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
    Henry:FaceDown()

end

return Scene