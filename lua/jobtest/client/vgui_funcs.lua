--[[
Args: DPanel this, DPanel parent
Desc: Base panel for jobtest admin panel
Return: Dpanel this
]]
function jobtest:AdminPnl(this, p)
    this:Hide()
    this:Dock(FILL)

    return this
end
