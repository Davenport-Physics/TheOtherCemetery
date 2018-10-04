
local DrawFunction   = nil
local UpdateFunction = nil
local InputFunction  = nil

local Level = {}

local WorldClass   = require("src/world/world")
local FuneralScene = require("src/levels/day0/scenes/FuneralHome")

local CameraClass = require("src/camera/camera")
local Camera      = CameraClass:new(150, 400, 0, -.5, .01)

local FuneralSceneMap             = FuneralScene.GetMap()
local FuneralSceneChars           = FuneralScene.GetCharacters()
local FuneralScenePlayerChar      = FuneralScene.GetPlayerCharacter()
local FuneralSceneCollisionObjs   = FuneralScene.GetCollisionObjs()

local FuneralWorld = WorldClass:new(FuneralSceneMap, FuneralSceneChars, FuneralScenePlayerChar, FuneralSceneCollisionObjs)
FuneralWorld:SetEntityToTrackForCamera(Camera)

local CameraPanning = true

local RoomScene = require("src/levels/day0/scenes/henry-bedroom-scene")
local RoomWorld = WorldClass:new(RoomScene.GetMap(), RoomScene.GetCharacters(), RoomScene.GetPlayerCharacter(), RoomScene.GetCollisionObjs())

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

DrawFunction   = FuneralWorld_Draw
UpdateFunction = FuneralWorld_Update
InputFunction  = FuneralWorld_HandleInput

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