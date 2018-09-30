Collision = {}
Collision.__index = Collision

local Shared = require("src/shared/shared")

function Collision:new(x_pos, y_pos, width, height)

    local obj = {}
    setmetatable(obj, Collision)
    obj.x_pos  = x_pos
    obj.y_pos  = y_pos
    obj.width  = width
    obj.height = height

    return obj    

end

function Collision:CheckForCollision(x, y)

    if not Shared.IsBetweenRange(x, self.x_pos, self.x_pos + self.width) then
        return false
    end
    
    if not Shared.IsBetweenRange(y, self.y_pos, self.y_pos + self.height) then
        return false
    end

    return true

end