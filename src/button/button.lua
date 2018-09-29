Button = {}
Button.__index = Button

local function GenericCallBack()
    print("Callback never set")
end

function Button:newImage(image_file, x_pos, y_pos, scale_x, scale_y, mouse_click_callback)

    local obj = {}
    setmetatable(obj, Button)

    obj:InitializeButtonAttributes(image_file, x_pos, y_pos, scale_x, scale_y, mouse_click_callback)
    return obj

end

function Button:InitializeButtonAttributes(image_file, x_pos, y_pos, scale_x, scale_y, mouse_click_callback)

    self.image        = love.graphics.newImage(image_file)
    self.x_pos        = x_pos
    self.y_pos        = y_pos
    self.image_width  = self.image:getWidth()
    self.image_height = self.image:getHeight()
    self.scale_x      = scale_x or 1
    self.scale_y      = scale_y or 1
    self.mouse_click_callback = mouse_click_callback or GenericCallBack

end

function Button:SetSoundWhenClicked(sound_file)

    self.sound = love.audio.newSource(sound_file, "static")

end

function Button:SetCallback(mouse_click_callback)

    self.mouse_click_callback = mouse_click_callback

end

function Button:IsBetweenRange(value, low, high)

    if value >= low and value <= high then return true end
    return false

end

function Button:CheckForMouseCollision()

    if not self:IsBetweenRange(love.mouse.getX(), self.x_pos, self.x_pos + self.image_width * self.scale_x) then
        return false
    end

    if not self:IsBetweenRange(love.mouse.getY(), self.y_pos, self.y_pos + self.image_height * self.scale_y) then
        return false
    end

    return true

end

function Button:CheckMouseClick()

    if love.mouse.isDown(1) then
        return self:CheckForMouseCollision()
    end

end

function Button:PlayMouseClickSoundIfPossible()

    if self.sound ~= nil then 
        love.audio.play(self.sound)
        love.timer.sleep(.45)
        love.audio.stop(self.sound)
    end

end

function Button:DoCallBackIfPossible()

    if self.mouse_click_callback ~= nil then
        self.mouse_click_callback()
    end

end

function Button:HandleMouseClick()

    if love.mouse.isDown(1) and self:CheckForMouseCollision() then
        self:PlayMouseClickSoundIfPossible()
        self:DoCallBackIfPossible()
    end

end

function Button:Draw()

    love.graphics.draw(self.image, self.x_pos, self.y_pos, 0, self.scale_x, self.scale_y)

end

return Button