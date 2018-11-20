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
    obj.current_scale = Settings.Scale

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

function TextBubble:CheckScale()

    if Settings.Scale ~= self.current_scale then
        self.fontsize      = 8 * Settings.Scale
        self.font          = love.graphics.newFont(self.fontsize)
        self.current_scale = Settings.Scale
    end

end

function TextBubble:DrawImage()

    local x = Settings.X_Canvas_Translation + (self.char.x_pos+12)*Settings.Scale
    local y = Settings.Y_Canvas_Translation + (self.char.y_pos-26)*Settings.Scale
    love.graphics.draw(self.image, x, y, 0, Settings.Scale, Settings.Scale)

end

function TextBubble:DrawText()

    local x = Settings.X_Canvas_Translation + (self.char.x_pos+16)*Settings.Scale
    local y = Settings.Y_Canvas_Translation + (self.char.y_pos-22)*Settings.Scale
    love.graphics.setFont(self.font)
    love.graphics.print({{0,0,0,1} ,self.text_drawn}, x, y)

end

function TextBubble:SoundPause()

    if self.sound_thread ~= nil and self.sound_thread:isRunning() then return end
    local sound_pause_data =
    [[
        require("love.audio")
        require("love.timer")
        sound = ...
        time_to_stop = love.timer.getTime() + .2
        while love.timer.getTime() < time_to_stop do
            love.timer.sleep(.05)
        end
        sound:pause()
    ]]
    self.sound_thread = nil
    self.sound_thread = love.thread.newThread(sound_pause_data)
    self.sound_thread:start(TEXTSOUND)

end

function TextBubble:Draw()

    if not self.allow_drawing then return end
    self:CheckScale()
    self:CheckTextDrawn()
    self:DrawImage()
    self:DrawText()
    self:SoundPause()

end

function TextBubble:AllowDrawing(val)

    self.allow_drawing = val

end

return TextBubble