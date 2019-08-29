local Test = { }

AccessorFunc( Test, 'name', 'Name', FORCE_STRING )
AccessorFunc( Test, 'questionCount', 'QuestionCount', FORCE_NUMBER )
Test.questions = { }

--[[
Args: String name, Table questions
Desc: Test class constructor
]]
function Test:New( name, questions )
    local this = table.Copy( Test )

    this:SetName( name )
    this.questions = questions
    this:SetQuestionCount( #questions )

    return this
end

--[[
Desc: Sends the test data to the server to be saved
]]
function Test:Sync()
    for i, q in pairs( self.questions ) do
        q:Sync() end
end

--[[
Args: Number num
Desc: Returns the question at the passed index
]]
function Test:GetQuestion( num )
    return this.questions[num] end

--[[
Args: String name, Table questions
Desc: Test class constructor global wrapper
]]
function jobtest:Test( name, questions )
    return Test:New( questions ) end