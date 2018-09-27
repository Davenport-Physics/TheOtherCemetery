World = {}
World.__index = World

function World:new(MapObj, CharacterObjs, PlayerCharacterObj, ObjectObjs)

    local obj = {}
    setmetatable(obj, World)

    obj.map_obj              = MapObj
    obj.character_objs       = CharacterObjs
    obj.player_character_obj = PlayerCharacterObj
    obj.object_objs          = ObjectObjs
    obj.Settings             = require("src/settings/settings")

    return obj

end

function World:RandomWalker()

end

function World:Update()

    self:RandomWalker()

end

function World:HandleInput()

    if love.keyboard.isDown(self.Settings.Controls.UP) then
        self.player_character_obj.MoveUp()
    elseif love.keyboard.isDown(self.Settings.Controls.DOWN) then
        self.player_character_obj.MoveDown()
    elseif love.keyboard.isDown(self.Settings.Controls.LEFT) then
        self.player_character_obj.MoveLeft()
    elseif love.keyboard.isDown(self.Settings.Controls.RIGHT) then
        self.player_character_obj.MoveRight()
    end

end

function World:Draw()

    self.map_obj:Draw(self.player_character_obj.x_pos, self.player_character_obj.y_pos)

    for i = 1, #self.object_objs do
        self.object_objs[i]:Draw()
    end
    for i = 1, #self.character_objs do
        self.character_objs[i]:Draw()
    end
    self.player_character_obj:Draw()

end

return World