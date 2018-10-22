
local Game = require("src/gamehandler/gamehandler")
Game.InitializeGameHandler()

function DrawNewGame()

    Game.Draw()

end

function Update_NewGame()

    Game.Update()

end

function HandleInput_NewGame()

    Game.HandleInput()

end