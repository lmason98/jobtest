local frame = {}

-- Desc: Inits the jobtest admin frame, allows admins to add/edit/remove tests.
function frame:Init()
    self.mgn = ScreenScale(3)
    self.main_pad = ScreenScale(3)
end

-- Desc: Builds the admin frame panels
function frame:BuildPanels()
    -- main panel
    self.main_pnl = vgui.Create('JobtestAdminMainPanel', self)
    self.main_pnl:DockMargin(self.mgn,self.mgn,self.mgn,self.mgn)
    self.main_pnl:DockPadding(self.main_pad,self.main_pad,self.main_pad,self.main_pad)
    self.main_pnl:Dock(FILL)
    self.main_pnl:InvalidateParent(true)
    self.main_pnl:BuildForm()

    -- toggle panel
    self.toggle_pnl = vgui.Create('JobtestAdminTogglePanel', self)
    self.toggle_pnl:DockMargin(self.mgn,self.mgn,0,self.mgn) -- 0 on the right for even spacing
    self.toggle_pnl:Dock(LEFT)
    self.toggle_pnl:InvalidateParent(true)
    self.toggle_pnl:SetWide(self:GetWide()/4)
    self.toggle_pnl:BuildButtons()

    self.Paint = jobtest.vgui.outline
end

vgui.Register('JobtestAdminFrame', frame, 'DFrame')

concommand.Add('jobtestadminframe', function()
    local frame = vgui.Create('JobtestAdminFrame')
    frame:SetSize(ScrW()/2, ScrH() * 2/3)
    frame:Center()
    frame:MakePopup()
    frame:SetTitle('')
    frame:DockPadding(0,ScreenScale(10),0,0) -- give top some padding for title and close button
    frame:BuildPanels()
end)
