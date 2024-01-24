local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local types = require(ServerScriptService.aprils_admin.types)
local time_util = require(script.Parent.time_util)

local function player_search(player_name: string): Player?
    for _, player in Players:GetPlayers() do
        if player.Name:sub(1, #player_name) == player_name then
            return player
        end
    end

    return nil
end

return function(input: string, as_type: types.parser_acceptable_types): types.parser_function_types
    if as_type == "string" then
        return input
    elseif as_type == "number" then
        return tonumber(input)
    elseif as_type == "player" then
        return player_search(input)
    elseif as_type == "timestring" then
        return time_util.timestring_to_seconds(input)
    end

    return
end
