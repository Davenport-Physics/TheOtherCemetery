local PathWalker = {}
PathWalker.__index = PathWalker

function PathWalker:new(char, walker_instructions)

    local obj = {}
    setmetatable(obj, PathWalker)
    obj.char = char
    obj.walker_instructions = walker_instructions
    obj.path = walker_instructions.path
    obj.is_done_walking = false

    return obj

end

function PathWalker:Update()



end

function PathWalker:IsDoneWalking()

    return self.is_done_walking

end

return PathWalker