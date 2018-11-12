local DataToSave =
{

    ["SaveName"] = "",
    ["PlayTime"] = 0,

    ["level"] =
    {

        day0 = false,
        day1 = false,
        day2 = false,
        day3 = false

    },

    ["Day0Events"] =
    {
        IntroPlayed             = false,
        FuneralScenePlayed      = false,
        BedroomSceneConveration = false
    },

    ["Day1Events"] =
    {
        WentToSchool = false,
        SpokeWithMomAfterSchool = false,
        HasSeenCultOutsideHouse = false
    },

    ["PlayTime"]           = 0,
    ["CurrentCharacter"]   = "Henry",
    ["CurrentCoordinates"] = {x_pos = nil, y_pos = nil},
    ["CurrentScene"]       = "levels/day0/scenes/intro",
    ["File"] = ""

}

function DataToSave.ResetValues()

    DataToSave["SaveName"] = ""
    DataToSave["PlayTime"] = 0

    DataToSave["level"].day0 = false
    DataToSave["level"].day1 = false
    DataToSave["level"].day2 = false
    DataToSave["level"].day3 = false

    DataToSave["Day0Events"].IntroPlayed             = false
    DataToSave["Day0Events"].FuneralScenePlayed      = false
    DataToSave["Day0Events"].BedroomSceneConveration = false

    DataToSave["Day1Events"].GrabbedLunch = false
    DataToSave["Day1Events"].WentToSchool = false
    DataToSave["Day1Events"].LostToBully  = false
    DataToSave["Day1Events"].DayTime      = true

    DataToSave["CurrentCharacter"]         = "Henry"
    DataToSave["CurrentCoordinates"].x_pos = 0
    DataToSave["CurrentCoordinates"].y_pos = 0
    DataToSave["CurrentScene"]             = "src/levels/day0/scenes/intro"
    DataToSave["File"]                     =  ""

end


return DataToSave