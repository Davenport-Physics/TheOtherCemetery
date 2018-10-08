
local Scene = {}

local Settings   = require("src/settings/settings")
local MapClass   = require("src/map/tiledmap")
local CharClass  = require("src/character/character")
local WorldClass = require("src/world/world")
local MapData    = require("src/levels/day0/maps/runner-example")
local Map        = MapClass:new(MapData)

local HenryChar = CharClass:new("tiles/Characters/Males/M_08.png", 32, 32, 16, 17, 6, .05)
local World     = WorldClass:new(Map, {}, HenryChar, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(HenryChar)

local transition = false

function Scene.Update()

    HenryChar.WalkDown(true)
    World:Update()


end

function Scene.CanTransition()

    return transition

end

local function RunnerCallback()

    if love.keyboard.isDown(Settings.Controls.LEFT) then
        HenryChar.x_pos = HenryChar.x_pos - 6
    elseif love.keyboard.isDown(Settings.Controls.RIGHT) then
        HenryChar.x_pos = HenryChar.x_pos - 6
    end

end

World:SetHandleInputCallback(RunnerCallback)

function Scene.HandleInput()

    World:HandleInput()

end

function Scene.Draw()

    World:Draw()

end


return Scene