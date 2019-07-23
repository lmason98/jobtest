local Test = { }

AccessorFunc( Test, 'questionCount', 'QuestionCount', FORCE_NUMBER )
Test.questions = { }

--[[
Args: Table questions
Desc: Test class constructor
]]
function Test:New( questions )
    local this = table.Copy( Test )

    this.questions = questions
    this:SetQuestionCount( #questions )

    return this
end

--[[
Args: Number num
Desc: Returns the question at the passed index
]]
function Test:GetQuestion( num )
    return this.questions[num] end

--[[
Args: Table questions
Desc: Test class constructor global wrapper
]]
function jobtest:Test( questions )
    return Test:New( questions ) end