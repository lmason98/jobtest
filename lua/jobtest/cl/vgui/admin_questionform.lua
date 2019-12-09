local questionForm = {}
-- Overwrite paint function
questionForm.Paint = jobtest.vgui.outline

function questionForm:BuildForm()
    local height = 0

    for i = 1,6 do
        local entryPnl, entry = jobtest.vgui.textEntry(self, 'blah', function() end)
        entryPnl:DockMargin(0,ScreenScale(1),0,0)
        entryPnl:Dock(TOP)
        entryPnl:InvalidateParent(true)
        entryPnl:SetTall(ScreenScale(8))
        entryPnl.text = self.text[i]
        table.insert(self.form, {pnl=entryPnl, entry=entry})
    end

<<<<<<< HEAD
    pnl.form[1].pnl.text = 'Question text'
    pnl.form[2].pnl.text = 'Choice 1'
    pnl.form[3].pnl.text = 'Choice 2'
    pnl.form[4].pnl.text = 'Choice 3'
    pnl.form[5].pnl.text = 'Choice 4'
    pnl.form[6].pnl.text = 'Answer number'
end

-- Args: DPanel questionForm 
-- Desc: Gets the height of the questionForm
-- Return: Num height
function questionForm:GetHeight()
=======
    self.remove_btn = jobtest.vgui.button(self, 'Remove this Question',
    function(this)
        -- slide out animation
        local posX, posY = self:GetPos()
        self:MoveTo(self:GetWide(), posY, 0.2, 0, -1, function() 
            print(' removing self.questions[' .. self.i .. ']')
            table.remove(self.questions, self.i)
            local i = 1 -- make sure panel indicies are correct
            for _, q in ipairs(self.questions) do
                if IsValid(q) then
                    q.i = i
                    i = i + 1
                end
            end
            PrintTable(self.questions)
            self:Remove()
        end)
    end)
    self.remove_btn:DockMargin(0,ScreenScale(1),0,0)
    self.remove_btn:Dock(TOP)
    self.remove_btn:InvalidateParent(true)
    self.remove_btn:SetTall(ScreenScale(8))
    table.insert(self.form, {self=self.remove_btn})

    -- for collapse anim
    self.hidden = false
    self.hideForm = function(self)
        if not self.hidden then
            for i, form in ipairs(self.form) do
                form.self:Hide()
            end
            self.hidden = true 
        else
            for i, form in ipairs(self.form) do
                form.self:Show()
            end
            self.hidden = false 
        end
    end

    -- collapses the test edit self up and down
    self.collpase_btn = jobtest.vgui.button(self, '/\\',
    function(this) -- collapse animation
        local h = self.oldHeight or self:GetTall()
        local hTo = ScreenScale(8) + self.pad * 2

        if not this.collapsed then
            self.oldHeight = self:GetTall()
            this.collapsed = true
            self:SizeTo(self:GetWide(), hTo, 0.2, 0, -1, function()
                local txt = self.form[1].entry:GetValue()
                if txt == '' or txt == ' ' then
                    txt = 'Blank Question Text' end

                this.text = txt
                self:hideForm()
            end) 
        else
            this.collapsed = false
            self:SizeTo(self:GetWide(), h, 0.2, 0, -1, function()
                this.text = '/\\'
                self:hideForm()
            end) 
        end
    end)
    self.collpase_btn:DockMargin(0,0,0,0)
    self.collpase_btn:Dock(BOTTOM)
    self.collpase_btn:InvalidateParent(true)
    self.collpase_btn:SetTall(ScreenScale(8))

    return height
end

-- Desc: Gets the height of the question panel
-- Return: Number height
function questionForm:GetHeight()
    local height = 0

    for i, element in ipairs(self.form) do
        print(' height: ' .. element.pnl:GetTall())
        height = height + element.pnl:GetTall() + ScreenScale(1) end

    height = height + qForm.collpase_btn:GetTall()

    return height + self.pad * 2 + ScreenScale(1)
>>>>>>> ccc4621d0c7002ced3ca3809a246d44ef059e4aa
end

-- Desc: Inits a question form panel
function questionForm:Init()
    self.form = {}
    self.text = {
        [1] = 'Question text',
        [2] = 'Choice 1',
        [3] = 'Choice 2',
        [4] = 'Choice 3',
        [5] = 'Choice 4',
        [6] = 'Answer Number'
    }
end


vgui.Register('JobtestAdminQuestionForm', questionForm, 'DPanel')
