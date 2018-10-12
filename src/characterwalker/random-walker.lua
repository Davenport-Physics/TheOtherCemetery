local RandomWalker = {}
RandomWalker.__index = RandomWalker

function RandomWalker:new(char, walker_instructions)

    local obj = {}
    setmetatable(obj, RandomWalker)
    obj.char = char
    obj.walker_instructions = walker_instructions

    return obj

end

function RandomWalker:Update()

end

function RandomWalker:IsDoneWalking()

    return false

end

return RandomWalker