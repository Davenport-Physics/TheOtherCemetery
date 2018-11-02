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
local Map        = TiledMapClass:new(require("src/levels/maps/interiors/grocery/grocery"))

local StationaryEntity = EntityClass:newMinimal(3*16, 6*16)
local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 3*16, 7*16, 16, 17, 6, .05); Henry:WalkUp();
local NPCs  =
{
    CharacterClass:new("tiles/Characters/Males/M_12.png", 2*16, 4*16, 16, 17, 6, .05),
    CharacterClass:new("tiles/Characters/Females/F_11.png", 2*16, 6*16, 16, 17, 4, .05)
}
NPCs[2]:WalkUp()
local World = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(StationaryEntity)
World:SetHandleInputCallback(function() end)

local ToCityDoor = DoorClass:new(2*16, 8*16, 2*16, 16, "src/levels/day1/scenes/city", 42*16, 41*16)

local GrocerTextExchange =
{
    TextBubbleClass:new(NPCs[2], "pics/share/text/TextBubbleSpeaking.png", "Are you MAD?"),
    TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "Not as much as you,\n love."),
    TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "NOW GET OUT!\n NOW!"),

}
local GrocerDialogExchange = DialogClass:new(GrocerTextExchange, 4)

local TextWhileWalking = TextBubbleClass:new(NPCs[2], "pics/share/text/TextBubbleSpeaking.png", "Hmph")
local WomanWalkerIntructions =
{
    {x = 2*16, y = 8*16}
}
local WomanWalker = WalkerClass:new(NPCs[2], "path-walker", WomanWalkerIntructions)

local GrocerToHenry =
{
    TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "Ah, Henry is it?"),
    TextBubbleClass:new(Henry, "pics/share/text/TextBubbleSpeaking.png", "Yes ... sir."),
    TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "I'd be careful with the\n people"),
    TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "in this city. They'll \nsurely try to kill you"),
    TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "Although they might do \nme in first"),
    TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "HAHAHAHA"),

}
local GrocerToHenryDialog = DialogClass:new(GrocerToHenry, 4)

local GrocerGeneric = TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "Take what you like.")

local ExchangeHad = false
local WomanLeft   = false
local GrocerHenry = false

local function UpdateDoorTransition()

    transition = ToCityDoor:CheckForCollision(Henry:GetCenterPosition())

end

local function UpdateExchangeHad()

    if ExchangeHad then return end
    if GrocerDialogExchange:IsFinished() then
        ExchangeHad = true
    end

end

local function UpdateWomanLeft()

    if WomanLeft then return end
    if WomanWalker:IsDoneWalking() then
        NPCs[2]:AllowDrawing(false)
        WomanLeft = true
    end
    if ExchangeHad and not WomanLeft then
        WomanWalker:Update()
    end

end

local function UpdateExchangeWithHenry()

    if GrocerHenry then return end
    if GrocerToHenryDialog:IsFinished() then
        GrocerHenry = true
    end

end

local function DrawExchangeIfPossible()

    if not ExchangeHad then
        GrocerDialogExchange:Draw()
    end

end

local function DrawWomanTextLeaving()

    if ExchangeHad and not WomanLeft then
        TextWhileWalking:Draw()
    end

end

local function DrawExchangeWithHenryIfPossible()

    if WomanLeft and not GrocerHenry then
        GrocerToHenry:Draw()
    end

end

local function DrawGenericText()

    if GrocerHenry then
        GrocerGeneric:Draw()
    end

end

function Scene.Update()

    World:Update()
    UpdateExchangeHad()
    UpdateWomanLeft()
    UpdateExchangeWithHenry()

end

function Scene.Draw()

    World:Draw()
    DrawExchangeIfPossible()
    DrawWomanTextLeaving()
    DrawExchangeWithHenryIfPossible()
    DrawGenericText()

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
    Henry:WalkUp(true)

end

return Scene