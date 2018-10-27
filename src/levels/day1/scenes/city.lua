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

local MapData = require("src/levels/day0/maps/city")
local Map     = TiledMapClass:new(MapData)
local Henry   = CharacterClass:new("tiles/Characters/Males/M_08.png", 49 * 16, 62 * 16, 16, 17, 6, .05);

local HomeDoor = DoorClass:new(49 * 16, 60 * 16, 16, 16, "src/levels/day1/scenes/home-lobby", 2*16, 7*16)

local NPCs =
{

    CharacterClass:new("tiles/Characters/Males/M_05.png", 33*16, 62*16, 16, 17, 4, .05),   -- Key Person
    CharacterClass:new("tiles/Characters/Females/F_08.png", 20*16, 43*16, 16, 17, 4, .05), -- Going To Work
    CharacterClass:new("tiles/Characters/Females/F_07.png", 33*16, 39*16, 16, 17, 4, .05), -- Kid Going To School

}
NPCs[1]:WalkLeft()
NPCs[2]:WalkLeft()
NPCs[3]:WalkUp()

local FemaleGoingToWorkWalkerInstructions =
{
    {x = 17*16, y = 43*16},
    {x = 17*16, y = 41*16}
}

local KidGoingToSchoolWalkerInstructions =
{
    {x = 33*16, y = 22*16},
    {x = 44*16, y = 22*16},
    {x = 44*16, y = 9*16},
    {x = 40*16, y = 9*16},
    {x = 40*16, y = 7*16},
    {x = 37*16, y = 7*16},
    {x = 37*16, y = 6*16}
}

local NPCWalkers =
{

    WalkerClass:new(NPCs[2], "path-walker", FemaleGoingToWorkWalkerInstructions),
    WalkerClass:new(NPCs[3], "path-walker", KidGoingToSchoolWalkerInstructions)

}

local NPCWalkersCanWalk = {false, false}

local World   = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local transition = false

local function DoorCollisionChecks()

    transition = HomeDoor:CheckForCollision(Henry:GetCenterPosition())
    if type(transition) == "table" then
        DataToSave.CurrentScene = transition[1]
    end

end

local function NPCWalkerUpdates()

    for i = 1, #NPCWalkers do
        if NPCWalkersCanWalk[i] then
            NPCWalkers[i]:Update()
        end
        if NPCWalkers[i]:IsDoneWalking() then
            NPCs[i+1]:AllowDrawing(false)
        end
    end

end

local function NPCWalkerConditions()

    for i = 1, #NPCWalkersCanWalk do
        if Shared.IsNear(Henry.x_pos, Henry.y_pos, NPCs[i+1].x_pos, NPCs[i+1].y_pos, 100) then
            NPCWalkersCanWalk[i] = true
        end
    end

end

local function NPCUpdates()

    NPCWalkerConditions()
    NPCWalkerUpdates()

end

function Scene.Update()

    World:Update()
    DoorCollisionChecks()
    NPCUpdates()

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

        if Shared.IsNear(Henry.x_pos, Henry.y_pos, DoNotGoInText[i].x_pos, DoNotGoInText[i].y_pos, 17) then
            DoNotGoInText[i].text:Draw()
        end

    end

end

local KeyNPCText = TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "What is wrong ... OPEN!")
local function DrawKeyNPCTextIfPossible()

    if Shared.IsNear(Henry.x_pos, Henry.y_pos, NPCs[1].x_pos, NPCs[1].y_pos, 100) then
        KeyNPCText:Draw()
    end

end

local KidNPCText = TextBubbleClass:new(NPCs[3], "pics/share/text/TextBubbleSpeaking.png", "Gahh, I'm going to be late!")
local function DrawKidNPCTextIfPossible()

    if Shared.IsNear(Henry.x_pos, Henry.y_pos, NPCs[3].x_pos, NPCs[3].y_pos, 100) and NPCs[3].allow_drawing then
        KidNPCText:Draw()
    end

end

local AdultGoingToWorkText = TextBubbleClass:new(NPCs[2], "pics/share/text/TextBubbleSpeaking.png", "NEED COFFEE")
local function DrawAdultTextIfPossible()

    if Shared.IsNear(Henry.x_pos, Henry.y_pos, NPCs[2].x_pos, NPCs[2].y_pos, 100) and NPCs[2].allow_drawing then
        AdultGoingToWorkText:Draw()
    end

end


local function DrawNPCTextIfPossible()

    DrawKeyNPCTextIfPossible()
    DrawAdultTextIfPossible()
    DrawKidNPCTextIfPossible()

end

function Scene.Draw()

    World:Draw()
    DrawHenryStopTextBubblesIfPossible()
    DrawNPCTextIfPossible()

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