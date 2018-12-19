local Settings        = require("src/settings/settings")
local EntityClass     = require("src/entity/entity")
local WorldClass      = require("src/world/world")
local CharacterClass  = require("src/character/character")
local TiledMapClass   = require("src/map/tiledmap")
local WalkerClass     = require("src/characterwalker/walker-generic")
local TextBubbleClass = require("src/character/textbubbles")
local DialogClass     = require("src/dialog/dialog")
local ButtonClass     = require("src/button/button")
local bit             = require("bit")

local function GetCharacterInitializer(char)

    if string.sub(char.name, 1, 1) == "M" then
        return CharacterClass.newMale
    end
    return CharacterClass.newFemale

end

local InsultScene = {}
InsultScene.__index = InsultScene

function InsultScene.new(map, player, enemy)

    local obj = {}
    setmetatable(obj, InsultScene)
    obj:InitChars(player, enemy)
    obj:InitWorld(map)
    obj.menu_active       = true
    obj.in_categories     = true
    obj.active_category   = 1
    obj.current_scale     = Settings.Scale
    obj.fontsize          = 8 * Settings.Scale
    obj.font              = love.graphics.newFont(obj.fontsize)
    obj.time_to_next_char = nil
    obj.transition        = false
    obj.font:setFilter("linear", "nearest", 16)

    return obj

end

function InsultScene:InitChars(player, enemy)

    self.player = GetCharacterInitializer(player)(CharacterClass, player.name,  player.x_pos, player.y_pos, 9, .075)
    self.enemy  = GetCharacterInitializer(enemy)(CharacterClass, enemy.name,  enemy.x_pos, enemy.y_pos, 9, .075)
    self.player:FaceLeft()
    self.enemy:FaceRight()

end

function InsultScene:InitWorld(map)

    self.mapdata = TiledMapClass:new(require(map))
    self.world   = WorldClass:new(self.mapdata, {self.enemy}, self.player, self.mapdata:GetCollisionObjects())

end

function InsultScene:InitButtons()

    if self.menu_image == nil then return end
    if self.playerinsults == nil then return end

    self.category_buttons = {}
    self.buttons          = {}
    for i = 1, #self.playerinsults do
        self.category_buttons[self.playerinsults[i].category] = ButtonClass:newWithoutImage(-1, -1, self.menu_width_half_scale, self.menu_height_half_scale)
        self.category_buttons[self.playerinsults[i].category]:SetCallback(function() self.in_categories = false; self.active_category = i end)
        self.category_buttons[self.playerinsults[i].category]:SetAlphaForFilter(.33)
        self.category_buttons[self.playerinsults[i].category]:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
        self.buttons[self.playerinsults[i].category] = {}
        for j = 1, #self.playerinsults[i] do
            self.buttons[self.playerinsults[i].category][j] = ButtonsClass:newWithoutImage(-1, -1, self.menu_width_half_scale, self.menu_height_half_scale)
            self.buttons[self.playerinsults[i].category][j]:SetAlphaForFilter(.33)
            self.buttons[self.playerinsults[i].category][j]:SetSoundWhenClicked("sound/startmenu/click/click.ogg")
        end
    end

end

function InsultScene:CalcButtonPos(idx)

    local x, y = self:GetMenuLocation()

    if idx%2 == 0 then
        x = x + self.menu_width_half * Settings.Scale
    end

    if idx*.333 >= .95 then
        y = y + self.menu_height_half * Settings.Scale
    end
    return x, y

end

function InsultScene:UpdateButtonPos()

    local x, y
    local w_s, h_s = self.menu_width_half  * Settings.Scale, self.menu_height_half * Settings.Scale
    local function SetParameters(button)
        button.x_pos  = x
        button.y_pos  = y
        button.width  = w_s
        button.height = h_s
    end
    for i = 1, #self.playerinsults do
        x, y = self:CalcButtonPos(i)
        SetParameters(self.category_buttons[self.playerinsults[i].category])
        for j = 1, #self.playerinsults[i] do
            x, y = self:CalcButtonPos(j)
            SetParameters(self.buttons[self.playerinsults[i].category][j])
        end
    end

end

function InsultScene:SetInsults(playerinsults, enemyinsults)

    --insults -> categories -> insult and ranking
    self.playerinsults = playerinsults
    --insults -> insult and ranking
    self.enemyinsults  = enemyinsults

end

function InsultScene:SetBanter(playerbanter, enemybanter)

    self.playerbanter = playerbanter
    self.enemybanter  = enemybanter

end

function InsultScene:SetCameraTracking(entity)

    self.world:SetEntityToTrackForCamera(entity)

end

function InsultScene:SetMenuEntity(menu_entity)

    self.menu_entity      = menu_entity
    self.menu_image       = getImageFromCache("pics/share/text/TextBoxes.png")
    self.menu_width_half  = bit.rshift(self.menu_image:getWidth(), 1)
    self.menu_height_half = bit.rshift(self.menu_image:getHeight(), 1)
    self.menu_width_half_scale  = self.menu_width_half  * Settings.Scale
    self.menu_height_half_scale = self.menu_height_half * Settings.Scale

end

function InsultScene:SetButtons()

    if self.buttons == nil then
        self:InitButtons()
        return
    end
    self:UpdateButtonPos()

end

function InsultScene:CheckScale()

    if Settings.Scale ~= self.current_scale then
        self.fontsize      = 8 * Settings.Scale
        self.font          = love.graphics.newFont(self.fontsize)
        self.current_scale = Settings.Scale
    end

end

function InsultScene:Draw()

    self.world:Draw()

end

function InsultScene:GetMenuLocationNoTranslation()

    return (self.menu_entity.x_pos) * Settings.Scale, (self.menu_entity.y_pos) * Settings.Scale

end

function InsultScene:GetMenuLocation()

    local x = Settings.X_Canvas_Translation + (self.menu_entity.x_pos) * Settings.Scale
    local y = Settings.Y_Canvas_Translation + (self.menu_entity.y_pos) * Settings.Scale
    return x, y

end

local function SecondRowOffset(row)

    if row == 2 then
        return -1
    end
    return 0

end

function InsultScene:GetTextLocation(idx, row)

    local x, y  = self:GetMenuLocation()
    local tempx = (idx - row + SecondRowOffset(row)) * self.menu_width_half * Settings.Scale + x + 16
    local tempy = (row - 1) * self.menu_height_half * Settings.Scale + y
    return tempx, tempy

end

function InsultScene:DrawBanter()

end

function InsultScene:DrawInsults()

    love.graphics.setFont(self.font)

    local tempx, tempy
    local row = 1
    for i = 1, #self.playerinsults do

        if row ~= 2 and i > 2 then
            row = 2
        end
        tempx, tempy = self:GetTextLocation(i, row)
        love.graphics.print({{0,0,0,1}, self.playerinsults[self.active_category].insults[i]}, tempx, tempy)

    end

end

function InsultScene:DrawCategories()

    love.graphics.setFont(self.font)

    local tempx, tempy
    local row = 1
    for i = 1, #self.playerinsults do

        if row ~= 2 and i > 2 then
            row = 2
        end
        tempx, tempy = self:GetTextLocation(i, row)
        love.graphics.print({{0,0,0,1}, self.playerinsults[i].category}, tempx, tempy)

    end

end

function InsultScene:DrawBackgroundForMenu()

    if self.menu_entity == nil then

        print("Background menu_entity never set")
        return

    end
    local x, y = self:GetMenuLocation()
    love.graphics.draw(self.menu_image, x, y, 0, Settings.Scale, Settings.Scale)

end

function InsultScene:DrawMenu()

    self:DrawBackgroundForMenu()
    if self.in_categories then
        self:DrawCategories()
    else
        self:DrawInsults()
    end

end

function InsultScene:DrawButtonOutlines()

    local function drawoutlines(buttons)
        for idx, value in pairs(buttons) do
            value:Draw()
        end
    end

    if self.in_categories then
        drawoutlines(self.category_buttons)
    end

end

function InsultScene:DrawText()

    self:DrawBanter()
    if self.menu_active then self:DrawMenu() end
    if self.buttons ~= nil then self:DrawButtonOutlines() end

end

function InsultScene:ButtonCategoryHandler()

    for idx, value in pairs(self.category_buttons) do
        value:HandleMouseClick()
    end

end

function InsultScene:ButtonSubCategoryHandler()

    for i = 1, #self.buttons[self.playerinsults[self.active_category].category] do
        self.buttons[self.playerinsults[self.active_category].category][i]:HandleMouseClick()
    end

end

function InsultScene:ButtonBackHandler()

end

function InsultScene:ButtonInputHandler()

    if self.buttons == nil then return end
    if self.in_categories then

        self:ButtonCategoryHandler()

    else 

        self:ButtonSubCategoryHandler()
        self:ButtonBackHandler()

    end

end

function InsultScene:HandleInput()

    self:ButtonInputHandler()

end

function InsultScene:Update()

    self:SetButtons()

end

function InsultScene:CanTransition()

    return self.transition

end

return InsultScene