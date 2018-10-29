
local IMAGE_CACHE = {}
function getImageFromCache(file)

    if IMAGE_CACHE[file] == nil then
        IMAGE_CACHE[file] = love.graphics.newImage(file)
    end
    return IMAGE_CACHE[file]

end

local SOUND_CACHE = {}
function getSoundFromCache(file)

    if SOUND_CACHE[file] == nil then
        SOUND_CACHE[file] = love.audio.newSource(file, "static")
    end
    return SOUND_CACHE[file]

end

function getStreamSoundFromCache(file)

    if SOUND_CACHE[file] == nil then
        SOUND_CACHE[file] = love.audio.newSource(file, "stream")
    end
    return SOUND_CACHE[file]

end