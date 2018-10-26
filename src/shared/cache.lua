
local IMAGE_CACHE = {}
function getImageFromCache(file)

    if IMAGE_CACHE[file] == nil then
        IMAGE_CACHE[file] = love.graphics.newImage(file)
    end
    return IMAGE_CACHE[file]

end