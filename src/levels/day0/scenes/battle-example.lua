local Scene = {}

local Settings    = require("src/settings/settings")
local MapClass    = require("src/map/tiledmap")
local CharClass   = require("src/character/character")
local WorldClass  = require("src/world/world")
local EntityClass = require("src/entity/entity")

local MapData = require("src/levels/day0/maps/battle-example")
local Map     = MapClass:new(MapData)

local HenryChar = CharClass:new("tiles/Characters/Males/M_08.png", 108, 64, 16, 17, 6, .05); HenryChar:WalkLeft(true);
local BullyChar = CharClass:new("tiles/Characters/Males/M_07.png", 16, 16, 16, 17, 6, .05); BullyChar:WalkRight(true);

local StaticEntity = EntityClass:newMinimal(80, 80)
local World = WorldClass:new(Map, {BullyChar}, HenryChar, Map:GetCollisionObjects())
World:SetEntityToTrackForCamera(StaticEntity)

local PuckQuad = Map.quads[496]
local Puck     = nil -- EntityClass:newQuadWithMovementFunction()

local transition = false

function Scene.Update()

    World:Update()
    if Puck ~= nil then Puck:Update() end

end

function Scene.CanTransition()

    return transition

end

local function Move_Puck(x, y)

    return x - 2, y

end

local function Shoot_Puck()

    Puck = EntityClass:newQuadWithMovementFunction(HenryChar.x_pos-4, HenryChar.y_pos, Move_Puck, .01, PuckQuad, Map.sprite_sheet)

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

function Scene.Draw()

    World:Draw()
    if Puck ~= nil then Puck:Draw() end

end

return Scene