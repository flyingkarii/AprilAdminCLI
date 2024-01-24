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
    execute = function(player, flags: { [string]: boolean }, target: Player, amount: number)
        print(`Flag t exists: {flags.t}`)
        print(`Target name: {target.Name}`)
        print(`Amount: {amount}`)
        return
    end
}