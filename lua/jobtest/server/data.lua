require 'mysqloo'

if ( file.Find( 'jobtest/server/sqlcreds.lua', 'LUA' ) ) then
    include 'sqlcreds.lua'
else
    print( ' [X] /lua/jobtest/server/sqlcreds.lua not found' )
end