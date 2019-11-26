--Args: String name, Number scale, Bool bold
--Desc: Creates a new font
local function CreateFont(name, scale, bold)
    local weight = 500
    name = name .. '_' .. tostring(scale)

    if (bold) then
        weight = 1000
        name = name .. 'b'
    end

    surface.CreateFont(name, {
        font = 'Roboto',
        size = ScreenScale(scale),
        weight = weight,
        antialias = true
    })
end
