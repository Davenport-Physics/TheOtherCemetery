require("src/shared/cache")
local DataToSave = require("src/save/savingdata")
local Scene      = {}

local Settings     = require("src/settings/settings")
local WorldClass   = require("src/world/world")
local DoorClass    = require("src/entity/door")
local WalkerClass  = require("src/characterwalker/walker-generic")
local TextBubbleClass = require("src/character/textbubbles")

local CharacterClass = require("src/character/character")
local MapData        = require("src/levels/day0/maps/henry-bedroom")
local TiledMapClass  = require("src/map/tiledmap")
local TiledMap       = TiledMapClass:new(MapData)

local BackgroundSound = getSoundFromCache("sound/ambiance/home/home.mp3")

local HenryChar = CharacterClass:new("tiles/Characters/Males/M_08.png", 3*16, 5*16, 16, 17, 6, .05); HenryChar:WalkRight(true);

local RoomWorld  = WorldClass:new(TiledMap, {}, HenryChar, TiledMap:GetCollisionObjects())
RoomWorld:SetEntityToTrackForCamera(HenryChar)

local Door_LeaveBedroom = DoorClass:new(7*16, 3*16, 16, 16, "src/levels/day1/scenes/home-lobby", 2*16, 6*16)

local transition = false

local function UpdateSounds()

    if not BackgroundSound:isPlaying() then
        BackgroundSound:setVolume(.5)
        BackgroundSound:play()
    end

end
function Scene.Update()

    transition = Door_LeaveBedroom:CheckForCollision(HenryChar:GetCenterPosition())
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

end


function Scene.HandleInput()

    RoomWorld:HandleInput()

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    HenryChar.x_pos = x_pos
    HenryChar.y_pos = y_pos
    HenryChar:WalkDown(true)

end

function Scene.Reset()

end

return Scene