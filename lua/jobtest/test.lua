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

    local hasName, hasQuestions = false, false
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
    end

    -- initial vals (testData == nil)
    if not hasName then
        this:SetName('Sample Test')
    end
    if not hasQuestions then
        local ansIndex = nil
        if SERVER then ansIndex = 1 end
        this.questions = {
            [1]={
                text='Are you awesome?',
                choices={
                    [1]='yes',
                    [2]='no'
                },
                ans_index=ansIndex
            }
        }
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
    print('hellllllllllllllllpppppppppppP???')
    return Test:New(testData) end
