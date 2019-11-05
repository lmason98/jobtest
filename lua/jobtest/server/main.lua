util.AddNetworkString 'jobtest_text_sv_to_cl'
util.AddNetworkString 'jobtest_open_admin_pnl_req'

jobtest.tests = {}

local test = jobtest:Test()
table.insert(jobtest.tests, test)
PrintTable(jobtest.tests)

--[[
Desc: Syncs Tests when a player initializes
]]
local function InitPlyTests(ply)
    for i, test in pairs(jobtest.tests) do
        jobtest:SyncTest(test.name, ply) end
end
hook.Add('PlayerInitialSpawn', 'jobtest_sync_player_test', InitPlyTests)

--[[
Args: Player ply, String text
Desc:
]]
local function ChatCommands(ply, text)
    local cmd = text:Split(' ')[1]
    cmd = cmd:sub(2)
    if cmd == jobtest.cfg.admin_pnl_cmd then
        if ply:IsAdmin() then
            net.Start('jobtest_open_admin_pnl_req')
            net.Send(ply)
            return false
        end
    end
end
hook.Add('PlayerSay', 'jobtest_chat_cmd', ChatCommands)
