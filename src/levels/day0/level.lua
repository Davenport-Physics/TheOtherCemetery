
local WorldClass   = require("src/world/world")
local FuneralScene = require("src/levels/day0/scenes/FuneralHome")

local FuneralSceneMap        = FuneralScene.GetMap()
local FuneralSceneChars      = FuneralScene.GetCharacters()
local FuneralScenePlayerChar = FuneralScene.GetPlayerCharacter()
local FuneralSceneEntities   = FuneralScene.GetEntities()

local FuneralWorld = WorldClass:new(FuneralSceneMap, FuneralSceneChars, FuneralScenePlayerChar, FuneralSceneEntities)

function Draw()

    FuneralWorld:Draw()

end

function Update()

    FuneralWorld:Update()

end

function HandleInput()

    FuneralWorld:HandleInput()

end