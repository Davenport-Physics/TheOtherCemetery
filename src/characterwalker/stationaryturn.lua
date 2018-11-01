local StationaryTurn = {}
StationaryTurn.__index = StationaryTurn

function StationaryTurn:new(char, walker_instructions)

    local obj = {}
    setmetatable(obj, StationaryTurn)
    obj.char = char
    obj.dt   = walker_instructions.DirectionDt
    obj.next_dir_change = love.timer.getTime() + obj.dt
    obj.current_dir     = walker_instructions.CurrentDirection

    return obj

end

function StationaryTurn:DetermineNextDirection()

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