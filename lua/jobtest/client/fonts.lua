--[[ Args: String name, Number scale, Bool bold
     Desc: Creates a new font to be used by the addon
]]
local function createFont( name, scale, bold )
    local weight = 500
    name = name .. '_' .. tostring( scale )

    if ( bold ) then
        weight = 800
        name = name .. 'b'
    end

    surface.CreateFont( name, {
        font = 'Roboto',
        size = ScreenScale( scale ),
        weight = weight,
        antialias = true
    } )
end

createFont( 'jobtest', 11, true )
createFont( 'jobtest', 10, true )
createFont( 'jobtest', 9, true )
createFont( 'jobtest', 9, false )
createFont( 'jobtest', 8, true )
createFont( 'jobtest', 7, true )
createFont( 'jobtest', 7, false )
createFont( 'jobtest', 6, false )
