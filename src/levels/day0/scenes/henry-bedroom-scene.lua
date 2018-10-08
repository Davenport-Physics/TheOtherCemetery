local Scene = {}

local Settings     = require("src/settings/settings")
local EntityClass  = require("src/entity/entity")
local WorldClass   = require("src/world/world")

local CharacterClass = require("src/character/character")
local MapData        = require("src/levels/day0/maps/henry-bedroom")
local TiledMapClass  = require("src/map/tiledmap")
local TiledMap       = TiledMapClass:new(MapData)

local AnnaChar  = CharacterClass:new("tiles/Characters/Females/F_01.png", 96, 16, 16, 17, 2, .05); AnnaChar:AllowDrawing(false);
local HenryChar = CharacterClass:new("tiles/Characters/Males/M_08.png", 32, 32, 16, 17, 6, .05); HenryChar:WalkRight(true);

local RoomEntity         = EntityClass:newMinimal(48, 48)
local RoomWorld          = WorldClass:new(TiledMap, {AnnaChar}, HenryChar, TiledMap:GetCollisionObjects())
RoomWorld:SetEntityToTrackForCamera(RoomEntity)

local transition = false

local ANNA_MADE_POSITION =
{

    false, false, false, false

}
local ANNA_POSITION_FUNCTION =
{

    AnnaChar.WalkDown,
    AnnaChar.WalkLeft,
    AnnaChar.WalkRight,
    AnnaChar.WalkUp

}
local ANNA_POSITIONS =
{

    {x = 96, y = 32},
    {x = 48, y = 32},
    {x = 96, y = 32},
    {x = 96, y = 16}

}

local cycle_complete         = false
local time_to_spawn_anna     = nil
local function Room_Spawn_Anna()

    if time_to_spawn_anna == nil then
        time_to_spawn_anna = love.timer.getTime() + 1
        return
    end
    if love.timer.getTime() >= time_to_spawn_anna then
        AnnaChar:AllowDrawing(true)
    end

end

local function Room_CheckTo_Despawn_Anna(idx)

    if idx == #ANNA_POSITIONS then
        AnnaChar:AllowDrawing(false)
        cycle_complete = true
        RoomWorld:SetEntityToTrackForCamera(HenryChar)
    end

end

local function Room_Check_Made_Anna()

    for i = 1, #ANNA_POSITIONS do
        if not ANNA_MADE_POSITION[i] then
            local x = AnnaChar.x_pos
            local y = AnnaChar.y_pos
            if x == ANNA_POSITIONS[i].x and y == ANNA_POSITIONS[i].y then
                ANNA_MADE_POSITION[i] = true
                Room_CheckTo_Despawn_Anna(i)
            end
            break
        end
    end

end

local function Room_Move_Anna()

    for i = 1, #ANNA_MADE_POSITION do
        if not ANNA_MADE_POSITION[i] then
            ANNA_POSITION_FUNCTION[i](AnnaChar, true)
            break
        end
    end

end

local function Update_Anna_Checks()
    if not AnnaChar.allow_drawing then
        Room_Spawn_Anna()
    else
        Room_Check_Made_Anna()
        Room_Move_Anna()
    end
end

function Scene.Update()

    if not cycle_complete then
        Update_Anna_Checks()
    end
    RoomWorld:Update()

end

function Scene.CanTransition()

    return transition

end

function Scene.Draw()

    RoomWorld:Draw()

end


function Scene.HandleInput()

    if cycle_complete then
        RoomWorld:HandleInput()
    end

end

return Scene