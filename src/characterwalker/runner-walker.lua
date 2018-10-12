local RunnerWalker = {}
RunnerWalker.__index = RunnerWalker

function RunnerWalker:new(char, walker_instructions)

    local obj = {}
    setmetatable(obj, RunnerWalker)
    obj.char = char
    obj.walker_instructions = walker_instructions
    obj.walk_direction      = walker_instructions.WalkDirection
    obj.player              = walker_instructions.player

    return obj

end

function RunnerWalker:AnnimateMove()
    if self.walk_direction == "WalkDown" then
        self.char:WalkDown(false)
        self.char:GlideDown()
    elseif self.walk_direction == "WalkUp" then
        self.char:WalkUp(false)
        self.char:GlideUp()
    elseif self.walk_direction == "WalkLeft" then
        self.char:WalkLeft(false)
        self.char:GlideLeft()
    elseif self.walk_direction == "WalkRight" then
        self.char:WalkRight(false)
        self.char:GlideRight()
    end
end

function RunnerWalker:CalculateHorizontalGlide()

    local dx = self.char.x_pos - self.player.x_pos
    if math.abs(dx) >= 2 then
        dx = math.floor((dx/math.abs(dx)) * 2)
    end
    if math.abs(dx) >= .05 then
        self.char:GlideRight(dx)
    end

end

function RunnerWalker:CalculateVerticalGlide()

    local dy = self.char.y_pos - self.player.y_pos
    if math.abs(dy) >= 2 then
        dy = math.floor((dy/math.abs(dy)) * 2)
    end
    if math.abs(dy) >= .05 then
        self.char:GlideUp(dy)
    end

end

function RunnerWalker:CalculateSidestep()

    if self.walk_direction == "WalkUp" or self.walk_direction == "WalkDown" then
        self:CalculateHorizontalGlide()
    elseif self.walk_direction == "WalkRight" or self.walk_direction == "WalkLeft" then
        self:CalculateVerticalGlide()
    end

end

function RunnerWalker:Move()

    self:AnnimateMove()
    self:CalculateSidestep()

end

function RunnerWalker:Update()

    self:Move()

end

function RunnerWalker:IsDoneWalking()

    return false

end

return RunnerWalker