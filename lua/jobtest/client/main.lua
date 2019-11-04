jobtest.tests = {}

--[[
Desc: Receives Test data from the server and saves a Test object to the client
test table.
]]
local function ReceiveTestSync()
    local tData = util.JSONToTable(net.ReadString())

    local testExists = false
    for i, test in pairs(jobtest.tests) do
        if test:GetName() == tData.name then
            jobtest.tests[i] = jobtest:Test(tData)
            testExists = true
            break
        end
    end

    if not testExists then
        table.insert(jobtest.tests, jobtest:Test(tData)) end
end
net.Receive('jobtest_text_sv_to_cl', ReceiveTestSync)

--[[
Desc: Receives a admin pnl open request
]]
local function OpenAdminPnl()
    vgui.Create('JobtestAdminMainPnl') end
net.Receive('jobtest_open_admin_pnl_req', OpenAdminPnl)
