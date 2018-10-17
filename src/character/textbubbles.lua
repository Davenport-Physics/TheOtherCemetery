local TextBubble = {}
TextBubble.__index = TextBubble

function TextBubble:new(char, image, text)

    local obj = {}
    setmetatable(obj, TextBubble)

    obj.char         = char
    obj.image        = love.graphics.newImage(image)
    obj.text_overlay = text

    return obj

end

function TextBubble:Draw()

    love.graphics.draw(image, char.x_pos+20, char.y_pos-20)
    love.graphics.print(text, char.x_pos+22, char.y_pos-15)

end

return TextBubble