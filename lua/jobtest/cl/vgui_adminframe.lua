local FRAME = {}

-- Args: Panel self, Num width, Num height
-- Desc: Draws outlines around panels, dev function
local function outline(self, w, h)
    surface.SetDrawColor(255,255,255)
    surface.DrawRect(0,0,w,h)
    surface.SetDrawColor(0,0,0)
    surface.DrawOutlinedRect(0,0,w,h)
end

-- Desc: Builds the toggle panel
function FRAME:BuildTogglePnl()
    local pnl = vgui.Create('DPanel', self)
    pnl:DockMargin(5,5,5,5)
    pnl:Dock(LEFT)
    pnl:InvalidateParent(true)
    pnl:SetWide(self:GetWide()/4)

    pnl.Paint = outline

    return pnl
end

-- Desc: Builds the main panel
function FRAME:BuildMainPnl()
    local pnl = vgui.Create('DPanel', self)
    pnl:DockMargin(5,5,5,5)
    pnl:Dock(FILL)
    pnl:InvalidateParent(true)

    pnl.Paint = outline

    return pnl
end

-- Desc: Inits the Admin Frame
function FRAME:Init()
    self:SetSize(ScrW()/2, ScrH() * 2/3)
    self:Center()
    self:MakePopup()
    self:SetTitle('')
    self:DockPadding(0,0,0,0)

    self.main_pnl = self:BuildMainPnl()
    self.toggle_pnl = self:BuildTogglePnl()

    self.Paint = outline
end

vgui.Register('JobtestAdminFrame', FRAME, 'DFrame')

concommand.Add('jobtestadminframe', function()
        vgui.Create('JobtestAdminFrame') end)
