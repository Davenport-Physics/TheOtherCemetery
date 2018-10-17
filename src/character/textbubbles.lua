local TextBubble = {}
TextBubble.__index = TextBubble

function TextBubble:new(char, image, text)

    local obj = {}
    setmetatable(obj, TextBubble)

    obj.char          = char
    obj.image         = love.graphics.newImage(image)
    obj.text          = text
    obj.allow_drawing = false

    return obj

end

function TextBubble:SetText(text)

    self.text = text

end

function TextBubble:Draw()

    if self.allow_drawing then
        love.graphics.draw(image, char.x_pos+20, char.y_pos-20)
        love.graphics.print(text, char.x_pos+22, char.y_pos-15)
    end

end

function TextBubble:AllowDrawing(val)

    self.allow_drawing = val

end

return TextBubble