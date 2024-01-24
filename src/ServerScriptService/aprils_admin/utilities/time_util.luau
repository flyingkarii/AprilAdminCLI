type unit_data = { [string]: { display: string, seconds: number } }

local conversion_order = { "y", "mo", "w", "d", "h", "m", "s" }
local conversions = {
    y = {display = "year", seconds = 31536000},
    mo = {display = "month", seconds = 2628288},
    w = {display = "week", seconds = 604800},
    d = {display = "day", seconds = 86400},
    h = {display = "hour", seconds = 3600},
    m = {display = "minute", seconds = 60},
    s = {display = "second", seconds = 1}
} :: unit_data

local time_util = {}

function time_util.timestring_to_seconds(input: string)
    local matches = input:gmatch("(%d+)(%a+)") :: () -> (string, string)
    local result = 0

    for number_str, unit in matches do
        local number = tonumber(number_str) :: number
        if not conversions[unit] then continue end
        
        result += number * conversions[unit].seconds
    end

    -- we want to return nil if no matches were valid units so we can do something with that
    return if result ~= 0 then result else nil
end

function time_util.prettify_timestring(input: string)
    local matches = input:gmatch("(%d+)(%a+)") :: () -> (string, string)
    local result = ""

    for number_str, unit in matches do
        local prefix = if #result ~= 0 then " " else ""
        local number = tonumber(number_str) :: number
        if not conversions[unit] then continue end

        local display_suffix = if number ~= 1 then "s" else ""
        local display = conversions[unit].display .. display_suffix
        number_str = prefix .. number_str
        
        result ..= `{number_str} {display}`
    end

    -- we want to return nil if no matches were valid units so we can do something with that
    return if result ~= "" then result else nil
end

function time_util.seconds_to_timestring(input: number)
    local result = ""
    local remaining_seconds = input

    while remaining_seconds > 0 do
        for _, unit in conversion_order do
            local unit_data = conversions[unit]
            
            if unit_data.seconds > remaining_seconds then
                continue
            end

            local amount = math.floor(remaining_seconds / unit_data.seconds)
            remaining_seconds -= amount * unit_data.seconds
            
            local current_timestring = tostring(amount) .. unit
            result ..= current_timestring
        end
    end

    return if result ~= "" then result else nil
end

return time_util