local theme = jobtest:VguiTheme()

local TOPPANEL = { }
local TOGGLEPANEL = { }
local FRAME = { }
local EDITTESTPANEL = { }
local CREATETESTPANEL = { }
local REMOVETESTPANEL = { }


--[[
Desc: Inits the edit test panel
]]
function EDITTESTPANEL:Init( )
    self.name = 'Edit Test'
end

vgui.Register( 'JobTestEditTestPanel', EDITTESTPANEL, 'DPanel' )

--[[
Desc: Inits the create test panel
]]
function CREATETESTPANEL:Init( )
    self:Hide()
    self.name = 'Create Test'
end

vgui.Register( 'JobTestCreateTestPanel', CREATETESTPANEL, 'DPanel' )

--[[
Desc: Inits the remove test panel
]]
function REMOVETESTPANEL:Init( )
    self:Hide()
    self.name = 'Remove Test'
end

vgui.Register( 'JobTestRemoveTestPanel', REMOVETESTPANEL, 'DPanel' )

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
function TOGGLEPANEL:Init( )
    local parent = self:GetParent()
    local this = self

    self:Dock( LEFT )
    self:InvalidateParent( true )
    self:SetWide( parent:GetWide() / 5 )
    self.origW = self:GetWide()

    self.pnls = { 
        edit_test = vgui.Create( 'JobTestEditTestPanel', parent ), -- open on init
        create_test = vgui.Create( 'JobTestCreateTestPanel', parent ), -- hidden on init
        remove_test = vgui.Create( 'JobTestRemoveTestPanel', parent ) -- hidden on init
    }

    for _, pnl in pairs( self.pnls ) do
        pnl:Dock( FILL )
        pnl:InvalidateLayout( true )

        pnl.Paint = function( self, w, h )
            surface.SetDrawColor( theme.main )
            surface.DrawRect( 0, 0, w, h )

            draw.SimpleText( pnl.name, 'jobtest_10b', w / 2, parent.pad, theme.text,
                TEXT_ALIGN_CENTER )
        end
        -- pnl:Populate()
    end

    self.btns = { }
    self.btns.edit_test = jobtest:VguiButton( 'Edit Test', self, TOP, true, function()
        self:Toggle( 'edit_test' )
    end )
    self.btns.create_test = jobtest:VguiButton( 'Create Test', self, TOP, true, function()
        self:Toggle( 'create_test' )
    end )
    self.btns.remove_test = jobtest:VguiButton( 'Remove Test', self, TOP, true, function()
        self:Toggle( 'remove_test' )
    end )
    
    for _, btn in pairs( self.btns ) do
        btn:SetTall( self:GetTall() / 8 )
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

        self.inW = self:GetWide() / 7 

        moveBtn.DoClick = function( self )
            local t = 0.6
            if ( this._in ) then
                this:SizeTo( this.origW, -1, t, 0, -1, function() moveBtn.txt = '<' end )
                moveBtn:MoveTo( this.origW - moveBtn:GetWide() - parent.pad, moveBtn.y, t )

                for _, btn in pairs( this.btns ) do
                    btn:Show() end

                if ( not parent.open_pnl ) then this._in = not this._in return end
                -- resize children of focussed panel
                for _, child in pairs( parent.open_pnl:GetChildren() ) do
                    child:SizeTo( child:GetWide() - this.origW, -1, t ) end
            else
                this:SizeTo( this.inW, -1, t, 0, -1, function() 
                    for _, btn in pairs( this.btns ) do
                        btn:Hide() end
                    moveBtn.txt = '>'
                end )
                moveBtn:MoveTo( parent.pad, moveBtn.y, t )

                if ( not parent.open_pnl ) then this._in = not this._in return end
                -- resize children of focussed panel
                for _, child in pairs( parent.open_pnl:GetChildren() ) do
                    child:SizeTo( child:GetWide() + this.origW, -1, t ) end
            end
        end
    end )
end

--[[
Desc: Toggles the panel at given index
Args: String i
]]
function TOGGLEPANEL:Toggle( i )
    for _, pnl in pairs( self.pnls ) do
        pnl:Hide() end

    self.pnls[i]:Show()
end


--[[
    Desc: Paints the top panel
    Args: Number w, Number h
]]
function TOGGLEPANEL:Paint( w, h )
    surface.SetDrawColor( theme.background )
    surface.DrawRect( 0, 0, w, h )

    surface.SetDrawColor( theme.outline )
    surface.DrawOutlinedRect( 0, 0, w, h )
    -- hide the top line
    surface.SetDrawColor( theme.background )
    surface.DrawLine( 1, 0, w-1, 0 )
end

vgui.Register( 'JobTestCreateToggelPanel', TOGGLEPANEL, 'DPanel' )

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
    self.open_pnl = nil

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
