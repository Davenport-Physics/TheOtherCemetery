require("src/shared/cache")

local Character = {}
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

local MIN_DT_FOR_CHANGING_STANCES = .045
local MIN_DT_FOR_GLIDING = .01

function Character:new(character_image_file, x_pos, y_pos, width, height, displacement, stance_change_time)

    local obj = {}
    setmetatable(obj, Character)

    obj.character_image            = getImageFromCache(character_image_file)
    obj.x_pos_orig, obj.y_pos_orig = x_pos, y_pos
    obj.x_pos, obj.y_pos           = x_pos, y_pos
    obj.width                      = width
    obj.height                     = height
    obj.collision_objs             = {}
    obj.allow_drawing              = true
    obj.stance_change_time         = stance_change_time or MIN_DT_FOR_CHANGING_STANCES
    obj.health                     = 10
    obj.currently_walking          = false
    obj.displace                   = false
    obj.distance_walked_currently  = 0
    obj:InitializeAnimationSet(displacement)
    obj:SetCollisionFunctions()

    return obj

end

function Character:AllowDrawing(allow_drawing)

    self.allow_drawing = allow_drawing

end

function Character:SetCollisionFunctions()

    self.collision_functions =
    {

        [DIRECTION.UP]    = function() self:DisplaceCharacterAlongYWithCollisionCheck(-self.displacement) end,
        [DIRECTION.DOWN]  = function() self:DisplaceCharacterAlongYWithCollisionCheck(self.displacement)  end,
        [DIRECTION.LEFT]  = function() self:DisplaceCharacterAlongXWithCollisionCheck(-self.displacement) end,
        [DIRECTION.RIGHT] = function() self:DisplaceCharacterAlongXWithCollisionCheck(self.displacement)  end

    }

end

function Character:SetCollisionObjects(collision_objs)

    self.collision_objs = collision_objs

end

function Character:SetHealth(Health)

    self.health = Health

end

function Character:DecreaseHealth(amount)

    self.health = self.health - amount
    if self.health <= 0 then

        self.allow_drawing = false

    end

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
    self.time_until_next_stance = love.timer.getTime()
    self.NextGlideTime = love.timer.getTime()

end

function Character:Draw()

    love.graphics.draw(self.character_image, self.current_quad, self.x_pos, self.y_pos, 0)

end

function Character:DrawWalkInPlace()

    love.graphics.draw(self.character_image, self.current_quad, self.x_pos, self.y_pos, 0)

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

function Character:DoesCharacterCollideWithWall(new_x, new_y, idx)

    if self.collision_objs[idx]:CheckForCollision(new_x, new_y) then
        return true
    end

end

function Character:DoesCharacterCollideWithObjects(new_x, new_y, idx)


    if self.DIRECTION ~= DIRECTION.DOWN then
        local width  = 8
        local height = self.height - 10
        new_x = new_x - 4
        new_y = new_y - self.height + 10
        return self.collision_objs[idx]:CheckForCollisionAdvanced(new_x, new_y, width, height)
    else
        return self.collision_objs[idx]:CheckForCollision(new_x, new_y)
    end

end

function Character:DoesCharacterCollide(new_x, new_y)

    for i = 1, #self.collision_objs do

        if self.collision_objs[i].name == "Wall" and self:DoesCharacterCollideWithWall(new_x, new_y, i) then
            return true
        elseif self.collision_objs[i].name == "Objects" and self:DoesCharacterCollideWithObjects(new_x, new_y, i) then
            return true
        end

    end
    return false

end

function Character:DisplaceCharacterAlongXWithCollisionCheck(displace_x)

    local temp_x       = 0
    local increment    = .05
    local x_mid, y_mid = self:GetCenterPosition()

    if displace_x > 0 then increment = -.05 end
    for dis = displace_x, 0, increment do
        temp_x = x_mid + dis
        if not self:DoesCharacterCollide(temp_x, self.y_pos + self.height) then
            self.x_pos = self.x_pos + dis;
            self.distance_walked_currently = self.distance_walked_currently + dis
            break;
        end
    end

end

function Character:DisplaceCharacterAlongYWithCollisionCheck(displace_y)

    local temp_y       = 0
    local increment    = .1
    local x_mid, y_mid = self:GetCenterPosition()

    if displace_y > 0 then increment = -.05 end
    for dis = displace_y, 0, increment do
        temp_y = self.y_pos + self.height + dis
        if not self:DoesCharacterCollide(x_mid, temp_y) then
            self.y_pos = self.y_pos + dis
            self.distance_walked_currently = self.distance_walked_currently + dis
            break
        end
    end

end

function Character:DisplaceCharacter()

    self.collision_functions[self.direction]()

end

function Character:CheckTimeChangeBeforeMoving()

    if love.timer.getTime() >= self.time_until_next_stance then

        self.time_until_next_stance = love.timer.getTime() + self.stance_change_time
        return true

    end

    return false

end

function Character:WalkGeneric(CorrectDirection, displace)

    if not self:CheckTimeChangeBeforeMoving() then return end

    if self.direction == CorrectDirection then

        self:DetermineNewPresentStance()
        if displace then
            self.currently_walking = true
            self.distance_walked_currently = 0
        end

    else

        self.direction    = CorrectDirection
        self.stance       = STANCE.STANDING
        self.next_stance  = STANCE.WALKING_1

    end
    self.current_quad = self.quads[CorrectDirection][self.stance]

end

function Character:FaceGeneric(CorrectDirection)

    self.direction    = CorrectDirection
    self.stance       = STANCE.STANDING
    self.next_stance  = STANCE.WALKING_1
    self.current_quad = self.quads[CorrectDirection][self.stance]

end

function Character:WalkDown(displace)

    self.displace = displace
    self:WalkGeneric(DIRECTION.DOWN, displace)

end

function Character:WalkUp(displace)

    self.displace = displace
    self:WalkGeneric(DIRECTION.UP, displace)

end

function Character:WalkLeft(displace)

    self.displace = displace
    self:WalkGeneric(DIRECTION.LEFT, displace)

end

function Character:WalkRight(displace)

    self.displace = displace
    self:WalkGeneric(DIRECTION.RIGHT, displace)

end

function Character:FaceUp()

    self:FaceGeneric(DIRECTION.UP)

end

function Character:FaceDown()

    self:FaceGeneric(DIRECTION.DOWN)

end

function Character:FaceLeft()

    self:FaceGeneric(DIRECTION.LEFT)

end

function Character:FaceRight()

    self:FaceGeneric(DIRECTION.RIGHT)

end

function Character:CanGlide()

    if love.timer.getTime() >= self.NextGlideTime then

        self.NextGlideTime = love.timer.getTime() + MIN_DT_FOR_GLIDING
        return true

    end
    return false

end

function Character:GlideUp(glide_distance, force_glide)


    if self:CanGlide() or force_glide then
        self:DisplaceCharacterAlongYWithCollisionCheck(glide_distance or -2)
    end

end

function Character:GlideDown(glide_distance, force_glide)

    if self:CanGlide() or force_glide then
        self:DisplaceCharacterAlongYWithCollisionCheck(glide_distance or 2)
    end

end

function Character:GlideLeft(glide_distance, force_glide)

    if self:CanGlide() or force_glide then
        self:DisplaceCharacterAlongXWithCollisionCheck(glide_distance or -2)
    end

end

function Character:GlideRight(glide_distance, force_glide)

    if self:CanGlide() or force_glide then
        self:DisplaceCharacterAlongXWithCollisionCheck(glide_distance or 2)
    end

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

function Character:GetCenterPosition()

    local x_mid = self.x_pos + math.floor(self.width  * .5)
    local y_mid = self.y_pos + math.floor(self.height * .5)

    return x_mid, y_mid

end

function Character:MakeMinisculeDisplacement()

    local mini_displacement = tonumber(string.format("%.3f", self.displacement*(love.timer.getDelta()/self.stance_change_time)))
    if self.direction == DIRECTION.RIGHT then
        self:DisplaceCharacterAlongXWithCollisionCheck(mini_displacement)
    end
    if self.direction == DIRECTION.LEFT then
        self:DisplaceCharacterAlongXWithCollisionCheck(-mini_displacement)
    end
    if self.direction == DIRECTION.UP then
        self:DisplaceCharacterAlongYWithCollisionCheck(-mini_displacement)
    end
    if self.direction == DIRECTION.DOWN then
        self:DisplaceCharacterAlongYWithCollisionCheck(mini_displacement)
    end
end

function Character:MinisculeDisplacement()

    if math.abs(self.distance_walked_currently) >= math.abs(self.displacement) then
        self.distance_walked_currently = 0
        self.displace = false
        self.currently_walking = false
        return
    end
    self:MakeMinisculeDisplacement()

end

function Character:Update()

    if not self.currently_walking or not self.displace then
        return
    end
    self:MinisculeDisplacement()

end


return Character