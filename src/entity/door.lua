local Door = {}
Door.__index = Door

local CollionClass = require("src/collision/collision")

function Door:new(x_pos, y_pos, width, height, transition_to_scene)

    local obj = {}
    setmetatable(obj, Door)
    obj.x_pos  = x_pos
    obj.y_pos  = y_pos
    obj.width  = width
    obj.height = height
    obj.transition_to_scene = transition_to_scene
    obj.collision_obj       = CollionClass:new(x_pos, y_pos, width, height, "door")

    return obj

end

function Door:CheckForCollision(x_pos, y_pos)

    if self.collision_obj:CheckForCollision(x_pos, y_pos) then
        return self.transition_to_scene
    end
    return false

end

return Door