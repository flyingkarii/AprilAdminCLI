local language_keys = require(script.Parent.language_keys)
local language_key_parser = {}

function language_key_parser.parse(key_id: number, args_table: { [string]: any })
    local language_value = language_keys[key_id]
    
    for key, argument in args_table do
        language_value = language_value:gsub(`\{{key}}`, tostring(argument))
    end

    return language_value
end

return language_key_parser