-- type
function is_nil(arg)
    return type(arg) == 'nil'
end

function is_boolean(arg)
    return type(arg) == 'boolean'
end

function is_string(arg)
    return type(arg) == 'string'
end

function is_number(arg)
    return type(arg) == 'number'
end

function is_function(arg)
    return type(arg) == 'function'
end

function is_table(arg)
    return type(arg) == 'table'
end

function is_thread(arg)
    return type(arg) == 'thread'
end

function is_userdata(arg)
    return type(arg) == 'userdata'
end

-- None
function is_none(arg)
    return arg == nil or arg == false or arg == 0 or arg == '' or arg ~= arg
end

-- arithmetic
function is_nan(arg)
    return arg ~= arg
end