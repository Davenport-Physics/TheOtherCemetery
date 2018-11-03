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

local BackgroundSound = getSoundFromCache("sound/ambiance/collector-slow.wav")

local transition = false
local Map        = TiledMapClass:new(require("src/levels/maps/interiors/collector/collector"))

local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 11*16, 12*16, 16, 17, 6, .05); Henry:WalkUp();
local NPCs  =
{
    CharacterClass:new("tiles/Characters/Females/F_08.png", 7*16, 5*16, 16, 17, 4, .05)
}

local TurnWalkerIntructions =
{

    DirectionDt = 1.25,
    CurrentDirection = "Down",
    SpecificTurns =
    {{dir = "Right", func =  NPCs[1].WalkDown, new_dir = "Down"},
    {dir = "Down" , func = NPCs[1].WalkRight, new_dir = "Right"}},

}
local WorkerTurner = WalkerClass:new(NPCs[1], "turn-walker", TurnWalkerIntructions)

local World = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local ExitDoor = DoorClass:new(10*16, 13*16, 3*16, 16, "src/levels/day1/scenes/city/city", 17*16, 41*16)
local DeepDoor = DoorClass:new(12*16, 5*16, 16, 16, "src/levels/day1/scenes/interiors/underneath-collector", 7*16, 27*16)

local Doors = DoorsHandler:new({ExitDoor}, Henry)

local GetOutStationaryEntity = EntityClass:newMinimal(10*16, 5*16)
local WorkerText = TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "Welcome!")
local GetOutText = TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "Get OUT!")
local ShouldDrawGetOutText = false
local DrawGetOutTextFor    = nil

local function CheckIfWomanIsLookingAtYou(temp_transition)

    if ShouldDrawGetOutText then return end
    if WorkerTurner.walker.current_dir == "Right" then
        ShouldDrawGetOutText = true
        DrawGetOutTextFor = love.timer.getTime() + 2
        World:SetHandleInputCallback(function() end)
        World:SetEntityToTrackForCamera(GetOutStationaryEntity)
    else
        transition = temp_transition
    end

end

local function UpdateDoorTransitions()

    transition = Doors:CheckForCollisions()
    if type(transition) == "table" then
        DataToSave.CurrentScene = transition[1]
        return
    end
    local temp = DeepDoor:CheckForCollision(Henry:GetCenterPosition())
    if type(temp) == "table" then
        CheckIfWomanIsLookingAtYou(temp)
    end

end

local function UpdateWalker()

    if ShouldDrawGetOutText then return end
    WorkerTurner:Update()

end

local function UpdateGetOutText()

    if not ShouldDrawGetOutText then return end
    if love.timer.getTime() >= DrawGetOutTextFor then
        DrawGetOutTextFor    = nil
        ShouldDrawGetOutText = false
        transition = {"src/levels/day1/scenes/city/city", 17*16, 41*16}
        World:SetHandleInputCallback(nil)
        World:SetEntityToTrackForCamera(Henry)
    end

end

local function DrawWorkerTextIfPossible()

    if ShouldDrawGetOutText then return end
    if Shared.IsNear(Henry.x_pos, Henry.y_pos, NPCs[1].x_pos, NPCs[1].y_pos, 48) then
        WorkerText:Draw()
    end

end

local function DrawGetOutTextIfPossible()

    if ShouldDrawGetOutText then
        GetOutText:Draw()
    end

end

function Scene.Update()

    World:Update()
    UpdateDoorTransitions()
    UpdateWalker()
    UpdateGetOutText()

end

function Scene.Draw()

    World:Draw()
    DrawWorkerTextIfPossible()
    DrawGetOutTextIfPossible()

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

    BackgroundSound:setVolume(.15)
    BackgroundSound:setLooping(true)
    BackgroundSound:play()

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:WalkDown(true)

end

return Scene