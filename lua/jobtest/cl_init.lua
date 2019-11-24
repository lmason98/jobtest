jobtest = {}

local cl_files = file.Find('jobtest/cl/*.lua', 'LUA')
local sh_files = file.Find('jobtest/*.lua', 'LUA')

-- include cl files
for i, file in ipairs(cl_files) do
    include('cl/' .. file) end
for i, file in ipairs(sh_files) do
    if file ~= 'init.lua' and file ~= 'cl_init.lua' then
        include(file) end
end

jobtest.lib.msg('Client files included.')
