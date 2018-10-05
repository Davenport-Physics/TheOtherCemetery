
local FuneralScene  = {}
local TiledMapClass = require("src/map/tiledmap")

local MapData = require("src/levels/day0/maps/funeral")
local FuneralHomeMap = TiledMapClass:new(MapData)

local CharacterClass = require("src/character/character")

local AnnaCharacter = CharacterClass:new("tiles/Characters/Females/F_01.png", 128, 102, 16, 17, 6)
local HenryChar     = CharacterClass:new("tiles/Characters/Males/M_08.png", 112, 172, 16, 17, 0); HenryChar:WalkUp(true);

local RandomFemaleFirstRow  = CharacterClass:new("tiles/Characters/Females/F_11.png", 192, 166, 16, 17, 0); RandomFemaleFirstRow:WalkUp(true);
local RandomFemaleSecondRow = CharacterClass:new("tiles/Characters/Females/F_12.png", 208, 198, 16, 17, 0); RandomFemaleSecondRow:WalkUp(true);
local RandomFemaleThirdRow  = CharacterClass:new("tiles/Characters/Females/F_06.png", 176, 230, 16, 17, 0); RandomFemaleThirdRow:WalkUp(true);

local RandonMaleSecondRow   = CharacterClass:new("tiles/Characters/Males/M_10.png", 176, 198, 16, 17, 0); RandonMaleSecondRow:WalkUp(true);
local RandonMaleFourthRow   = CharacterClass:new("tiles/Characters/Males/M_03.png", 176, 262, 16, 17, 0); RandonMaleFourthRow:WalkUp(true);



function FuneralScene.GetMap()

    return FuneralHomeMap

end

function FuneralScene.GetCollisionObjs()

    return FuneralHomeMap:GetCollisionObjects()

end

function FuneralScene.GetCharacters()

    return {HenryChar, RandomFemaleFirstRow, RandomFemaleSecondRow, RandomFemaleThirdRow, RandonMaleSecondRow, RandonMaleFourthRow}

end

function FuneralScene.GetPlayerCharacter()

    return AnnaCharacter

end

return FuneralScene