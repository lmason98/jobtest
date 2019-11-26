local _vgui = {}

-- Args: Panel self, Num width, Num height
-- Desc: Draws outlines around panels, dev function
function _vgui.outline(self, w, h)
    surface.SetDrawColor(255,255,255)
    surface.DrawRect(0,0,w,h)
    surface.SetDrawColor(0,0,0)
    surface.DrawOutlinedRect(0,0,w,h)
end

-- Desc: Base _vgui button
-- Args: DPanel parent, String text, Function callback
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

jobtest.vgui = _vgui 
