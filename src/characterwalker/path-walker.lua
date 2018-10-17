local PathWalker = {}
PathWalker.__index = PathWalker

function PathWalker:new(char, walker_instructions)

    local obj = {}
    setmetatable(obj, PathWalker)
    obj.char = char
    obj.walker_instructions = walker_instructions
    obj:Init()

    return obj

end

function PathWalker:Init()

    self.is_done_walking = false
    self.path       = self.walker_instructions.Path
    self.loop       = self.walker_instructions.Loop or false
    self.loop_amt   = self.walker_instructions.TimesToLoop or 0

    self.point_made = {}
    for i = 1, #self.path do
        self.point_made[i] = false
    end

end

function PathWalker:CheckForPointsMade()



end

function PathWalker:Update()

    self:CheckForPointsMade()

end

function PathWalker:IsDoneWalking()

    return self.is_done_walking

end

return PathWalker