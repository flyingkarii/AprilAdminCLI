local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local command_handler = require(ServerScriptService.aprils_admin.command_handler)

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(msg)
        local response = command_handler.run_string(player, msg)
        
        if response then
            print(response)
        end
    end)
end)
