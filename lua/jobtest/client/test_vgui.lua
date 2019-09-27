local theme = jobtest:VguiTheme()

local FRAME = { }
local TESTPNL = { }
local QPNL = { }

--[[
    Desc: Inits the question panel
]]
function QPNL:Init( )
    self.p = 10
    self.btns = { }
    self.selectedIndex = 0
    self.fontB = 'jobtest_8b'
    self.font = 'jobtest_6'
end

--[[ 
    Args: Question q
    Desc: Set's the question of the panel
]]
function QPNL:SetQ( q )
    local parent = self:GetParent()
    local totalH = 0
    local _, textH = 0, 0
    self.q = q
    self.radBtns = { }

    totalH = jobtest:GetTextH( self.fontB, q:GetQString(), self:GetWide() - self.p * 3 ) + self.p

    surface.SetFont( self.font )

    for i = 1, #q.choices do
        local textH = jobtest:GetTextH( self.font, q:GetChoice( i ),
            self:GetWide() - self.p * 3 )

        local radBtn = vgui.Create( 'DCheckBox', self )
        radBtn:SetSize( ScreenScale( 5 ), ScreenScale( 5 ) )
        radBtn:SetPos( self.p, totalH + self.p * 1.2 )

        radBtn.Paint = function( btn, w, h )
            surface.SetDrawColor( theme.btn )
            surface.DrawRect( 0, 0, w, h )

            local selectedCol = theme.btn

            if ( btn:GetChecked() ) then
                selectedCol = theme.btndown
            elseif ( btn:IsHovered() ) then
                selectedCol = theme.focused
            end

            surface.SetDrawColor( selectedCol )
            surface.DrawRect( 3, 3, w - 6, h - 6 )
            surface.SetDrawColor( theme.outline )
            surface.DrawOutlinedRect( 0, 0, w, h )
        end

        -- radio btn functionality
        radBtn.DoClick = function()
            for i = 1, #self.radBtns do
                self.radBtns[i]:SetValue( false ) end

            self.selectedIndex = i
            self.radBtns[i]:SetValue( true )
            self.q:SetSelected( i )
        end

        self.radBtns[i] = radBtn

        totalH = totalH + textH + self.p --* 5 is padding
    end

    self.origW = self:GetWide()
    self.origH = totalH
    self:SetTall( totalH + self.p )
end

--[[ 
    Args: Number w, Number h 
    Desc: Paints the question panel
]]
function QPNL:Paint( w, h )
    surface.SetDrawColor( theme.main )
    surface.DrawRect( 0, 0, w, h )

    surface.SetDrawColor( theme.outline )
    surface.DrawOutlinedRect( 0, 0, w, h )

    if ( self.q ) then
        local yPos = self.p
        local w = self:GetWide() - self.p * 3

<<<<<<< HEAD
        draw.DrawText( DarkRP.textWrap( self.q:GetQString(), self.fontB, w ),
            self.fontB, self.p, yPos, theme.textSelected )
        yPos = yPos + jobtest:GetTextH( self.fontB, self.q:GetQString(), w ) + self.p
=======
        surface.SetFont( self.fontB )
        local _, textH = surface.GetTextSize( self.q:GetQString() )

        draw.SimpleText( self.q:GetQString(), self.fontB, self.p, yPos,
            theme.textSelected )
        yPos = yPos + textH + self.p
>>>>>>> 2cb33f2c9edc5f7e05d42ef073d800fb9efbe542

        surface.SetFont( self.font )
        _, textH = surface.GetTextSize( self.q:GetChoice( 1 ) )

        for i = 1, #self.q.choices do
            local txt = DarkRP.textWrap( self.q:GetChoice( i ), self.font,
                w - self.p * 3 )
            local newLineCount = #txt:Split( '\n' )

            draw.DrawText( txt, self.font, self.p * 3, yPos, theme.text )
            yPos = yPos + textH * newLineCount + self.p
        end
    end
end

vgui.Register( 'JobTestQuestionPanel', QPNL, 'DPanel' )

function TESTPNL:BuildCompleteBtn( )
    local base = vgui.Create( 'DPanel', self.scroll )
    base:Dock( TOP )
    base:InvalidateParent( true )
    base:SetTall( self:GetParent():GetTall() / 10 )

    -- hide the base panel
    base.Paint = function() end

    timer.Simple( 0, function()
        local cmplt = jobtest:VguiButton( 'Complete', base, function()
            if ( self:GetParent().test:IsComplete() ) then
                -- TODO: self:GetParent().test:Evaluate() 
                --* evaluate method will send test to server to be checked?
            end
        end )
        cmplt:SetSize( base:GetWide() / 2.5, base:GetTall() * ( 2 / 3 ) )
        cmplt:Center()
    end )
end

--[[ Desc: Inits the test panel ]]
function TESTPNL:Init( )
    local parent = self:GetParent()

    self.scroll = vgui.Create( 'DScrollPanel', self )
    self.scroll:Dock( FILL )
    self.scroll:InvalidateParent( true )
    self.scroll:GetCanvas():DockPadding( 5, 5, 5, 5 )

    self.scroll:GetCanvas().Paint = function( _, w, h )
        surface.SetDrawColor( theme.background )
        surface.DrawRect( 0, 0, w, h )
    end

    local sBar = self.scroll:GetVBar()
    sBar:SetWide( sBar:GetWide() / 2 )
    sBar.Paint = function( _, w, h )
        surface.SetDrawColor( theme.background )
        surface.DrawRect( 0, 0, w, h )
    end
    sBar.btnGrip.Paint = function( _, w, h )
        draw.RoundedBox( 2, 0, ScreenScale( 4 ),
            w, h - ScreenScale( 6 ), theme.outline )
        draw.RoundedBox( 2, 1, ScreenScale( 4 ) + 1,
            w - 2, h - ScreenScale( 6 ) - 2, theme.main )
    end
    sBar.btnUp.Paint = function() end
    sBar.btnDown.Paint = function() end

    self.qPnls = { }

    for i, question in pairs( parent:GetQs() ) do
        self.qPnls[i] = vgui.Create( 'JobTestQuestionPanel', self.scroll )
        self.qPnls[i]:Dock( TOP )
        self.qPnls[i]:DockMargin( 0, 0, 0, 5 )
        self.qPnls[i]:InvalidateParent( true )
        timer.Simple( 0, function() self.qPnls[i]:SetQ( question ) end )
    end

    self:BuildCompleteBtn()
end
vgui.Register( 'JobTestPanel', TESTPNL, 'DPanel' )

--[[ Desc: Inits the test frame ]]
function FRAME:Init( )
    self:SetWide( ScrW() * ( 1 / 3 ) )
    self:SetTall( ScrH() * ( 3 / 4 ) )
    self:Center()
    self:MakePopup()
    self:SetTitle( 'Jobtest' )
    self:DockPadding( 5, ScreenScale( 15 ), 5, 5 )
    self:InvalidateLayout( true )

    self.test = jobtest:Test( )

    self.testpnl = vgui.Create( 'JobTestPanel', self )
    self.testpnl:Dock( FILL )
end

--[[ Return: Table testQs ]]
function FRAME:GetQs( )
   return self.test.questions end

--[[
    Args: Number w, Number h
    Desc: Paints the vgui frame
]]
function FRAME:Paint( w, h )
    surface.SetDrawColor( theme.background )
    surface.DrawRect( 0, 0, w, h )
end

vgui.Register( 'JobTestFrame', FRAME, 'DFrame' )

concommand.Add( 'jobtestframe', function() vgui.Create( 'JobTestFrame' ) end )
