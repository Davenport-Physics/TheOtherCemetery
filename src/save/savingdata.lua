local DataToSave =
{

    ["SaveName"] = "",

    ["level"] = "src/levels/day0/level",

    ["Day0Events"] =
    {
        IntroPlayed             = false,
        FuneralScenePlayed      = false,
        BedroomSceneConveration = false
    },

    ["Day1Events"] =
    {
        WentToSchool              = false,
        SpokeWithMomAfterSchool   = false,
        NeighbourConversationSeen = false,
        HasSeenCultOutsideHouse   = false
    },

    ["PlayTime"]           = {hours = 0, minutes = 0, seconds = 0},
    ["CurrentCharacter"]   = "Henry",
    ["CurrentCoordinates"] = {x_pos = nil, y_pos = nil},
    ["CurrentScene"]       = "src/levels/day0/scenes/intro",
    ["File"] = ""

}

function DataToSave.SetValues(temp)

    DataToSave["SaveName"] = temp["SaveName"]
    DataToSave["PlayTime"] = temp["PlayTime"]

    DataToSave["level"] = temp["level"]

    DataToSave["Day0Events"].IntroPlayed               = temp["Day0Events"].IntroPlayed
    DataToSave["Day0Events"].FuneralScenePlayed        = temp["Day0Events"].FuneralScenePlayed
    DataToSave["Day0Events"].BedroomSceneConveration   = temp["Day0Events"].BedroomSceneConveration

    DataToSave["Day1Events"].WentToSchool              = temp["Day1Events"].WentToSchool
    DataToSave["Day1Events"].SpokeWithMomAfterSchool   = temp["Day1Events"].SpokeWithMomAfterSchool
    DataToSave["Day1Events"].NeighbourConversationSeen = temp["Day1Events"].SpokeWithMomAfterSchool
    DataToSave["Day1Events"].HasSeenCultOutsideHouse   = temp["Day1Events"].HasSeenCultOutsideHouse

    DataToSave["CurrentCharacter"]         = temp["CurrentCharacter"]
    DataToSave["CurrentCoordinates"].x_pos = temp["CurrentCoordinates"].x_pos
    DataToSave["CurrentCoordinates"].y_pos = temp["CurrentCoordinates"].y_pos
    DataToSave["CurrentScene"]             = temp["CurrentScene"]
    DataToSave["File"]                     = temp["File"]

end

function DataToSave.ResetValues()

    DataToSave["SaveName"] = ""
    DataToSave["PlayTime"] = {hours = 0, minutes = 0, seconds = 0}

    DataToSave["level"] = "src/levels/day0/level"

    DataToSave["Day0Events"].IntroPlayed             = false
    DataToSave["Day0Events"].FuneralScenePlayed      = false
    DataToSave["Day0Events"].BedroomSceneConveration = false

    DataToSave["Day1Events"].WentToSchool              = false
    DataToSave["Day1Events"].SpokeWithMomAfterSchool   = false
    DataToSave["Day1Events"].NeighbourConversationSeen = false
    DataToSave["Day1Events"].HasSeenCultOutsideHouse   = false

    DataToSave["CurrentCharacter"]         = "Henry"
    DataToSave["CurrentCoordinates"].x_pos = 0
    DataToSave["CurrentCoordinates"].y_pos = 0
    DataToSave["CurrentScene"]             = "src/levels/day0/scenes/intro"
    DataToSave["File"]                     =  ""

end


return DataToSave