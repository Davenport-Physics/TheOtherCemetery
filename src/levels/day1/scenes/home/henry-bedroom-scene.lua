require("src/shared/cache")
local DataToSave = require("src/save/savingdata")
local Scene      = {}

local Settings     = require("src/settings/settings")
local WorldClass   = require("src/world/world")
local DoorClass    = require("src/entity/door")
local WalkerClass  = require("src/characterwalker/walker-generic")
local TextBubbleClass = require("src/character/textbubbles")

local CharacterClass = require("src/character/character")
local MapData        = require("src/levels/maps/home/henry-bedroom")
local TiledMapClass  = require("src/map/tiledmap")
local TiledMap       = TiledMapClass:new(MapData)

local BackgroundSound = getSoundFromCache("sound/ambiance/home/home.mp3")

local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 3*16, 5*16, 16, 17, 6, .05); Henry:WalkRight(true);

local RoomWorld  = WorldClass:new(TiledMap, {}, Henry, TiledMap:GetCollisionObjects())
RoomWorld:SetEntityToTrackForCamera(Henry)

local Door_LeaveBedroom = DoorClass:new(7*16, 3*16, 16, 16, "src/levels/day1/scenes/home/home-lobby", 2*16, 6*16)

local transition = false

local function UpdateSounds()

    if not BackgroundSound:isPlaying() then
        BackgroundSound:setVolume(.5)
        BackgroundSound:play()
    end

end

local HomeworkText = TextBubbleClass:newSpeaking(Henry, "I don't feel like doing\n homework...")

local function CheckIfNearBooksForHomeworkText()

    if math.sqrt((Henry.x_pos - 4*16)^2 + (Henry.y_pos - 5*16)^2) <= 16 then
        HomeworkText:Draw()
    end

end

local function CheckIfShouldDrawHomeworkText()

    if DataToSave["Day1Events"].SpokeWithMomAfterSchool then
        CheckIfNearBooksForHomeworkText()
    end

end

function Scene.Update()

    transition = Door_LeaveBedroom:CheckForCollision(Henry:GetCenterPosition())
    if type(transition) == "table" then
        DataToSave.CurrentScene = transition[1]
    end
    RoomWorld:Update()
    UpdateSounds()

end

function Scene.CanTransition()

    return transition

end

function Scene.Draw()

    RoomWorld:Draw()
    CheckIfShouldDrawHomeworkText()

end


function Scene.HandleInput()

    RoomWorld:HandleInput()
    CheckIfShouldDrawHomeworkText()

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