local RunnerWalker = {}
RunnerWalker.__index = RunnerWalker

function RunnerWalker:new(char, walker_instructions)

    local obj = {}
    setmetatable(obj, RunnerWalker)
    obj.char = char
    obj.walker_instructions = walker_instructions
    obj.walk_direction      = walker_instructions.WalkDirection
    obj.player              = walker_instructions.Player
    obj.displacement        = walker_instructions.Displacement or 1.5
    obj.random_displacement_chance = walker_instructions.RandomDisplacementChance or false

    return obj

end

function RunnerWalker:AnnimateMove()
    if self.walk_direction == "WalkDown" then
        self.char:WalkDown(false)
        self.char:GlideDown(self.displacement)
    elseif self.walk_direction == "WalkUp" then
        self.char:WalkUp(false)
        self.char:GlideUp(-self.displacement)
    elseif self.walk_direction == "WalkLeft" then
        self.char:WalkLeft(false)
        self.char:GlideLeft(-self.displacement)
    elseif self.walk_direction == "WalkRight" then
        self.char:WalkRight(false)
        self.char:GlideRight(self.displacement)
    end
end

function RunnerWalker:CalculateRandomChance(dd)

    if not self.random_displacement_chance then 
        return dd 
    end

    if math.random(1, 100) <= self.random_displacement_chance then
        return -(dd/math.abs(dd)) * 2.75
    else
        return dd
    end

end

function RunnerWalker:CalculateHorizontalGlide()

    local dx = self.char.x_pos - self.player.x_pos
    if math.abs(dx) >= 2 then
        dx = (dx/math.abs(dx)) * 2
    end
    dx = self:CalculateRandomChance(dx)
    if math.abs(dx) >= .05 then
        self.char:GlideRight(-dx, true)
    end

end

function RunnerWalker:CalculateVerticalGlide()

    local dy = self.char.y_pos - self.player.y_pos
    if math.abs(dy) >= 2 then
        dy = (dy/math.abs(dy)) * 2
    end
    dy = self:CalculateRandomChance(dy)
    if math.abs(dy) >= .05 then
        self.char:GlideUp(-dy, true)
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