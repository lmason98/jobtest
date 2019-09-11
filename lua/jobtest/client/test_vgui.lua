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

    -- calculating panel height
    surface.SetFont( self.fontB )
    _, textH = surface.GetTextSize( q:GetQString() )
    totalH = textH + self.p

    surface.SetFont( self.font )

    for i = 1, #q.choices do
        _, textH = surface.GetTextSize( q:GetChoice( i ) )
        local fitStr = DarkRP.textWrap( q:GetChoice( i ), self.font,
            self:GetWide() - self.p * 3 )
        local newLineCount = #fitStr:Split( '\n' )

        local radBtn = vgui.Create( 'DCheckBox', self )
        radBtn:SetSize( ScreenScale( 5 ), ScreenScale( 5 ) )
        radBtn:SetPos( self.p, totalH + self.p * 1.2 )

        -- TODO: radBtn paint
        -- radBtn.Paint = function( _, w, h )
        -- end

        -- radio btn functionality
        radBtn.DoClick = function()
            for i = 1, #self.radBtns do
                self.radBtns[i]:SetValue( false ) end

            self.selectedIndex = i
            self.radBtns[i]:SetValue( true )
        end

        self.radBtns[i] = radBtn

        totalH = totalH + ( textH * newLineCount ) + self.p --* 5 is padding

    end

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

        surface.SetFont( self.fontB )
        local _, textH = surface.GetTextSize( self.q:GetQString() )

        draw.SimpleText( self.q:GetQString(), self.fontB, self.p, yPos, theme.textSelected )
        yPos = yPos + textH + self.p

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
    sBar:SetWide( sBar:GetWide() / 3 )
    sBar.Paint = function( _, w, h )
        surface.SetDrawColor( theme.background )
        surface.DrawRect( 0, 0, w, h )
    end
    sBar.btnGrip.Paint = function( _, w, h )
        draw.RoundedBox( 8, 0, ScreenScale( 3 ),
            w, h - ScreenScale( 6 ), theme.outline )
        draw.RoundedBox( 8, 1, ScreenScale( 3 ) + 1,
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