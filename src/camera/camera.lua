local Camera = {}
Camera.__index = Camera

function Camera:new(start_x_pos, start_y_pos, displace_x, displace_y, time_to_displace)

    local Obj = {}
    setmetatable(Obj, Camera)
    Obj.o_x_pos = start_x_pos
    Obj.o_y_pos = start_y_pos
    Obj.x_pos = start_x_pos
    Obj.y_pos = start_y_pos
    Obj.displace_y = displace_y
    Obj.displace_x = displace_x
    Obj.time_between_updates = time_to_displace
    Obj.time_for_update = love.timer.getTime()

    return Obj

end

function Camera:Update()

    if love.timer.getTime() >= self.time_for_update then

        self.time_for_update = love.timer.getTime() + self.time_between_updates
        self.x_pos = self.x_pos + self.displace_x
        self.y_pos = self.y_pos + self.displace_y

    end

end

function Camera:ResetPosition()

    self.x_pos = self.o_x_pos
    self.y_pos = self.o_y_pos

end

return Camera