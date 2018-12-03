require("src/shared/cache")
local DataToSave = require("src/save/savingdata")
local Scene      = {}

local EntityClass  = require("src/entity/entity")
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

local Henry = CharacterClass:new("tiles/Characters/Males/M_08.png", 3*16, 5*16, 16, 17, 9, .075); Henry:WalkRight(true);

local RoomWorld  = WorldClass:new(TiledMap, {}, Henry, TiledMap:GetCollisionObjects())
RoomWorld:SetEntityToTrackForCamera(Henry)

local Door_LeaveBedroom = DoorClass:new(7*16, 3*16, 16, 16, "src/levels/day1/scenes/home/home-lobby", 2*16, 6*16)

local transition = false

local function UpdateSounds()

    if not BackgroundSound:isPlaying() then
        BackgroundSound:setVolume(Settings.MasterVolume * Settings.MusicVolume)
        BackgroundSound:play()
    end

end

local text_timer = nil
local function UpdateControlText()

    if DataToSave["Day1Events"].SawControlText then return end
    if text_timer == nil then
        text_timer = love.timer.getTime() + 4
    end
    if love.timer.getTime() >= text_timer then
        DataToSave["Day1Events"].SawControlText = true
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

local control_pos  = EntityClass:newMinimal(0, 8*16)
local control_text = TextBubbleClass:new(control_pos, "pics/share/text/TextBoxes.png", "W - Up\tS - Down\nA - Left\tD - Right\nEscape - Menu")
local function DrawControlTextIfPossible()

    if DataToSave["Day1Events"].SawControlText then return end
    control_text:Draw()

end

function Scene.Update()

    transition = Door_LeaveBedroom:CheckForCollision(Henry:GetCenterPosition())
    if type(transition) == "table" then
        DataToSave.CurrentScene = transition[1]
    end
    RoomWorld:Update()
    UpdateSounds()
    UpdateControlText()

end

function Scene.CanTransition()

    if type(transition) == "table" then
        DataToSave["Day1Events"].SawControlText = true
    end
    return transition

end

function Scene.Draw()

    RoomWorld:Draw()

end

function Scene.DrawText()

    CheckIfShouldDrawHomeworkText()
    DrawControlTextIfPossible()

end

function Scene.HandleInput()

    RoomWorld:HandleInput()
    CheckIfShouldDrawHomeworkText()

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
    Henry:FaceDown()

end

function Scene.Reset()

end

return Scene