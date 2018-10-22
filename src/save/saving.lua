local SaveData    = require("src/save/savingdata")
require("src/save/savingpersistence")

local separator = nil

local function InitSeparator()
    separator = package.config:sub(1,1)
end

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

    os.execute("mkdir .." .. separator .. "saves"  )

end

local function HandleDirectoryChecksAndCreation()

    InitSeparator()
    if not CheckIfSaveDirectoryExists() then
        print("Making saves dir")
        Makedirectory()
    end

end

function SaveDataToFile(filename)

    persistence.store(filename, SaveData.DataToSave)
    
end

function LoadDataFromFile(filename)

    SaveData.DataToSave = persistence.load(filename)
    if SaveData.DataToSave == nil then
        return "SaveDidNotExist"
    end

end