local Collision = {}
Collision.__index = Collision

local Shared = require("src/shared/shared")
local sqrt = math.sqrt

function Collision:new(x_pos, y_pos, width, height, name)

    local obj = {}
    setmetatable(obj, Collision)
    obj.x_pos  = x_pos
    obj.y_pos  = y_pos
    obj.width  = width
    obj.height = height
    obj.end_x  = x_pos + width
    obj.end_y  = y_pos + height
    obj.name   = name or ""

    return obj

end

function Collision:CheckIfNearby(x, y)

    return sqrt((self.x_pos - x) ^ 2 + (self.y_pos - y) ^ 2) <= 24

end

function Collision:CheckForCollision(x, y)

    if not Shared.IsBetweenRange(x, self.x_pos, self.end_x) then
        return false
    end

    if not Shared.IsBetweenRange(y, self.y_pos, self.end_y) then
        return false
    end

    return true

end

function Collision:CheckForCollisionAdvanced(x, y, width, height)

    if (x > self.end_x or x + width < self.x_pos) then
        return false
    end
    if (y > self.end_y or y + height < self.y_pos) then
        return false
    end

    return true

end

return Collision