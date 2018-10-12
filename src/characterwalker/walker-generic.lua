local RandomWalkerClass = require("src/characterwalker/random-walker")
local RunnerWalkerClass = require("src/characterwalker/runner-walker")
local BattleWalkerClass = require("src/characterwalker/battle-walker")
local PathWalkerClass   = require("src/characterwalker/path-walker")

local WalkerGeneric = {}
CharWalker.__index = CharWalker

function WalkerGeneric:new(char, type, walker_instructions)

    local obj = {}
    setmetatable(obj, CharWalker)
    obj.char = char
    obj.type = type
    obj.walker_instructions = walker_instructions
    obj:InitializeWalkerTypeObject()

    return obj

end

function WalkerGeneric:InitializeWalkerTypeObject()

    if self.type == "random-walker" then
        self.walker = RandomWalkerClass:new(self.char, self.walker_instructions)
    elseif self.type == "runner-walker" then
        self.walker = RunnerWalkerClass:new(self.char, self.walker_instructions)
    elseif self.type == "battle-walker" then
        self.walker = BattleWalkerClass:new(self.char, self.walker_instructions)
    elseif self.type == "path-walker" then
        self.walker = PathWalkerClass:new(self.char, self.walker_instructions)
    end

end

function WalkerGeneric:Update()

    if self.walker ~= nil then
        self.walker:Update()
    end

end

function WalkerGeneric:IsDoneWalking()

    if self.walker ~= nil then
        return self.walker:IsDoneWalking()
    end

    return false

end

return WalkerGeneric