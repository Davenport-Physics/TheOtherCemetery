local DataToSave = require("src/save/savingdata")

local Scene  = {}

local Settings        = require("src/settings/settings")
local EntityClass     = require("src/entity/entity")
local WorldClass      = require("src/world/world")
local CameraClass     = require("src/camera/camera")
local TiledMapClass   = require("src/map/tiledmap")
local TextBubbleClass = require("src/character/textbubbles")
local DialogClass     = require("src/dialog/dialog")

local Camera        = CameraClass:new(144, 300, 0, -.2, .015)
local CameraPanning = true

local MapData        = require("src/levels/maps/city/interiors/funeral")
local FuneralHomeMap = TiledMapClass:new(MapData)

local CharacterClass = require("src/character/character")
local AnnaCharacter  = CharacterClass:new("tiles/Characters/Females/F_01.png", 128, 102, 16, 17, 6)
local HenryChar      = CharacterClass:new("tiles/Characters/Males/M_08.png", 112, 172, 16, 17, 0); HenryChar:WalkUp(true);

local RandomFemaleFirstRow  = CharacterClass:new("tiles/Characters/Females/F_11.png", 192, 166, 16, 17, 0); RandomFemaleFirstRow:WalkUp(true);
local RandomFemaleSecondRow = CharacterClass:new("tiles/Characters/Females/F_12.png", 208, 198, 16, 17, 0); RandomFemaleSecondRow:WalkUp(true);
local RandomFemaleThirdRow  = CharacterClass:new("tiles/Characters/Females/F_06.png", 176, 230, 16, 17, 0); RandomFemaleThirdRow:WalkUp(true);

local RandonMaleSecondRow   = CharacterClass:new("tiles/Characters/Males/M_10.png", 176, 198, 16, 17, 0); RandonMaleSecondRow:WalkUp(true);
local RandonMaleFourthRow   = CharacterClass:new("tiles/Characters/Males/M_03.png", 176, 262, 16, 17, 0); RandonMaleFourthRow:WalkUp(true);

local chars = {HenryChar, RandomFemaleFirstRow, RandomFemaleSecondRow, RandomFemaleThirdRow, RandonMaleSecondRow, RandonMaleFourthRow}
local FuneralWorld = WorldClass:new(FuneralHomeMap, chars, AnnaCharacter, FuneralHomeMap:GetCollisionObjects())
FuneralWorld:SetEntityToTrackForCamera(Camera)


local AnnaStationaryText = EntityClass:newMinimal(5*16, 14*16)
local AnnaText =
{

    TextBubbleClass:new(AnnaStationaryText, "pics/share/text/TextBoxes.png", "Moving here was supposed to be a \nnew change for my family."),
    TextBubbleClass:new(AnnaStationaryText, "pics/share/text/TextBoxes.png", "However, I never anticipated that it \nwould mean this..."),
    TextBubbleClass:new(AnnaStationaryText, "pics/share/text/TextBoxes.png", "I wanted to thank all of you for \nbeing here. Most of you don’t know \nDuncan,"),
    TextBubbleClass:new(AnnaStationaryText, "pics/share/text/TextBoxes.png", "but I am sure he would have \nappreciated it."),
    TextBubbleClass:new(AnnaCharacter, "pics/share/text/TextBubbleSpeaking.png", "Thank you."),

}

local AnnaDialog = DialogClass:new(AnnaText, 4)


local transition = false

function Scene.Draw()

    FuneralWorld:Draw()
    AnnaDialog:Draw()

end

function Scene.Update()

    if CameraPanning and Camera.y_pos < -20 then

        CameraPanning = false
        transition    = {"src/levels/day0/scenes/henry-bedroom-scene"}
        DataToSave.CurrentScene = "src/levels/day0/scenes/henry-bedroom-scene"
        love.audio.stop()
        DataToSave.Day0Events["FuneralScenePlayed"] = true
        return

    end

    if CameraPanning then
        Camera:Update()
    end

end

function Scene.CanTransition()

    return transition

end

function Scene.HandleInput()

    if not CameraPanning then

        FuneralWorld:HandleInput()

    end

end

function Scene.Reset()

    Camera:ResetPosition()
    CameraPanning = true
    transition    = false
    Camera:ResetPosition()
    print("Funeral Scene Reset")
    print("Camera.y_pos = " .. Camera.y_pos)

end

return Scene