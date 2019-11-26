local FRAME = {}

function FRAME:Init() end

-- Desc: Builds the admin frame panels
function FRAME:BuildPanels()
    local mgn = ScreenScale(3) -- margin

    -- main panel
    self.main_pnl = vgui.Create('JobtestAdminMainPanel', self)
    self.main_pnl:DockMargin(mgn,mgn,mgn,mgn)
    self.main_pnl:Dock(FILL)
    self.main_pnl:InvalidateParent(true)

    -- toggle panel
    self.toggle_pnl = vgui.Create('JobtestAdminTogglePanel', self)
    self.toggle_pnl:DockMargin(mgn,mgn,0,mgn) -- 0 on the right for even spacing
    self.toggle_pnl:Dock(LEFT)
    self.toggle_pnl:InvalidateParent(true)
    self.toggle_pnl:SetWide(self:GetWide()/4)
    self.toggle_pnl:BuildButtons()

    self.Paint = jobtest.vgui.outline
end

vgui.Register('JobtestAdminFrame', FRAME, 'DFrame')

concommand.Add('jobtestadminframe', function()
    local frame = vgui.Create('JobtestAdminFrame')
    frame:SetSize(ScrW()/2, ScrH() * 2/3)
    frame:Center()
    frame:MakePopup()
    frame:SetTitle('')
    frame:DockPadding(0,ScreenScale(10),0,0)
    frame:BuildPanels()
end)
