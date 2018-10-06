local Level = {}

local DrawFunction   = nil
local UpdateFunction = nil
local InputFunction  = nil

local Settings     = require("src/settings/settings")
local EntityClass  = require("src/entity/entity")
local WorldClass   = require("src/world/world")

local RoomEntity         = EntityClass:newMinimal(48, 48)
local RoomScene          = require("src/levels/day0/scenes/henry-bedroom-scene")
local RoomWorld          = WorldClass:new(RoomScene.GetMap(), RoomScene.GetCharacters(), RoomScene.GetPlayerCharacter(), RoomScene.GetCollisionObjs())
RoomWorld:SetEntityToTrackForCamera(RoomEntity)

local IntroMusic = nil
local AnnaDialog = nil

local function Room_Draw()

    RoomWorld:Draw()

end

local time_to_spawn_anna     = nil
local function Room_Spawn_Anna()

    if time_to_spawn_anna == nil then
        time_to_spawn_anna = love.timer.getTime() + 1
        return
    end
    if love.timer.getTime() >= time_to_spawn_anna then
        RoomScene.GetCharacters()[1]:AllowDrawing(true)
    end

end


local Anna = RoomScene.GetCharacters()[1]
local ANNA_MADE_POSITION =
{

    false, false, false, false

}
local ANNA_POSITION_FUNCTION =
{

    Anna.WalkDown,
    Anna.WalkLeft,
    Anna.WalkRight,
    Anna.WalkUp

}
local ANNA_POSITIONS =
{

    {x = 80, y = 32},
    {x = 32, y = 32},
    {x = 80, y = 32},
    {x = 80, y = 16}

}

local function Room_Check_Made_Anna()

    for i = 1, #ANNA_POSITIONS do
        if not ANNA_MADE_POSITION[i] then
            local x = Anna.x_pos
            local y = Anna.y_pos
            if x == ANNA_POSITIONS[i].x and y == ANNA_POSITIONS[i].y then
                ANNA_MADE_POSITION[i] = true
            end
            break
        end
    end

end

local function Room_Move_Anna()

    for i = 1, #ANNA_MADE_POSITION do
        if not ANNA_MADE_POSITION[i] then
            ANNA_POSITION_FUNCTION[i](Anna, true)
            break
        end
    end

end

local function Room_Update()

    if not RoomScene.GetCharacters()[1].allow_drawing then
        Room_Spawn_Anna()
    else
        Room_Check_Made_Anna()
        Room_Move_Anna()
    end

    RoomWorld:Update()

end

local function Room_HandleInput()

    RoomWorld:HandleInput()

end

local FuneralScene = require("src/levels/day0/scenes/FuneralHome")

local CameraClass = require("src/camera/camera")
local Camera      = CameraClass:new(144, 300, 0, -.2, .015)

local FuneralSceneMap             = FuneralScene.GetMap()
local FuneralSceneChars           = FuneralScene.GetCharacters()
local FuneralScenePlayerChar      = FuneralScene.GetPlayerCharacter()
local FuneralSceneCollisionObjs   = FuneralScene.GetCollisionObjs()

local FuneralWorld = WorldClass:new(FuneralSceneMap, FuneralSceneChars, FuneralScenePlayerChar, FuneralSceneCollisionObjs, 2.5)
FuneralWorld:SetEntityToTrackForCamera(Camera)

local CameraPanning = true

local function FuneralWorld_Draw()

    FuneralWorld:Draw()

end

local function FuneralWorld_Clear()

    love.audio.stop(IntroMusic)
    IntroMusic                = nil
    CameraPanning             = nil
    Camera                    = false
    FuneralScene              = nil
    FuneralSceneMap           = nil
    FuneralSceneChars         = nil
    FuneralScenePlayerChar    = nil
    FuneralSceneCollisionObjs = nil
    FuneralWorld              = nil

end

local function FuneralWorld_SetNextFunctions()

    DrawFunction   = Room_Draw
    UpdateFunction = Room_Update
    InputFunction  = Room_HandleInput

end

local function FuneralWorld_Update()

    if CameraPanning and Camera.y_pos < -20 then

        FuneralWorld_Clear()
        FuneralWorld_SetNextFunctions()
        return

    end

    if CameraPanning then

        Camera:Update()

    end
    FuneralWorld:Update()

end

local function FuneralWorld_HandleInput()

    if not CameraPanning then

        FuneralWorld:HandleInput()

    end

end


local IntroVideo = nil
local function Introduction_Draw()

    if IntroVideo == nil then return end
    love.graphics.scale(.35)
    love.graphics.draw(IntroVideo, 0, 0)

end

local function Intro_Update()

    if IntroVideo == nil then

        IntroMusic = love.audio.newSource("sound/intro/Mournful_Departure.mp3", "static")
        IntroVideo = love.graphics.newVideo("video/intro/intro.ogv")
        IntroMusic:play()
        IntroVideo:play()
        love.audio.setVolume(.5)

    end
    if not IntroVideo:isPlaying() then

        IntroMusic:setVolume(.25)
        IntroVideo     = nil
        DrawFunction   = FuneralWorld_Draw
        UpdateFunction = FuneralWorld_Update
        InputFunction  = FuneralWorld_HandleInput
        AnnaDialog     = love.audio.newSource("sound/intro/anna-dialog/anna-intro.mp3", "static")
        AnnaDialog:play()

    end

end

DrawFunction   = Introduction_Draw
UpdateFunction = Intro_Update
InputFunction  = function() end

function Level.Draw()

    DrawFunction()

end

function Level.Update()

    UpdateFunction()

end

function Level.HandleInput()

    InputFunction()

end

return Level