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

function Character:new(character_image_file, x_pos, y_pos, width, height)

    local obj = {}
    setmetatable(obj, Character)

    obj.character_image = love.graphics.newImage(character_image_file)
    obj.x_pos         = x_pos
    obj.y_pos         = y_pos
    obj.width         = width
    obj.height        = height
    obj:InitializeAnimationSet()

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

function Character:InitializeAnimationSet()

    self:InitQuads()
    self.current_quad  = self.quads[1][1]
    self.direction     = DIRECTION.DOWN
    self.stance        = STANCE.STANDING
    self.next_stance   = STANCE.WALKING_1
    self.displacement  = 25

end

function Character:Draw()

    love.graphics.draw(self.character_image, self.current_quad, self.x_pos, self.y_pos, 0,  3, 3)

end

function Character:DrawWalkInPlace()

    self:WalkDown()
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

function Character:WalkGeneric(CorrectionDirection)

    if self.direction == CorrectionDirection then

        self:DetermineNewPresentStance()

    else

        self.direction    = CorrectionDirection
        self.stance       = STANCE.STANDING
        self.next_stance  = STANCE.WALKING_1

    end
    self.current_quad = self.quads[CorrectionDirection][self.stance]

end

function Character:WalkDown()

    self:WalkGeneric(DIRECTION.DOWN)

end

function Character:WalkUp()

    self:WalkGeneric(DIRECTION.UP)

end

function Character:WalkLeft()

    self:WalkGeneric(DIRECTION.LEFT)

end

function Character:WalkRight()

    self:WalkGeneric(DIRECTION.RIGHT)

end


return Character