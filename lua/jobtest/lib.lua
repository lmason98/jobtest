local lib = {}

-- Args: String text
-- Desc: Prints an addon message.
function lib.msg(text)
    print(string.format('[JobTest]: %s', text)) end

jobtest.lib = lib
