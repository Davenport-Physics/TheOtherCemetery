

local StarterMapTileDirectory = "tiles/autumn-platformer-tileset/png/tiles"
local StarterMap =
{

    {"12","12","12","12","12","17","01","01","18","12","12"},
    {"12","12","12","12","12","17","01","01","18","12","12"},
    {"12","12","12","12","12","17","01","01","18","12","12"},
    {"12","12","12","12","12","17","01","01","18","12","12"},
    {"12","12","12","12","12","17","01","01","18","12","12"},
    {"12","12","12","12","12","17","01","01","18","12","12"},
    {"12","12","12","12","12","17","01","01","18","12","12"},
    {"12","12","12","12","12","17","01","01","18","12","12"},

}

local MapClass = require("src/map/map")
local MapImage = MapClass:new(StarterMap, StarterMapTileDirectory); MapImage:InitializeMapCache();

function DrawNewGame()
    MapImage:Draw()
end