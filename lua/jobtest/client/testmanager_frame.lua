local LEFTPANEL = { }
local RIGHTPANEL = { }
local FRAME = { }

--[[
Desc: Initializes the test manager selection panel
]]
function LEFTPANEL:Init( )
    local parent = self:GetParent()

    self:Dock( LEFT )
    self:InvalidateParent( true )
    self:SetWide( ( parent:GetWide() / 2 ) - 5 )
end

vgui.Register( 'JobTestManagerSelectionPanel', LEFTPANEL, 'DPanel' )

--[[
Desc: Initializes the test manager editor panel
]]
function RIGHTPANEL:Init( )
    local parent = self:GetParent()

    self:Dock( LEFT )
    self:InvalidateParent( true )
    self:SetWide( ( parent:GetWide() / 2 ) - 5 )
end

vgui.Register( 'JobTestManagerEditorPanel', RIGHTPANEL, 'DPanel' )

--[[
Desc: Initializes the test manager frame
]]
function FRAME:Init( )
    self:SetSize( 800, 600 )
    self:Center()
    self:SetTitle( 'Job Test Manager' )
    self:MakePopup()

    self.leftpnl = vgui.Create( 'JobTestManagerEditorPanel', self )
    self.rightpnl = vgui.Create( 'JobTestManagerSelectionPanel', self )
end

vgui.Register( 'JobTestManagerFrame', FRAME, 'DFrame' )

concommand.Add( 'opentestmanager', function()
    vgui.Create( 'JobTestManagerFrame' )
end )

print( 'hey!' )