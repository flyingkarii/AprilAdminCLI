local ServerScriptService = game:GetService("ServerScriptService")

local types = require(ServerScriptService.aprils_admin.types)

return {
    flags = {
        "t"
    },
    arguments = {
        {
            required = true,
            type = "player"
        },
        {
            required = true,
            type = "number"
        }
    },
    execute = function(player, flags: {[string]: boolean}, target: Player, amount: number)
        local str_flag = tostring(flags.t)
        print("Flag t exists: " .. str_flag)
        return
    end
}