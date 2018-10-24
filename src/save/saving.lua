local DataToSave  = require("src/save/savingdata")
local Settings    = require("src/settings/settings")
require("src/save/savingpersistence")

local separator = package.config:sub(1,1)

local function CheckIfSaveDirectoryExists()

    local f, err = io.open(".." .. separator .. "saves" .. separator .. "temp", "w")
    if f then

        f:write("stuff")
        f:close()
        return true

    end
    return false

end

local function Makedirectory()

    os.execute("mkdir saves")

end

local function HandleDirectoryChecksAndCreation()

    if not CheckIfSaveDirectoryExists() then
        print("Making saves dir")
        Makedirectory()
    end

end

function StoreSaveData(filename)

    HandleDirectoryChecksAndCreation()
    persistence.store("saves" .. separator .. filename, DataToSave)

end

function LoadSaveData(filename)

    SaveData.DataToSave = persistence.load("saves" .. separator .. filename)
    if SaveData.DataToSave == nil then
        return "SaveDidNotExist"
    end

end

function GetPartialDataFromSaves()

    local s_start  = "saves" .. separator
    local filename = ""
    local p_saves = {}
    for i = 1, 3 do
        filename = s_start .. "save" .. tostring(i) .. ".lua"
        local s  = persistence.load(filename)
        if s ~= nil then
            p_saves[i] = {["SaveName"] = s["SaveName"], ["PlayTime"] = s["PlayTime"], ["File"] = filename}
        else
            p_saves[i] = {["SaveName"] = "empty", ["PlayTime"] = 0, ["File"] = filename}
        end
    end
    return p_saves

end

local function GetRelevantSettingData()

    local temp = 
    {

        ["Controls"]      = Settings.Controls,
        ["Window_Width"]  = Settings.Window_Width,
        ["Window_Height"] = Settings.Window_Height,
        ["MasterVolume"]  = Settings.MasterVolume,
        ["MusicVolume"]   = Settings.MusicVolume

    }

    return temp

end

function StoreSettings()

    persistence.store("settings.lua", GetRelevantSettingData())

end

function LoadSettings()

    local temp = persistence.load("settings.lua")
    if temp then
        Settings.Controls      = temp.Controls
        Settings.Window_Width  = temp.Window_Width
        Settings.Window_Height = temp.Window_Height
        Settings.MasterVolume  = temp.MasterVolume
        Settings.MusicVolume   = temp.MusicVolume
    end

end