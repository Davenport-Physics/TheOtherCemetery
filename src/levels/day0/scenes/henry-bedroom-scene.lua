local Scene = {}

local Settings     = require("src/settings/settings")
local EntityClass  = require("src/entity/entity")
local WorldClass   = require("src/world/world")
local DoorClass    = require("src/entity/door")
local WalkerClass  = require("src/characterwalker/walker-generic")
local TextBubbleClass = require("src/character/textbubbles")

local CharacterClass = require("src/character/character")
local MapData        = require("src/levels/day0/maps/henry-bedroom")
local TiledMapClass  = require("src/map/tiledmap")
local TiledMap       = TiledMapClass:new(MapData)

local AnnaChar  = CharacterClass:new("tiles/Characters/Females/F_01.png", 7*16, 4*16, 16, 17, 2, .05); AnnaChar:AllowDrawing(false);
local HenryChar = CharacterClass:new("tiles/Characters/Males/M_08.png", 3*16, 5*16, 16, 17, 6, .05); HenryChar:WalkRight(true);

local AnnaPathWalkerInstructionsToHenry =
{
    {x = 7*16 , y = 5*16},
    {x = 5*16 , y = 5*16}
}
local AnnaPathWalkerInstructionsAwayFromHenry =
{
    {x = 7*16 , y = 5*16},
    {x = 7*16 , y = 4*16}
}
local AnnaPathWalkerToHenry       = WalkerClass:new(AnnaChar, "path-walker", AnnaPathWalkerInstructionsToHenry)
local AnnaPathWalkerAwayFromHenry = nil
local TextTime = love.timer.getTime()
local Textidx  = 0
local Text =
{
    TextBubbleClass:new(AnnaChar, "pics/share/text/TextBubbleSpeaking.png", "Hey Bud, how are you feeling?", 7),
    TextBubbleClass:new(HenryChar, "pics/share/text/TextBubbleSpeaking.png", "...", 7),
    TextBubbleClass:new(AnnaChar, "pics/share/text/TextBubbleSpeaking.png", "Yeah, me too. I miss them.", 7),
    TextBubbleClass:new(AnnaChar, "pics/share/text/TextBubbleSpeaking.png", "Well . . . try to get some sleep \ntonight alright?", 7),
    TextBubbleClass:new(AnnaChar, "pics/share/text/TextBubbleSpeaking.png", "You have to get back to school\n tomorrow.", 7),
    TextBubbleClass:new(AnnaChar, "pics/share/text/TextBubbleSpeaking.png", "Love you kiddo.", 7)
}

local RoomEntity = EntityClass:newMinimal(5*16, 5*16)
local RoomWorld  = WorldClass:new(TiledMap, {AnnaChar}, HenryChar, TiledMap:GetCollisionObjects())
RoomWorld:SetEntityToTrackForCamera(RoomEntity)

local Door_LeaveBedroom = DoorClass:new(7*16, 3*16, 16, 16, "src/levels/day0/scenes/home-lobby", 2*16, 6*16)

local transition = false

local cycle_complete         = false
local time_to_spawn_anna     = nil
local anna_done_talking      = false
local function Room_SpawnAnna()

    if time_to_spawn_anna == nil then
        time_to_spawn_anna = love.timer.getTime() + 1
        return
    end
    if love.timer.getTime() >= time_to_spawn_anna then
        AnnaChar:AllowDrawing(true)
    end

end

local function Room_CheckToDespawnAnna()

    if not AnnaPathWalkerAwayFromHenry:IsDoneWalking() then return end
    AnnaChar:AllowDrawing(false)
    cycle_complete = true
    RoomWorld:SetEntityToTrackForCamera(HenryChar)
    transition = {"src/levels/day0/scenes/day-one-transition"}

end

local function Update_Talk()

    if love.timer.getTime() >= TextTime then

        TextTime = love.timer.getTime() + 2.25
        Textidx = Textidx + 1

    end
    if Textidx > #Text then
        anna_done_talking = true
    end

end

local function Update_AnnaMove()

    AnnaPathWalkerToHenry:Update()
    if AnnaPathWalkerToHenry:IsDoneWalking() and not anna_done_talking then
        Update_Talk()
    end
    if anna_done_talking and AnnaPathWalkerAwayFromHenry == nil then
        AnnaPathWalkerAwayFromHenry = WalkerClass:new(AnnaChar, "path-walker", AnnaPathWalkerInstructionsAwayFromHenry)
    elseif anna_done_talking and not AnnaPathWalkerAwayFromHenry:IsDoneWalking() then
        AnnaPathWalkerAwayFromHenry:Update()
        Room_CheckToDespawnAnna()
    end

end

local function Update_Anna()

    if not AnnaChar.allow_drawing then
        Room_SpawnAnna()
    else
        Update_AnnaMove()
    end

end

function Scene.Update()

    transition = Door_LeaveBedroom:CheckForCollision(HenryChar:GetCenterPosition())
    if not cycle_complete then Update_Anna() end
    RoomWorld:Update()
    
end

function Scene.CanTransition()

    return transition

end

local function DrawText()

    if not anna_done_talking and Textidx > 0 then
        Text[Textidx]:Draw()
    end

end

function Scene.Draw()

    RoomWorld:Draw()
    DrawText()

end


function Scene.HandleInput()

    if cycle_complete then
        RoomWorld:HandleInput()
    end

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = true
    HenryChar.x_pos = x_pos
    HenryChar.y_pos = y_pos
    HenryChar:WalkDown(true)

end

return Scene