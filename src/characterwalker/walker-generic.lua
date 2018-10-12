local RandomWalkerClass = require("src/characterwalker/random-walker")
local RunnerWalkerClass = require("src/characterwalker/runner-walker")
local BattleWalkerClass = require("src/characterwalker/battle-walker")
local PathWalkerClass   = require("src/characterwalker/path-walker")

local WalkerGeneric = {}
CharWalker.__index = CharWalker

function WalkerGeneric:new(char, type)

    local obj = {}
    setmetatable(obj, CharWalker)
    obj.char = char
    obj.type = type
    obj:InitializeWalkerTypeObject()

    return obj

end

function WalkerGeneric:InitializeWalkerTypeObject()

    if self.type == "random" then
        self.walker = RandomWalkerClass:new()
    elseif self.type == "runner-walker" then
        self.walker = RunnerWalkerClass:new()
    elseif self.type == "battle-walker" then
        self.walker = BattleWalkerClass:new()
    elseif self.type == "path-walker" then
        self.walker = PathWalkerClass:new()
    end

end

function WalkerGeneric:Update()

    if self.walker ~= nil then
        self.walker:Update()
    end

end

return WalkerGeneric