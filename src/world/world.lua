World = {}
World.__index = World

function World:new(MapObj, CharacterObjs, PlayerCharacterObj, ObjectObjs)

    local obj = {}
    setmetatable(obj, World)

    obj.map_obj              = MapObj
    obj.character_objs       = CharacterObjs
    obj.player_character_obj = PlayerCharacterObj
    obj.object_objs          = ObjectObjs

    return obj

end

function World:Update()

end

function World:HandleInput()

end

function World:Draw()

    self.map_obj:Draw()
    self.object_objs:Draw()
    self.character_objs:Draw()
    self.player_character_obj:Draw()

end

return World