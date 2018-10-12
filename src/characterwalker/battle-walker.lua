local BattleWalker = {}
BattleWalker.__index = BattleWalker

function BattleWalker:new(char, walker_instructions)

    local obj = {}
    setmetatable(obj, BattleWalker)
    obj.char = char
    obj.walker_instructions = walker_instructions

    return obj

end

function BattleWalker:Update()

end

function BattleWalker:IsDoneWalking()

    return false

end

return BattleWalker