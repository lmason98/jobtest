--[[
Args: DPanel parent, Number dock, String text, String font, Function callBack, Number width or height
Desc: Base button for jobtest panels
Return DButton btn
]]
function jobtest:VguiBtn(p, d, t, f, cBack, w_h)
    local btn = vgui.Create('DButton', p)
    btn:Dock(d)
    btn:InvalidateParent(true)
    btn:SetText('')
    btn.text = t
    btn.font = f
    btn.DoClick = cBack

    if d == LEFT or d == RIGHT then
        btn:SetWide(p:GetWide() * w_h)
    elseif d == TOP or d == BOTTOM then
        btn:SetTall(w_h)
    end

    btn.Paint = function(s, w, h)
        surface.SetDrawColor(255,255,255)
        surface.DrawRect(0,0,w,h)

        draw.SimpleText(s.text, s.font, w/2, h/2, Color(0,0,0),
            TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            
        surface.SetDrawColor(0,0,0)
        surface.DrawOutlinedRect(0,0,w,h)
    end

    return btn
end
