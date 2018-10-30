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
local TextBubbleClass = require("src/character/textbubbles")
local DialogClass     = require("src/dialog/dialog")

local MapData = require("src/levels/day0/maps/home-lobby")
local Map     = TiledMapClass:new(MapData)

local StationaryEntity = EntityClass:newMinimal(7*16, 6*16)

local Anna  = CharacterClass:new("tiles/Characters/Females/F_01.png", 7 * 16, 4 * 16, 16, 17, 2, .05);
local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 2 * 16, 6 * 16, 16, 17, 6, .05);

local World = WorldClass:new(Map, {Anna}, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local BedroomDoor    = DoorClass:new(2*16, 5*16, 16, 16, "src/levels/day1/scenes/henry-bedroom-scene", 7*16, 4*16)
local LeaveHouseDoor = DoorClass:new(2*16, 8*16, 2*16, 16, "src/levels/day1/scenes/city", 49 * 16, 61 * 16)

local BackgroundSound = getSoundFromCache("sound/ambiance/home/home.mp3")

local SecondaryConversationStarted = false
local FrozeHenry                   = false

local transition = false
local function CheckDoorCollisions()

    if type(BedroomDoor:CheckForCollision(Henry:GetCenterPosition())) == "table" then
        transition = BedroomDoor:CheckForCollision(Henry:GetCenterPosition())
    elseif type(LeaveHouseDoor:CheckForCollision(Henry:GetCenterPosition())) == "table" then
        transition = LeaveHouseDoor:CheckForCollision(Henry:GetCenterPosition())
    end

    if type(transition) == table then
        DataToSave.CurrentScene = transition[1]
    end

end

local LoveYouText = TextBubbleClass:new(Anna, "pics/share/text/TextBubbleSpeaking.png", "Have a good day at school!", 7)

local TextBetweenHenryAndMom =
{

    TextBubbleClass:new(Anna , "pics/share/text/TextBubbleSpeaking.png", "Hey! Did you have a good \nday at school?"),
    TextBubbleClass:new(Henry, "pics/share/text/TextBubbleSpeaking.png", "It. . . was okay."),
    TextBubbleClass:new(Anna , "pics/share/text/TextBubbleSpeaking.png", "Well that’s good to hear."),
    TextBubbleClass:new(Anna , "pics/share/text/TextBubbleSpeaking.png", "I had a fairly weird day myself."),
    TextBubbleClass:new(Anna , "pics/share/text/TextBubbleSpeaking.png", "I went to the grocery store \nto get some food and"),
    TextBubbleClass:new(Anna , "pics/share/text/TextBubbleSpeaking.png", "as I was going to checkout,"),
    TextBubbleClass:new(Anna , "pics/share/text/TextBubbleSpeaking.png", "I realized there wasn’t anyone \nin the store"),
    TextBubbleClass:new(Anna , "pics/share/text/TextBubbleSpeaking.png", "I thought I had saw a clerk or \ntwo when I entered,"),
    TextBubbleClass:new(Anna , "pics/share/text/TextBubbleSpeaking.png", "but I don’t know. . ."),
    TextBubbleClass:new(Anna , "pics/share/text/TextBubbleSpeaking.png", "Anyways, I’m going to \nmake dinner in an hour."),
    TextBubbleClass:new(Anna , "pics/share/text/TextBubbleSpeaking.png", "So if you any homework \nor if you want to go"),
    TextBubbleClass:new(Anna , "pics/share/text/TextBubbleSpeaking.png", "play outside, now’s your \nchance"),

}
local DialogBetweenHenryAndMom = DialogClass:new(TextBetweenHenryAndMom, 3.25)

local function DrawTextFromAnna()

    if not DataToSave["Day1Events"].WentToSchool then
        LoveYouText:Draw()
    elseif not SecondaryConversationStarted then
        SecondaryConversationStarted = true
    elseif not DialogBetweenHenryAndMom:IsFinished() then
        DialogBetweenHenryAndMom:Draw()
    end

end

local function CheckIfPlayerIsCloseToAnna()

    if not Shared.IsNear(Henry.x_pos, Henry.y_pos, Anna.x_pos, Anna.y_pos, 64) then
        return
    end
    DrawTextFromAnna()

end

local function UpdateSounds()

    if not BackgroundSound:isPlaying() then
        BackgroundSound:setVolume(.5)
        BackgroundSound:play()
    end

end

local function UpdateHenryForFreezing()

    if not SecondaryConversationStarted then return end
    if not FrozeHenry then
        FrozeHenry = true
        World:SetHandleInputCallback(function() end)
        World:SetEntityToTrackForCamera(StationaryEntity)
    end
    if DialogBetweenHenryAndMom:IsFinished() then
        World:SetHandleInputCallback(nil)
        World:SetEntityToTrackForCamera(Henry)
    end

end

function Scene.Update()

    World:Update()
    CheckDoorCollisions()
    UpdateSounds()
    UpdateHenryForFreezing()

end

function Scene.Draw()

    World:Draw()
    CheckIfPlayerIsCloseToAnna()

end

function Scene.HandleInput()

    World:HandleInput()

end

function Scene.CanTransition()

    return transition

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition  = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:WalkDown(true)

end

function Scene.Reset()

end

return Scene