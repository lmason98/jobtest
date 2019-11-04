util.AddNetworkString 'jobtest_text_sv_to_cl'
util.AddNetworkString 'jobtest_open_admin_pnl_req'

jobtest.tests = {}

local test = jobtest:Test({
    name='Sample Test', 
    questions={
        [1]={
            text='Are you awesome?',
            choices={
                [1]='yes',
                [2]='no'
            },
            ans_index=1
        }
    }
})
table.insert(jobtest.tests, test)

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
    print('cmd: ' .. cmd)
    print('cfg: ' .. jobtest.cfg.admin_pnl_cmd)
    print('cmd == cfg: ' .. cmd == jobtest.cfg.admin_pnl_cmd)
    if cmd == jobtest.cfg.admin_pnl_cmd then
        print('HEYYYYYYYYYYYYYY')
        if ply:IsAdmin() then
            print('hey')
            net.Start('jobtest_open_admin_pnl_req')
            net.Send(ply)
            return false
        end
    end
end
hook.Add('PlayerSay', 'jobtest_chat_cmd', ChatCommands)
