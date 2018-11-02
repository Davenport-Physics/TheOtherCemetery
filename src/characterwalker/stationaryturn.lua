local StationaryTurn = {}
StationaryTurn.__index = StationaryTurn

function StationaryTurn:new(char, walker_instructions)

    local obj = {}
    setmetatable(obj, StationaryTurn)
    obj.char = char
    obj.dt   = walker_instructions.DirectionDt
    obj.next_dir_change = love.timer.getTime() + obj.dt
    obj.current_dir     = walker_instructions.CurrentDirection
    obj.specific_turns  = walker_instructions.SpecificTurns

    return obj

end

function StationaryTurn:GenericDirection()
    if self.current_dir == "Down" then
        self.current_dir = "Left"
        self.char:WalkLeft()
    elseif self.current_dir == "Left" then
        self.current_dir = "Up"
        self.char:WalkUp()
    elseif self.current_dir == "Up" then
        self.current_dir = "Right"
        self.char:WalkRight()
    elseif self.current_dir == "Right" then
        self.current_dir = "Down"
        self.char:WalkDown()
    end
end

function StationaryTurn:SpecificTurns()

    for i = 1, #self.specific_turns do

        if self.current_dir == self.specific_turns[i].dir then
            self.current_dir = self.specific_turns[i].new_dir
            self.specific_turns[i].func(self.char)
            return
        end

    end

end

function StationaryTurn:DetermineNextDirection()

    if self.specific_turns == nil then
        self:GenericDirection()
    else
        self:SpecificTurns()
    end

end

function StationaryTurn:Update()

    if love.timer.getTime() >= self.next_dir_change then

        self:DetermineNextDirection()
        self.next_dir_change = love.timer.getTime() + self.dt

    end

end

function StationaryTurn:IsDoneWalking()

    return false

end

return StationaryTurn