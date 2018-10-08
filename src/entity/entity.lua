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

function Entity:newMinimal(x_pos, y_pos)

    local obj = {}
    setmetatable(obj, Entity)
    obj.x_pos = x_pos
    obj.y_pos = y_pos
    obj.width = 16
    obj.width = 16

    return obj

end

function Entity:newQuadWithMovementFunction(x_pos, y_pos, movement_function, dt_update, quad, sprite_sheet)

    local obj = {}
    setmetatable(obj, Entity)

    obj.x_pos          = x_pos
    obj.y_pos          = y_pos
    obj.move_func      = movement_function
    obj.quad           = quad
    obj.sprite_sheet   = sprite_sheet
    obj.dt_update      = dt_update or .1
    obj.next_update    = love.timer.getTime() + obj.dt_update

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

    if self.image ~= nil then
        love.graphics.draw(self.image, self.x_pos, self.y_pos, 0, self.x_scale, self.y_scale)
    elseif self.quad ~= nil and self.sprite_sheet ~= nil then
        print("Drawing puck")
        love.graphics.draw(self.sprite_sheet, self.quad, self.x_pos, self.y_pos)
    end

end

function Entity:Update()

    if self.move_func ~= nil and love.timer.getTime() >= self.next_update then

        self.x_pos, self.y_pos = self.move_func(self.x_pos, self.y_pos)
        self.next_update = love.timer.getTime() + self.dt_update

    end

end

return Entity