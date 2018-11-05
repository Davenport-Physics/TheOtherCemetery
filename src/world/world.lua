require("src/shared/cache")
local ButtonClass = require("src/button/button")
local Save        = require("src/save/saving")

local ESCAPE_MENU_IMAGE_CACHE      = getImageFromCache("pics/ingame/ingame.png")
local ESCAPE_MENU_IMAGE_BACKGROUND = getImageFromCache("tiles/autumn-platformer-tileset/png/elements/background.png")
local ESCAPE_MENU_SAVE_GAME_BUTTON = ButtonClass:newWithoutImage(-100,-100, 1, 1, 0, 0)
local ESCAPE_MENU_QUIT_GAME_BUTTON = ButtonClass:newWithoutImage(-100,-100, 1, 1, 0, 0)

ESCAPE_MENU_QUIT_GAME_BUTTON:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
ESCAPE_MENU_SAVE_GAME_BUTTON:SetSoundWhenClicked("sound/startmenu/click/click.ogg")

ESCAPE_MENU_QUIT_GAME_BUTTON:SetCallback(function() love.event.push("startmenu") end)

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
    obj:SetEscapeMenuObjects()
    if SetCollisionsForNPC == nil then SetCollisionsForNPC = true end
    obj.set_collision_for_npc = SetCollisionsForNPC
    obj.map_obj:SetScaleForBlending(obj.world_scale)
    obj:GiveCharactersMapCollisionObjects()

    return obj

end

function World:SetEscapeMenuObjects()

    self.escape_menu_x_pos      = -100
    self.escape_menu_y_pos      = -100
    self.escape_menu_call_time  = love.timer.getTime()
    self.escape_menu            = ESCAPE_MENU_IMAGE_CACHE
    self.escape_menu_background = ESCAPE_MENU_IMAGE_BACKGROUND
    self.escape_menu_active     = false
    self.escape_menu_save_game  = ESCAPE_MENU_SAVE_GAME_BUTTON
    self.escape_menu_quit_game  = ESCAPE_MENU_QUIT_GAME_BUTTON
    self.escape_menu_save_game:SetCallback(function() StoreSaveData(); self.escape_menu_active = false; self.Settings.GlobalScaleOn = true; end)

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

function World:UpdateEscapeMenuSaveObject(offset_x, offset_y)

    self.escape_menu_save_game.x_pos = self.escape_menu_x_pos + 20.5
    self.escape_menu_save_game.y_pos = self.escape_menu_y_pos + 125.5
    self.escape_menu_save_game.image_width  = 303
    self.escape_menu_save_game.image_height = 105

end

function World:UpdateEscapeMenuQuitObject(offset_x, offset_y)


    self.escape_menu_quit_game.x_pos = self.escape_menu_x_pos + 20.5
    self.escape_menu_quit_game.y_pos = self.escape_menu_y_pos + 395.5
    self.escape_menu_quit_game.image_width  = 303
    self.escape_menu_quit_game.image_height = 105

end

function World:UpdateEscapeMenuObjects()

    local offset_x = 0
    local offset_y = 0
    if self.camera_tracking ~= nil then
        offset_x = self.camera_tracking.x_pos
        offset_y = self.camera_tracking.y_pos
    end
    self:UpdateEscapeMenuSaveObject(offset_x, offset_y)
    self:UpdateEscapeMenuQuitObject(offset_x, offset_y)

end

function World:UpdateCharacters()

    self.player_character_obj:Update()
    for i = 1, #self.character_objs do
        self.character_objs[i]:Update()
    end

end

function World:Update()

    self:UpdateEscapeMenuObjects()
    self:UpdateCharacters()

end

function World:HandleInputMovePlayer()

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

function World:HandleInputEscapeButtons()

    self.escape_menu_save_game:HandleMouseClick()
    self.escape_menu_quit_game:HandleMouseClick()

end

function World:HandleInputEscape()

    if love.keyboard.isDown("escape") and love.timer.getTime() >= self.escape_menu_call_time then
        self.escape_menu_active     = not self.escape_menu_active
        self.escape_menu_call_time  = love.timer.getTime() + .2
        self.Settings.GlobalScaleOn = not self.Settings.GlobalScaleOn
    end

    if self.escape_menu_active then
        self:HandleInputEscapeButtons()
    end

end

function World:HandleInput()

    if self.player_character_obj == nil then return end
    if self.input_callback ~= nil then self.input_callback(); return; end

    self:HandleInputEscape()
    if not self.escape_menu_active then self:HandleInputMovePlayer() end

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

function World:DrawEscapeMenu()

    self.escape_menu_x_pos =  love.graphics.getWidth()*.5 -  self.escape_menu:getWidth()*.5
    self.escape_menu_y_pos = love.graphics.getHeight()*.5 - self.escape_menu:getHeight()*.5

    local b_s_x = love.graphics.getWidth()/self.escape_menu_background:getWidth()
    local b_s_y = love.graphics.getHeight()/self.escape_menu_background:getHeight()

    love.graphics.draw(self.escape_menu_background, 0, 0, 0, b_s_x, b_s_y)
    love.graphics.draw(self.escape_menu, self.escape_menu_x_pos, self.escape_menu_y_pos)

end

function World:Draw()

    if self.escape_menu_active then
        self:DrawEscapeMenu()
        return
    end
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