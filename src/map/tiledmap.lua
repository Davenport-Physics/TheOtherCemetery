require("src/shared/cache")

local TiledMap = {}
TiledMap.__index = TiledMap

local Settings = require("src/settings/settings")
local Shared   = require("src/shared/shared")

function TiledMap:new(tiled_map)

    local obj = {}
    setmetatable(obj, TiledMap)
    obj.tiled_map = tiled_map
    obj:InitializeSpriteSheet()
    obj:InitializeTiles()
    obj:InitializeLayers()
    obj.tile_cache     = {}
    obj.sheet_id_cache = {}
    obj.scale = 1

    return obj
end

function TiledMap:SetScaleForBlending(scale)

    self.scale = scale

end

function TiledMap:InitializeEmptyTables()

    self.sprite_sheet = {}
    self.sheet_width  = {}
    self.sheet_height = {}
    self.spacing      = {}
    self.width        = {}
    self.height       = {}

end

function TiledMap:InitializeSpriteSheet()

    self:InitializeEmptyTables()
    for i = 1, #self.tiled_map.tilesets do

        self.sprite_sheet[i] = getImageFromCache(self.tiled_map.tilesets[i].image)
        self.sheet_width[i]  = self.sprite_sheet[i]:getWidth()
        self.sheet_height[i] = self.sprite_sheet[i]:getHeight()
        self.spacing[i]      = self.tiled_map.tilesets[i].spacing
        self.width[i]        = self.tiled_map.tilesets[i].tilewidth
        self.height[i]       = self.tiled_map.tilesets[i].tileheight

    end


end

function TiledMap:InitializeTiles()

    self.quads = {}
    self.quad_ids = {}
    local max_id = 0
    for i = 1, #self.tiled_map.tilesets do
        self.quad_ids[i] = {min = max_id+1, max = max_id+1}
        for y = 0, self.sprite_sheet[i]:getHeight() - self.height[i], self.height[i] + self.spacing[i] do

            for x = 0, self.sprite_sheet[i]:getWidth() - self.width[i], self.width[i] + self.spacing[i] do

                local temp_quad = love.graphics.newQuad(x, y, self.width[i], self.height[i], self.sheet_width[i], self.sheet_height[i])
                self.quads[#self.quads + 1] = temp_quad
                max_id = max_id + 1

            end

        end
        self.quad_ids[i].max = max_id
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
    local sx       = 1
    local sy       = 1
    local temp_id  = layer_data

    if temp_id >= bit31 then
        temp_id = temp_id - bit31
        sx      = -1*sx
        x_off = x_off + self.width[1]
    end
    if temp_id >= bit30 then
        temp_id = temp_id - bit30
        sx = -1*sx
        sy = -1*sy
        x_off = x_off + self.width[1]
        y_off = y_off + self.height[1]
    end
    if temp_id >= bit29 then
        temp_id = temp_id - bit29
        sx = -1*sx
        sy = -1*sy
        angle = angle + (-sx*math.pi/2)
        x_off = x_off - self.width[1]
    end
    return {temp_id, angle, x_off, y_off, sx, sy}

end

function TiledMap:GetRotation(layer_data)

    if self.tile_cache[layer_data] ~= nil then

        return unpack(self.tile_cache[layer_data])

    end

    self.tile_cache[layer_data] = self:RotationConditions(layer_data)

    return unpack(self.tile_cache[layer_data])
end

function TiledMap:FromRealIDGetSpriteSheetIndex(real_id)

    if self.sheet_id_cache[real_id] ~= nil then return self.sheet_id_cache[real_id] end
    for i = 1, #self.quad_ids do

        if self.quad_ids[i].max >= real_id and real_id >= self.quad_ids[i].min then
            self.sheet_id_cache[real_id] = i
            return i
        end

    end
    print("Defaulting to first sheet")
    return 1

end

function TiledMap:DrawTile(layer_data, tiles_drawn_along_row, current_y_offset, ra_x, ra_y)

    if layer_data == 0 then return end
    local real_id, angle, x_off, y_off, sx, sy = self:GetRotation(layer_data)

    local x = (tiles_drawn_along_row) * self.width[1] + x_off
    local y = current_y_offset + y_off

    local sprite_sheet_idx = self:FromRealIDGetSpriteSheetIndex(real_id)

    if ra_x ~= nil and ra_y ~= nil then
        if Shared.IsBetweenRange(x, ra_x-self.d_lx, ra_x+self.d_lx) and Shared.IsBetweenRange(y, ra_y-self.d_ly, ra_y+self.d_ly) then
            love.graphics.draw(self.sprite_sheet[sprite_sheet_idx], self.quads[real_id], x, y, angle, sx, sy)
        end
    else
        love.graphics.draw(self.sprite_sheet[sprite_sheet_idx], self.quads[real_id], x, y, angle, sx, sy)
    end

end

local GraphicsHeight = love.graphics.getHeight
local GraphicsWidth  = love.graphics.getWidth
function TiledMap:DrawLayer(layer, ra_x, ra_y)

    local TilesAlongX = layer.width
    local TilesAlongY = layer.height

    local tiles_drawn_along_row = 0
    local current_y_offset      = 0

    self.d_lx = GraphicsWidth()*.5 + 40
    self.d_ly = GraphicsHeight()*.5 + 40
    for i = 1, #layer.data do

        if (tiles_drawn_along_row > (TilesAlongX - 1)) then

            current_y_offset = current_y_offset + self.height[1]
            tiles_drawn_along_row = 0

        end
        self:DrawTile(layer.data[i], tiles_drawn_along_row, current_y_offset, ra_x, ra_y)
        tiles_drawn_along_row = tiles_drawn_along_row + 1

    end

end

function TiledMap:DrawMaps(DrawObjects, ra_x, ra_y)

    for i = 1, #self.layers_tile_layer do

        if not DrawObjects and self.layers_tile_layer[i].name ~= "Objects" then
            self:DrawLayer(self.layers_tile_layer[i], ra_x, ra_y)
        end
        if DrawObjects and self.layers_tile_layer[i].name == "Objects" then
            self:DrawLayer(self.layers_tile_layer[i], ra_x, ra_y)
        end

    end

end

function TiledMap:DrawObjects(ra_x, ra_y)

    self:DrawMaps(true, ra_x, ra_y)

end


function TiledMap:Draw(ra_x, ra_y)

    self:DrawMaps(false, ra_x, ra_y)

end

local CollisionClass = require("src/collision/collision")
function TiledMap:MakeCollisionObj(tile, tiles_drawn_along_row, current_y_offset, full_mesh)

    if tile == 0 then return end

    local x = (tiles_drawn_along_row) * self.width[1]
    local y = 0

    if full_mesh then
        y = current_y_offset
    else
        y = current_y_offset + 10
    end

    local name
    if full_mesh then
        name = "Wall"
    else
        name = "Objects"
    end

    self.collision_objs[#self.collision_objs + 1] = CollisionClass:new(x, y, self.width[1], self.height[1], name)

end

function TiledMap:FromLayerDetermineCollisionObjs(layer, full_mesh)

    local TilesAlongX = layer.width

    local tiles_drawn_along_row = 0
    local current_y_offset      = 0

    for i = 1, #layer.data do

        if (tiles_drawn_along_row > (TilesAlongX - 1)) then

            current_y_offset = current_y_offset + self.height[1]
            tiles_drawn_along_row = 0

        end
        self:MakeCollisionObj(layer.data[i], tiles_drawn_along_row, current_y_offset, full_mesh)
        tiles_drawn_along_row = tiles_drawn_along_row + 1

    end

end

function TiledMap:InitializeCollisionObjs()

    self.collision_objs = {}

    for i = 1, #self.layers_tile_layer do
        if self.layers_tile_layer[i].name == "Wall" then
            self:FromLayerDetermineCollisionObjs(self.layers_tile_layer[i], true)
        end
        if self.layers_tile_layer[i].name == "Objects" then
            self:FromLayerDetermineCollisionObjs(self.layers_tile_layer[i], false)
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