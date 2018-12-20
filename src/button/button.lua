require("src/shared/cache")
local Settings = require("src/settings/settings")

local Button = {}
Button.__index = Button

local CALLBACK_TIME_TO_NEXT_DT = .5

local function GenericCallBack()
    print("Callback never set")
end

function Button:newImage(image_file, x_pos, y_pos, scale_x, scale_y, mouse_click_callback)

    local obj = {}
    setmetatable(obj, Button)
    obj:InitializeButtonAttributes(image_file, x_pos, y_pos, scale_x, scale_y, mouse_click_callback)
    return obj

end

function Button:newWithoutImage(x_pos, y_pos, width, height, mouse_click_callback)

    local obj = {}
    setmetatable(obj, Button)
    obj.x_pos        = x_pos
    obj.y_pos        = y_pos
    obj.image_width  = width
    obj.image_height = height
    obj.scale_x      = 1
    obj.scale_y      = 1
    obj.mouse_click_callback = mouse_click_callback or GenericCallBack
    obj.sound_thread = nil
    obj.next_callback = love.timer.getTime() + .25
    return obj

end

function Button:InitializeButtonAttributes(image_file, x_pos, y_pos, scale_x, scale_y, mouse_click_callback)

    self.image        = getImageFromCache(image_file)
    self.x_pos        = x_pos
    self.y_pos        = y_pos
    self.image_width  = self.image:getWidth()
    self.image_height = self.image:getHeight()
    self.scale_x      = scale_x or 1
    self.scale_y      = scale_y or 1
    self.mouse_click_callback = mouse_click_callback or GenericCallBack
    self.sound_thread = nil
    self.next_callback = love.timer.getTime()
    self.alpha = 1
    self.avoid_callback_timer = false

end

function Button:SetSoundWhenClicked(sound_file)

    self.sound = love.audio.newSource(sound_file, "static")

end

function Button:SetCallback(mouse_click_callback)

    self.mouse_click_callback = mouse_click_callback

end

function Button:SetAlphaForFilter(alpha)

    self.alpha = alpha

end

function Button:SetDebug(val)

    self.debug = val

end

function Button:IsBetweenRange(value, low, high)

    if self.debug then
        --print(low .. " " .. value .. " " .. high)
    end
    if value >= low and value <= high then return true end
    return false

end

function Button:CheckForMouseCollision()

    if not self:IsBetweenRange(love.mouse.getX(), self.x_pos, self.x_pos + self.scale_x*self.image_width) then
        return false
    end

    if not self:IsBetweenRange(love.mouse.getY(), self.y_pos, self.y_pos + self.scale_y*self.image_height) then
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

    if self.sound == nil then return end

    local sound_thread_data =
    [[
        require("love.audio")
        require("love.timer")
        sound, volume = ...

        sound:setVolume(volume)
        sound:play()
        love.timer.sleep(.4)
        sound:stop()
    ]]
    if self.sound_thread ~= nil and self.sound_thread:isRunning() then
        return
    end
    self.sound_thread = nil
    self.sound_thread = love.thread.newThread(sound_thread_data)
    self.sound_thread:start(self.sound, Settings.MasterVolume * Settings.SoundEffectsVolume)

end

function Button:DoCallBackIfPossible()

    if self.mouse_click_callback == nil then
        return
    end
    if self.next_callback > love.timer.getTime() and not self.avoid_callback_timer then
        return
    end
    self.mouse_click_callback()
    self.next_callback = love.timer.getTime() + CALLBACK_TIME_TO_NEXT_DT

end

function Button:HandleMouseClick()

    if self.debug then
        print("Handling click")
    end
    if self:CheckMouseClick() then
        self:PlayMouseClickSoundIfPossible()
        self:DoCallBackIfPossible()
    end

end

function Button:DrawWithFilter()

    love.graphics.setColor(.66, .66, .66, self.alpha)
    love.graphics.draw(self.image, self.x_pos, self.y_pos, 0, self.scale_x, self.scale_y)
    love.graphics.setColor(1, 1, 1, 1)

end

function Button:DrawRectangleWithFilterIfPossible()

    love.graphics.setColor(.66, .66, .66, self.alpha)
    love.graphics.rectangle("fill", self.x_pos, self.y_pos, self.image_width, self.image_height)
    love.graphics.setColor(1,1,1,1)

end

function Button:Draw()

    if self.image == nil then
        if self:CheckForMouseCollision() then
            self:DrawRectangleWithFilterIfPossible()
        end
        return
    end
    if self:CheckForMouseCollision() then
        self:DrawWithFilter()
    else
        love.graphics.draw(self.image, self.x_pos, self.y_pos, 0, self.scale_x, self.scale_y)
    end

end

function Button:DrawOutline()

    love.graphics.rectangle("line", self.x_pos, self.y_pos, self.image_width, self.image_height)

end

return Button