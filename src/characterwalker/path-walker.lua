local PathWalker = {}
PathWalker.__index = PathWalker

function PathWalker:new(char, walker_instructions)

    local obj = {}
    setmetatable(obj, PathWalker)
    obj.char = char
    obj.walker_instructions = walker_instructions
    obj.point_threshold     = walker_instructions.threshold or 1
    obj.cycle               = walker_instructions.cycle or false
    obj.debug               = walker_instructions.debug or false
    obj.idx                 = 1
    obj:Init()

    return obj

end

function PathWalker:Init()

    self.is_done_walking = false
    self.path         = self.walker_instructions.path
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

function PathWalker:SetCurrentInformation(walk, new_pos_large_mag, compare_x)

    self.new_pos_large_mag = new_pos_large_mag
    self.current_walk      = walk
    self.compare_x         = compare_x

end

function PathWalker:SetNewWalkStanceY(old_pos, new_pos)

    if new_pos > old_pos then
        self:SetCurrentInformation(self.char.WalkDown, true, false)
    elseif new_pos < old_pos then
        self:SetCurrentInformation(self.char.WalkUp, false, false)
    end

end

function PathWalker:SetNewWalkStanceX(old_pos, new_pos)

    if new_pos > old_pos then
        self:SetCurrentInformation(self.char.WalkRight, true, true)
    elseif new_pos < old_pos then
        self:SetCurrentInformation(self.char.WalkLeft, false, true)
    end

end

function PathWalker:ResetIfIterationFinished()

    self.idx = 1
    self:Init()

end

function PathWalker:SetFlagsOrReset()

    if not self.cycle then
        self.is_done_walking = true
    else
        self:ResetIfIterationFinished()
    end

end

function PathWalker:CalculateNextWalkOrQuit(idx)

    if (idx + 1) > #self.path then
        self:SetFlagsOrReset()
        return
    end
    if self.path[idx+1].y ~= self.path[idx].y then
        self:SetNewWalkStanceY(self.path[idx].y, self.path[idx+1].y)
        self.idx = idx + 1
        return
    end
    if self.path[idx+1].x ~= self.path[idx].x then
        self:SetNewWalkStanceX(self.path[idx].x, self.path[idx+1].x)
        self.idx = idx + 1
        return
    end

end

function PathWalker:GetCharAndPathD(idx)

    local char_d = nil
    local path_d = nil
    if self.compare_x then
        char_d = self.char.x_pos
        path_d = self.path[idx].x
    else
        char_d = self.char.y_pos
        path_d =  self.path[idx].y
    end
    return char_d, path_d

end

function PathWalker:IsPointMade(char_d, path_d, idx)

    if self.new_pos_large_mag then
        if char_d >= path_d then
            self.point_made[idx] = true
        end
    else
        if char_d <= path_d then
            self.point_made[idx] = true
        end
    end

end

function PathWalker:SetCharacterPositionWithPointMade(idx)

    if self.point_made[idx] == true then
        self.char.x_pos = self.path[idx].x
        self.char.y_pos = self.path[idx].y
    end

end

function PathWalker:CheckForSpecificPointMade(idx)

    local char_d, path_d = self:GetCharAndPathD(idx)
    self:IsPointMade(char_d, path_d, idx)
    self:SetCharacterPositionWithPointMade(idx)

end

function PathWalker:CheckForPointsMade()

    if not self.point_made[self.idx] then
        self:CheckForSpecificPointMade(self.idx)
        if self.point_made[self.idx] then self:CalculateNextWalkOrQuit(self.idx) end
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