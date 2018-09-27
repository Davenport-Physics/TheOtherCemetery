

Level = {}

local WorldClass   = require("src/world/world")
local FuneralScene = require("src/levels/day0/scenes/FuneralHome")

local FuneralSceneMap        = FuneralScene.GetMap()
local FuneralSceneChars      = FuneralScene.GetCharacters()
local FuneralScenePlayerChar = FuneralScene.GetPlayerCharacter()
local FuneralSceneEntities   = FuneralScene.GetEntities()

local FuneralWorld = WorldClass:new(FuneralSceneMap, FuneralSceneChars, FuneralScenePlayerChar, FuneralSceneEntities)

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