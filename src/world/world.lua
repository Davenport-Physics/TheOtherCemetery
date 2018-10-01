World = {}
World.__index = World

function World:new(MapObj, CharacterObjs, PlayerCharacterObj, CollisionObjs)

    local obj = {}
    setmetatable(obj, World)

    obj.map_obj              = MapObj
    obj.character_objs       = CharacterObjs
    obj.player_character_obj = PlayerCharacterObj
    obj.collision_objs       = CollisionObjs
    --TODO WORK ON COLLISION OBJECTS
    obj.Settings             = require("src/settings/settings")

    return obj

end

function World:RandomWalker()

end

function World:Update()

    -- self:RandomWalker()

end

function World:HandleInput()

    if love.keyboard.isDown(self.Settings.Controls.UP) then
        self.player_character_obj:WalkUp(true)
    elseif love.keyboard.isDown(self.Settings.Controls.DOWN) then
        self.player_character_obj:WalkDown(true)
    elseif love.keyboard.isDown(self.Settings.Controls.LEFT) then
        self.player_character_obj:WalkLeft(true)
    elseif love.keyboard.isDown(self.Settings.Controls.RIGHT) then
        self.player_character_obj:WalkRight(true)
    end

end

function World:DrawMapIfPossible()

    if self.map_obj ~= nil then
        self.map_obj:Draw()
    end

end

function World:DrawEntitiesIfPossible()

    if self.entity_objs == nil then return end

    for i = 1, #self.entity_objs do
        self.entity_objs[i]:Draw()
    end

end

function World:DrawCharactersIfPossible()

    if self.character_objs == nil then return end

    for i = 1, #self.character_objs do
        self.character_objs[i]:Draw()
    end

end

function World:DrawPlayerCharacterIfPossible()

    if self.player_character_obj ~= nil then
        self.player_character_obj:Draw()
    end

end

function World:Draw()

    if self.camera_tracking ~= nil then
        self.Settings.DrawCameraFunctions(self.camera_tracking.x_pos, self.camera_tracking.y_pos, 3)
    end
    self:DrawMapIfPossible()
    self:DrawCharactersIfPossible()
    self:DrawPlayerCharacterIfPossible()

end

function World:SetEntityToTrackForCamera(entity)

    self.camera_tracking = entity

end

return World