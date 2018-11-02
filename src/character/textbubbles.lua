require("src/shared/cache")
local Settings = require("src/settings/settings")

local TextBubble = {}
TextBubble.__index = TextBubble

function TextBubble:new(char, image, text, fontsize)

    local obj = {}
    setmetatable(obj, TextBubble)

    obj.char          = char
    obj.image         = getImageFromCache(image)
    obj.text          = text
    obj.fontsize      = 7--fontsize or 21
    obj.font          = love.graphics.newFont(obj.fontsize)
    obj.font:setFilter("nearest", "nearest", 1)
    obj.allow_drawing = true

    return obj

end

function TextBubble:SetText(text)

    self.text = text

end

function TextBubble:Draw()

    if self.allow_drawing then
        love.graphics.draw(self.image, self.char.x_pos+12, self.char.y_pos-26)
        love.graphics.setFont(self.font)
        love.graphics.print({{0,0,0,1} ,self.text}, self.char.x_pos+16, self.char.y_pos-21)
    end

end

function TextBubble:AllowDrawing(val)

    self.allow_drawing = val

end

return TextBubble