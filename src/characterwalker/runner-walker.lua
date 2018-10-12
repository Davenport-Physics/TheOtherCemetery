local RunnerWalker = {}
RunnerWalker.__index = RunnerWalker

function RunnerWalker:new(walker_instructions)

    local obj = {}
    setmetatable(obj, RunnerWalker)
    obj.walker_instructions = walker_instructions

    return obj

end

function RunnerWalker:Update()

end

function RunnerWalker:IsDoneWalking()

    return false

end

return RunnerWalker