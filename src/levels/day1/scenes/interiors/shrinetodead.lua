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

local StationaryEntity = EntityClass:newMinimal(4*16, 2*16)
local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 5*16, 7*16, 16, 17, 9, .075); Henry:WalkUp();
local NPCs  = {}
local World = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(StationaryEntity)
World:SetHandleInputCallback(function() end)

local doors =
{
    DoorClass:new(4*16, 8*16, 2*16, 16, "src/levels/day1/scenes/interiors/underneath-collector", 7*16, 13*16)
}
local doorshandler          = DoorsHandler:new(doors, Henry)
local TextWhatIsThisPlace   = {TextBubbleClass:newSpeaking(Henry, "What is this place??")}
local DialogWhatIsthisPlace = DialogClass:new(TextWhatIsThisPlace, 3)
local WalkInstructions =
{
    path = {{x = 5*16, y = 5*16}}
}
local HenryWalker = WalkerClass:new(Henry, "path-walker", WalkInstructions)
local LookedAround  = false
local TimeToTurn    = nil
local TriggerDialog = false

local TurnInstructions =
{
    DirectionDt = 1.25,
    CurrentDirection = "Up",
    SpecificTurns =
    {{dir = "Up", func =  Henry.FaceLeft, new_dir = "Left"},
    {dir = "Left" , func = Henry.FaceRight, new_dir = "Right"},
    {dir = "Right" , func = Henry.FaceUp, new_dir = "Up"}},
}
local TurnWalker = WalkerClass:new(Henry, "turn-walker", TurnInstructions)

local function UpdateDoorTransition()

    transition = doorshandler:CheckForCollisions()
    if type(transition) == "table" then
        DataToSave.CurrentScene = transition[1]
    end

end

local function LookAroundFirstIfNeeded()

    if DataToSave["Day1Events"].WentUnderneathCollector then return end
    if LookedAround then return end
    if TimeToTurn == nil then
        TimeToTurn = love.timer.getTime() + 3
    end
    TurnWalker:Update()
    if love.timer.getTime() >= TimeToTurn then
        LookedAround = true
    end

end

local function WalkHenryIfPossible()

    if DataToSave["Day1Events"].WentUnderneathCollector then return end
    if not LookedAround then return end
    if TriggerDialog then return end
    HenryWalker:Update()
    if HenryWalker:IsDoneWalking() then
        TriggerDialog = true
    end

end

local function LetPlayerMoveIfNeeded()

    if DataToSave["Day1Events"].WentUnderneathCollector and not DialogWhatIsthisPlace:IsFinished() then
        World:SetEntityToTrackForCamera(Henry)
        World:SetHandleInputCallback(nil)
    end

end

local function DrawDialogIfPossible()

    if DataToSave["Day1Events"].WentUnderneathCollector then return end
    if TriggerDialog and not DataToSave["Day1Events"].WentUnderneathCollector then
        DialogWhatIsthisPlace:Draw()
    end
    if DialogWhatIsthisPlace:IsFinished() then
        DataToSave["Day1Events"].WentUnderneathCollector = true
        World:SetEntityToTrackForCamera(Henry)
        World:SetHandleInputCallback(nil)
    end

end

function Scene.Update()

    World:Update()
    LookAroundFirstIfNeeded()
    LetPlayerMoveIfNeeded()
    UpdateDoorTransition()
    WalkHenryIfPossible()

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

    if type(transition) == "table" then
        BackgroundSound:stop()
    end
    return transition

end

function Scene.Reset()

    BackgroundSound:setVolume(Settings.MasterVolume * Settings.MusicVolume * .5)
    BackgroundSound:play()

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:FaceUp()

end

return Scene