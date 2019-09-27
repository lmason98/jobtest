local Test = { }

AccessorFunc( Test, 'name', 'Name', FORCE_STRING )
AccessorFunc( Test, 'questionCount', 'QuestionCount', FORCE_NUMBER )
Test.questions = { }

--[[ Args: String name, Table questions
     Desc: Test class constructor
]]
function Test:New( name, questions )
    local this = table.Copy( Test )

    if ( name and isstring( name ) ) then
        this:SetName( name )
    else
        this:SetName( 'Test' )
    end

    if ( questions and istable( questions ) and #questions >= 1 ) then
        this.questions = questions
        this:SetQuestionCount( #questions )
    else
        this.questions = { }
        this:SetQuestionCount( 5 )
        for i = 1, 5 do
            this.questions[i] = jobtest:Question() end
    end

    return this
end

--[[
    Desc: Checks if the test has been filled out
    Return: Bool formComplete
]]
function Test:IsComplete( )
    for _, q in pairs( self.questions ) do
        if ( q:GetSelected() == -1 ) then
            return false end
    end

    return true
end

--[[ Desc: Sends the test data to the server to be saved ]]
function Test:Sync()
    for i, q in pairs( self.questions ) do
        q:Sync() end
end

--[[ Args: Number num
     Desc: Returns the question at the passed index
]]
function Test:GetQuestion( num )
    return this.questions[num] end

--[[ Args: String name, Table questions
     Desc: Test class constructor global wrapper
]]
function jobtest:Test( name, questions )
    return Test:New( name, questions ) end