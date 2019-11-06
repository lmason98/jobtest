--[[
Args: DPanel this, DPanel parent
Desc: Base panel for jobtest admin panel
Return: Dpanel this
]]
function jobtest:AdminPnl(this, p)
    this:Dock(FILL)
    this:DockPadding(0,ScreenScale(20),0,ScreenScale(20)) 

    this.createScroll = function(this)
        local scroll = vgui.Create('DScrollPanel', this)
        scroll:Dock(FILL)

        scroll.Paint = function(s, w, h)
            surface.SetDrawColor(150,150,150)
            surface.DrawRect(0,0,w,h)
        end

        this.scroll_pnl = scroll
    end

    this:Hide()
    return this
end
