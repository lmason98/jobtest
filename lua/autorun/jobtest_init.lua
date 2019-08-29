AddCSLuaFile()

--[[
Desc: Downloads and includes the addon files
]]
local function loadAddon( )
    local root = 'jobtest/%s'

    local sv = file.Find( root:format( 'server/*.lua' ), 'LUA' )
    local cl = file.Find( root:format( 'client/*.lua' ), 'LUA' )
    local sh = file.Find( root:format( '*.lua' ), 'LUA' )

    jobtest = jobtest or { }

    if ( SERVER ) then
        include( 'jobtest_cfg.lua' )
        AddCSLuaFile( 'jobtest_cfg.lua' )

        if ( sh and istable( sh ) and 0 < table.Count( sh ) ) then
            for i, file in pairs( sh ) do
                include( root:format( file ) )
                AddCSLuaFile( root:format( file ) )
            end
        end if ( sv and istable( sv ) and 0 < table.Count( sv ) ) then
            for i, file in pairs( sv ) do
                include( root:format( 'server/' .. file ) ) end
        end if ( cl and istable( cl ) and 0 < table.Count( cl ) ) then
            for i, file in pairs( cl ) do
                AddCSLuaFile( root:format( 'client/' .. file ) ) end
        end
    end
    if ( CLIENT ) then
        include( 'jobtest_cfg.lua' )
        if ( sh and istable( sh ) and 0 < table.Count( sh ) ) then
            for i, file in pairs( sh ) do
                include( root:format( file ) ) end
        end if ( cl and istable( cl ) and 0 < table.Count( cl ) ) then
            for i, file in pairs( cl ) do
                include( root:format( 'client/' .. file ) ) end
        end
    end

    print( ' [+] JobTest: Initialized')
end
hook.Add( 'Initialize', 'jobtest_init', loadAddon )