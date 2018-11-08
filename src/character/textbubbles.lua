require("src/shared/cache")
local Settings  = require("src/settings/settings")
local TEXTSOUND = getStreamSoundFromCache("sound/talk-slow.mp3")

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
    obj.text_drawn    = ""
    obj.fontsize      = fontsize or 16
    obj.font          = love.graphics.newFont(obj.fontsize)
    obj.time_to_next_char = nil
    obj.font:setFilter("linear", "nearest", 16)
    obj.allow_drawing = true

    return obj

end

function TextBubble:SetText(text)

    self.text = text

end

function TextBubble:CheckForTimeInit()
    if self.time_to_next_char == nil then
        self.time_to_next_char = love.timer.getTime() + .15
    end
end

function TextBubble:SoundHandler()

    if #self.text_drawn == #self.text then
        TEXTSOUND:stop()
    elseif not TEXTSOUND:isPlaying() and self.allow_drawing then
        TEXTSOUND:setVolume(.15)
        TEXTSOUND:play()
    end

end

function TextBubble:AddNewCharacterIfPossible()

    if #self.text == nil then return end
    if #self.text_drawn == #self.text then
        return
    end
    if #self.text_drawn > #self.text then
        self.text_drawn = ""
    end
    self.text_drawn = self.text_drawn .. self.text:sub(#self.text_drawn+1, #self.text_drawn+1)

end

function TextBubble:CheckTextDrawn()

    self:CheckForTimeInit()
    self:SoundHandler()
    if love.timer.getTime() >= self.time_to_next_char then
        self:AddNewCharacterIfPossible()
    end

end

function TextBubble:DrawImage()

    love.graphics.push()
        local x = Settings.X_Canvas_Translation + (self.char.x_pos+12)*Settings.Scale
        local y = Settings.Y_Canvas_Translation + (self.char.y_pos-26)*Settings.Scale
        love.graphics.draw(self.image, x, y, 0, Settings.Scale, Settings.Scale)
    love.graphics.pop()

end

function TextBubble:DrawText()

    love.graphics.push()
        local x = Settings.X_Canvas_Translation + (self.char.x_pos+16)*Settings.Scale
        local y = Settings.Y_Canvas_Translation + (self.char.y_pos-22)*Settings.Scale
        love.graphics.setFont(self.font)
        love.graphics.print({{0,0,0,1} ,self.text_drawn}, x, y)
    love.graphics.pop()

end

function TextBubble:Draw()

    if not self.allow_drawing then return end
    self:CheckTextDrawn()
    self:DrawImage()
    self:DrawText()

end

function TextBubble:AllowDrawing(val)

    self.allow_drawing = val

end

return TextBubble