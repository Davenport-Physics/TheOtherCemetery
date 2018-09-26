Character = {}
Character.__index = Character

function Character:new(character_image_file, x_pos, y_pos, width, height)

    local obj = {}
    setmetatable(obj, Character)

    obj.character_image = love.graphics.newImage(character_image_file)
    obj.x_pos  = x_pos
    obj.y_pos  = y_pos
    obj.width  = width
    obj.height = height
    obj:InitializeAnimationSet()

    return obj

end

function Character:InitQuads()

    self.quads = {}
    for x = 0, self.character_image:getWidth() - self.width, self.width do
        self.quads[#self.quads + 1] = {}
        for y = 0, self.character_image:getHeight() - self.height, self.height do
            local Quad = love.graphics.newQuad(x, y, self.width, self.height, self.character_image:getDimensions())
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

end

function Character:DrawDown()

    love.graphics.draw(self.character_image, self.quads[1][1], self.x_pos, self.y_pos, 0,  3, 3)

end

function Character:WalkDown()

end

function Character:WalkUp()

end

function Character:WalkLeft()

end

function Character:WalkRight()

end


return Character