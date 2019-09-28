util.AddNetworkString( 'jobtest_validate_test' )

local defaultTest = jobtest:Test()

jobtest.tests = { }
jobtest.tests[1] = defaultTest

--[[ 
    Args: String name
    Desc: Fetches the test given the name if it exists, false otherwise
    Return: Test test or Bool false
]]
function jobtest:GetTest( name )
    for _, t in pairs( self.tests ) do
        if ( name == t:GetName() ) then
            return t end
    end

    return false
end

--[[
    Args: Number len, Player ply
    Desc: Checks if the selected test answers are correct
]]
local function validateTest( len, ply )
    local name = net.ReadString()
    local selected = net.ReadTable()

    local testToCompare = jobtest:GetTest( name )
    local passed = false

    if ( testToCompare ) then
        passed = testToCompare:Evaluate( selected ) end

    print( 'You passed: ' .. tostring( passed ) )
end
net.Receive( 'jobtest_validate_test', validateTest )