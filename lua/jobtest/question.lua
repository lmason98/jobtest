local Question = {}

AccessorFunc(Question, 'text', 'Text', FORCE_STRING)
Question.choices = {}

if SERVER then
    AccessorFunc(Question, 'ans_index', 'AnsIndex', FORCE_STRING) end

--[[
Args: Table qData
Desc: Creates a Question object out of the qData
Return: New Question object
]]--
function Question:New(qData)
    if not qData then return end

    local this = self

    for k, data in pairs(qData) do
        if k == 'text' then
            this:SetText(data)
        elseif k == 'choices' then
            this.choices = data
        elseif k == 'ans_index' and SERVER then
            this:SetAnsIndex(data)
        end
    end

    return this
end

--[[
Desc: Returns the qData from the Question
Return: Table qData
]]
function Question:GetData()
    return {
        text=self:GetText(),
        choices=self.choices,
        ans_index=self:GetAnsIndex() or nil
    }
end


--[[
Args: Table qData
Desc: Creates a Question object out of the qData
Return: New Question object
]]--
function jobtest:Question(qData)
    return Question:New(qData) end
