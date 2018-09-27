Settings = {}

Settings.Controls =
{

    UP    = "w",
    DOWN  = "s",
    LEFT  = "a",
    RIGHT = "d",

}

Settings.PlayerSaveName = ""

function SetPlayerSaveName(name)

    if name ~= nil then
        Settings.PlayerSaveName = name
    end

end

function SetPlayerControls(controls)

    if controls ~= nil then
        Settings.Controls = controls
    end

end

return Settings