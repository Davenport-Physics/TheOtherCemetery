

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

function Level.Draw()

    FuneralWorld:Draw()

end

local CameraPanning = true

function Level.Update()

    if CameraPanning and Camera.y_pos < -180 then

        FuneralWorld:SetEntityToTrackForCamera(FuneralScenePlayerChar)
        CameraPanning = false
        Camera = nil

    end

    if CameraPanning then Camera:Update() end
    FuneralWorld:Update()

end

function Level.HandleInput()

    if not CameraPanning then
        FuneralWorld:HandleInput()
    end

end

return Level