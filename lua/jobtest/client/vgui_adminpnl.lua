local dims = {
    main = {
        w = ScrW() / 2,
        h = ScrH() * (2/3),
        font = ''
    },
    togglepnl = {
        h = 1 / 8 -- 1/8 * dims.main.h
    }
}

local CreateTest = {}
local EditTest = {}
local RemoveTest = {}
local TogglePnl = {}
local MainFrame = {}

--[[
Desc: Inits the create test panel.
]]
function CreateTest:Init()
    local p = self:GetParent()

    self = jobtest:AdminPnl(self, p)
    self.test = jobtest:Test()
end
vgui.Register('JobtestCreatePnl', CreateTest, 'DPanel')
--[[
Desc: Inits the remove test panel.
]]
function EditTest:Init()
    local p = self:GetParent()
    
    self = jobtest:AdminPnl(self, p)
end
vgui.Register('JobtestEditPnl', EditTest, 'DPanel')
--[[
Desc: Inits the edit test panel.
]]
function RemoveTest:Init()
    local p = self:GetParent()
    
    self = jobtest:AdminPnl(self, p)
end
vgui.Register('JobtestRemovePnl', RemoveTest, 'DPanel')

--[[
Desc: Inits the toggle panel.
]]
function TogglePnl:Init()
    local p = self:GetParent()

    self:DockPadding(0,0,0,0)
    self:Dock(TOP)
    self:SetTall(p:GetTall() * dims.togglepnl.h)

    self:BuildBtns(p)
end

--[[
Args: DFrame parent
Desc: Builds the toggle buttons for the main frame panels
]]
function TogglePnl:BuildBtns(p)
    self.btns = {}

    local i = 0
    for k, pnlData in pairs(p.pnls) do
        i = i + 1

        local btn = vgui.Create('DButton', self)
        btn:Dock(LEFT)
        btn:SetText(pnlData.name)
        btn:SetWide((p:GetWide() / 3) + 1/2) -- fix rounding error?

        btn.DoClick = function(this) self:ShowPnl(p, k) end
    end
end

--[[
Args: DPanel parent, String name
Desc: Shows the panel with the passed name
]]
function TogglePnl:ShowPnl(p, name)
    for k, pnlData in pairs(p.pnls) do
        if k == name then
            for k, pnlData in pairs(p.pnls) do
                pnlData.pnl:Hide() end

            pnlData.pnl:Show()
            break
        end
    end
end
vgui.Register('JobtestTogglePnl', TogglePnl, 'DPanel')

--[[
Desc: Inits the Main Admin frame.
]]
function MainFrame:Init()
    self:SetWide(dims.main.w)
    self:SetHeight(dims.main.h)
    self:SetTitle('')
    self:Center()
    self:MakePopup()

    self:DockPadding(0,22,0,0)

    self.pnls = {
        create_test = {
            name = 'Create Panel',
            pnl = vgui.Create('JobtestCreatePnl', self)},
        edit_test = {
            name = 'Edit Test',
            pnl = vgui.Create('JobtestEditPnl', self)},
        remove_test = {
            name = 'Remove Test',
            pnl = vgui.Create('JobtestRemovePnl', self)}
    }
    self.toggle_pnl = vgui.Create('JobtestTogglePnl', self)
end
vgui.Register('JobtestAdminMainFrame', MainFrame, 'DFrame')

-- remove later
concommand.Add('jobtestadminframe', function() vgui.Create('JobtestAdminMainFrame') end)
