local PathWalker = {}
PathWalker.__index = PathWalker

function PathWalker:new(char, walker_instructions)

    local obj = {}
    setmetatable(obj, PathWalker)
    obj.char = char
    obj.walker_instructions = walker_instructions
    obj:InitializePath()

    return obj

end

function PathWalker:InitializePath()

end

function PathWalker:Update()

end

function PathWalker:IsDoneWalking()

    return false

end

return PathWalker