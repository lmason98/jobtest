--[[
Args: String name, Number scale, Bool bold
Desc: Creates a new font
]]
local function CreateFont(name, scale, bold)
    local weight = 500
    name = name .. '_' .. tostring(scale)

    if (bold) then
        weight = 800
        name = name .. 'b'
    end

    print(name)

    surface.CreateFont(name, {
        font = 'Roboto',
        size = ScreenScale(scale),
        weight = weight,
        antialias = true
    })
end

CreateFont('jtest', 15, true)
CreateFont('jtest', 12, true)
