local theme = jobtest:VguiTheme()

local TOPPANEL = { }
local TOGGELPANEL = { }
local FRAME = { }

--[[
    Desc: Inits the top panel
]]--
function TOPPANEL:Init( )
    local parent = self:GetParent()

    self:Dock( TOP )
    self:InvalidateParent( true )
    self:SetTall( parent:GetTall() / 8 )

    timer.Simple( 0, function()
        local closeBtn = vgui.Create( 'DButton', self )
        closeBtn:SetSize( ScreenScale( 6 ), ScreenScale( 6 ) )
        closeBtn:SetPos( self:GetWide() - closeBtn:GetWide() - parent.pad,
            closeBtn:GetTall() )
        closeBtn:SetText( 'X' )

        closeBtn.DoClick = function( self )
            parent:Remove()
        end

        jobtest:AnimateDElement( closeBtn, 3 / 2 )
    end )
end

--[[
    Desc: Paints the top panel
    Args: Number w, Number h
]]
function TOPPANEL:Paint( w, h )
    surface.SetDrawColor( theme.background )
    surface.DrawRect( 0, 0, w, h )

    surface.SetDrawColor( theme.outline )
    surface.DrawOutlinedRect( 0, 0, w, h )
end

vgui.Register( 'JobTestCreateTopPanel', TOPPANEL, 'DPanel' )

--[[
    Desc: Inits the toggel panel
]]
function TOGGELPANEL:Init( )
    local parent = self:GetParent()
    local this = self

    self:Dock( LEFT )
    self:InvalidateParent( true )
    self:SetWide( parent:GetWide() / 5 )
    self.origW = self:GetWide()

    local bsPnl = vgui.Create( 'DPanel', parent )
    bsPnl:Dock( FILL )
    bsPnl:InvalidateParent( true )

    bsPnl.Paint = function( self, w, h )
        surface.SetDrawColor( 100, 100, 100, 255 )
        surface.DrawRect( 0, 0, w, h )
    end

    timer.Simple( 0, function()
        self._in = false

        local moveBtn = vgui.Create( 'DButton', self )
        moveBtn:SetSize( self:GetWide() / 10, self:GetTall() / 10 )
        moveBtn:SetPos( self:GetWide() - moveBtn:GetWide() - parent.pad,
            self:GetTall() / 2 - moveBtn:GetTall() / 2 )
        moveBtn:SetText( '' )

        moveBtn.txt = '<'
        moveBtn.Paint = function( self, w, h )
            draw.SimpleText( self.txt, 'jobtest_11b', w / 2, h / 2, theme.text,
                TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        end

        moveBtn.DoClick = function( self )
            if ( this._in ) then
                moveBtn.txt = '<'
                this:SizeTo( this.origW, -1, 0.6 )
                moveBtn:MoveTo( this.origW - moveBtn:GetWide() - parent.pad, moveBtn.y, 0.6 )
            else
                moveBtn.txt = '>'
                this:SizeTo( this:GetWide() / 7, -1, 0.6 )
                moveBtn:MoveTo( parent.pad, moveBtn.y, 0.6 )
            end

            this._in = not this._in
        end
    end )
end

--[[
    Desc: Paints the top panel
    Args: Number w, Number h
]]
function TOGGELPANEL:Paint( w, h )
    surface.SetDrawColor( theme.background )
    surface.DrawRect( 0, 0, w, h )

    surface.SetDrawColor( theme.outline )
    surface.DrawOutlinedRect( 0, 0, w, h )
    -- hide the top line
    surface.SetDrawColor( theme.background )
    surface.DrawLine( 1, 0, w-1, 0 )
end

vgui.Register( 'JobTestCreateToggelPanel', TOGGELPANEL, 'DPanel' )

--[[
    Desc: Inits the frame
]]
function FRAME:Init( )
    self:SetWide( ScrW() * ( 2 / 3 ) )
    self:SetTall( ScrH() * ( 4 / 5 ) )
    self:Center()
    self:MakePopup()
    self:ShowCloseButton( false )
    self:SetTitle( '' )
    self:DockPadding( 0, 0, 0, 0 )
    self.pad = ScreenScale( 3 ) 

    self.top_pnl = vgui.Create( 'JobTestCreateTopPanel', self )
    self.toggle_pnl = vgui.Create( 'JobTestCreateToggelPanel', self )
end

--[[
    Desc: Paints the frame
    Args: Number w, Number h
]]
function FRAME:Paint( w, h )
    surface.SetDrawColor( theme.main )
    surface.DrawRect( 0, 0, w, h )

    surface.SetDrawColor( theme.outline )
    surface.DrawOutlinedRect( 0, 0, w, h )
end

vgui.Register( 'JobTestCreateFrame', FRAME, 'DFrame' )

concommand.Add( 'jobtestcreateframe', function() vgui.Create( 'JobTestCreateFrame' ) end )
