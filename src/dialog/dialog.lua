local Dialog = {}
Dialog.__index = Dialog

function Dialog:new(textbubbles, delay)

    local obj = {}
    setmetatable(obj, Dialog)
    obj.textbubbles  = textbubbles
    obj.delay        = delay
    obj.started      = false
    obj.finished     = false
    obj.text_idx     = 1
    obj.time_to_next = nil
    return obj

end

function Dialog:CheckIfStarted()

    if not self.started then
        self.time_to_next = love.timer.getTime() + self.delay
        self.started      = true
    end

end

function Dialog:CheckForSwitch()

    if love.timer.getTime() > self.time_to_next then
        self.text_idx      = self.text_idx + 1
        self.time_to_next  = love.timer.getTime() + self.delay
    end

end

function Dialog:Draw()

    if self.finished then return end
    self:CheckIfStarted()
    self:CheckForSwitch()
    if self.text_idx > #self.textbubbles then
        self.finished = true
        return
    end
    self.textbubbles[self.text_idx]:Draw()

end

function Dialog:IsFinished()

    return self.finished

end

return Dialog