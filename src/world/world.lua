local World = {}
World.__index = World

function World:new(MapObj, CharacterObjs, PlayerCharacterObj, CollisionObjs, SetCollisionsForNPC)

    local obj = {}
    setmetatable(obj, World)

    obj.map_obj               = MapObj
    obj.character_objs        = CharacterObjs
    obj.player_character_obj  = PlayerCharacterObj
    obj.collision_objs        = CollisionObjs
    obj.Settings              = require("src/settings/settings")
    obj.entities              = {}
    if SetCollisionsForNPC == nil then SetCollisionsForNPC = true end
    obj.set_collision_for_npc = SetCollisionsForNPC
    obj.map_obj:SetScaleForBlending(obj.world_scale)
    obj:GiveCharactersMapCollisionObjects()

    return obj

end

function World:GiveCharactersMapCollisionObjects()

    if self.player_character_obj ~= nil then
        self.player_character_obj:SetCollisionObjects(self.collision_objs)
    end
    if self.set_collision_for_npc then
        for i = 1, #self.character_objs do
            self.character_objs[i]:SetCollisionObjects(self.collision_objs)
        end
    end

end

function World:SetHandleInputCallback(func)

    self.input_callback = func

end

function World:RandomWalker()

end

function World:Update()

    -- self:RandomWalker()

end

function World:HandleInput()

    if self.player_character_obj == nil then return end
    if self.input_callback ~= nil then self.input_callback(); return; end

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
        if self.camera_tracking ~= nil then
            self.map_obj:Draw(self.camera_tracking.x_pos, self.camera_tracking.y_pos)
        else
            self.map_obj:Draw()
        end
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
        if self.character_objs[i].allow_drawing then
            self.character_objs[i]:Draw()
        end
    end

end

function World:DrawPlayerCharacterIfPossible()

    if self.player_character_obj ~= nil then
        self.player_character_obj:Draw()
    end

end

function World:DrawObjectsIfPossible()

    if self.map_obj ~= nil then
        if self.camera_tracking ~= nil then
            self.map_obj:DrawObjects(self.camera_tracking.x_pos, self.camera_tracking.y_pos)
        else
            self.map_obj:DrawObjects()
        end
    end

end

function World:Draw()

    if self.camera_tracking ~= nil then
        self.Settings.DrawCameraFunctions(self.camera_tracking.x_pos, self.camera_tracking.y_pos, self.world_scale)
    end
    self:DrawMapIfPossible()
    self:DrawCharactersIfPossible()
    self:DrawPlayerCharacterIfPossible()
    self:DrawObjectsIfPossible()

end

function World:SetEntityToTrackForCamera(entity)

    self.camera_tracking = entity

end

function World:AddEntityForTracking(entity)

    self.entities[#self.entities + 1] = entity

end
return World