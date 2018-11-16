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

local CHARS =
{
    ["Henry"] = "tiles/Characters/Males/M_08.png",
    ["Anna"]  = "tiles/Characters/Females/F_01.png"
}

local MAPS =
{
    ["FuneralHome"] = "",
    ["HomeLobby"] = ""
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

function SetPlayerCharCallback(func)

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