local RunnerWalker = {}
RunnerWalker.__index = RunnerWalker

function RunnerWalker:new(char, walker_instructions)

    local obj = {}
    setmetatable(obj, RunnerWalker)
    obj.char = char
    obj.walker_instructions = walker_instructions

    return obj

end

function RunnerWalker:AnnimateMove()
    if self.walker_instructions.WalkDirection == "WalkDown" then
        self.char:WalkDown(false)
        self.char:GlideDown()
    elseif self.walker_instructions.WalkDirection == "WalkUp" then
        self.char:WalkUp(false)
        self.char:GlideUp()
    elseif self.walker_instructions.WalkDirection == "WalkLeft" then
        self.char:WalkLeft(false)
        self.char:GlideLeft()
    elseif self.walker_instructions.WalkDirection == "WalkRight" then
        self.char:WalkRight(false)
        self.char:GlideRight()
    end
end

function RunnerWalker:CalculateSidestep()

    

end

function RunnerWalker:Move()

    self:AnnimateMove()
    self:

end

function RunnerWalker:Update()

    self:Move()

end

function RunnerWalker:IsDoneWalking()

    return false

end

return RunnerWalker