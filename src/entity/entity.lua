local Entity = {}
Entity.__index = Entity

local Shared = require("src/shared/shared")

function Entity:newGeneric(image, x_pos, y_pos, x_scale, y_scale, collision_on)

    self.image   = image
    self.width   = image:getWidth()
    self.height  = image:getHeight()
    self.x_pos   = x_pos
    self.y_pos   = y_pos
    self.x_scale = x_scale
    self.y_scale = y_scale
    self.collision_on = collision_on

end

function Entity:new(image_file, x_pos, y_pos, x_scale, y_scale, collision_on)

    local obj = {}
    setmetatable(obj, Entity)
    obj:newGeneric(love.graphics.newImage(image_file), x_pos, y_pos,x_scale, y_scale, collision_on)

    return obj

end

function Entity:newWithImage(image, x_pos, y_pos, x_scale, y_scale, collision_on)

    local obj = {}
    setmetatable(obj, Entity)
    obj:newGeneric(image, x_pos, y_pos, x_scale, y_scale, collision_on)

    return obj

end


function Entity:CheckCollision(x_pos, y_pos)

    if not Shared.IsBetweenRange(x_pos, self.x_pos, self.width) then
        return false
    end
    if not Shared.IsBetweenRange(y_pos, self.y_pos, self.height) then
        return false
    end
    return true

end

function Entity:Draw()

    love.graphics.draw(self.image, self.x_pos, self.y_pos, 0, self.x_scale, self.y_scale)

end

return Entity