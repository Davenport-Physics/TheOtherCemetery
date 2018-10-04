local TiledMap = {}
TiledMap.__index = TiledMap

function TiledMap:new(tiled_map)

    local obj = {}
    setmetatable(obj, TiledMap)
    obj.tiled_map = tiled_map
    obj:InitializeSpriteSheet()
    obj:InitializeTiles()
    obj:InitializeLayers()
    obj.tile_cache = {}

    return obj
end

function TiledMap:InitializeSpriteSheet()

    self.sprite_sheet = love.graphics.newImage(self.tiled_map.tilesets[1].image)
    self.sheet_width  = self.sprite_sheet:getWidth()
    self.sheet_height = self.sprite_sheet:getHeight()
    self.spacing      = self.tiled_map.tilesets[1].spacing
    self.width        = self.tiled_map.tilesets[1].tilewidth
    self.height       = self.tiled_map.tilesets[1].tileheight

end

function TiledMap:InitializeTiles()

    self.quads = {}
    for y = 0, self.sprite_sheet:getHeight() - self.height, self.height + self.spacing do

        for x = 0, self.sprite_sheet:getWidth() - self.width, self.width + self.spacing do

            local temp_quad = love.graphics.newQuad(x, y, self.width, self.height, self.sheet_width, self.sheet_height)
            self.quads[#self.quads + 1] = temp_quad

        end

    end

end

function TiledMap:IsTileLayer(layer)

    if layer.type == "tilelayer" then

        self.layers_tile_layer[#self.layers_tile_layer + 1] = layer
        return true

    end
    return false

end

function TiledMap:IsObjectLayer(layer)

    -- TODO FINISH THIS
    return false

end

function TiledMap:InitializeLayers()

    self.layers = self.tiled_map.layers
    self.layers_tile_layer   = {}
    self.layers_object_layer = {}

    for i = 1, #self.layers do

        if self:IsTileLayer(self.layers[i]) then
        elseif self:IsObjectLayer() then end

    end

end

local bit31    = 2147483648
local bit30    = 1073741824
local bit29    = 536870912
function TiledMap:RotationConditions(layer_data)

    local angle    = 0
    local x_off    = 0
    local y_off    = 0
    local temp_id  = layer_data

    if temp_id >= bit31 then
        temp_id = temp_id - bit31
        angle = 0
        x_off = x_off + 2 * self.width
    end
    if temp_id >= bit30 then
        temp_id = temp_id - bit30
        angle = angle + math.pi
        x_off = x_off + self.width
        y_off = y_off + self.height
    end
    if temp_id >= bit29 then
        temp_id = temp_id - bit29
        angle = angle + (math.pi/2)
        x_off = x_off - self.width
    end
    return {temp_id, angle, x_off, y_off}

end

function TiledMap:GetRotation(layer_data)

    if self.tile_cache[layer_data] ~= nil then

        return unpack(self.tile_cache[layer_data])

    end

    self.tile_cache[layer_data] = self:RotationConditions(layer_data)

    return unpack(self.tile_cache[layer_data])
end

function TiledMap:DrawTile(layer_data, tiles_drawn_along_row, current_y_offset)

    if layer_data == 0 then return end
    local real_id, angle, x_off, y_off = self:GetRotation(layer_data)
    love.graphics.draw(self.sprite_sheet, self.quads[real_id], (tiles_drawn_along_row) * self.width + x_off, current_y_offset + y_off, angle)

end

function TiledMap:DrawLayer(layer)

    local TilesAlongX = layer.width
    local TilesAlongY = layer.height

    local tiles_drawn_along_row = 0
    local current_y_offset      = 0

    for i = 1, #layer.data do

        if (tiles_drawn_along_row > (TilesAlongX - 1)) then

            current_y_offset = current_y_offset + self.height
            tiles_drawn_along_row = 0

        end
        self:DrawTile(layer.data[i], tiles_drawn_along_row, current_y_offset)
        tiles_drawn_along_row = tiles_drawn_along_row + 1

    end

end

function TiledMap:DrawObjects()

    return

end

function TiledMap:DrawMaps()

    for i = 1, #self.layers_tile_layer do

        self:DrawLayer(self.layers_tile_layer[i])

    end

end

function TiledMap:Draw()

    self:DrawMaps()
    self:DrawObjects()

end

local CollisionClass = require("src/collision/collision")
function TiledMap:MakeCollisionObj(tile, tiles_drawn_along_row, current_y_offset)

    if tile == 0 then return end
    self.collision_objs[#self.collision_objs + 1] = CollisionClass:new((tiles_drawn_along_row) * self.width, current_y_offset, self.width, self.height)

end

function TiledMap:FromLayerDetermineCollisionObjs(layer)

    local TilesAlongX = layer.width
    local TilesAlongY = layer.height

    local tiles_drawn_along_row = 0
    local current_y_offset      = 0

    for i = 1, #layer.data do

        if (tiles_drawn_along_row > (TilesAlongX - 1)) then

            current_y_offset = current_y_offset + self.height
            tiles_drawn_along_row = 0

        end
        self:MakeCollisionObj(layer.data[i], tiles_drawn_along_row, current_y_offset)
        tiles_drawn_along_row = tiles_drawn_along_row + 1

    end

end

function TiledMap:InitializeCollisionObjs()

    self.collision_objs = {}

    for i = 1, #self.layers_tile_layer do
        if self.layers_tile_layer[i].name == "Wall" then
            self:FromLayerDetermineCollisionObjs(self.layers_tile_layer[i])
        end
    end

end

function TiledMap:GetCollisionObjects()

    if self.collision_objs ~= nil then
        return self.collision_objs
    end

    self:InitializeCollisionObjs()
    return self.collision_objs

end

return TiledMap