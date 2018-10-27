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

local MapData = require("src/levels/day0/maps/city")
local Map     = TiledMapClass:new(MapData)
local Henry   = CharacterClass:new("tiles/Characters/Males/M_08.png", 49 * 16, 62 * 16, 16, 17, 6, .05);

local HomeDoor = DoorClass:new(49 * 16, 60 * 16, 16, 16, "src/levels/day1/scenes/home-lobby", 2*16, 7*16)

local World   = WorldClass:new(Map, {}, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local transition = false

local function DoorCollisionChecks()

    transition = HomeDoor:CheckForCollision(Henry:GetCenterPosition())
    if type(transition) == "table" then
        DataToSave.CurrentScene = transition[1]
    end

end

function Scene.Update()

    World:Update()
    DoorCollisionChecks()

end


local DoNotGoInText =
{
    {x_pos = 23*16, y_pos = 59*16, text = TextBubbleClass:new(Henry, "pics/share/text/TextBubbleSpeaking.png", "Locked...")},
    {x_pos = 29*16, y_pos = 59*16, text = TextBubbleClass:new(Henry, "pics/share/text/TextBubbleSpeaking.png", "Locked...")},
    {x_pos = 35*16, y_pos = 59*16, text = TextBubbleClass:new(Henry, "pics/share/text/TextBubbleSpeaking.png", "Locked...")},
    {x_pos = 41*16, y_pos = 59*16, text = TextBubbleClass:new(Henry, "pics/share/text/TextBubbleSpeaking.png", "Locked...")},
    {x_pos = 16*16, y_pos = 40*16, text = TextBubbleClass:new(Henry, "pics/share/text/TextBubbleSpeaking.png", "I shouldn't go here")},
    {x_pos = 25*16, y_pos = 41*16, text = TextBubbleClass:new(Henry, "pics/share/text/TextBubbleSpeaking.png", "I should go to school")},
    {x_pos = 53*16, y_pos = 37*16, text = TextBubbleClass:new(Henry, "pics/share/text/TextBubbleSpeaking.png", "...")},
    {x_pos = 42*16, y_pos = 40*16, text = TextBubbleClass:new(Henry, "pics/share/text/TextBubbleSpeaking.png", "I should go to school")},
    {x_pos = 36*16, y_pos = 41*16, text = TextBubbleClass:new(Henry, "pics/share/text/TextBubbleSpeaking.png", "I shouldn't go here")},

}
local function DrawHenryStopTextBubblesIfPossible()

    for i = 1, #DoNotGoInText do

        if Shared.IsNear(Henry.x_pos, Henry.y_pos, DoNotGoInText[i].x_pos, DoNotGoInText[i].y_pos, 16) then
            DoNotGoInText[i].text:Draw()
        end

    end

end

function Scene.Draw()

    World:Draw()
    DrawHenryStopTextBubblesIfPossible()

end

function Scene.HandleInput()

    World:HandleInput()

end

function Scene.CanTransition()

    return transition

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:WalkDown(true)

end

function Scene.Reset()

end

return Scene