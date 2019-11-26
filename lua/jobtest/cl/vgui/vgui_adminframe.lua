local FRAME = {}

-- Desc: Builds the toggle panel
function FRAME:BuildTogglePnl()
    -- build and dock this pnl
    local pnl = vgui.Create('DPanel', self)

    pnl.Paint = jobtest.derma.outline

    pnl.buildButtons = function(self)
        local w = pnl:GetWide()
        local wTo = w/8

        pnl.collpase_btn = jobtest.derma.button(pnl, '<',
        function(self)
            if not self.collapsed then
                self.collapsed = true
                pnl:SizeTo(wTo, self:GetTall(), 0.2, 0, -1, function()
                    self.text = '>' end) 
            else
                self.collapsed = false
                pnl:SizeTo(w, self:GetTall(), 0.2, 0, -1, function()
                    self.text = '<' end) 
            end
        end)
        pnl.collpase_btn:Dock(RIGHT)
        pnl.collpase_btn:InvalidateParent(true)
        pnl.collpase_btn:SetWide(pnl:GetWide()/8)
    end

    return pnl
end

-- Desc: Builds the main panel
function FRAME:BuildMainPnl()
    -- build and dock this pnl
    local pnl = vgui.Create('DPanel', self)
    local mgn = ScreenScale(3)
    pnl.Paint = jobtest.derma.outline

    return pnl
end

-- Desc: Inits the Admin Frame
function FRAME:Init()
    self:SetSize(ScrW()/2, ScrH() * 2/3)
    self:Center()
    self:MakePopup()
    self:SetTitle('')
    self:DockPadding(0,ScreenScale(10),0,0)

    local mgn = ScreenScale(3) -- margin

    -- main panel
    self.main_pnl = self:BuildMainPnl()
    self.main_pnl:DockMargin(mgn,mgn,mgn,mgn)
    self.main_pnl:Dock(FILL)
    self.main_pnl:InvalidateParent(true)

    -- toggle panel
    self.toggle_pnl = self:BuildTogglePnl()
    self.toggle_pnl:DockMargin(mgn,mgn,0,mgn) -- 0 on the right for even spacing
    self.toggle_pnl:Dock(LEFT)
    self.toggle_pnl:InvalidateParent(true)
    self.toggle_pnl:SetWide(self:GetWide()/4)
    self.toggle_pnl.buildButtons()

    self.Paint = jobtest.derma.outline
end

vgui.Register('JobtestAdminFrame', FRAME, 'DFrame')

concommand.Add('jobtestadminframe', function()
        vgui.Create('JobtestAdminFrame') end)
