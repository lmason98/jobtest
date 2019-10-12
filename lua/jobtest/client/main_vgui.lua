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
    Args: String font, String str, Number maxW 
    Desc: Gets the text height of a wrapped multi-line string
    Return: Number textH
]]
function jobtest:GetTextH( font, str, maxW )
    surface.SetFont( font )

    local _, textH = surface.GetTextSize( str )
    local fitStr = DarkRP.textWrap( str, font, maxW )
    local newLCount = #fitStr:Split( '\n' )

    return textH * newLCount + ( 2.5 * newLCount )
end

--[[
Args: String text, DPanel parent, Function doClick, Number dock
Desc: Creates a vgui button
Return: DButton btn
]]
function jobtest:VguiButton( text, parent, doClick, dock  )
    local btn = vgui.Create( 'DButton', parent )
    btn:SetTall( 30 )

    if ( dock ) then
        if ( dock == BOTTOM ) then
            btn:DockMargin( 10, 0, 10, 10 )
        else
            btn:DockMargin( 10, 10, 10, 0 )
        end

        btn:Dock( dock )
        btn:InvalidateParent( true )
    end

    btn._font = 'jobtest_10b'

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

        draw.SimpleText( self:GetText(), self._font, w / 2, h / 2, textCol,
            TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    function btn:DoClick()
        doClick() end

    return btn
end

--[[
Args: String text, DPanel parent, Function onEnter
Desc: Creates a vgui text entry
]]
function jobtest:VguiTextEntry( text, parent, onEnter )
    local txtEntry = vgui.Create( 'DTextEntry', parent )
    txtEntry:SetTall( 30 )
    txtEntry:DockMargin( 10, 10, 10, 0 )
    txtEntry:Dock( TOP )
    txtEntry:InvalidateParent( true )
    txtEntry:SetText( text )
    txtEntry:SetFont( 'jobtest_7' )

    function txtEntry:Paint( w, h )
        local col = theme.main
        local textCol = theme.text

        if ( self:IsHovered() ) then
            col = theme.focused
        elseif ( self:IsEditing() ) then
            col = theme.btndown
            textCol = theme.textselected
        end

        surface.SetDrawColor( col )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( theme.outline )
        surface.DrawOutlinedRect( 0, 0, w, h )

        self:DrawTextEntryText( textCol, Color( 255, 255, 255, 50 ),
            textCol )
    end

    function txtEntry:OnEnter( )
        onEnter( txtEntry:GetValue() ) end
end

--[[
    Args: DElement element, Number factor, Function cbEnter, cbExit
    Desc: Animates the derma element (grow shrink on hover)
]]
function jobtest:AnimateDElement( element, f, cbEnter, cbExit )
    local origX, origY = element:GetPos()
    local origW, origH = element:GetSize()
    local t = 0.15

    local justMoved = false
    local cursorIn = false
    element.OnCursorEntered = function( ele )
        cursorIn = true
        if ( not justMoved ) then
            ele:SizeTo( origW * f, origH * f, t, 0, -1, cbEnter )
            ele:MoveTo( origX - ( origW * ( f - 1 ) / 2 ),
                origY - ( origH * ( f - 1 ) / 2 ), t )

            justMoved = true
            timer.Simple( t, function()
                justMoved = false
                if ( not cursorIn ) then
                    ele:OnCursorExited()
                end
            end )
        end
    end
    element.OnCursorExited = function( ele )
        cursorIn = false
        if ( not justMoved ) then
            ele:SizeTo( origW, origH, t, 0, -1, cbExit )
            ele:MoveTo( origX, origY, t )

            justMoved = true
            timer.Simple( t, function() justMoved = false end )
        end
    end
end
