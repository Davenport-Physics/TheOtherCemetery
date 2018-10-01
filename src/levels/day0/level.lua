

Level = {}

local WorldClass   = require("src/world/world")
local FuneralScene = require("src/levels/day0/scenes/FuneralHome")

local FuneralSceneMap             = FuneralScene.GetMap()
local FuneralSceneChars           = FuneralScene.GetCharacters()
local FuneralScenePlayerChar      = FuneralScene.GetPlayerCharacter()
local FuneralSceneCollisionObjs   = FuneralScene.GetCollisionObjs()

local FuneralWorld = WorldClass:new(FuneralSceneMap, FuneralSceneChars, FuneralScenePlayerChar, FuneralSceneCollisionObjs)
FuneralWorld:SetEntityToTrackForCamera(FuneralScenePlayerChar)

function Level.Draw()

    FuneralWorld:Draw()

end

function Level.Update()

    FuneralWorld:Update()

end

function Level.HandleInput()

    FuneralWorld:HandleInput()

end

return Level