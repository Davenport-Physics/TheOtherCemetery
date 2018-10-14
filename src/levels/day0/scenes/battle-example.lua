local Scene = {}

local Settings    = require("src/settings/settings")
local MapClass    = require("src/map/tiledmap")
local CharClass   = require("src/character/character")
local WorldClass  = require("src/world/world")
local EntityClass = require("src/entity/entity")
local RunnerClass = require("src/characterwalker/walker-generic")

local MapData = require("src/levels/day0/maps/battle-example")
local Map     = MapClass:new(MapData)

local HenryChar = CharClass:new("tiles/Characters/Males/M_08.png", 108, 64, 16, 17, 6, .05); HenryChar:WalkLeft(true);
local BullyChar = CharClass:new("tiles/Characters/Males/M_07.png", 16, 16, 16, 17, 6, .05); BullyChar:WalkRight(true);
local Runner    = RunnerClass:new(BullyChar, "runner-walker", {WalkDirection = "WalkRight", Player = HenryChar, Displacement = .5, RandomDisplacementChance = 35})

local StaticEntity = EntityClass:newMinimal(80, 80)
local World = WorldClass:new(Map, {BullyChar}, HenryChar, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(StaticEntity)

local MIN_TIME_FOR_PUCK_SPAWN = .25
local TimeForNextPuck = love.timer.getTime()
local PuckQuad = Map.quads[496]
local Puck     = {} -- EntityClass:newQuadWithMovementFunction()

local transition = false

function UpdateAllPucks()

    for i = 1, #Puck do
        Puck[i]:Update()
    end

end

function Scene.Update()

    World:Update()
    Runner:Update()
    if #Puck ~= 0 then UpdateAllPucks() end

end

function Scene.CanTransition()

    return transition

end

local function Move_Puck(x, y)

    return x - 2, y

end

local function Shoot_Puck()

    if love.timer.getTime() >= TimeForNextPuck then
        Puck[#Puck + 1] = EntityClass:newQuadWithMovementFunction(HenryChar.x_pos-4, HenryChar.y_pos, Move_Puck, .01, PuckQuad, Map.sprite_sheet[1])
        TimeForNextPuck = love.timer.getTime() + MIN_TIME_FOR_PUCK_SPAWN
    end

end

local function HandleInputCallback()

    if love.keyboard.isDown(Settings.Controls.UP) then
        HenryChar:GlideUp()
        HenryChar:WalkLeft(false)
    elseif love.keyboard.isDown(Settings.Controls.DOWN) then
        HenryChar:GlideDown()
        HenryChar:WalkLeft(false)
    end
    if love.keyboard.isDown(Settings.Controls.ATTACK_BUTTON) then
        Shoot_Puck()
    end

end

World:SetHandleInputCallback(HandleInputCallback)

function Scene.HandleInput()

    World:HandleInput()

end

function DrawPucks()

    for i = 1, #Puck do
        Puck[i]:Draw()
    end

end

function Scene.Draw()

    World:Draw()
    if #Puck ~= 0 then DrawPucks() end

end

return Scene