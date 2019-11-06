local Test = {}

AccessorFunc(Test, 'name', 'Name', FORCE_STRING)
Test.questions = {}

--[[
Args: Table testData
Desc: Creates a Test object out of the testData
Return: New Test object
]]--
function Test:New(testData)
    local this = self

    if testData then
        for k, data in pairs(testData) do
            if k == 'name' then
                this:SetName(data)
                hasName = true
            elseif k == 'questions' then
                for i, qData in pairs(data) do
                    this.questions[i] = jobtest:Question(qData) end
                hasQuestions = true
            end
        end
    else
        -- initial vals (testData == nil)
        this:SetName('Sample Test')
        this.questions = { jobtest:Question() }
    end

    return this
end

--[[
Desc: Return the tData from the Test
Return Table tData
]]
function Test:GetData()
    local tData = {
        name=self:GetName(),
        questions={}
    }
    
    for i, q in pairs(self.questions) do
        tData.questions[i] = q:GetData() end

    return tData
end

--[[
Args: Table testData
Desc: Creates a Test object out of the testData
Return: New Test object
]]--
function jobtest:Test(testData)
    return Test:New(testData) end
