local theme = jobtest:VguiTheme()

local FRAME = { }

--[[
    Desc: Inits the frame
]]
function FRAME:Init( )
    self:SetWide( ScrW() * ( 1 / 2 ) )
    self:SetTall( ScrH() * ( 4 / 5 ) )
    self:Center()
    self:MakePopup()
    self:SetTitle( '' )
end

--[[
    Desc: Paints the frame
    Args: Number w, Number h
]]
function FRAME:Paint( w, h )
    surface.SetDrawColor( theme.background )
    surface.DrawRect( 0, 0, w, h )
end

vgui.Register( 'JobTestCreateFrame', FRAME, 'DFrame' )

concommand.Add( 'jobtestcreateframe', function() vgui.Create( 'JobTestCreateFrame' ) end )
