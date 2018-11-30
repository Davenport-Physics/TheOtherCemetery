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

local transition = false
local Map        = TiledMapClass:new(require("src/levels/maps/interiors/neighbour/lobby2"))
local NPCs =
{
    CharacterClass:newFemale("F_03", 2, 6)
}; NPCs[1]:FaceUp();

local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 5*16, 7*16, 16, 17, 9, .075); Henry:FaceUp();
local World = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local door = DoorClass:new(2*16, 8*16, 2*16, 16, "src/levels/day1/scenes/city/city", 23*16, 60*16)
local DoorHandler = DoorsHandler:new({door}, Henry)

local function UpdateDoorTransition()

    transition = DoorHandler:CheckForCollisions()
    if type(transition) == "table" then
        DataToSave.CurrentScene = transition[1]
    end

end

local delay = nil
local startedtext = false
local seentext    = false
local textconversation =
{
    TextBubbleClass:newSpeaking(NPCs[1], "Oh! Henry, you should have \nknocked."),
    TextBubbleClass:newSpeaking(Henry, "Sorr..."),
    TextBubbleClass:newSpeaking(NPCs[1], "Oh, it's okay. It's not often \nyou get to meet a..."),
    TextBubbleClass:newSpeaking(NPCs[1], "I think it's been two years \nsince the last one."),
    TextBubbleClass:newSpeaking(NPCs[1], "Hmm..."),
    TextBubbleClass:newSpeaking(Henry, "What do you mean...?"),
    TextBubbleClass:newSpeaking(NPCs[1], "Oh, nothing you have to \nworry about now."),
}; local dialogconversation = DialogClass:new(textconversation, 3.25);
local stationarycamera = EntityClass:newMinimal(5*16, 6*16)

local function UpdateSeenText()

    if seentext then
        DataToSave["Day1Events"].NeighbourConversationSeen2 = true
        World:SetHandleInputCallback(nil)
        World:SetEntityToTrackForCamera(Henry)
        NPCs[1]:FaceUp()
    end

end

local function UpdateDelay()

    if delay == nil then
        delay = love.timer.getTime() + .5
        World:SetHandleInputCallback(function() end)
        World:SetEntityToTrackForCamera(stationarycamera)
    end

end

local function CheckTimer()

    if love.timer.getTime() >= delay then
        startedtext = true
        NPCs[1]:FaceDown()
    end

end

local function UpdateText()

    if DataToSave["Day1Events"].NeighbourConversationSeen2 then
        return
    end
    UpdateSeenText()
    UpdateDelay()
    CheckTimer()

end

local function DrawConversation()

    if DataToSave["Day1Events"].NeighbourConversationSeen2 then
        return
    end
    if startedtext then
        dialogconversation:Draw()
    end
    if dialogconversation:IsFinished() then
        seentext = true
    end

end

function Scene.Update()

    World:Update()
    UpdateDoorTransition()
    UpdateText()

end

function Scene.Draw()

    World:Draw()

end

function Scene.DrawText()

    DrawConversation()

end

function Scene.HandleInput()

    World:HandleInput()

end

function Scene.Clean()

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
    Henry:FaceUp()

end

return Scene