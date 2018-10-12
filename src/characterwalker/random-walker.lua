local RandomWalker = {}
RandomWalker.__index = RandomWalker

function RandomWalker:new(walker_instructions)

    local obj = {}
    setmetatable(obj, RandomWalker)
    obj.walker_instructions = walker_instructions

    return obj

end

function RandomWalker:Update()

end

function RandomWalker:IsDoneWalking()

    return false

end

return RandomWalker