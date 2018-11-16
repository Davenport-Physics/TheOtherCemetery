local DataToSave      = require("src/save/savingdata")
local Shared          = require("src/shared/shared")
local Settings        = require("src/settings/settings")
local EntityClass     = require("src/entity/entity")
local WorldClass      = require("src/world/world")
local DoorClass       = require("src/entity/door")
local CharacterClass  = require("src/character/character")
local TiledMapClass   = require("src/map/tiledmap")
local WalkerClass     = require("src/characterwalker/walker-generic")
local TextBubbleClass = require("src/character/textbubbles")
local DialogClass     = require("src/dialog/dialog")
local DoorsHandler    = require("src/entity/doorhandler")

local CHAR_DIR = "tiles/Characters/"

local function GetCharLoc(char)
    return CHAR_DIR .. char
end

local CHARS =
{
    ["Henry"]    = GetCharLoc("Males/M_08.png"),
    ["Anna"]     = GetCharLoc("Females/F_01.png"),
    ["PaulOwen"] = GetCharLoc("Males/M_12.png"),
    ["Cheri"]    = GetCharLoc("Females/F_11.png"),
    ["Teacher"]  = GetCharLoc("Males/M_05.png")
}

local MAPS_DIR = "src/levels/maps/"

local function GetMapLoc(map)
    return MAPS_DIR .. map
end

local MAPS =
{
    ["City"]            = GetMapLoc("city/city"),
    ["CityRuined"]      = GetMapLoc("city/city-ruined.lua"),
    ["FuneralHome"]     = GetMapLoc("city/interiors/funeral"),
    ["HomeLobby"]       = GetMapLoc("home/home-lobby"),
    ["HenryBedroom"]    = GetMapLoc("home/henry-bedroom"),
    ["Grocery"]         = GetMapLoc("interiors/grocery/grocery"),
    ["Collector"]       = GetMapLoc("interiors/collector/collector"),
    ["UnderCollector"]  = GetMapLoc("interiors/collector/underneath/underneath"),
    ["CollectorShrine"] = GetMapLoc("interiors/collector/underneath/shrinetodead"),
    ["School"]          = GetMapLoc("school/school"),
    ["SchoolRoom"]      = GetMapLoc("school/school-room.lua")
}

local Scene = {}
Scene.__index = Scene

function Scene:new(player, npcs, map)

    local obj = {}
    setmetatable(obj, Scene)

    obj:InitPlayer(player)
    obj:InitNPCs(npcs)
    obj:InitWorld(map)
    obj:InitDefaultCallbacks()
    obj.transition = false

    return obj

end

function Scene:InitPlayer(player)

    self.player = CharacterClass:new(CHARS[player.name], player.x_pos, player.y_pos, 16, 17, 9, .075)

end

function Scene:InitNPCs(npcs)

    self.npcs = {}
    for i = 1, #npcs do
        self.npcs[i] = CharacterClass(CHARS[npcs[i].name], npcs[i].x_pos, npcs[i].y_pos, 16, 17, 4, .05)
    end

end

function Scene:InitWorld(map)

    self.map   = TiledMapClass:new(MAPS[map])
    self.world = WorldClass:new(self.map, self.npcs, self.player, self.map:GetCollisionObjs())
    self.world:SetEntityToTrackForCamera(self.player)

end

function Scene:InitDefaultCallbacks()

    self.update_callback      = function() end
    self.draw_callback        = function() end
    self.drawtext_callback    = function() end
    self.handleinput_callback = function() end
    self.reset_callback       = function() end
    self.playerchar_callback  = function() end

end

function Scene:SetInput(func)

    self.world:SetHandleInputCallback(func)

end

function Scene:SetCamera(entity)

    self.world:SetEntityToTrackForCamera(entity)

end

function Scene:SetTransitionVar(val)

    self.transition = val

end

function Scene:SetUpdateCallback(func)

    self.update_callback = func

end

function Scene:SetDrawCallback(func)

    self.draw_callback = func

end

function Scene:SetDrawTextCallback(func)

    self.drawtext_callback = func

end

function Scene:SetHandleInputCallback(func)

    self.handleinput_callback = func

end

function Scene:SetResetCallback(func)

    self.reset_callback = func

end

function Scene:SetPlayerCharCallback(func)

    self.playerchar_callback = func

end

function Scene:Update()

    self.update_callback()

end

function Scene:Draw()

    self.draw_callback()

end

function Scene:DrawText()

    self.drawtext_callback()

end

function Scene:HandleInput()

    self.handleinput_callback()

end

function Scene:Reset()

    self.reset_callback()

end

function Scene:CanTransition()

    return self.transition

end

function Scene:SetPlayerCharPosition(x_pos, y_pos)

    self.playerchar_callback(x_pos, y_pos)

end

return Scene