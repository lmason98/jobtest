local PANEL = {}

-- Desc: Builds a collapsable question form, can edit question attributes here.
function PANEL:BuildQuestionForm()
    --!!! left off here
end

-- Desc: Builds the form for the selected test from the toggle panel, can edit name
-- and collapse questions here.
function PANEL:BuildForm()
    -- test name
    -- questions
    
end

-- Desc: Builds the questions to a given test to be edited or removed, have
-- to have a scroll panel here to hold all tests.
function PANEL:Init()
    self.scroll = vgui.Create('DScrollPanel', self)
    self.scroll:Dock(FILL)
    self.scroll:InvalidateParent(true)

    local vbar = self.scroll:GetVBar()
end

-- Overwrite paint function
PANEL.Paint = jobtest.vgui.outline

vgui.Register('JobtestAdminMainPanel', PANEL, 'DPanel')
