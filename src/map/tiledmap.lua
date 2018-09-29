TiledMap = {}
TiledMap.__index = TiledMap

function TiledMap:new(tiled_map)

    local obj = {}
    setmetatable(obj, TiledMap)
    obj.tiled_map = tiled_map
    obj:InitializeSpriteSheet()
    obj:InitializeTiles()
    obj:InitializeLayers()

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
    for y = 0, self.sprite_sheet:getHeight() - self.height, self.height+1 do

        for x = 0, self.sprite_sheet:getWidth() - self.width, self.width+1 do

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

function TiledMap:DrawTile(layer_data, tiles_drawn_along_row, current_y_offset)

    if layer_data ~= 0 then

        love.graphics.draw(self.sprite_sheet, self.quads[layer_data], (tiles_drawn_along_row) * self.width, current_y_offset)

    end

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

return TiledMap