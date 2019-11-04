local dims = {
    main = {
        w = ScrW() / 3,
        h = ScrH() * (1/3),
        font = ''
    }
}

local MainPnl = {}

--[[
Desc: Inits the Main Admin panel.
]]
function MainPnl:Init()
    self:SetWide(dims.main.w)    
    self:SetHeight(dims.main.h)    
    self:SetTitle()
    self:Center()
end
vgui.Register('JobtestAdminMainPnl', MainPnl, 'DFrame')
