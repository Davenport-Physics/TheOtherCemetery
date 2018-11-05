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
local DoorsHandler    = require("src/entity/doorhandler")

local BackgroundSound = getStreamSoundFromCache("sound/ambiance/city.wav")
local SchoolBell      = nil--

local MapData = require("src/levels/maps/city/city")
local Map     = TiledMapClass:new(MapData)
local Henry   = CharacterClass:new("tiles/Characters/Males/M_08.png", 49 * 16, 62 * 16, 16, 17, 6, .05);

local HomeDoor      = DoorClass:new(49 * 16, 60 * 16, 16, 16,  "src/levels/day1/scenes/home/home-lobby", 2*16, 7*16)
local SchoolDoor    = DoorClass:new(36 * 16, 5 * 16, 2*16, 16, "src/levels/day1/scenes/school/school",   7*16, 27*16)
local GroceryDoor   = DoorClass:new(42 * 16, 40 * 16, 16, 16, "src/levels/day1/scenes/interiors/grocery", 3*16, 7*16)
local CollectorDoor = DoorClass:new(16 * 16, 40 * 16, 2*16, 16, "src/levels/day1/scenes/interiors/collector", 11*16, 12*16)

local Doors = DoorsHandler:new({HomeDoor, SchoolDoor, GroceryDoor, CollectorDoor}, Henry)

local NPCs =
{

    CharacterClass:new("tiles/Characters/Males/M_05.png", 33*16, 62*16, 16, 17, 4, .05),   -- Key Person
    CharacterClass:new("tiles/Characters/Females/F_08.png", 30*16, 43*16, 16, 17, 4, .05), -- Going To Work
    CharacterClass:new("tiles/Characters/Females/F_07.png", 33*16, 43*16, 16, 17, 4, .05), -- Kid Going To School
    CharacterClass:new("tiles/Characters/Females/F_05.png", 39*16, 43*16, 16, 17, 4, .05)  -- Lady turning

}
NPCs[1]:WalkLeft()
NPCs[2]:WalkLeft()
NPCs[3]:WalkUp()

local FemaleGoingToWorkWalkerInstructions =
{
    path =
    {{x = 17*16, y = 43*16},
    {x = 17*16, y = 41*16}}
}

local KidGoingToSchoolWalkerInstructions =
{
    path =
    {{x = 33*16, y = 22*16},
    {x = 44*16, y = 22*16},
    {x = 44*16, y = 9*16},
    {x = 40*16, y = 9*16},
    {x = 40*16, y = 7*16},
    {x = 37*16, y = 7*16},
    {x = 37*16, y = 6*16}},
    debug = true
}

local TurnWalkerInstructions =
{
    CurrentDirection = "Down",
    DirectionDt      = 1
}

local NPCWalkers =
{

    WalkerClass:new(NPCs[2], "path-walker", FemaleGoingToWorkWalkerInstructions),
    WalkerClass:new(NPCs[3], "path-walker", KidGoingToSchoolWalkerInstructions),
    WalkerClass:new(NPCs[4], "turn-walker", TurnWalkerInstructions)

}

local NPCWalkersCanWalk = {false, false}

local World   = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local transition = false

local function CheckIfNearSchoolDoor()

    if SchoolBell ~= nil then return end
    if math.sqrt((Henry.x_pos - 36 * 16)^2 + (Henry.y_pos - 5 * 16)^2) < 200 then

        SchoolBell = getSoundFromCache("sound/shorts/school-bell.wav")
        SchoolBell:setVolume(.5)
        SchoolBell:play()

    end

end

local function DoorCollisionChecks()

    transition = Doors:CheckForCollisions()
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
        if Shared.IsNear(Henry.x_pos, Henry.y_pos, NPCs[i+1].x_pos, NPCs[i+1].y_pos, 144) then
            NPCWalkersCanWalk[i] = true
        end
    end

end

local function NPCUpdates()

    NPCWalkers[3]:Update()
    NPCWalkerConditions()
    NPCWalkerUpdates()

end

local function SoundUpdates()
    if not BackgroundSound:isPlaying() and not DataToSave["Day1Events"].WentToSchool then
        BackgroundSound = getStreamSoundFromCache("sound/ambiance/city.wav")
        BackgroundSound:setVolume(.5)
        BackgroundSound:setLooping(true)
        BackgroundSound:play()
    elseif not BackgroundSound:isPlaying() and DataToSave["Day1Events"].WentToSchool then
        BackgroundSound = getStreamSoundFromCache("sound/ambiance/city-slow.wav")
        BackgroundSound:setVolume(.5)
        BackgroundSound:setLooping(true)
        BackgroundSound:play()
    end
end

function Scene.Update()

    World:Update()
    DoorCollisionChecks()
    NPCUpdates()
    SoundUpdates()
    CheckIfNearSchoolDoor()

end


local DoNotGoInText =
{
    {x_pos = 23*16, y_pos = 59*16, text = TextBubbleClass:newThought(Henry, "Locked...")},
    {x_pos = 29*16, y_pos = 59*16, text = TextBubbleClass:newThought(Henry, "Locked...")},
    {x_pos = 35*16, y_pos = 59*16, text = TextBubbleClass:newThought(Henry, "Locked...")},
    {x_pos = 41*16, y_pos = 59*16, text = TextBubbleClass:newThought(Henry, "Locked...")},
    {x_pos = 16*16, y_pos = 40*16, text = TextBubbleClass:newThought(Henry, "I shouldn't go here")},
    {x_pos = 25*16, y_pos = 41*16, text = TextBubbleClass:newThought(Henry, "I shouldn't go here")},
    {x_pos = 53*16, y_pos = 37*16, text = TextBubbleClass:newThought(Henry, "...")},
    {x_pos = 36*16, y_pos = 41*16, text = TextBubbleClass:newThought(Henry, "I shouldn't go here")},
    {x_pos = 67*16, y_pos = 8*16, text = TextBubbleClass:newThought( Henry, "I shouldn't go here")},
    {x_pos = 74*16, y_pos = 6*16, text = TextBubbleClass:newThought( Henry, "Nothing here..."), range = 48},

}
local FamiliarPlace =
{

    {x_pos = 74*16, y_pos = 7*16, text = TextBubbleClass:newThought(Henry, "Have I seen this before?")},

}
local function DrawHenryStopTextBubblesAfterSchoolIfPossible()

    for i = 1, #DoNotGoInText-1 do
        if Shared.IsNear(Henry.x_pos, Henry.y_pos, DoNotGoInText[i].x_pos, DoNotGoInText[i].y_pos, DoNotGoInText[i].range or 17) then
            DoNotGoInText[i].text:Draw()
        end
    end
    if Shared.IsNear(Henry.x_pos, Henry.y_pos, FamiliarPlace[1].x_pos, FamiliarPlace[1].y_pos, 48) then
        FamiliarPlace[1].text:Draw()
    end

end

local function DrawHenryStopTextBubblesBeforeSchoolIfPossible()

    for i = 1, #DoNotGoInText do
        if Shared.IsNear(Henry.x_pos, Henry.y_pos, DoNotGoInText[i].x_pos, DoNotGoInText[i].y_pos, DoNotGoInText[i].range or 17) then
            DoNotGoInText[i].text:Draw()
        end
    end


end

local function DrawHenryStopTextBubblesIfPossible()

    if not DataToSave["Day1Events"].WentToSchool then
        DrawHenryStopTextBubblesBeforeSchoolIfPossible()
    else
        DrawHenryStopTextBubblesAfterSchoolIfPossible()
    end

end

local KeyNPCText = TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "What is wrong ... OPEN!")
local function DrawKeyNPCTextIfPossible()

    if not NPCs[1].allow_drawing then return end
    if Shared.IsNear(Henry.x_pos, Henry.y_pos, NPCs[1].x_pos, NPCs[1].y_pos, 100) then
        KeyNPCText:Draw()
    end

end

local AdultGoingToWorkText = TextBubbleClass:new(NPCs[2], "pics/share/text/TextBubbleSpeaking.png", "NEED COFFEE")
local function DrawAdultTextIfPossible()

    if not NPCs[2].allow_drawing then return end
    if Shared.IsNear(Henry.x_pos, Henry.y_pos, NPCs[2].x_pos, NPCs[2].y_pos, 100) then
        AdultGoingToWorkText:Draw()
    end

end

local KidNPCText = TextBubbleClass:new(NPCs[3], "pics/share/text/TextBubbleSpeaking.png", "Gahh, I'm going to be late!")
local function DrawKidNPCTextIfPossible()

    if not NPCs[3].allow_drawing then return end
    if Shared.IsNear(Henry.x_pos, Henry.y_pos, NPCs[3].x_pos, NPCs[3].y_pos, 100) then
        KidNPCText:Draw()
    end

end

local CrazyNPCText = TextBubbleClass:new(NPCs[4], "pics/share/text/TextBubbleSpeaking.png", "You and your mom are \nspecial.")
local function DrawCrazyTextIfPossible()

    if not NPCs[4].allow_drawing then return end
    if Shared.IsNear(Henry.x_pos, Henry.y_pos, NPCs[4].x_pos, NPCs[4].y_pos, 48) then
        CrazyNPCText:Draw()
    end

end

local function DrawNPCTextIfPossible()

    DrawKeyNPCTextIfPossible()
    DrawAdultTextIfPossible()
    DrawKidNPCTextIfPossible()
    DrawCrazyTextIfPossible()

end

local function StopDrawingNPCs()

    for i = 1, #NPCWalkers do
        NPCWalkersCanWalk[i] = false
        NPCs[i+1]:AllowDrawing(false)
    end
    NPCs[1]:AllowDrawing(false)
    NPCs[4]:AllowDrawing(false)

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

    if type(transition) == "table" then
        love.audio.stop()
    end

    return transition

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:WalkDown(true)

end

function Scene.Reset()

    love.audio.stop()
    if DataToSave["Day1Events"].WentToSchool then
        StopDrawingNPCs()
    end

end

return Scene