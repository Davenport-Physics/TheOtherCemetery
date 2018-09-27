local MapClass = require("src/map/map")


local FuneralHomeFloorDataLocation = "tiles/autumn-platformer-tileset/png/elements/"
local FuneralHomeFloorData =
{

    {"box1","box1", "box1","box1", "box1","box1", "box1","box1"},
    {"box1","box1", "box1","box1", "box1","box1", "box1","box1"},
    {"box1","box1", "box1","box1", "box1","box1", "box1","box1"},
    {"box1","box1", "box1","box1", "box1","box1", "box1","box1"},

}

local FuneralHomeFloorMap = MapClass:new(FuneralHomeFloorData, FuneralHomeFloorDataLocation)