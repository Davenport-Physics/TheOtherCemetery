local PathWalker = {}
PathWalker.__index = PathWalker

function PathWalker:new(char, walker_instructions)

    local obj = {}
    setmetatable(obj, PathWalker)
    obj.char = char
    obj.walker_instructions = walker_instructions
    obj.point_threshold     = 1
    obj:Init()

    return obj

end

function PathWalker:Init()

    self.is_done_walking = false
    self.path         = self.walker_instructions
    self.point_made   = {}
    self.current_walk = nil

    if #self.path > 0 then
        self:SetNewWalkStanceX(self.char.x_pos, self.path[1].x)
        self:SetNewWalkStanceY(self.char.y_pos, self.path[1].y)
    end
    for i = 1, #self.path do
        self.point_made[i] = false
    end

end

function PathWalker:SetNewWalkStanceY(old_pos, new_pos)

    if new_pos > old_pos then
        self.current_walk = self.char.WalkDown
    elseif new_pos < old_pos then
        self.current_walk = self.char.WalkUp
    end

end

function PathWalker:SetNewWalkStanceX(old_pos, new_pos)

    if new_pos > old_pos then
        self.current_walk = self.char.WalkRight
    elseif new_pos < old_pos then
        self.current_walk = self.char.WalkLeft
    end

end

function PathWalker:CalculateNextWalkOrQuit(idx)

    if (idx + 1) > #self.path then
        self.is_done_walking = true
        return
    end
    if self.path[idx+1].y ~= self.path[idx].y then
        self:SetNewWalkStanceY(self.path[idx].y, self.path[idx+1].y)
        return
    end
    if self.path[idx+1].x ~= self.path[idx].x then
        self:SetNewWalkStanceX(self.path[idx].x, self.path[idx+1].x)
        return
    end

end

function PathWalker:CheckForSpecificPointMade(idx)

    local x = (self.char.x_pos - self.path[idx].x)^2
    local y = (self.char.y_pos - self.path[idx].y)^2
    if math.sqrt(x + y) <= self.point_threshold then
        self.point_made[idx] = true
    end

end

function PathWalker:CheckForPointsMade()

    for i = 1, #self.point_made do
        if not self.point_made[i] then
            self:CheckForSpecificPointMade(i)
            if self.point_made[i] then self:CalculateNextWalkOrQuit(i) end
        end
    end

end

function PathWalker:Update()

    if self.is_done_walking then return end
    self.current_walk(self.char, true)
    self:CheckForPointsMade()

end

function PathWalker:IsDoneWalking()

    return self.is_done_walking

end

return PathWalker