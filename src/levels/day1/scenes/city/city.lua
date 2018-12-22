require("src/shared/cache")
local bit = require("bit")
local DataToSave = require("src/save/savingdata")
local Shared     = require("src/shared/shared")
local Scene = {}

local Settings        = require("src/settings/settings")
local CameraClass     = require("src/camera/camera")
local EntityClass     = require("src/entity/entity")
local WorldClass      = require("src/world/world")
local DoorClass       = require("src/entity/door")
local CharacterClass  = require("src/character/character")
local TiledMapClass   = require("src/map/tiledmap")
local WalkerClass     = require("src/characterwalker/walker-generic")
local TextBubbleClass = require("src/character/textbubbles")
local DialogClass     = require("src/dialog/dialog")
local DoorsHandler    = require("src/entity/doorhandler")

local BackgroundSound = getStreamSoundFromCache("sound/ambiance/city.wav")
local SchoolBell      = nil--

local MapData = require("src/levels/maps/city/city")
local Map     = TiledMapClass:new(MapData)
local Henry   = CharacterClass:new("tiles/Characters/Males/M_08.png", 49 * 16, 62 * 16, 16, 17, 9, .075);

local Doors =
{
    DoorClass:new(49 * 16, 60 * 16, 16, 16,  "src/levels/day1/scenes/home/home-lobby", 2*16, 7*16),
    DoorClass:new(36 * 16, 5 * 16, 2*16, 16, "src/levels/day1/scenes/school/school",   7*16, 27*16),
    DoorClass:new(42 * 16, 40 * 16, 16, 16, "src/levels/day1/scenes/interiors/grocery", 3*16, 7*16),
    DoorClass:new(16 * 16, 40 * 16, 2*16, 16, "src/levels/day1/scenes/interiors/collector", 11*16, 12*16),
    DoorClass:new(53 * 16, 37 * 16, 2*16, 16, "src/levels/day1/scenes/interiors/funeral", 8*16, 16*16),
    DoorClass:new(41 * 16, 59 * 16, 16, 16, "src/levels/day1/scenes/interiors/neighbour", 2*16, 7*16),
    DoorClass:new(19 * 16, 3 * 16, 2*16, 16, "src/levels/day1/scenes/school/butchery", 5*16, 7*16),
    DoorClass:new(23 * 16, 59 * 16, 16, 16, "src/levels/day1/scenes/interiors/neighbour2", 2*16, 7*16),
    DoorClass:new(36 * 16, 41 * 16, 16, 16, "src/levels/day1/scenes/example/example-insult", 2*16, 7*16) -- Example Door
}
local DoorHandler = DoorsHandler:new(Doors, Henry)
DoorHandler:ToggleDoor(7, false)

local NPCs =
{

    CharacterClass:newMale("M_05", 33, 62, 4, .06),    -- Key Person
    CharacterClass:newFemale("F_08", 30, 43, 4, .06),  -- Going To Work
    CharacterClass:newFemale("F_07", 33, 43, 4, .06),  -- Kid Going To School
    CharacterClass:newFemale("F_05", 39, 43, 4, .06),  -- Lady turning
    CharacterClass:newFemale("F_03", 41, 46, 4, .06),  -- Couple Bickering
    CharacterClass:newFemale("F_10", 42, 46, 4, .06),  -- Coupler Bickering
    CharacterClass:newMale("M_01", 63, 64, 4, .06)     -- Kid running around

}
NPCs[1]:FaceLeft()
NPCs[2]:FaceLeft()
NPCs[3]:FaceUp()
NPCs[5]:FaceRight()
NPCs[6]:FaceLeft()
NPCs[7]:FaceUp()

NPCs[5]:AllowDrawing(false)
NPCs[6]:AllowDrawing(false)

local KidRunningAroundFountain =
{
    cycle = true,
    path =
    {
        {x = 63*16, y = 60*16},
        {x = 68*16, y = 60*16},
        {x = 68*16, y = 64*16},
        {x = 63*16, y = 64*16}

    }
}

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
    WalkerClass:new(NPCs[4], "turn-walker", TurnWalkerInstructions),
    WalkerClass:new(NPCs[7], "path-walker", KidRunningAroundFountain)

}
local NPCTurners =
{
    WalkerClass:new(NPCs[2], "turn-walker", {CurrentDirection = "Left", DirectionDt = 1.5}),
    WalkerClass:new(NPCs[3], "turn-walker", {CurrentDirection = "Up", DirectionDt = 2})
}

local NPCWalkersCanWalk = {false, false}

local World   = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(Henry)

local transition = false

local function CheckIfNearSchoolDoor()

    if SchoolBell ~= nil then return end
    if math.sqrt((Henry.x_pos - bit.lshift(36, 4))^2 + (Henry.y_pos - bit.lshift(5, 4))^2) < 200 then

        SchoolBell = getSoundFromCache("sound/shorts/school-bell.wav")
        SchoolBell:setVolume(Settings.MasterVolume * Settings.MusicVolume)
        SchoolBell:play()

    end

end

local function DoorCollisionChecks()

    transition = DoorHandler:CheckForCollisions()
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

local function TurnNPCs()

    for i = 1, #NPCTurners do
        if not NPCWalkersCanWalk[i] then
            NPCTurners[i]:Update()
        end
    end

end

local function NPCUpdates()

    NPCWalkers[3]:Update()
    NPCWalkers[4]:Update()
    TurnNPCs()
    NPCWalkerConditions()
    NPCWalkerUpdates()

end

local function SoundUpdates()
    if not BackgroundSound:isPlaying() and not DataToSave["Day1Events"].WentToSchool then
        BackgroundSound = getStreamSoundFromCache("sound/ambiance/city.wav")
        BackgroundSound:setVolume(Settings.MasterVolume * Settings.MusicVolume)
        BackgroundSound:setLooping(true)
        BackgroundSound:play()
    elseif not BackgroundSound:isPlaying() and DataToSave["Day1Events"].WentToSchool then
        World:SetTimeCycle("Afternoon")
        World:TogglePlayerLighting(true)
        BackgroundSound = getStreamSoundFromCache("sound/ambiance/city-slow.wav")
        BackgroundSound:setVolume(Settings.MasterVolume * Settings.MusicVolume)
        BackgroundSound:setLooping(true)
        BackgroundSound:play()
    end
end

local function UpdateAfterSchool()

    if not DataToSave["Day1Events"].WentToSchool then return end
    if DataToSave["Day1Events"].DialogInButcherySeen then return end
    if DoorHandler.enabled[7] then return end
    DoorHandler:ToggleDoor(7, true)

end

local function LockButcheryIfPossible()

    if not DataToSave["Day1Events"].WentToSchool then return end
    if not DataToSave["Day1Events"].DialogInButcherySeen then return end
    if not DoorHandler.enabled[7] then return end
    DoorHandler:ToggleDoor(7, false)

end

local StartCoupleBickering = false
local CoupleBickeringText =
{
    TextBubbleClass:newSpeaking(NPCs[5], "Why do I have to go?"),
    TextBubbleClass:newSpeaking(NPCs[6], "Everyone has to do their \npart."),
    TextBubbleClass:newSpeaking(NPCs[6], "Now come on!"),
}
local CoupleBickeringDialog = DialogClass:new(CoupleBickeringText, 3.25)
local BickeringCoupleEntity = EntityClass:newMinimal(42*16, 45*16)
local function ToggleBickeringCouple()

    World:SetHandleInputCallback(function() end)
    World:SetEntityToTrackForCamera(BickeringCoupleEntity)
    NPCs[5]:AllowDrawing(true)
    NPCs[6]:AllowDrawing(true)
    StartCoupleBickering = true

end

local function ToggleFadeToBlack()

    if World.fade_out == nil then
        World:SetFadeToBlack(true)
        NPCs[6]:FaceRight()
    end
    if World:FadeToBlackFinished() then
        DataToSave["Day1Events"].SeenCoupleBickeringOutsideGrocer = true
        World:ResetFadeToBlack()
        NPCs[5]:AllowDrawing(false)
        NPCs[6]:AllowDrawing(false)
        World:SetHandleInputCallback(nil)
        World:SetEntityToTrackForCamera(Henry)
    end

end

local function UpdateGrocerAfterSchoolEntrace()

    if not DataToSave["Day1Events"].WentToGrocerAfterSchool then return end
    if DataToSave["Day1Events"].SeenCoupleBickeringOutsideGrocer then return end
    if not NPCs[5].allow_drawing then
        ToggleBickeringCouple()
    end
    if CoupleBickeringDialog:IsFinished() then
        ToggleFadeToBlack()
    end

end

local CameraEntity = nil
local PersonFromShack = CharacterClass:new("tiles/Characters/Females/F_05.png", 20*16, 4*16, 16, 17, 4, .05)
PersonFromShack:AllowDrawing(false)
local TimeBeforePan = nil
local function InitCameraEntityIfNeeded()

    if CameraEntity == nil then
        CameraEntity = CameraClass:new(36*16, 6*16, -2, 0, .01)
        World:SetEntityToTrackForCamera(CameraEntity)
        World:SetHandleInputCallback(function() end)
        TimeBeforePan = love.timer.getTime() + .5
    end

end

local settofade = false
local function FadeToBlackIfCameraEntityFinished()

    if CameraEntity.x_pos < 20*16 and not settofade then
        PersonFromShack:AllowDrawing(true)
        World:SetFadeToBlack(true)
        settofade = true
    end

end

local function UpdateCameraEntity()

    if World.fade_out == nil and love.timer.getTime() >= TimeBeforePan then
        CameraEntity:Update()
    elseif World:FadeToBlackFinished() then
        PersonFromShack:AllowDrawing(false)
        World:SetEntityToTrackForCamera(Henry)
        World:SetHandleInputCallback(nil)
        World:ResetFadeToBlack()
        DataToSave["Day1Events"].SawPersonComingFromShack = true
    end

end

local function UpdateManFromShack()

    if DataToSave["Day1Events"].SawPersonComingFromShack then return end
    if not DataToSave["Day1Events"].WentToSchool then return end
    InitCameraEntityIfNeeded()
    FadeToBlackIfCameraEntityFinished()
    UpdateCameraEntity()

end

function Scene.Update()

    World:Update()
    UpdateAfterSchool()
    DoorCollisionChecks()
    NPCUpdates()
    SoundUpdates()
    CheckIfNearSchoolDoor()
    UpdateGrocerAfterSchoolEntrace()
    UpdateManFromShack()
    LockButcheryIfPossible()

end

local function DrawPersonFromShackIfPossible()

    PersonFromShack:Draw()

end

local function DrawCoupleBickeringText()

    if not StartCoupleBickering then return end
    if DataToSave["Day1Events"].SeenCoupleBickeringOutsideGrocer then return end
    CoupleBickeringDialog:Draw()

end


local DoNotGoInText =
{
    --{x_pos = 23*16, y_pos = 59*16, text = TextBubbleClass:newThought(Henry, "Locked...")},
    {x_pos = 29*16, y_pos = 59*16, text = TextBubbleClass:newThought(Henry, "Locked...")},
    {x_pos = 35*16, y_pos = 59*16, text = TextBubbleClass:newThought(Henry, "Locked...")},
    {x_pos = 16*16, y_pos = 40*16, text = TextBubbleClass:newThought(Henry, "I shouldn't go here")},
    {x_pos = 25*16, y_pos = 41*16, text = TextBubbleClass:newThought(Henry, "I shouldn't go here")},
    --{x_pos = 53*16, y_pos = 37*16, text = TextBubbleClass:newThought(Henry, "...")},
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

local MiscNPCText =
{
    {NPC_IDX = 1, Text = TextBubbleClass:newSpeaking(NPCs[1], "What is wrong ... OPEN!")},
    {NPC_IDX = 2, Text = TextBubbleClass:newSpeaking(NPCs[2], "NEED COFFEE")},
    {NPC_IDX = 3, Text = TextBubbleClass:newSpeaking(NPCs[3], "Gahh, I'm going to be late!")},
    {NPC_IDX = 4, Text = TextBubbleClass:newSpeaking(NPCs[4], "You and your mom are \nspecial.")},
    {NPC_IDX = 7, Text = TextBubbleClass:newSpeaking(NPCs[7], "Today is a special day!")}
};

local function DrawMiscText()

    if DataToSave["Day1Events"].WentToSchool then return end
    local IDX_MISC
    for i = 1, #MiscNPCText do
        IDX_MISC = MiscNPCText[i].NPC_IDX
        if not NPCs[IDX_MISC].allow_drawing then goto skip end
        if Shared.IsNear(Henry.x_pos, Henry.y_pos, NPCs[IDX_MISC].x_pos, NPCs[IDX_MISC].y_pos, 100) then
            MiscNPCText[i].Text:Draw()
        end
        ::skip::
    end

end

local function DrawNPCTextIfPossible()

    DrawMiscText()

end

local function StopDrawingNPCs()

    for i = 1, #NPCWalkers do
        NPCWalkersCanWalk[i] = false
        NPCs[i+1]:AllowDrawing(false)
    end
    NPCs[1]:AllowDrawing(false)
    NPCs[4]:AllowDrawing(false)
    NPCs[7]:AllowDrawing(false)

end

function Scene.Draw()

    World:Draw()
    DrawPersonFromShackIfPossible()

end

function Scene.DrawText()

    DrawHenryStopTextBubblesIfPossible()
    DrawNPCTextIfPossible()
    DrawCoupleBickeringText()

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
    Henry:FaceDown()

end

function Scene.Reset()

    love.audio.stop()
    if DataToSave["Day1Events"].WentToSchool then
        StopDrawingNPCs()
    end

end

return Scene