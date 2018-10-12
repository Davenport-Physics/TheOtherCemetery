local RunnerWalker = {}
RunnerWalker.__index = RunnerWalker

function RunnerWalker:new(char, walker_instructions)

    local obj = {}
    setmetatable(obj, RunnerWalker)
    obj.char = char
    obj.walker_instructions = walker_instructions

    return obj

end

function RunnerWalker:Walk()

    if self.walker_instructions.WalkDirection == "WalkDown" then
        self.char:WalkDown(true)
    elseif self.walker_instructions.WalkDirection == "WalkUp" then
        self.char:WalkUp(true)
    elseif self.walker_instructions.WalkDirection == "WalkLeft" then
        self.char:WalkLeft(true)
    elseif self.walker_instructions.WalkDirection == "WalkRight" then
        self.char:WalkRight(true)
    end

end

function RunnerWalker:Glide()


end

function RunnerWalker:Update()

    self:Walk()
    self:Glide()

end

function RunnerWalker:IsDoneWalking()

    return false

end

return RunnerWalker