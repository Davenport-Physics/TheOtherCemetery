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
local Map        = TiledMapClass:new(require("src/levels/maps/school/butchery"))

local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 5*16, 7*16, 16, 17, 9, .075); Henry:FaceUp();
local NPCs  =
{
    CharacterClass:newMale("M_10", 4, 4),
    CharacterClass:newMale("M_02", 5, 5),
    CharacterClass:newMale("M_03", 6, 4)
}
NPCs[1]:FaceRight()
NPCs[2]:FaceUp()
NPCs[3]:FaceLeft()
local World = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)
World:SetTimeCycle("Afternoon")
local dialogstarted = false
local dialogtoHenrystarted = false

local textbetweenNPCS =
{
    TextBubbleClass:newSpeaking(NPCs[3], "It never feels right"),
    TextBubbleClass:newSpeaking(NPCs[2], "No, but we have to do it"),
    TextBubbleClass:newSpeaking(NPCs[2], "At least it isn't one of your \nown, right?")
}; local dialogbetweenNPCS = DialogClass:new(textbetweenNPCS, 3.25);

local textbetweenNPCandHenry =
{
    TextBubbleClass:newSpeaking(NPCs[2], "Oh Henry..."),
    TextBubbleClass:newSpeaking(NPCs[2], "Shouldn't you be at home?"),
    TextBubbleClass:newSpeaking(Henry, "..."),
    TextBubbleClass:newSpeaking(NPCs[2], "Go home Henry"),
}; local dialogtoHenry = DialogClass:new(textbetweenNPCandHenry, 3.25);

local function HandleFirstDialog()

    if dialogstarted then return end
    dialogstarted = true
    World:SetHandleInputCallback(function() end)

end

local function HandleSecondDialog()

    if dialogtoHenrystarted then return end
    if dialogstarted and dialogbetweenNPCS:IsFinished() then
        dialogtoHenrystarted = true
        for i = 1, #NPCs do
            NPCs[i]:FaceDown()
        end
    end

end

local function ThrowHenryOutIfPossible()

    if dialogtoHenry:IsFinished() then
        DataToSave["Day1Events"].DialogInButcherySeen = true
        print(DataToSave["Day1Events"].DialogInButcherySeen)
        transition = {"src/levels/day1/scenes/city/city", 20*16, 4*16}
    end

end

local function UpdateDialogExchange()

    if DataToSave["Day1Events"].DialogInButcherySeen then return end
    HandleFirstDialog()
    HandleSecondDialog()
    ThrowHenryOutIfPossible()

end

local function DrawFirstDialogIfPossible()

    if dialogbetweenNPCS:IsFinished() then return end
    if not dialogstarted then return end
    dialogbetweenNPCS:Draw()

end

local function DrawSecondDialogIfPossible()

    if dialogtoHenry:IsFinished() then return end
    if not dialogtoHenrystarted then return end
    dialogtoHenry:Draw()

end

local function DrawDialog()

    if DataToSave["Day1Events"].DialogInButcherySeen then return end
    DrawFirstDialogIfPossible()
    DrawSecondDialogIfPossible()

end

function Scene.Update()

    World:Update()
    UpdateDialogExchange()

end

function Scene.Draw()

    World:Draw()


end

function Scene.DrawText()

    DrawDialog()

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