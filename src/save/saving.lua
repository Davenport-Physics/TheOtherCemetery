local DataToSave  = require("src/save/savingdata")
local Settings    = require("src/settings/settings")
local inspect     = require("src/debug/inspect")
require("src/save/savingpersistence")

--local OS        = love.system.getOS()
local separator = "/"
local Path
local SavePath
if Settings.BUILD then
    Path = love.filesystem.getSaveDirectory()
else
    Path = love.filesystem.getWorkingDirectory()
end
SavePath = Path


local function CheckIfDirectoryExists(dir)

    return love.filesystem.getInfo(dir, "directory")

end

local function Makedirectory(path)

    return love.filesystem.createDirectory(path)

end

local function HandleDirectoryChecksAndCreation()

    if not Settings.BUILD then return end
    if CheckIfDirectoryExists(SavePath) ~= nil then
        return
    end
    if not Makedirectory(SavePath) then
        -- TODO Handle this issue
    end

end

function StoreSaveData(filename)

    HandleDirectoryChecksAndCreation()
    if filename == nil then filename = DataToSave["File"] end
    persistence.store(SavePath .. separator .. filename, DataToSave)

end

function LoadSaveData(filename)

    local temp, err = persistence.load(SavePath .. separator .. filename)
    DataToSave.SetValues(temp)

end

function GetPartialDataFromSaves()

    local s_start  = SavePath .. separator
    local filename
    local p_saves = {}
    for i = 1, 3 do
        filename = s_start .. "save" .. tostring(i) .. ".lua"
        local s  = persistence.load(filename)
        if s ~= nil then
            p_saves[i] = {["SaveName"] = s["SaveName"], ["PlayTime"] = s["PlayTime"], ["File"] = "save" .. tostring(i) .. ".lua"}
        else
            p_saves[i] = {["SaveName"] = "empty", ["PlayTime"] = {hours = 0, minutes = 0, seconds = 0}, ["File"] = "save" .. tostring(i) .. ".lua"}
        end
    end
    return p_saves

end

local function GetRelevantSettingData()

    local temp =
    {

        ["Controls"]           = Settings.Controls,
        ["Window_Width"]       = Settings.Window_Width,
        ["Window_Height"]      = Settings.Window_Height,
        ["MasterVolume"]       = Settings.MasterVolume,
        ["MusicVolume"]        = Settings.MusicVolume,
        ["SoundEffectsVolume"] = Settings.SoundEffectsVolume,
        ["Fullscreen"]         = Settings.Fullscreen

    }

    return temp

end

function StoreSettings()

    HandleDirectoryChecksAndCreation()
    persistence.store(Path .. separator .. "settings.lua", GetRelevantSettingData())

end

function LoadSettings()

    local temp = persistence.load(Path .. separator .. "settings.lua")
    if temp then
        Settings.Controls           = temp.Controls
        Settings.Window_Width       = temp.Window_Width
        Settings.Window_Height      = temp.Window_Height
        Settings.MasterVolume       = temp.MasterVolume
        Settings.MusicVolume        = temp.MusicVolume
        Settings.SoundEffectsVolume = temp.SoundEffectsVolume
        Settings.Fullscreen         = temp.Fullscreen
    end

end