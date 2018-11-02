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
local CameraClass     = require("src/camera/camera")

local SleepCam        = nil --CameraClass:new(9*16, 10*16, .25, 0, .0125)

local transition = false
local Map        = TiledMapClass:new(require("src/levels/maps/school/school-room"))

local BackgroundMusic = getStreamSoundFromCache("sound/ambiance/school/school.wav")

local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 10*16, 13*16, 16, 17, 4, .025); Henry:WalkUp();
local NPCs  =
{
    CharacterClass:new("tiles/Characters/Males/M_05.png"  , 10*16, 7*16, 16, 17, 4, .025), -- Teacher
    CharacterClass:new("tiles/Characters/Females/F_07.png", 8*16, 7*16, 16, 17, 4, .025),
    CharacterClass:new("tiles/Characters/Females/F_06.png", 6*16, 7*16, 16, 17, 4, .025),
    CharacterClass:new("tiles/Characters/Males/M_10.png"  , 4*16, 9*16, 16, 17, 4, .025),
    CharacterClass:new("tiles/Characters/Males/M_04.png"  , 6*16, 11*16, 16, 17, 4, .025)

}
for i = 2, #NPCs do
    NPCs[i]:WalkUp()
end

local StationaryEntity = EntityClass:newMinimal(10*16, 9*16)
local World            = WorldClass:new(Map, NPCs, Henry, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(StationaryEntity)
World:SetHandleInputCallback(function() end)
local ExitDoor         = DoorClass:new(9*16, 14*16, 3*16, 16, "src/levels/day1/scenes/school", 7*16, 12*16)

local TextBubbles =
{

    TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "He is next..."),
    TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "OH! Henry, why are you \nhere today?"),
    TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "Shouldn’t you be at home \nresting?"),
    TextBubbleClass:new(Henry,   "pics/share/text/TextBubble.png", "Who was he talking about..."),
    TextBubbleClass:new(NPCs[1], "pics/share/text/TextBubbleSpeaking.png", "Well, take your seat Henry"),

}

local Dialog = DialogClass:new(TextBubbles, 3)

local TextBoxEntity = EntityClass:newMinimal(16, 13*16)
--"Now, who they made a deal with still remains a mystery, although we have our theories. It could be natives that had inhabited this region before, or maybe another force they had reckoned with. . ."
local TextBox =
{
    TextBubbleClass:new(TextBoxEntity, "pics/share/text/TextBoxes.png", "Our great founding fathers \nmade a deal..."),
    TextBubbleClass:new(TextBoxEntity, "pics/share/text/TextBoxes.png", "This deal has kept our town of \nwillowstead safe for over \na century."),
    TextBubbleClass:new(TextBoxEntity, "pics/share/text/TextBoxes.png", "Now, who they made a deal \nwith still remains a mystery, \nalthough we have our theories."),
    TextBubbleClass:new(TextBoxEntity, "pics/share/text/TextBoxes.png", "It could be natives that had \ninhabited this region before"),
    TextBubbleClass:new(TextBoxEntity, "pics/share/text/TextBoxes.png", "or maybe another force \nentirely..."),

}
local TextBoxDialog = DialogClass:new(TextBox, 4)

local HenryPathWalkerInstructions =
{
    {x = 12*16, y = 13*16},
    {x = 12*16, y = 9*16}
}
local HenryPathWalker = WalkerClass:new(Henry, "path-walker", HenryPathWalkerInstructions)

local function CheckForDoorTransitions()

    transition = ExitDoor:CheckForCollision(Henry:GetCenterPosition())
    if type(transition) == "table" then
        DataToSave.CurrentScene = transition[1]
    end

end

local function DrawDialogIfPossible()

    if Dialog:IsFinished() then return end
    Dialog:Draw()

end

local function DrawTeacherSecondDialogIfPossible()

    if not HenryPathWalker:IsDoneWalking() and not TextBoxDialog:IsFinished() then
        return
    end
    TextBoxDialog:Draw()

end

local function HandleIfHenryShouldWalk()

    if not Dialog:IsFinished() or HenryPathWalker:IsDoneWalking() then
        return
    end
    HenryPathWalker:Update()

end

local function HandleTransitionIfTeacherIsDoneTalkingAgain()

    if TextBoxDialog:IsFinished() then
        transition = {"src/levels/day1/scenes/deadworld-view"}
    end

end

local function UpdateSleepCam()

    if not HenryPathWalker:IsDoneWalking() then return end
    if SleepCam == nil then
        SleepCam = CameraClass:new(9*16, 10*16, .1, 0, .0125)
        World:SetEntityToTrackForCamera(SleepCam)
    end
    SleepCam:Update()


end

local function UpdateSounds()

    if not BackgroundMusic:isPlaying() then
        BackgroundMusic:setVolume(1)
        BackgroundMusic:setLooping(true)
        BackgroundMusic:play()
    end

end

function Scene.Update()

    World:Update()
    CheckForDoorTransitions()
    HandleIfHenryShouldWalk()
    HandleTransitionIfTeacherIsDoneTalkingAgain()
    UpdateSleepCam()
    UpdateSounds()

end


function Scene.Draw()

    World:Draw()
    DrawDialogIfPossible()
    DrawTeacherSecondDialogIfPossible()

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

function Scene.Reset()

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:WalkUp(true)

end

return Scene