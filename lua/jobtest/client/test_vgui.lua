local FRAME = { }
local TESTPNL = { }
local QPNL = { }

--[[ Desc: Inits the question panel ]]
function QPNL:Init( )
    local parent = self:GetParent()
end

--[[ Args: Number w, Number h 
     Desc: Paints the question panel
]]
-- function QPNL:Paint( w, h )
--     --TODO: Paint qPnl
-- end

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
        self.qPnls[i]:SetTall( parent:GetTall() * ( 1 / 5 ) )
    end
end
vgui.Register( 'JobTestPanel', TESTPNL, 'DPanel' )

--[[ Desc: Inits the test frame ]]
function FRAME:Init( )
    self:SetWide( ScrW() * ( 1.5 / 3 ) )
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