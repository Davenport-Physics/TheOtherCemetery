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
local Map        = TiledMapClass:new(require("src/levels/maps/interiors/neighbour/lobby"))

local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 2*16, 7*16, 16, 17, 9, .075); Henry:FaceUp();
local NPCs  =
{
    CharacterClass:new("tiles/Characters/Females/F_11.png", 7*16, 4*16, 16, 17, 4, .05), -- Woman
    CharacterClass:new("tiles/Characters/Males/M_04.png", 8*16, 4*16, 16, 17, 4, .05) -- Husband
}
NPCs[1]:FaceRight()
NPCs[2]:FaceLeft()

local StationaryEntity = EntityClass:newMinimal(6*16, 6*16)
local World = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(StationaryEntity)
World:SetHandleInputCallback(function() end)

local Doors =
{
    DoorClass:new(2*16, 8*16, 2*16, 16, "src/levels/day1/scenes/city/city", 41*16, 60*16)
}

local DoorHandler = DoorsHandler:new(Doors, Henry)

local ConversationText =
{
    TextBubbleClass:newSpeaking(NPCs[1], "This time of year I can't stop\n thinking about Joy."),
    TextBubbleClass:newSpeaking(NPCs[2], "..."),
    TextBubbleClass:newSpeaking(NPCs[1], "We should have just left."),
    TextBubbleClass:newSpeaking(NPCs[2], "You know why we ca..."),
    TextBubbleClass:newSpeaking(NPCs[1], "Oh give me a break."),
    TextBubbleClass:newSpeaking(NPCs[2], "I miss her too, okay?!")
}
local DialogConversationHandler = DialogClass:new(ConversationText, 3)

local function DoorCollisionChecks()

    transition = DoorHandler:CheckForCollisions()
    if type(transition) == "table" then
        DataToSave.CurrentScene = transition[1]
    end

end

local function GiveControlToHenryIfPossible()

    if not DataToSave["Day1Events"].NeighbourConversationSeen and DialogConversationHandler:IsFinished() then

        DataToSave["Day1Events"].NeighbourConversationSeen = true
        World:SetHandleInputCallback(nil)
        World:SetEntityToTrackForCamera(Henry)

    end

end

local function DrawConversationBetweenManAndWoman()

    if not DataToSave["Day1Events"].NeighbourConversationSeen then
        DialogConversationHandler:Draw()
    end

end

function Scene.Update()

    World:Update()
    DoorCollisionChecks()
    GiveControlToHenryIfPossible()

end

function Scene.Draw()

    World:Draw()

end

function Scene.DrawText()

    DrawConversationBetweenManAndWoman()

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
    Henry:FaceUp()

end

return Scene