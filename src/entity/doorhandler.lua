local DoorHandler = {}
DoorHandler.__index = DoorHandler

function DoorHandler:new(doors, character)

    local obj = {}
    setmetatable(obj, DoorHandler)
    obj.doors = doors
    obj.char  = character
    obj:InitEnabled()

    return obj

end

function DoorHandler:InitEnabled()

    self.enabled = {}
    for i = 1, #self.doors do
        self.enabled[i] = true
    end

end

function DoorHandler:ToggleDoor(idx, val)

    self.enabled[idx] = val

end

function DoorHandler:CheckForCollisions()

    local transition
    for i = 1, #self.doors do
        if self.enabled[i] then
            transition = self.doors[i]:CheckForCollision(self.char:GetCenterPosition())
            if type(transition) == "table" then
                return transition
            end
        end
    end

    return false

end

return DoorHandler