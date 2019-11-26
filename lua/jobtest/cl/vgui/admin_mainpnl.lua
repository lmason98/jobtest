local PANEL = {}

-- Args: DPanel pnl
-- Desc: Builds a collapsable question form, can edit question attributes here.
-- Return: DPanel pnl
function PANEL:BuildQForm(pnl)
    local height = 0
    pnl.form = {}

    for i = 1,6 do
        local entryPnl, entry = jobtest.vgui.textEntry(pnl, 'blah', function() end)
        entryPnl:DockMargin(0,ScreenScale(1),0,0)
        entryPnl:Dock(TOP)
        entryPnl:InvalidateParent(true)
        entryPnl:SetTall(ScreenScale(8))
        table.insert(pnl.form, {pnl=entryPnl, entry=entry})
    end

    -- for collapse anim
    pnl.hidden = false
    pnl.hideForm = function(self)
        if not pnl.hidden then
            for i, form in ipairs(pnl.form) do
                form.pnl:Hide()
            end
            pnl.hidden = true 
        else
            for i, form in ipairs(pnl.form) do
                form.pnl:Show()
            end
            pnl.hidden = false 
        end
    end

    -- collapses the test edit pnl up and down
    pnl.collpase_btn = jobtest.vgui.button(pnl, '<',
    function(this) -- collapse animation
        local h = pnl.oldHeight or pnl:GetTall()
        local hTo = ScreenScale(8) + self.pad * 2

        if not this.collapsed then
            pnl.oldHeight = pnl:GetTall()
            this.collapsed = true
            pnl:SizeTo(pnl:GetWide(), hTo, 0.2, 0, -1, function()
                this.text = '>'
                pnl:hideForm()
            end) 
        else
            this.collapsed = false
            pnl:SizeTo(pnl:GetWide(), h, 0.2, 0, -1, function()
                this.text = '<'
                pnl:hideForm()
            end) 
        end
    end)
    pnl.collpase_btn:DockMargin(0,ScreenScale(1),0,0)
    pnl.collpase_btn:Dock(BOTTOM)
    pnl.collpase_btn:InvalidateParent(true)
    pnl.collpase_btn:SetTall(ScreenScale(8))

    return pnl, height
end

function PANEL:GetQFormHeight(pnl)
    local height = 0

    for i, element in ipairs(pnl.form) do
        height = height + element.pnl:GetTall() + ScreenScale(1) end

    height = height + pnl.collpase_btn:GetTall() + ScreenScale(1)

    return height + self.pad * 2 + ScreenScale(1)
end

-- Desc: Builds the form for the selected test from the toggle panel, can edit name
-- and collapse questions here.
function PANEL:BuildForm()
    -- test name
    -- questions
    self.questions = {}
    for i = 1,10 do
        local pnl, height = vgui.Create('DPanel', self)
        pnl:DockPadding(self.pad,self.pad,self.pad,self.pad)
        pnl:DockMargin(0,self.pad,0,0)
        pnl:Dock(TOP)
        pnl:InvalidateParent(true)

        pnl, height = self:BuildQForm(pnl)
        pnl:SetTall(self:GetQFormHeight(pnl))

        pnl.Paint = jobtest.vgui.outline

        self.scroll:AddItem(pnl)
        table.insert(self.questions, pnl)
    end
end

-- Desc: Builds the questions to a given test to be edited or removed, have
-- to have a scroll panel here to hold all tests.
function PANEL:Init()
    self.scroll = vgui.Create('DScrollPanel', self)
    self.scroll:Dock(FILL)
    self.scroll:InvalidateParent(true)
    self.pad = ScreenScale(3)

    local vbar = self.scroll:GetVBar()
end

-- Overwrite paint function
PANEL.Paint = jobtest.vgui.outline

vgui.Register('JobtestAdminMainPanel', PANEL, 'DPanel')
