-- parser typpes
export type parser_acceptable_types = "number" | "player" | "string" | "timestring"
export type parser_function_types = number? | Player? | string?

-- command handler types
export type unparsed_arguments = { [number]: string }
export type argument<T> = T
export type command_arguments = { 
    type: parser_acceptable_types,
    required: boolean
}
export type command_info = { 
    name: string?,
    description: string?,
    permission: string?,
    arguments: {[number]: command_arguments}?,
    flags: { string },
    execute: (sender: Player, flags: { [string]: boolean }, ...any) -> any & (sender: Player, ...any) -> any 
}

-- flag types
export type flag_acceptable_types = "number" | "string" | "none"
export type flag_default_value_types = (number | string | boolean)?
export type received_flag = { type: flag_acceptable_types, value: any }
export type received_flags = { [string]: received_flag }

return {}