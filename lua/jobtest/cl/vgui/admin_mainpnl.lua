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

    pnl.form[1].pnl.text = 'Question text'
    pnl.form[2].pnl.text = 'Choice 1'
    pnl.form[3].pnl.text = 'Choice 2'
    pnl.form[4].pnl.text = 'Choice 3'
    pnl.form[5].pnl.text = 'Choice 4'
    pnl.form[6].pnl.text = 'Answer number'

    pnl.remove_btn = jobtest.vgui.button(pnl, 'Remove this Question',
    function(this)
        -- slide out animation
        local posX, posY = pnl:GetPos()
        pnl:MoveTo(self:GetWide(), posY, 0.2, 0, -1, function() 
            print(' removing self.questions[' .. pnl.i .. ']')
            table.remove(self.questions, pnl.i)
            local i = 1 -- make sure panel indicies are correct
            for _, q in ipairs(self.questions) do
                if IsValid(q) then
                    q.i = i
                    i = i + 1
                end
            end
            PrintTable(self.questions)
            pnl:Remove()
        end)
    end)
    pnl.remove_btn:DockMargin(0,ScreenScale(1),0,0)
    pnl.remove_btn:Dock(TOP)
    pnl.remove_btn:InvalidateParent(true)
    pnl.remove_btn:SetTall(ScreenScale(8))
    table.insert(pnl.form, {pnl=pnl.remove_btn})

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
    pnl.collpase_btn = jobtest.vgui.button(pnl, '/\\',
    function(this) -- collapse animation
        local h = pnl.oldHeight or pnl:GetTall()
        local hTo = ScreenScale(8) + self.pad * 2

        if not this.collapsed then
            pnl.oldHeight = pnl:GetTall()
            this.collapsed = true
            pnl:SizeTo(pnl:GetWide(), hTo, 0.2, 0, -1, function()
                local txt = pnl.form[1].entry:GetValue()
                if txt == '' or txt == ' ' then
                    txt = 'Blank Question Text' end

                this.text = txt
                pnl:hideForm()
            end) 
        else
            this.collapsed = false
            pnl:SizeTo(pnl:GetWide(), h, 0.2, 0, -1, function()
                this.text = '/\\'
                pnl:hideForm()
            end) 
        end
    end)
    pnl.collpase_btn:DockMargin(0,0,0,0)
    pnl.collpase_btn:Dock(BOTTOM)
    pnl.collpase_btn:InvalidateParent(true)
    pnl.collpase_btn:SetTall(ScreenScale(8))

    return pnl, height
end

-- Args: Int index
-- Desc: Returns the inputted form data from the i'th qForm
-- Return: Table data
function PANEL:GetQFormData(i)

end

-- Desc: Returns a table containing all the test data
-- Return: Table data
function PANEL:GetFormData()
end

-- Args: DPanel qForm 
-- Desc: Gets the height of the qForm
-- Return: Int height
function PANEL:GetQFormHeight(qForm)
    local height = 0

    for i, element in ipairs(qForm.form) do
        height = height + element.pnl:GetTall() + ScreenScale(1) end

    height = height + qForm.collpase_btn:GetTall()

    return height + self.pad * 2 + ScreenScale(1)
end

-- Desc: Builds the form for the selected test from the toggle panel, can edit name
-- and collapse questions here.
function PANEL:BuildForm()
    self.questions = {}
    
    self.test_name = jobtest.vgui.textEntry(self, 'Test Name')
    self.test_name:DockMargin(0,self.pad,0,0)
    self.test_name:Dock(TOP)
    self.test_name:InvalidateParent(true)

    self.add_question = jobtest.vgui.button(self, 'Add Question',
    function()
        local pnl, height = vgui.Create('DPanel', self)
        pnl:DockPadding(self.pad,self.pad,self.pad,self.pad)
        pnl:DockMargin(0,self.pad,0,0)
        pnl:Dock(TOP)
        pnl:InvalidateParent(true)

        pnl, height = self:BuildQForm(pnl)
        pnl:SetTall(self:GetQFormHeight(pnl))

        pnl.Paint = jobtest.vgui.outline

        pnl.i = table.insert(self.questions, pnl)
        print('\n')
        PrintTable(self.questions)
    end)
    self.add_question:DockMargin(0,self.pad,0,0)
    self.add_question:Dock(TOP)
    self.add_question:InvalidateParent(true)
end

-- Desc: Builds the questions to a given test to be edited or removed, have
-- to have a scroll panel here to hold all tests.
function PANEL:Init()
    self.scroll = vgui.Create('DScrollPanel', self)
    self.scroll:Dock(FILL)
    self.scroll:InvalidateParent(true)
    self.pad = ScreenScale(3)

    local vbar = self.scroll:GetVBar()
    vbar:SetWide(vbar:GetWide()*2/3)
end

-- Overwrite paint function
PANEL.Paint = jobtest.vgui.outline

vgui.Register('JobtestAdminMainPanel', PANEL, 'DPanel')
