local ServerScriptService = game:GetService("ServerScriptService")

local language_key_parser = require(ServerScriptService.aprils_admin.utilities.language_key_parser)
local parser = require(ServerScriptService.aprils_admin.utilities.parser)
local types = require(script.Parent.types)
local command_handler = {}

local function combine_string(input: string)
    local matches = input:gmatch("[\"].+[\"]")

    for match in matches do
        local replace_spaces = match:gsub("%s+", "␡")
        local replace_quotes = replace_spaces:gsub("\"", "")
        input = input:gsub(match, replace_quotes)
    end

    return input
end

local function get_arguments_table(input: string)
    local arguments_table = input:split(" ")

    for i, argument in arguments_table do
        arguments_table[i] = argument:gsub("␡", " ")
    end

    return arguments_table
end

local function get_flags(args: types.unparsed_arguments)
    local result = {}
    local indices = {}

    for index, argument in args do
        if argument:sub(1, 1) == "-" then
            table.insert(indices, index)
            table.insert(result, argument:sub(2))
        end
    end

    return result, indices
end

function command_handler.run(sender: Player, command: string, args: types.unparsed_arguments): string?
    if not script.Parent.commands:FindFirstChild(command) then
        local language_data = {
            cmd = command
        }

        return language_key_parser.parse(1, language_data) 
    end

    local command_info: types.command_info = require(script.Parent.commands[command]) :: any
    local command_args: any = if command_info.arguments then command_info.arguments else {}

    local has_flags = false
    local flags = {}
    local passed_flags, flag_indices = get_flags(args)

    -- clear flag arguments from arguments
    for _, index in flag_indices do
        table.remove(args, index)
    end

    if #command_info.flags > 0 then
        has_flags = true

        for _, flag_name in command_info.flags do
            flags[flag_name] = if table.find(passed_flags, flag_name) then true else false
        end
    end

    local parsed_arguments: {any} = {}

    for index, data: types.command_arguments in command_args do
        local current_argument = args[index]

        if data.required and current_argument == nil then
            local language_data = {
                required_type = data.type,
                id = index
            }

            return language_key_parser.parse(2, language_data)
        end

        if not data.required and current_argument == nil then
            continue
        end

        if parser(current_argument, data.type) == nil then
            local language_data = {
                required_type = data.type,
                passed_argument = current_argument,
                id = index
            }

            return language_key_parser.parse(3, language_data)
        end

        parsed_arguments[index] = parser(current_argument, data.type)
    end
    
    return if has_flags 
    then command_info.execute(sender, flags, table.unpack(parsed_arguments)) 
    else command_info.execute(sender, table.unpack(parsed_arguments))
end

function command_handler.run_string(sender: Player, input: string): string?
    local no_whitespace = input:lower():gsub("%s+", " ")
    local combined_string = combine_string(no_whitespace)
    local command = no_whitespace:match("^%a+")
    if not command then return language_key_parser.parse(1, { cmd = command }) end

    local arguments_string = combined_string:sub(#command + 2)
    local arguments_table = get_arguments_table(arguments_string)

    return command_handler.run(sender, command, arguments_table)
end

return command_handler