jobtest.tests = {}

--[[
Args: String name, (SERVER) Player ply
Desc: Syncs the Test either from client to server or server to client
]]
function jobtest:SyncTest(name, ply)
    if SERVER then
        for i, test in pairs(jobtest.tests) do
            if test:GetName() == name then
                local tDataStr = util.TableToJSON(test:GetData())

                net.Start('jobtest_text_sv_to_cl')
                    net.WriteString(tDataStr)
                net.Send(ply)
                break
            end
        end
    elseif CLIENT then
        --pass
    end
end
