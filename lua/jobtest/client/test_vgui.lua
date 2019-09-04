local FRAME = { }
local TESTPNL = { }
local QPNL = { }

--[[ Desc: Inits the question panel ]]
function QPNL:Init( )
    self.p = 10
    self.btns = { }
    self.selectedIndex = 0
    self.fontB = 'jobtest_8b'
    self.font = 'jobtest_6'
end

--[[ Args: Question q
     Desc: Set's the question of the panel
]]
function QPNL:SetQ( q )
    local parent = self:GetParent()
    local totalH = 0
    local _, textH = 0, 0
    self.q = q

    --* Question text font
    surface.SetFont( self.fontB )
    _, textH = surface.GetTextSize( q:GetQString() )
    totalH = textH + self.p

    surface.SetFont( self.font )

    for i = 1, #q.choices do
        _, textH = surface.GetTextSize( q:GetChoice( i ) )
        totalH = totalH + textH + self.p --* 5 is padding
    end

    self:SetTall( totalH + self.p )

    -- for i = 1, #q.choices do
    --     local btn = vgui.Create( 'DButton', self )
    --     btn:SetTall( textH )
    --     btn:Dock( TOP )
    --     btn:InvalidateParent( true )
    --     btn:SetWide( 50 )
    --     self.btns[i] = btn
    -- end
end

--[[ Args: Number w, Number h 
     Desc: Paints the question panel
]]
function QPNL:Paint( w, h )
    surface.SetDrawColor( 255, 255, 255 )
    surface.DrawRect( 0, 0, w, h )

    if ( self.q ) then
        local yPos = self.p

        surface.SetFont( self.fontB )
        local _, textH = surface.GetTextSize( self.q:GetQString() )

        draw.SimpleText( self.q:GetQString(), self.fontB, self.p, yPos, Color( 0, 0, 0 ) )
        yPos = yPos + textH + self.p

        surface.SetFont( self.font )
        _, textH = surface.GetTextSize( self.q:GetChoice( 1 ) )

        for i = 1, #self.q.choices do
            draw.SimpleText( self.q:GetChoice( i ), self.font, self.p * 2.5, yPos, Color( 0, 0, 0 ) )
            yPos = yPos + textH + self.p
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

    -- self.scroll:GetCanvas().Paint = function( _, w, h )
    --     --TODO: Paint scroll panel
    -- end

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

vgui.Register( 'JobTestFrame', FRAME, 'DFrame' )

concommand.Add( 'jobtestframe', function() vgui.Create( 'JobTestFrame' ) end )