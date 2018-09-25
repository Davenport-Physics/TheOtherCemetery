

local Map = {}

function Map:new(Map, MapTileDirectory)

    local o = {Map = Map, MapTileDirectory = MapTileDirectory}
    setmetatable(o, self)
    self.__index = self
    return o

end

function Map.InitializeMapStrings()

    self.Map_Cache = {}
    for y = 1, #self.Map do
        self.Map_Cache[y] = {}
        for x = 1, #self.Map[y] do
            self.Map_Cache[y][x] = self.MapTileDirectory .. "/" .. self.Map[y][x] .. ".png"
        end
    end

end

function Map:SetImageDataFromStringCache(StringCache, y, x)

    for k = 1, #StringCache do
        if StringCache[k] == StarterMap_Cache[y][x] then
            self.Map_Cache[y][x] = self.MapImage_Cache[k]
            break
        end
    end

end

function Map:UsingStringCacheResetStarterMapCache(StringCache)

    self.MapImage_Cache = {}
    for i = 1, #StringCache do
        self.MapImage_Cache[i] = love.graphics.newImage(StringCache[i])
    end

    for y = 1, #self.Map_Cache do
        for x = 1, #self.Map_Cache[y] do
            SetImageDataFromStringCache(StringCache, y, x)
        end
    end

end

function Map:CheckIfStringExistsInStringCache(StringCache, y, x)

    for k = 1, #StringCache do
        if StringCache[k] == self.Map_Cache[y][x] then return true end
    end
    return false

end

function Map:InitializeMapImages()

    local StringCache = {}
    for y = 1, #self.Map_Cache do
        for x = 1, #self.Map_Cache[y] do
            if not CheckIfStringExistsInStringCache(StringCache, y, x) then
                StringCache[#StringCache + 1] = self.Map_Cache[y][x]
            end
        end
    end
    UsingStringCacheResetStarterMapCache(StringCache)

end

function Map:InitializeMapCache()

    self.InitializeMapStrings()
    self.InitializeMapImages()

end

function Map:Draw()
    for y = 1, #self.Map_Cache do
        for x = 1, #self.Map_Cache[y] do
            love.graphics.draw(self.Map_Cache[y][x],(x-1)*75, (y-1)*75, 0, .15, .15)
        end
    end
end

return Map