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

local BackgroundSound = getStreamSoundFromCache("sound/ambiance/piano-loop-1.mp3")

local transition = false
local Map        = TiledMapClass:new(require("src/levels/maps/city/interiors/funeral"))

local ExitDoor = DoorClass:new(8 * 16, 17 * 16, 2*16, 16, "src/levels/day1/scenes/city/city", 53*16, 38*16)

local StationaryEntity = EntityClass:newMinimal(8*16, 3*16)
local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 8*16, 16*16, 16, 17, 9, .075); Henry:WalkUp();
local NPCs  =
{
    CharacterClass:new("tiles/Characters/Males/M_11.png", 8*16, 3*16, 16, 17, 4, .05)
}
NPCs[1]:FaceUp()
local World = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local HearingSpeech = false
local SpeechText =
{
    TextBubbleClass:newSpeaking(NPCs[1], "Ahh Henry, How are you \nfeeling?"),
    TextBubbleClass:newSpeaking(Henry, "I-I don't know why I'm here..."),
    TextBubbleClass:newSpeaking(NPCs[1],"Well there surely must \nbe a reason."),
    TextBubbleClass:newSpeaking(NPCs[1], "Everything always has \na reason."),
    TextBubbleClass:newSpeaking(NPCs[1], "Don't you think Henry?"),
    TextBubbleClass:newSpeaking(Henry, "I... suppose")
}
local SpeechDialog = DialogClass:new(SpeechText, 3)

local function UpdateDoorTransition()

    transition = ExitDoor:CheckForCollision(Henry:GetCenterPosition())

end

local function UpdateSpeechIfPossible()

    if not DataToSave["Day1Events"].HeardSpeechFromPriest and SpeechDialog:IsFinished() then
        DataToSave["Day1Events"].HeardSpeechFromPriest = true
        World:SetHandleInputCallback(nil)
        World:SetEntityToTrackForCamera(Henry)
        NPCs[1]:FaceUp()
        HearingSpeech = false
    end
    if DataToSave["Day1Events"].HeardSpeechFromPriest then return end
    if HearingSpeech then return end
    if Shared.IsNear(Henry.x_pos, Henry.y_pos, NPCs[1].x_pos, NPCs[1].y_pos, 64) then
        HearingSpeech = true
        World:SetHandleInputCallback(function() end)
        World:SetEntityToTrackForCamera(StationaryEntity)
        NPCs[1]:FaceDown()
    end

end

local function DrawSpeechIfPossible()

    if HearingSpeech then
        SpeechDialog:Draw()
    end

end

function Scene.Update()

    World:Update()
    UpdateDoorTransition()
    UpdateSpeechIfPossible()

end

function Scene.Draw()

    World:Draw()

end

function Scene.DrawText()

    DrawSpeechIfPossible()

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

    BackgroundSound:setLooping(true)
    BackgroundSound:setVolume(Settings.MasterVolume * Settings.MusicVolume)
    BackgroundSound:play()

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:FaceUp()

end

return Scene