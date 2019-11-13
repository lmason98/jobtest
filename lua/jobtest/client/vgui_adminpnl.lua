-- parameterize dimensions for easy access
local dims = {
    main = {
        w = ScrW() / 2,
        h = ScrH() * (2/3),
        font = ''
    },
    test_select = {
        w = 1/3, -- 1/3rd the width of main
        tgl_btn_w = 1/8, -- 1/8th the width of this
        select_btn_h = 1/10, -- 1/10th the height of this
    },
    test_form = {
        header_h = 1/8 -- 1/6 of this
    }
}

local QuestionForm = {}
local TestForm = {}
local TestSelect = {}
local MainFrame = {}

--[[
Desc: 
]]
function QuestionForm:Init()
end

--[[
Desc: Inits the TestForm panel
]]
function TestForm:Init()
    self.p = self:GetParent()

    self.test = nil

    timer.Simple(0, function()

    local header_h = self:GetTall() * dims.test_form.header_h

    self.scroll = vgui.Create('DScrollPanel', self)
    self.scroll:Dock(FILL)
    self.scroll:InvalidateParent(true)
    self.scroll.Paint = function(s, w, h)
        surface.SetDrawColor(255,255,255)
        surface.DrawRect(0,0,w,h)
    end

    self.header = vgui.Create('DPanel', self)
    self.header:Dock(TOP)
    self.header:SetTall(header_h)
    self.header:InvalidateParent(true)

    self.footer = vgui.Create('DPanel', self)
    self.footer:Dock(BOTTOM)
    self.footer:SetTall(header_h)
    self.footer:InvalidateParent(true)

    self.header:Hide()
    self.scroll:Hide()
    self.footer:Hide()

    end)
end

--[[
Desc: Sets the test of the TestForm panel
]]
function TestForm:SetTest(test)
    self.header:Show() 
    print('height: ' .. self.header:GetTall())
    print('test:')
    PrintTable(test)

    self.test = test
end

--[[
Args: Number width, Number height 
Desc: Paints the TestForm panel
]]
function TestForm:Paint(w, h)
    if self.test == nil then
        draw.SimpleText('Select a test or create a new one.', 'jtest_12b', w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)  
    else
    end
end
vgui.Register('JobtestTestForm', TestForm, 'DPanel')

--[[
Desc: Inits the TestSelect panel
]]
function TestSelect:Init()
    self.p = self:GetParent()

    -- sort of hacky but dims are wrong otherwise.
    timer.Simple(0, function()

    local w = self.p:GetWide() * dims.test_select.w -- normal width
    local wTo = w * dims.test_select.tgl_btn_w -- collapse width
    local btnH = self:GetTall() * dims.test_select.select_btn_h -- toggle btn height

    self:SetWide(w)
    self.collapsed = false

    self.collapseBtn = jobtest:VguiBtn(self, RIGHT, '<', 'jtest_15b',
        function(this)
        if not self.collapsed then
            self:SizeTo(wTo, self:GetTall(), 0.2, 0, -1,
                function() this.text = '>' end)

            self.collapsed = true
        else
            self:SizeTo(w, self:GetTall(), 0.2, 0, -1,
                function() this.text = '<' end)

            self.collapsed = false
        end
    end, dims.test_select.tgl_btn_w)

    self.scroll = vgui.Create('DScrollPanel', self)
    self.scroll:Dock(FILL)
    self.scroll:InvalidateParent(true)
    self.scroll:GetVBar():SetWide(0) -- people can scroll

    self.createBtn = jobtest:VguiBtn(self.scroll, TOP, 'Create New Test', 'jtest_12b',
        function(this)
            -- pass
        end, btnH)

    self.selectBtns = {}

    for i, test in pairs(jobtest.tests) do
        local selectTest = jobtest:VguiBtn(self.scroll, TOP, test.name, 'jtest_12b',
        function(this)
            self.p.test_form:SetTest(test)            
        end, btnH)

        print(selectTest)
        print(selectTest:GetWide())
        print(selectTest:GetTall())
        print(btnH)

        table.insert(self.selectBtns, selectTest)
    end

    end)
end

--[[
Args: Number width, Number height 
Desc: Paints the TestSelect panel
]]
function TestSelect:Paint(w, h)
    w = w - (w * dims.test_select.tgl_btn_w)

    surface.SetDrawColor(255,255,255)
    surface.DrawRect(0,0,w+1,h)
end
vgui.Register('JobtestTestSelect', TestSelect, 'DPanel')


--[[
Desc: Inits the Main Admin frame.
]]
function MainFrame:Init()
    self:SetWide(dims.main.w)
    self:SetHeight(dims.main.h)
    self:SetTitle('')
    self:Center()
    self:MakePopup()

    self:InvalidateLayout(true)
    self.test_form = vgui.Create('JobtestTestForm', self)
    self.test_form:Dock(FILL)
    self.test_form:InvalidateParent(true)

    self:InvalidateLayout(true)
    self.test_select = vgui.Create('JobtestTestSelect', self)
    self.test_select:Dock(LEFT)
    self.test_select:InvalidateParent(true)
end
vgui.Register('JobtestAdminMainFrame', MainFrame, 'DFrame')

-- remove later
concommand.Add('jobtestadminframe', function() vgui.Create('JobtestAdminMainFrame') end)
