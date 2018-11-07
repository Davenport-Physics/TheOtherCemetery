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
local Map        = TiledMapClass:new(require("src/levels/maps/interiors/grocery/grocery"))

local BackgroundSound = getStreamSoundFromCache("sound/ambiance/grocery/catchy.wav")
BackgroundSound:setVolume(.5)
BackgroundSound:setLooping(true)

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

local ToCityDoor = DoorClass:new(2*16, 8*16, 2*16, 16, "src/levels/day1/scenes/city/city", 42*16, 41*16)

local GrocerTextExchange =
{
    TextBubbleClass:newSpeaking(NPCs[2], "Are you MAD?"),
    TextBubbleClass:newSpeaking(NPCs[1], "Not as much as you,\n love."),
    TextBubbleClass:newSpeaking(NPCs[1], "NOW GET OUT!\n NOW!"),

}
local GrocerDialogExchange = DialogClass:new(GrocerTextExchange, 4)

local TextWhileWalking = TextBubbleClass:newSpeaking(NPCs[2], "Hmph")
local WomanWalkerIntructions =
{
    path = {
        {x = 2*16, y = 8*16}
    }
}
local WomanWalker = WalkerClass:new(NPCs[2], "path-walker", WomanWalkerIntructions)

local GrocerToHenry =
{
    TextBubbleClass:newSpeaking(NPCs[1], "Ah, Henry is it?"),
    TextBubbleClass:newSpeaking(Henry, "Yes ... sir."),
    TextBubbleClass:newSpeaking(NPCs[1], "I'd be careful with the\n people in this city."),
    TextBubbleClass:newSpeaking(NPCs[1], "They'll surely try to \nkill you,"),
    TextBubbleClass:newSpeaking(NPCs[1], "Although they might do \nme in first."),
    TextBubbleClass:newSpeaking(NPCs[1], "HAHAHAHA"),

}
local GrocerToHenryDialog = DialogClass:new(GrocerToHenry, 4)

local GrocerGeneric = TextBubbleClass:newSpeaking(NPCs[1], "Take whatever you like.")

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
        World:SetEntityToTrackForCamera(Henry)
        World:SetHandleInputCallback(nil)
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
        GrocerToHenryDialog:Draw()
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
    UpdateDoorTransition()

end

function Scene.Draw()

    World:Draw()

end

function Scene.DrawText()

    DrawExchangeIfPossible()
    DrawWomanTextLeaving()
    DrawExchangeWithHenryIfPossible()
    DrawGenericText()

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

    BackgroundSound:play()

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:FaceUp()

end

return Scene