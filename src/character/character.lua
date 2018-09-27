Character = {}
Character.__index = Character


local DIRECTION =
{

    DOWN  = 1,
    RIGHT = 2,
    UP    = 3,
    LEFT  = 4

}

local STANCE = 
{

    STANDING  = 1,
    WALKING_1 = 2,
    WALKING_2 = 3,

}

local MIN_DT_FOR_CHANGING_STANCES = .05

function Character:new(character_image_file, x_pos, y_pos, width, height, displacement)

    local obj = {}
    setmetatable(obj, Character)

    obj.character_image            = love.graphics.newImage(character_image_file)
    obj.x_pos_orig, obj.y_pos_orig = x_pos, y_pos
    obj.x_pos, obj.y_pos           = x_pos, y_pos
    obj.width                      = width
    obj.height                     = height
    obj:InitializeAnimationSet(displacement)

    return obj

end

function Character:InitQuads()

    self.quads = {}
    for x = 0, self.character_image:getWidth() - self.width, self.width do
        self.quads[#self.quads + 1] = {}
        for y = 0, self.character_image:getHeight() - self.height, self.height do
            local Quad = love.graphics.newQuad(x, y+1, self.width, self.height, self.character_image:getDimensions())
            self.quads[#self.quads][#self.quads[#self.quads]+1] = Quad
        end
    end
    self.down_quads  = self.quads[1]
    self.right_quads = self.quads[2]
    self.up_quads    = self.quads[3]
    self.left_quads  = self.quads[4]

end

function Character:InitializeAnimationSet(displacement)

    self:InitQuads()
    self.current_quad  = self.quads[1][1]
    self.direction     = DIRECTION.DOWN
    self.stance        = STANCE.STANDING
    self.next_stance   = STANCE.WALKING_1
    self.displacement  = displacement or 5
    self.time_until_next_stance = love.timer.getTime() + MIN_DT_FOR_CHANGING_STANCES

end

function Character:Draw()

    love.graphics.draw(self.character_image, self.current_quad, self.x_pos, self.y_pos, 0,  3, 3)

end

function Character:DrawWalkInPlace()

    self:WalkDown(true)
    love.graphics.draw(self.character_image, self.current_quad, self.x_pos, self.y_pos, 0, 3, 3)

end

function Character:DetermineNewPresentStance()

    if self.stance == STANCE.STANDING then

        self.stance = self.next_stance

    elseif self.stance == STANCE.WALKING_1 then

        self.stance      = STANCE.STANDING
        self.next_stance = STANCE.WALKING_2

    elseif self.stance == STANCE.WALKING_2 then

        self.stance      = STANCE.STANDING
        self.next_stance = STANCE.WALKING_1

    end

end

function Character:DisplaceCharacter()

    if self.direction == DIRECTION.UP then

        self.y_pos = self.y_pos - self.displacement

    elseif self.direction == DIRECTION.DOWN then

        self.y_pos = self.y_pos + self.displacement

    elseif self.direction == DIRECTION.LEFT then

        self.x_pos = self.x_pos - self.displacement

    elseif self.direction == DIRECTION.RIGHT then

        self.x_pos = self.x_pos + self.displacement

    end

end

function Character:CheckTimeChangeBeforeMoving()

    if love.timer.getTime() >= self.time_until_next_stance then

        self.time_until_next_stance = love.timer.getTime() + MIN_DT_FOR_CHANGING_STANCES
        return true

    end

    return false

end

function Character:WalkGeneric(CorrectDirection, displace)

    if not self:CheckTimeChangeBeforeMoving() then return end

    if self.direction == CorrectDirection then

        self:DetermineNewPresentStance()
        if displace then self:DisplaceCharacter() end

    else

        self.direction    = CorrectDirection
        self.stance       = STANCE.STANDING
        self.next_stance  = STANCE.WALKING_1

    end
    self.current_quad = self.quads[CorrectDirection][self.stance]

end

function Character:WalkDown(displace)

    self:WalkGeneric(DIRECTION.DOWN, displace)

end

function Character:WalkUp(displace)

    self:WalkGeneric(DIRECTION.UP, displace)

end

function Character:WalkLeft(displace)

    self:WalkGeneric(DIRECTION.LEFT, displace)

end

function Character:WalkRight(displace)

    self:WalkGeneric(DIRECTION.RIGHT, displace)

end

function Character:ResetPositionToOriginal()

    self.x_pos = self.x_pos_orig
    self.y_pos = self.y_pos_orig

end

function Character:SetXPos(x_pos)

    self.x_pos_orig = x_pos
    self.x_pos      = x_pos

end

function Character:SetYPos(y_pos)

    self.y_pos_orig = y_pos
    self.y_pos      = y_pos

end


return Character