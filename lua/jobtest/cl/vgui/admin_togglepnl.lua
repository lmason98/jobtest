local PANEL = {}

-- Desc: Builds a scroll panel on top to hold all potential tests
function PANEL:Init()
    self.scroll = vgui.Create('DScrollPanel', self)
    self.scroll:Dock(FILL)
    self.scroll:InvalidateParent(true)

    local vbar = self.scroll:GetVBar()
    vbar:SetWide(0) -- hide the vertical bar, people can scroll here
end

-- Overwrite paint function
PANEL.Paint = jobtest.vgui.outline

-- Desc: Builds the test create and select buttons
function PANEL:BuildButtons()
    local w = self:GetWide()
    local wTo = w/8

    self.collpase_btn = jobtest.vgui.button(self, '<',
    function(this) -- collapse animation
        if not this.collapsed then
            this.collapsed = true
            self:SizeTo(wTo, this:GetTall(), 0.2, 0, -1, function()
                this.text = '>' end) 
        else
            this.collapsed = false
            self:SizeTo(w, this:GetTall(), 0.2, 0, -1, function()
                this.text = '<' end) 
        end
    end)
    self.collpase_btn:Dock(RIGHT)
    self.collpase_btn:InvalidateParent(true)
    self.collpase_btn:SetWide(self:GetWide()/8)

    for i = 1, 20 do
        local selectBtn = jobtest.vgui.button(self, tostring(i), function() end)
        selectBtn:Dock(TOP)
        selectBtn:InvalidateParent(true)
        selectBtn:SetTall(self:GetTall()/14)

        self.scroll:AddItem(selectBtn)
    end
end

vgui.Register('JobtestAdminTogglePanel', PANEL, 'DPanel')
