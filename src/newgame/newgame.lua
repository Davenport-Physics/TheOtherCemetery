

local StarterMapTileDirectory = "tiles/autumn-platformer-tileset/png/tiles"
local StarterMap =
{

    {"12","12","12","12","12","17","01","01"},
    {"12","12","12","12","12","17","01","01"},
    {"12","12","12","12","12","17","01","01"},
    {"12","12","12","12","12","17","01","01"},
    {"12","12","12","12","12","17","01","01"},
    {"12","12","12","12","12","17","01","01"},
    {"12","12","12","12","12","17","01","01"},
    {"12","12","12","12","12","17","01","01"},

}
local StarterMap_Cache = {}
local StarterMapImage_Cache = {}

local function Initialize_StarterMapStrings()

    for i = 1, #StarterMap do
        StarterMap_Cache[i] = {}
        for j = 1, #StarterMap[1] do
            StarterMap_Cache[i][j] = StarterMapTileDirectory .. "/" .. StarterMap[i][j] .. ".png"
        end
    end

end

local function CheckIfStringExistsInStringCache(StringCache, i, j)

    for k = 1, #StringCache do
        if StringCache[k] == StarterMap_Cache[i][j] then return true end
    end
    return false

end

local function SetImageDataFromStringCache(StringCache, i, j)

    for k = 1, #StringCache do
        if StringCache[k] == StarterMap_Cache[i][j] then
            StarterMap_Cache[i][j] = StarterMapImage_Cache[k]
            break
        end
    end

end

local function UsingStringCacheResetStarterMapCache(StringCache)

    for i = 1, #StringCache do
        StarterMapImage_Cache[i] = love.graphics.newImage(StringCache[i])
    end

    for i = 1, #StarterMap_Cache do
        for j = 1, #StarterMap_Cache do
            SetImageDataFromStringCache(StringCache, i, j)
        end
    end

end

local function Initialize_StarterMapImages()

    local StringCache = {}
    for i = 1, #StarterMap_Cache do
        for j = 1, #StarterMap_Cache[1] do
            if not CheckIfStringExistsInStringCache(StringCache, i, j) then
                StringCache[#StringCache + 1] = StarterMap_Cache[i][j]
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

    for i = 1, #StarterMap_Cache do
        for j = 1, #StarterMap_Cache[1] do
            love.graphics.draw(StarterMap_Cache[j][i],(i-1)*75, (j-1)*75, 0, .15, .15)
        end
    end

end