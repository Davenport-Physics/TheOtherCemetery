local PathWalker = {}
PathWalker.__index = PathWalker

function PathWalker:new(walker_instructions)

    local obj = {}
    setmetatable(obj, PathWalker)
    obj.walker_instructions = walker_instructions

    return obj

end

function PathWalker:Update()

end

function PathWalker:IsDoneWalking()

    return false

end

return PathWalker