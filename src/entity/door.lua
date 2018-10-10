local Door = {}
Door.__index = Door

local CollionClass = require("src/collision/collision")

function Door:new(x_pos, y_pos, width, height, transition_to_scene, new_x_pos, new_y_pos)

    local obj = {}
    setmetatable(obj, Door)
    obj.x_pos  = x_pos
    obj.y_pos  = y_pos
    obj.new_x_pos = new_x_pos
    obj.new_y_pos = new_y_pos
    obj.width  = width
    obj.height = height
    obj.transition_to_scene = transition_to_scene
    obj.collision_obj       = CollionClass:new(x_pos, y_pos, width, height, "door")

    return obj

end

function Door:CheckForCollision(x_pos, y_pos)

    if self.collision_obj:CheckForCollision(x_pos, y_pos) then
        return {self.transition_to_scene, self.new_x_pos, self.new_y_pos}
    end
    return false

end

return Door