AddCSLuaFile()

--[[
Desc: Downloads and includes the addon files
]]
local function loadAddon( )
    jobtest = {}

    if SERVER then

        -- shared
        include 'jobtest_cfg.lua'
        include 'jobtest/test.lua'
        include 'jobtest/question.lua'
        include 'jobtest/main.lua'

        AddCSLuaFile 'jobtest_cfg.lua'
        AddCSLuaFile 'jobtest/test.lua'
        AddCSLuaFile 'jobtest/question.lua'
        AddCSLuaFile 'jobtest/main.lua'

        -- server
        include 'jobtest/server/main.lua'
        include 'jobtest/main.lua'

        -- client
        AddCSLuaFile 'jobtest/client/main.lua'
        AddCSLuaFile 'jobtest/client/fonts.lua'

        -- vgui
        AddCSLuaFile 'jobtest/client/vgui_adminpnl.lua'
        AddCSLuaFile 'jobtest/client/vgui_funcs.lua'

    elseif CLIENT then

        -- shared
        include 'jobtest_cfg.lua'
        include 'jobtest/test.lua'
        include 'jobtest/question.lua'
        include 'jobtest/main.lua'

        -- client
        include 'jobtest/client/main.lua'

        -- vgui
        include 'jobtest/client/vgui_adminpnl.lua'
        include 'jobtest/client/vgui_funcs.lua'

    end
end
hook.Add( 'Initialize', 'jobtest_init', loadAddon )
