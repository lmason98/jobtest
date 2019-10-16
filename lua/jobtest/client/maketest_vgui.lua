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
    local parent = self:GetParent()
    self:Hide()
    self.name = 'Create Test'
    self.forms = {}

    local testName = jobtest:VguiTextEntry( 'test name:', self, function( self )
        print( self:GetValue() ) end )

    local newQ = jobtest:VguiButton( 'Add Question', self, TOP, false, function( ) 
        self:CreateQPnl()
    end )
    newQ:DockMargin( parent.pad, parent.pad, parent.pad, parent.pad )
    newQ._font = 'jobtest_7b'

    local complete = jobtest:VguiButton( 'Complete', self, BOTTOM, false, function( )
        -- add form validation here
        -- have to write method on Test class to save created tests
    end )
    complete:Dock( BOTTOM )
    complete:DockMargin( parent.pad, parent.pad, parent.pad, parent.pad ) 

    self.qForm = vgui.Create( 'DScrollPanel', self )
    self.qForm:Dock( FILL )
    self.qForm:GetCanvas():DockPadding( 0, parent.pad, 0, parent.pad )
    self.qForm:InvalidateParent( true )
    self.qForm.Paint = function( self, w, h )
        surface.SetDrawColor( theme.outline )
        surface.DrawLine( 0, 0, w, 0 )
        surface.DrawLine( 0, h-1, w, h-1 )
    end

    local sBar = self.qForm:GetVBar()
    sBar:SetWide( sBar:GetWide() * ( 2 / 3 ) )
    sBar.Paint = function( _, w, h )
        surface.SetDrawColor( theme.main )
        surface.DrawRect( 0, 0, w, h )
        surface.SetDrawColor( theme.outline )
        surface.DrawLine( 0, 0, w, 0 )
        surface.DrawLine( 0, h-1, w, h-1 )
    end
    sBar.btnGrip.Paint = function( _, w, h )
        w = w * ( 3 / 5 )
        draw.RoundedBox( 4, 0, ScreenScale( 4 ),
            w, h - ScreenScale( 6 ), theme.outline )
        draw.RoundedBox( 4, 1, ScreenScale( 4 ) + 1,
            w - 2, h - ScreenScale( 6 ) - 2, theme.background )
    end
    sBar.btnUp.Paint = function() end
    sBar.btnDown.Paint = function() end
end

--[[
Desc: Creates a question form panel
Return: DPanel pnl
]]
function CREATETESTPANEL:CreateQPnl( )
    local parent = self:GetParent()
    local pnl = vgui.Create( 'DPanel', self.qForm:GetCanvas() )    
    pnl:Dock( TOP )
    pnl:DockMargin( parent.pad, 0, parent.pad, parent.pad ) 
    pnl:InvalidateParent( true )
    pnl:SetTall( pnl:GetTall() * ScreenScale( 4 ) ) 
    pnl.Paint = function() end

    local form = {
        [1] = { text='Question text:', numeric=false, data=nil },
        [2] = { text='Choice 1 text:', numeric=false, data=nil },
        [3] = { text='Choice 2 text:', numeric=false, data=nil },
        [4] = { text='Choice 3 text:', numeric=false, data=nil },
        [5] = { text='Choice 4 text:', numeric=false, data=nil },
        [6] = { text='Correct Choice Number:', numeric=true, data=nil }
    }

    for _, formEle in SortedPairs( form ) do
        print(_)
        local pnl, tEntry = jobtest:VguiTextEntry( formEle.text, pnl, function( self )
            formEle.data = self:GetValue() end ) -- data = text on enter        

        pnl:DockMargin( 0, 0, 0, parent.pad )
        tEntry:SetNumeric( formEle.numeric )
    end

    local removeQ = jobtest:VguiButton( 'Remove Question', pnl, TOP, false, function( self )
        pnl:Remove()
    end )
    removeQ:DockMargin( 0, 0, 0, parent.pad )
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
    local pad = self:GetTall() / 2 

    surface.SetDrawColor( theme.background )
    surface.DrawRect( 0, 0, w, h )

    surface.SetDrawColor( theme.outline )
    surface.DrawOutlinedRect( 0, 0, w, h )

    draw.SimpleText( 'Jobtest Config', 'jobtest_11b', pad, pad, theme.text,
        TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
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
    self:SetWide( ScrW() * ( 1 / 2 ) )
    self:SetTall( ScrH() * ( 3 / 4 ) )
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
