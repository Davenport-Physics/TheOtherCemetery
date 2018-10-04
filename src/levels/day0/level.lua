
local DrawFunction   = nil
local UpdateFunction = nil
local InputFunction  = nil

local Level = {}

local WorldClass   = require("src/world/world")
local FuneralScene = require("src/levels/day0/scenes/FuneralHome")

local CameraClass = require("src/camera/camera")
local Camera      = CameraClass:new(150, 450, 0, -.25, .01)

local EntityClass = require("src/entity/entity")

local FuneralSceneMap             = FuneralScene.GetMap()
local FuneralSceneChars           = FuneralScene.GetCharacters()
local FuneralScenePlayerChar      = FuneralScene.GetPlayerCharacter()
local FuneralSceneCollisionObjs   = FuneralScene.GetCollisionObjs()

local FuneralWorld = WorldClass:new(FuneralSceneMap, FuneralSceneChars, FuneralScenePlayerChar, FuneralSceneCollisionObjs)
FuneralWorld:SetEntityToTrackForCamera(Camera)

local CameraPanning = true

local RoomEntity = EntityClass:newMinimal(50, 50)
local RoomScene  = require("src/levels/day0/scenes/henry-bedroom-scene")
local RoomWorld  = WorldClass:new(RoomScene.GetMap(), RoomScene.GetCharacters(), RoomScene.GetPlayerCharacter(), RoomScene.GetCollisionObjs())
RoomWorld:SetEntityToTrackForCamera(RoomEntity)

local IntroMusic = nil
local AnnaDialog = nil

local function Room_Draw()

    RoomWorld:Draw()

end

local function Room_Update()

    RoomWorld:Update()

end

local function Room_HandleInput()

    RoomWorld:HandleInput()

end


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

    if CameraPanning and Camera.y_pos < -180 then

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
    love.graphics.scale(.4)
    love.graphics.draw(IntroVideo, 0, 0)

end

local function Intro_Update()

    if IntroVideo == nil then

        IntroMusic = love.audio.newSource("sound/intro/Mournful_Departure.mp3", "static")
        IntroVideo = love.graphics.newVideo("video/intro/intro.ogv")
        IntroMusic:setVolume(.15)
        IntroMusic:play()
        IntroVideo:play()

    end
    if not IntroVideo:isPlaying() then

        IntroVideo     = nil
        DrawFunction   = FuneralWorld_Draw
        UpdateFunction = FuneralWorld_Update
        InputFunction  = FuneralWorld_HandleInput
        AnnaDialog = love.audio.newSource("sound/intro/anna-dialog/anna-intro.mp3", "static")
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