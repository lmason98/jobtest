--[[
Desc: Receives Test data from the server and saves a Test object to the client
test table.
]]
local function ReceiveTestSync()
    local tData = util.JSONToTable(net.ReadString())

    if not jobtest.tests then
        jobtest.tests = {} end

    local testExists = false
    for i, test in pairs(jobtest.tests) do
        if test:GetName() == tData.name then
            jobtest.tests[i] = jobtest:Test(tData)
            testExists = true
            break
        end
    end

    if not testExists then
        local test = jobtest:Test(tdata)
        table.insert(jobtest.tests, test) end
end
net.Receive('jobtest_text_sv_to_cl', ReceiveTestSync)

--[[
Desc: Receives a admin pnl open request
]]
local function OpenAdminPnl()
    vgui.Create('JobtestAdminMainFrame') end
net.Receive('jobtest_open_admin_pnl_req', OpenAdminPnl)

-- 1: 2
-- 2: 4
-- 3: 1
-- 4: 2
-- 5: 2
-- 6: 4
-- 7: 1
-- 8: 4
-- 9: 1
-- 10: 2
-- 11: 1
-- 12: 4
-- 13: 4
-- 14: 1
-- 15: 2
-- 16: 3 
-- 17: 4 
-- 18: 2
-- anxious: 9 
-- avoidant: 11
-- secure: 22
