require("src/shared/cache")
local Settings = require("src/settings/settings")

local TextBubble = {}
TextBubble.__index = TextBubble

function TextBubble:new(char, image, text, fontsize)

    return TextBubble:initnew(char, image, text, fontsize)

end

function TextBubble:newSpeaking(char, text, fontsize)

    return TextBubble:initnew(char, "pics/share/text/TextBubbleSpeaking.png", text, fontsize)

end

function TextBubble:newThought(char, text, fontsize)

    return TextBubble:initnew(char, "pics/share/text/TextBubble.png", text, fontsize)

end

function TextBubble:initnew(char, image, text, fontsize)

    local obj = {}
    setmetatable(obj, TextBubble)

    obj.char          = char
    obj.image         = getImageFromCache(image)
    obj.text          = text
    obj.fontsize      = fontsize or 16
    obj.font          = love.graphics.newFont(obj.fontsize)
    obj.font:setFilter("linear", "nearest", 16)
    obj.allow_drawing = true

    return obj

end

function TextBubble:SetText(text)

    self.text = text

end

function TextBubble:Draw()

    if not self.allow_drawing then return end
    local x = nil
    local y = nil
    love.graphics.push()
        x = Settings.X_Canvas_Translation + (self.char.x_pos+12)*Settings.Scale
        y = Settings.Y_Canvas_Translation + (self.char.y_pos-26)*Settings.Scale
        love.graphics.translate(x, y)
        love.graphics.draw(self.image, 0, 0, 0, Settings.Scale, Settings.Scale)
    love.graphics.pop()
    love.graphics.push()
        x = Settings.X_Canvas_Translation + (self.char.x_pos+16)*Settings.Scale
        y = Settings.Y_Canvas_Translation + (self.char.y_pos-22)*Settings.Scale
        love.graphics.translate(x, y)
        love.graphics.setFont(self.font)
        love.graphics.print({{0,0,0,1} ,self.text}, 0, 0)
    love.graphics.pop()

end

function TextBubble:AllowDrawing(val)

    self.allow_drawing = val

end

return TextBubble