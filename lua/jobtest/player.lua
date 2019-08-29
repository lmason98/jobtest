local PLAYER = FindMetaTable( 'Player' )

--[[
Desc: Determines wether the player is an admin that can edit questions
Return: Bool canEdit 
]]
function PLAYER:CanEditJobtestQs( )
    if ( jobtest.cfg.canEditGroups[self:GetUserGroup()] ) then
        return true end

    return false
end