
local Scene = {}

local Settings    = require("src/settings/settings")
local MapClass    = require("src/map/tiledmap")
local CharClass   = require("src/character/character")
local RunnerClass = require("src/characterwalker/walker-generic")
local WorldClass  = require("src/world/world")
local MapData     = require("src/levels/day0/maps/runner-example")
local Map         = MapClass:new(MapData)

local RunnerNPC = CharClass:new("tiles/Characters/Males/M_09.png", 3 * 16, 0, 16, 17, 6, .05)
local HenryChar = CharClass:new("tiles/Characters/Males/M_08.png", 3 * 16, 3 * 16, 16, 17, 6, .05)
local World     = WorldClass:new(Map, {RunnerNPC}, HenryChar, Map:GetCollisionObjects(), false)
World:SetEntityToTrackForCamera(HenryChar)

local Runner    = RunnerClass:new(RunnerNPC, "runner-walker", {WalkDirection = "WalkDown", Player = HenryChar})

local transition = false
local time_to_transition = nil

local function CheckForTransitionTime()

    if time_to_transition == nil then
        time_to_transition = love.timer.getTime() + 8
    end
    if love.timer.getTime() >= time_to_transition then
        transition = {"src/levels/day0/scenes/city"}
    elseif Runner:IsDistanceBetweenCharsAcceptable(HenryChar) then
        transition = {"src/levels/day0/scenes/battle-example"}
    end

end

function Scene.Update()

    HenryChar:WalkDown(true)
    Runner:Update()
    World:Update()
    CheckForTransitionTime()

end

function Scene.CanTransition()

    return transition

end

local function RunnerCallback()

    if love.keyboard.isDown(Settings.Controls.LEFT) then
        HenryChar:GlideLeft()
    elseif love.keyboard.isDown(Settings.Controls.RIGHT) then
        HenryChar:GlideRight()
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