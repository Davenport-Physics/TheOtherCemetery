local PathWalker = {}
PathWalker.__index = PathWalker

function PathWalker:new(char, walker_instructions)

    local obj = {}
    setmetatable(obj, PathWalker)
    obj.char = char
    obj.walker_instructions = walker_instructions
    obj.point_threshold     = walker_instructions.threshold or 1
    obj.debug               = walker_instructions.debug or false
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

    local char_d = nil
    local path_d = nil
    if self.compare_x then
        char_d = self.char.x_pos
        path_d = self.path[idx].x
    else
        char_d = self.char.y_pos
        path_d =  self.path[idx].y
    end
    if self.new_pos_large_mag then
        if char_d >= path_d then
            if self.debug then
                print(char_d)
                print(path_d)
                print("----")
            end
            self.point_made[idx] = true
        end
    else
        if char_d <= path_d then
            if self.debug then
                print(char_d)
                print(path_d)
                print("----")
            end
            self.point_made[idx] = true
        end
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