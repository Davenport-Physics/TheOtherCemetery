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

local transition = false
local Map        = TiledMapClass:new(require("src/levels/maps/city/city"))
local DeadMap    = TiledMapClass:new(require("src/levels/maps/city/city-ruined"))

local BackgroundSound     = getStreamSoundFromCache("sound/ambiance/city-slow.wav")
local BackgroundWindSound = getStreamSoundFromCache("sound/ambiance/creepy-wind/creepy-wind-a.wav")
local BackgroundDeadSound = getStreamSoundFromCache("sound/ambiance/moaning-dead/moaning-of-the-dead-a.wav")
BackgroundSound:setVolume(Settings.MasterVolume * Settings.MusicVolume)
BackgroundSound:setLooping(true)
BackgroundWindSound:setVolume(Settings.MasterVolume * Settings.MusicVolume)
BackgroundWindSound:setLooping(true)

local EntityOutsideHouse = EntityClass:newMinimal(49*16, 63*16)
local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 49*16, 61*16, 16, 17, 9, .075); Henry:WalkDown();
local NPCs  =
{

    CharacterClass:new("tiles/Characters/Males/M_05.png", 48*16, 64*16, 16, 17, 4, .025),
    CharacterClass:new("tiles/Characters/Females/F_08.png", 49*16, 64*16, 16, 17, 4, .025),
    CharacterClass:new("tiles/Characters/Females/F_05.png", 50*16, 64*16, 16, 17, 4, .025)

}
NPCs[1]:WalkUp()
NPCs[2]:WalkUp()
NPCs[3]:WalkUp()

local World     = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
local DeadWorld = WorldClass:new(DeadMap, NPCs, Henry, DeadMap:GetCollisionObjects())
World:SetEntityToTrackForCamera(EntityOutsideHouse)
World:SetTimeCycle("Night")
DeadWorld:SetEntityToTrackForCamera(EntityOutsideHouse)
World:SetHandleInputCallback(function() end)
DeadWorld:SetHandleInputCallback(function() end)

local ActiveWorld = World

local WhatTheTimer = nil
local WhatTheText = TextBubbleClass:new(Henry, "pics/share/text/TextBubbleSpeaking.png", "What the...")
local TextFromCultOutside =
{
    TextBubbleClass:new(NPCs[2], "pics/share/text/TextBubbleSpeaking.png", "Ne rae eay,"),
    TextBubbleClass:new(NPCs[2], "pics/share/text/TextBubbleSpeaking.png", "uo il ATISED!")

}
local DialogFromTextCultOutside = DialogClass:new(TextFromCultOutside, 4)

local ShiftActiveWorldTimer = nil
local ShiftActiveWorldDT    = 2

local function DrawTextFromCultOutside()

    if DialogFromTextCultOutside:IsFinished() then
        return
    end
    DialogFromTextCultOutside:Draw()

end

local function DrawWhatTheTextIfPossible()

    if WhatTheTimer == nil then return end
    if WhatTheTimer > love.timer.getTime() then
        WhatTheText:Draw()
    else
        WhatTheTimer = nil
        transition   = {"src/levels/day1/scenes/transitions/betaending"}
    end

end

local function CultOutsideLogic()

    if DialogFromTextCultOutside:IsFinished() and ShiftActiveWorldTimer == nil then
        ActiveWorld = DeadWorld
        ShiftActiveWorldTimer = love.timer.getTime() + ShiftActiveWorldDT
        BackgroundDeadSound:play()
    end

end

local function ShiftBackToNormalWorld()

    if ShiftActiveWorldTimer == nil then return end
    if love.timer.getTime() >= ShiftActiveWorldTimer then

        ActiveWorld = World
        DataToSave["Day1Events"].HasSeenCultOutsideHouse = true
        for i = 1, 3 do
            NPCs[i]:AllowDrawing(false)
        end
        World:SetEntityToTrackForCamera(Henry)
        BackgroundSound:play()
        BackgroundWindSound:stop()
        BackgroundDeadSound:stop()
        WhatTheTimer = love.timer.getTime() + 2
        World:SetHandleInputCallback(nil)

    end

end

local function CultOutsideHouseUpdate()

    if DataToSave["Day1Events"].HasSeenCultOutsideHouse then
        if NPCs[1].allow_drawing then
            for i = 1, 3 do
                NPCs[i]:AllowDrawing(false)
            end
            World:SetHandleInputCallback(nil)
        end
        return
    end
    CultOutsideLogic()
    ShiftBackToNormalWorld()

end

function Scene.Update()

    ActiveWorld:Update()
    CultOutsideHouseUpdate()

end

function Scene.Draw()

    ActiveWorld:Draw()

end

function Scene.DrawText()

    DrawTextFromCultOutside()
    DrawWhatTheTextIfPossible()

end

function Scene.HandleInput()

    ActiveWorld:HandleInput()

end

function Scene.CanTransition()

    if type(transition) == "table" then
        love.audio.stop()
    end
    return transition

end

function Scene.Reset()

    love.audio.stop()
    BackgroundWindSound:play()

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:FaceDown()

end

return Scene