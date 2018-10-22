local DataToSave = 
{

    ["SaveName"] = "",
    
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
        GrabbedLunch = false,
        WentToSchool = false,
        LostToBully  = false,
        DayTime      = true,
    },

    ["CurrentCharacter"]   = "Henry",
    ["CurrentCoordinates"] = {x_pos = nil, y_pos = nil},
    ["CurrentScene"]       = "levels/day0/scenes/intro",

}


return DataToSave