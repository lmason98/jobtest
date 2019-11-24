local FRAME = {}

-- Desc: Inits the Admin Frame
function FRAME:Init()
    self:SetWide(ScrW()/3, ScrH()/2)
    self:Center()
    self:MakePop()
    self:SetTitle('')
end

vgui.Register('JobtestAdminFrame', FRAME, 'DFrame')

concommand.Add('jobtestadminframe', function()
        vgui.Create('JobtestAdminFrame')
end)
