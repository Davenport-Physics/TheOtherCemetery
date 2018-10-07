
local Scene  = {}

local Settings      = require("src/settings/settings")
local EntityClass   = require("src/entity/entity")
local WorldClass    = require("src/world/world")
local CameraClass   = require("src/camera/camera")
local TiledMapClass = require("src/map/tiledmap")

local Camera        = CameraClass:new(144, 300, 0, -.2, .015)
local CameraPanning = true

local MapData        = require("src/levels/day0/maps/funeral")
local FuneralHomeMap = TiledMapClass:new(MapData)

local CharacterClass = require("src/character/character")
local AnnaCharacter = CharacterClass:new("tiles/Characters/Females/F_01.png", 128, 102, 16, 17, 6)
local HenryChar     = CharacterClass:new("tiles/Characters/Males/M_08.png", 112, 172, 16, 17, 0); HenryChar:WalkUp(true);

local RandomFemaleFirstRow  = CharacterClass:new("tiles/Characters/Females/F_11.png", 192, 166, 16, 17, 0); RandomFemaleFirstRow:WalkUp(true);
local RandomFemaleSecondRow = CharacterClass:new("tiles/Characters/Females/F_12.png", 208, 198, 16, 17, 0); RandomFemaleSecondRow:WalkUp(true);
local RandomFemaleThirdRow  = CharacterClass:new("tiles/Characters/Females/F_06.png", 176, 230, 16, 17, 0); RandomFemaleThirdRow:WalkUp(true);

local RandonMaleSecondRow   = CharacterClass:new("tiles/Characters/Males/M_10.png", 176, 198, 16, 17, 0); RandonMaleSecondRow:WalkUp(true);
local RandonMaleFourthRow   = CharacterClass:new("tiles/Characters/Males/M_03.png", 176, 262, 16, 17, 0); RandonMaleFourthRow:WalkUp(true);

local chars = {HenryChar, RandomFemaleFirstRow, RandomFemaleSecondRow, RandomFemaleThirdRow, RandonMaleSecondRow, RandonMaleFourthRow}
local FuneralWorld = WorldClass:new(FuneralHomeMap, chars, AnnaCharacter, FuneralHomeMap:GetCollisionObjects())
FuneralWorld:SetEntityToTrackForCamera(Camera)

local transition = false

function Scene.Draw()

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

function Scene.Update()

    if CameraPanning and Camera.y_pos < -20 then

        CameraPanning = false
        transition    = true
        return

    end

    if CameraPanning then

        Camera:Update()

    end
    FuneralWorld:Update()

end

function Scene.CanTransition()

    return transition

end

function Scene.HandleInput()

    if not CameraPanning then

        FuneralWorld:HandleInput()

    end

end

return Scene