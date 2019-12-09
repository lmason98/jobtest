local _vgui = {}

-- Args: Panel self, Num width, Num height
-- Desc: Draws outlines around panels, dev function
function _vgui.outline(self, w, h)
    surface.SetDrawColor(255,255,255)
    surface.DrawRect(0,0,w,h)
    surface.SetDrawColor(0,0,0)
    surface.DrawOutlinedRect(0,0,w,h)
end

-- Args: DPanel parent, String text, Function callback
-- Desc: Base vgui button
-- Return: DButton btn
function _vgui.button(parent, text, callback)
    local btn = vgui.Create('DButton', parent)
    btn:SetText('')
    btn.text = text

    btn.Paint = function(self, w, h)
        _vgui.outline(self, w, h)

        draw.SimpleText(self.text, 'DermaDefault', w/2, h/2, Color(0,0,0),
            TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    btn.DoClick = callback

    return btn
end

-- Args: DPanel parent, String text
-- Desc: Base vgui text entry
-- Return: DPanel entryPnl, DTextEntry entry
function _vgui.textEntry(parent, text)
    local entryPnl = vgui.Create('DPanel', parent)
    entryPnl.text = text

    entryPnl.Paint = function(self, w, h)
        _vgui.outline(self, w, h)

        draw.SimpleText(self.text .. ':', 'DermaDefault', ScreenScale(3), h/2,
            Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local entry = vgui.Create('DTextEntry', entryPnl)
    entry:DockMargin(ScreenScale(35),0,0,0)
    entry:Dock(FILL)
    entry:InvalidateParent(true)

    return entryPnl, entry
end

jobtest.vgui = _vgui 
