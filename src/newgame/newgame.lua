

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
local StarterMap_Cache = {}
local StarterMapImage_Cache = {}

local function Initialize_StarterMapStrings()

    for y = 1, #StarterMap do
        StarterMap_Cache[y] = {}
        for x = 1, #StarterMap[y] do
            StarterMap_Cache[y][x] = StarterMapTileDirectory .. "/" .. StarterMap[y][x] .. ".png"
        end
    end

end

local function CheckIfStringExistsInStringCache(StringCache, y, x)

    for k = 1, #StringCache do
        if StringCache[k] == StarterMap_Cache[y][x] then return true end
    end
    return false

end

local function SetImageDataFromStringCache(StringCache, y, x)

    for k = 1, #StringCache do
        if StringCache[k] == StarterMap_Cache[y][x] then
            StarterMap_Cache[y][x] = StarterMapImage_Cache[k]
            break
        end
    end

end

local function UsingStringCacheResetStarterMapCache(StringCache)

    for i = 1, #StringCache do
        StarterMapImage_Cache[i] = love.graphics.newImage(StringCache[i])
    end

    for y = 1, #StarterMap_Cache do
        for x = 1, #StarterMap_Cache[y] do
            SetImageDataFromStringCache(StringCache, y, x)
        end
    end

end

local function Initialize_StarterMapImages()

    local StringCache = {}
    for y = 1, #StarterMap_Cache do
        for x = 1, #StarterMap_Cache[y] do
            if not CheckIfStringExistsInStringCache(StringCache, y, x) then
                StringCache[#StringCache + 1] = StarterMap_Cache[y][x]
            end
        end
    end
    UsingStringCacheResetStarterMapCache(StringCache)

end

function InitializeNewGame_StarterMapCache()

    Initialize_StarterMapStrings()
    Initialize_StarterMapImages()

end

function DrawNewGame()

    for y = 1, #StarterMap_Cache do
        for x = 1, #StarterMap_Cache[y] do
            love.graphics.draw(StarterMap_Cache[y][x],(x-1)*75, (y-1)*75, 0, .15, .15)
        end
    end

end