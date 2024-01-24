local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local command_handler = require(ServerScriptService.aprils_admin.command_handler)

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(msg)
        command_handler.run_string(player, msg)
    end)
end)
