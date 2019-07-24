--[[
Desc: Returns the enabled theme in the config file
Return: Table theme
]]
function jobtest:VguiTheme( )
    for i, theme in pairs( jobtest.cfg.themes ) do
        if ( theme.enabled ) then
            return theme end
    end
end

local theme = jobtest:VguiTheme()

--[[
Args: String text, DPanel parent, Number dock, Function doClick
Desc: Creates a vgui button
]]
function jobtest:VguiButton( text, parent, dock, doClick )
    local btn = vgui.Create( 'DButton', parent )
    btn:SetTall( 30 )

    if ( dock == BOTTOM ) then
        btn:DockMargin( 10, 0, 10, 10 )
    else
        btn:DockMargin( 10, 10, 10, 0 )
    end

    btn:Dock( dock )
    btn:InvalidateParent( true )
    btn:SetText( text )

    function btn:PaintOver( w, h )
        local col = theme.main
        local textCol = theme.text

        if ( btn:IsDown() ) then
            col = theme.btndown
            textCol = theme.textselected
        elseif ( btn:IsHovered() ) then
            textCol = theme.textselected
        end

        surface.SetDrawColor( col )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( theme.outline )
        surface.DrawOutlinedRect( 0, 0, w, h )

        draw.SimpleText( self:GetText(), 'jobtest_7b', w / 2, h / 2, textCol,
            TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    function btn:DoClick()
        doClick() end
end

--[[
Args: 
Desc:
]]
function jobtest:VguiTextForm( )
end