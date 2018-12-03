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
        SawControlText            = false,
        WentToSchool              = false,
        WentToGrocerBeforeSchool  = false,
        SpokeWithMomAfterSchool   = false,
        NeighbourConversationSeen = false,
        HeardSpeechFromPriest     = false,
        WentToGrocerAfterSchool   = false,
        SawPersonComingFromShack  = false,
        WentUnderneathCollector   = false,
        SeenCoupleBickeringOutsideGrocer = false,
        DialogInButcherySeen      = false,
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

    DataToSave["Day0Events"].IntroPlayed                = temp["Day0Events"].IntroPlayed
    DataToSave["Day0Events"].FuneralScenePlayed         = temp["Day0Events"].FuneralScenePlayed
    DataToSave["Day0Events"].BedroomSceneConveration    = temp["Day0Events"].BedroomSceneConveration

    DataToSave["Day1Events"].SawControlText             = temp["Day1Events"].SawControlText
    DataToSave["Day1Events"].WentToSchool               = temp["Day1Events"].WentToSchool
    DataToSave["Day1Events"].WentToGrocerBeforeSchool   = temp["Day1Events"].WentToGrocerBeforeSchool
    DataToSave["Day1Events"].SpokeWithMomAfterSchool    = temp["Day1Events"].SpokeWithMomAfterSchool
    DataToSave["Day1Events"].NeighbourConversationSeen  = temp["Day1Events"].NeighbourConversationSeen
    DataToSave["Day1Events"].NeighbourConversationSeen2 = temp["Day1Events"].NeighbourConversationSeen2
    DataToSave["Day1Events"].HeardSpeechFromPriest      = temp["Day1Events"].HeardSpeechFromPriest
    DataToSave["Day1Events"].HasSeenCultOutsideHouse    = temp["Day1Events"].HasSeenCultOutsideHouse
    DataToSave["Day1Events"].WentToGrocerAfterSchool    = temp["Day1Events"].WentToGrocerAfterSchool
    DataToSave["Day1Events"].SawPersonComingFromShack   = temp["Day1Events"].SawPersonComingFromShack
    DataToSave["Day1Events"].SeenCoupleBickeringOutsideGrocer   = temp["Day1Events"].SeenCoupleBickeringOutsideGrocer
    DataToSave["Day1Events"].WentUnderneathCollector    = temp["Day1Events"].WentUnderneathCollector
    DataToSave["Day1Events"].DialogInButcherySeen       = temp["Day1Events"].DialogInButcherySeen

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

    DataToSave["Day1Events"].SawControlText             = false
    DataToSave["Day1Events"].WentToSchool               = false
    DataToSave["Day1Events"].SpokeWithMomAfterSchool    = false
    DataToSave["Day1Events"].NeighbourConversationSeen  = false
    DataToSave["Day1Events"].NeighbourConversationSeen2 = false
    DataToSave["Day1Events"].HeardSpeechFromPriest      = false
    DataToSave["Day1Events"].HasSeenCultOutsideHouse    = false
    DataToSave["Day1Events"].WentToGrocerAfterSchool    = false
    DataToSave["Day1Events"].WentToGrocerBeforeSchool   = false
    DataToSave["Day1Events"].SeenCoupleBickeringOutsideGrocer = false
    DataToSave["Day1Events"].WentUnderneathCollector    = false
    DataToSave["Day1Events"].SawPersonComingFromShack   = false
    DataToSave["Day1Events"].DialogInButcherySeen       = false

    DataToSave["CurrentCharacter"]         = "Henry"
    DataToSave["CurrentCoordinates"].x_pos = 0
    DataToSave["CurrentCoordinates"].y_pos = 0
    DataToSave["CurrentScene"]             = "src/levels/day0/scenes/intro"
    DataToSave["File"]                     =  ""

end


return DataToSave