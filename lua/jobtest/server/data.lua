require 'mysqloo'

if ( file.Find( 'jobtest/server/sqlcreds.lua', 'LUA' ) ) then
    include 'sqlcreds.lua'
else
    print( ' [X] sqlcreds.lua not found' )
end