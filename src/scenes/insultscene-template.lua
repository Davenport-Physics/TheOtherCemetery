local Settings        = require("src/settings/settings")
local EntityClass     = require("src/entity/entity")
local WorldClass      = require("src/world/world")
local CharacterClass  = require("src/character/character")
local TiledMapClass   = require("src/map/tiledmap")
local WalkerClass     = require("src/characterwalker/walker-generic")
local TextBubbleClass = require("src/character/textbubbles")
local DialogClass     = require("src/dialog/dialog")

local function GetCharacterInitializer(char)

    if char.name[1] == "m" then
        return CharacterClass.newMale
    end
    return CharacterClass.newFemale

end

local InsultScene = {}
InsultScene.__index = InsultScene

function InsultScene.new(map, player, enemy)

    local obj = {}
    setmetatable(obj, InsultScene)
    obj.InitChars(player, enemy)
    obj.InitWorld(map)
    obj.menu_active      = true
    obj.in_categories    = true
    obj.active_categorie = 1

    return obj

end

function InsultScene:InitChars(player, enemy)

    self.player = GetCharacterInitializer(player)(CharacterClass, player.name,  player.x_pos, player.y_pos, 9, .075)
    self.enemy  = GetCharacterInitializer(enemy)(CharacterClass, enemy.name,  enemy.x_pos, enemy.y_pos, 9, .075)

end

function InsultScene:InitWorld(map)

    self.mapdata = TiledMapClass:new(map)
    self.world   = WorldClass:new(self.mapdata, {self.enemy}, self.player, self.mapdata:GetCollisionObjects())
    self.world:SetEntityToTrackForCamera(self.player)

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

function InsultScene:Draw()

    self.world:Draw()

end

function InsultScene:DrawBanter()

end

function InsultScene:DrawInsults()

end

function InsultScene:DrawCategories()

end

function InsultScene:DrawMenu()

    if self.in_categories then
        self:DrawCategories()
    else
        self:DrawInsults()
    end

end

function InsultScene:DrawText()

    self:DrawBanter()
    if self.menu_active then self:DrawMenu() end

end

return InsultScene