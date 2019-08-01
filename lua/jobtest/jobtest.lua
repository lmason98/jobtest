--[[
Args: Player ply
Desc: Determines if the passed player is an admin
Return: Bool canEdit
]]
function jobtest:CanEditTests( ply )
    if ( jobtest.cfg.caneditgroupse[ply:GetUserGroup()] ) then
        return true end

    return false
end