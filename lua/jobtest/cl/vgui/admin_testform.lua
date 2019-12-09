local testForm = {}

-- Args: Int index
-- Desc: Returns the inputted form data from the i'th qForm
-- Return: Table data
function testForm:GetQFormData(i)
end

-- Desc: Returns a table containing all the test data
-- Return: Table data
function testForm:GetFormData()
end

-- Desc: Builds the form for the selected test from the toggle panel, can edit name
-- and collapse questions here.
function testForm:BuildForm()
    self.test_name = jobtest.vgui.textEntry(self, 'Test Name')
    self.test_name:DockMargin(0,self.pad,0,0)
    self.test_name:Dock(TOP)
    self.test_name:InvalidateParent(true)

    self.add_question = jobtest.vgui.button(self, 'Add Question',
    function()
        local form = vgui.Create('JobtestAdminQuestionForm', self)
        form:DockPadding(self.pad,self.pad,self.pad,self.pad)
        form:DockMargin(0,self.pad,0,0)
        form:Dock(TOP)
        form:InvalidateParent(true)

        height = form:BuildForm()
        form:SetTall(100)
        form:GetHeight()
    end)
    self.add_question:DockMargin(0,self.pad,0,0)
    self.add_question:Dock(TOP)
    self.add_question:InvalidateParent(true)
end

-- Desc: Builds the questions to a given test to be edited or removed, have
-- to have a scroll panel here to hold all tests.
function testForm:Init()
    self.scroll = vgui.Create('DScrollPanel', self)
    self.scroll:Dock(FILL)
    self.scroll:InvalidateParent(true)
    self.pad = ScreenScale(3)

    local vbar = self.scroll:GetVBar()
    vbar:SetWide(vbar:GetWide() * 2/3)

    self.questions = {}
end

-- Overwrite paint function
testForm.Paint = jobtest.vgui.outline

vgui.Register('JobtestAdminMainPanel', testForm, 'DPanel')
