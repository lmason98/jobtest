local questionForm = {}

-- Overwrite paint function
questionForm.Paint = jobtest.vgui.outline

function questionForm:BuildForm()
    local height = 0
    self.form = {}

    for i = 1,6 do
        local entryPnl, entry = jobtest.vgui.textEntry(pnl, 'blah', function() end)
        entryPnl:DockMargin(0,ScreenScale(1),0,0)
        entryPnl:Dock(TOP)
        entryPnl:InvalidateParent(true)
        entryPnl:SetTall(ScreenScale(8))
        table.insert(self.form, {pnl=entryPnl, entry=entry})
    end

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
end

-- Desc: Inits a question form panel
function questionForm:Init()
end


vui.Register('JobtestAdminQuestionForm', questionForm, 'DPanel')
