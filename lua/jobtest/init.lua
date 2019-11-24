jobtest = {}

local sv_files = file.Find('jobtest/sv/*.lua', 'LUA')
local cl_files = file.Find('jobtest/cl/*.lua', 'LUA')
local sh_files = file.Find('jobtest/*.lua', 'LUA')

-- include sv files
for i, file in ipairs(sv_files) do
    include('sv/' .. file) end
for i, file in ipairs(sh_files) do
    if file ~= 'init.lua' and file ~= 'cl_init.lua' then
        include(file) end
end

jobtest.lib.msg('Server files included.')

-- download client files
AddCSLuaFile 'cl_init.lua'

for i, file in ipairs(cl_files) do
    AddCSLuaFile('cl/' .. file) end
for i, file in ipairs(sh_files) do
    if file ~= 'init.lua' and file ~= 'cl_init.lua' then
        print('file: ' .. file)
        AddCSLuaFile(file) end
end

jobtest.lib.msg('Client files downloaded.')
