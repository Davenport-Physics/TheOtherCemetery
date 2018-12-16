local DataToSave  = require("src/save/savingdata")
local Shared      = require("src/shared/shared")
local EntityClass = require("src/entity/entity")
local InsultClass = require("src/scenes/insultscene-template") 
local Scene       = {}

local Henry = {name = "M_08", x_pos = 8, y_pos = 4}
local Enemy = {name = "M_09", x_pos = 1, y_pos = 4}
local InsultScene = InsultClass.new("src/levels/maps/example/battle-example", Henry, Enemy)
local playerinsults =
{
    {category = "Mom", insults = {"Your mom sucks!"}},
    {category = "Dad", insults = {"Your dad sucks!"}},
    {category = "Personal", insults = {"You suck"}},
    {category = "Silly", insults = {"I suck!"}}
}
InsultScene:SetMenuEntity(EntityClass:newMinimal(1*16, 6*16))
InsultScene:SetCameraTracking(EntityClass:newMinimal(4*16, 5*16))
InsultScene:SetInsults(playerinsults, {insults = {"Suck this", "Suck that!"}})


function Scene.Update()

    InsultScene:Update()

end

function Scene.Draw()

    InsultScene:Draw()

end

function Scene.DrawText()

    InsultScene:DrawText()

end

function Scene.HandleInput()

    InsultScene:HandleInput()

end

function Scene.Clean()

end

function Scene.CanTransition()

    return InsultScene:CanTransition()

end

function Scene.Reset()

end

function Scene.SetPlayerCharPosition(x_pos, y_pos)

    transition = false
    Henry.x_pos = x_pos
    Henry.y_pos = y_pos
end

return Scene