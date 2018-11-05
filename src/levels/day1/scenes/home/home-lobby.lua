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

local MapData = require("src/levels/maps/home/home-lobby")
local Map     = TiledMapClass:new(MapData)

local StationaryEntity = EntityClass:newMinimal(7*16, 6*16)

local Anna  = CharacterClass:new("tiles/Characters/Females/F_01.png", 7 * 16, 4 * 16, 16, 17, 2, .05);
local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 2 * 16, 6 * 16, 16, 17, 6, .05);

local World = WorldClass:new(Map, {Anna}, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local BedroomDoor    = DoorClass:new(2*16, 5*16, 16, 16, "src/levels/day1/scenes/home/henry-bedroom-scene", 7*16, 4*16)
local LeaveHouseDoor = DoorClass:new(2*16, 8*16, 2*16, 16, "src/levels/day1/scenes/city/city", 49 * 16, 61 * 16)
local LeaveHouseDoorAlternative = DoorClass:new(2*16, 8*16, 2*16, 16, "src/levels/day1/scenes/city/cult", 49 * 16, 61 * 16)

local BackgroundSound = getSoundFromCache("sound/ambiance/home/home.mp3")

local SecondaryConversationStarted = false
local FrozeHenry                   = false

local transition = false
local function CheckDoorCollisions()

    if type(BedroomDoor:CheckForCollision(Henry:GetCenterPosition())) == "table" then
        transition = BedroomDoor:CheckForCollision(Henry:GetCenterPosition())
    elseif not DataToSave["Day1Events"].SpokeWithMomAfterSchool and type(LeaveHouseDoor:CheckForCollision(Henry:GetCenterPosition())) == "table" then
        transition = LeaveHouseDoor:CheckForCollision(Henry:GetCenterPosition())
    elseif DataToSave["Day1Events"].SpokeWithMomAfterSchool and type(LeaveHouseDoorAlternative:CheckForCollision(Henry:GetCenterPosition())) == "table" then
        transition = LeaveHouseDoorAlternative:CheckForCollision(Henry:GetCenterPosition())
    end

    if type(transition) == table then
        DataToSave.CurrentScene = transition[1]
    end

end

local LoveYouText = TextBubbleClass:newSpeaking(Anna, "Have a good day at \nschool!")

local TextBetweenHenryAndMom =
{

    TextBubbleClass:newSpeaking(Anna , "Hey! Did you have a good \nday at school?"),
    TextBubbleClass:newSpeaking(Henry, "It ... was okay."),
    TextBubbleClass:newSpeaking(Anna , "Well that’s good to hear."),
    TextBubbleClass:newSpeaking(Anna , "I had a fairly weird day \nmyself."),
    TextBubbleClass:newSpeaking(Anna , "I went to the grocery store \nto get some food and"),
    TextBubbleClass:newSpeaking(Anna , "as I was going to checkout,"),
    TextBubbleClass:newSpeaking(Anna , "I realized there wasn’t \nanyone in the store"),
    TextBubbleClass:newSpeaking(Anna , "I thought I had saw a clerk or \ntwo when I entered,"),
    TextBubbleClass:newSpeaking(Anna , "but I don’t know. . ."),
    TextBubbleClass:newSpeaking(Anna , "Anyways, I’m going to \nmake dinner in an hour."),
    TextBubbleClass:newSpeaking(Anna , "So if you any homework \nor if you want to go"),
    TextBubbleClass:newSpeaking(Anna , "play outside, now’s your \nchance"),

}
local DialogBetweenHenryAndMom = DialogClass:new(TextBetweenHenryAndMom, 3.25)

local function CheckIfSpeakingToMomShouldToggleSaveData()
    if DialogBetweenHenryAndMom:IsFinished() then
        DataToSave["Day1Events"].SpokeWithMomAfterSchool = true
    end
end

local function DrawTextFromAnna()

    if not DataToSave["Day1Events"].WentToSchool then
        LoveYouText:Draw()
    elseif not SecondaryConversationStarted then
        SecondaryConversationStarted = true
    elseif not DialogBetweenHenryAndMom:IsFinished() then
        DialogBetweenHenryAndMom:Draw()
        CheckIfSpeakingToMomShouldToggleSaveData()
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