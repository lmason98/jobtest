local FRAME = { }

--[[
Desc: Initializes the test manager frame
]]
function FRAME:Init( )
    self:SetSize( 600, 500 )
    self:Center()
    self:SetTitle( 'Job Test Manager' )
end

vgui.Register( 'JobTestManagerFrame', FRAME, 'DFrame' )

concommand.Add( 'opentestmanager', function()
    vgui.Create( 'JobTestManagerFrame' )
end )

print( 'hey!' )