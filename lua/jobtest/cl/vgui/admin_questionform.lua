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
end

-- Desc: Inits a question form panel
function questionForm:Init()
end


vui.Register('JobtestAdminQuestionForm', questionForm, 'DPanel')
