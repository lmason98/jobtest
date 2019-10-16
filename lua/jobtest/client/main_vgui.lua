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
Args: String text, String font, Number maxW 
Desc: Gets the text height of a wrapped multi-line string
Return: Number textH
]]
function jobtest:GetTextH( text, font, maxW )
    surface.SetFont( font )

    local _, textH = surface.GetTextSize( text )
    local fitStr = DarkRP.textWrap( text, font, maxW )
    local newLCount = #fitStr:Split( '\n' )

    return textH * newLCount + ( 2.5 * newLCount )
end

--[[
Args: String text, String font 
Desc: Gets the length in pixels of the text
Return: Number textW
]]
function jobtest:GetTextW( text, font )
    surface.SetFont( font )
    local w, h = surface.GetTextSize( text )

    return w
end

--[[
Args: String text, DPanel parent, Number dock, Bool hideTopOutline, Function doClick
Desc: Creates a vgui button
Return: DButton btn
]]
function jobtest:VguiButton( text, parent, dock, hideTopOutline, doClick  )
    local btn = vgui.Create( 'DButton', parent )
    btn:SetTall( 30 )

    if ( dock ) then
        -- if ( dock == BOTTOM ) then
        --     btn:DockMargin( 10, 0, 10, 10 )
        -- else
        --     btn:DockMargin( 10, 10, 10, 0 )
        -- end

        btn:Dock( dock )
        btn:InvalidateParent( true )
    end

    btn._font = 'jobtest_9b'

    btn:SetText( text )

    function btn:PaintOver( w, h )
        local col = theme.btn
        local textCol = theme.text

        if ( btn:IsDown() ) then
            col = theme.btndown
            textCol = theme.textSelected
        elseif ( btn:IsHovered() ) then
            col = theme.focused
            textCol = theme.textSelected
        end

        surface.SetDrawColor( col )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( theme.outline )
        surface.DrawOutlinedRect( 0, 0, w, h )

        if ( hideTopOutline ) then
            surface.SetDrawColor( col )
            surface.DrawLine( 1, 0, self:GetWide() - 1, 0 )
        end

        draw.SimpleText( self:GetText(), self._font, w / 2, h / 2, textCol,
            TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

    function btn:DoClick()
        doClick() end

    return btn
end

--[[
Args: String text, DPanel parent, Function onEnter
Desc: Creates a vgui text entry accompanied by a dlabel
Return: DPanel pnl, DTextEntry tEntry, (tEntry parented to pnl)
]]
function jobtest:VguiTextEntry( text, parent, onEnter )
    local pad = ScreenScale( 3 )

    local pnl = vgui.Create( 'DPanel', parent )
    pnl:Dock( TOP )
    pnl:DockMargin( 10, 10, 10, 0 )
    pnl:SetTall( ScreenScale( 10 ) )

    local lbl = vgui.Create( 'DLabel', pnl )
    lbl:Dock( LEFT )
    lbl:SetWide( jobtest:GetTextW( text, 'jobtest_7b' ) + pad ) 
    lbl:SetText( '' )

    lbl.Paint = function( self, w, h )
        surface.SetDrawColor( theme.main )
        surface.DrawRect( 0, 0, w, h )

        draw.SimpleText( text, 'jobtest_7b', 0, h / 2, theme.text,
            TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    end

    local tEntry = vgui.Create( 'DTextEntry', pnl )
    tEntry:Dock( FILL )
    tEntry:SetText( '' )
    tEntry:SetFont( 'jobtest_7' )

    tEntry.Paint = function( self, w, h )
        local col = theme.btn

        if ( self:IsEditing() ) then
            col = theme.btndown
        elseif ( self:IsHovered() ) then
            col = theme.focused
        end

        surface.SetDrawColor( col )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( theme.outline )
        surface.DrawOutlinedRect( 0, 0, w, h )

        self:DrawTextEntryText( theme.text, Color( 255, 255, 255, 50 ),
            theme.text )
    end

    tEntry.OnEnter = onEnter

    return pnl, tEntry
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
