local DoorHandler = {}
DoorHandler.__index = DoorHandler

function DoorHandler:new(doors, character)

    local obj = {}
    setmetatable(obj, DoorHandler)
    obj.doors = doors
    obj.char  = character

    return obj

end

function DoorHandler:CheckForCollisions()

    local transition = false
    for i = 1, #self.doors do
        transition = self.doors[i]:CheckForCollision(self.char:GetCenterPosition())
        if type(transition) == "table" then
            return transition
        end
    end

    return transition

end

return DoorHandler