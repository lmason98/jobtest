local Question = { }

AccessorFunc( Question, 'choice_count', 'ChoiceCount', FORCE_NUMBER )
AccessorFunc( Question, 'chosen_index', 'ChosenIndex', FORCE_NUMBER )
Question.choices = { }

if ( SERVER ) then
    AccessorFunc( Question, 'answer_index', 'AnswerIndex', FORCE_NUMBER ) end

--[[
Args: Table questionData, (SERVER only) Number answerIndex
Desc: Question class constructor
]]
function Question:New( questionData, answerIndex )
    local this = table.Copy( Question )

    --> TODO: Make max choices configurable
    if ( SERVER and #questionData >= 2 and #questionData <= 4 and answerIndex and isnumber( answerIndex ) ) then
        this:SetChoiceCount( #questionData )
        this:SetChosenIndex( 0 )
        for i = 1, this:GetChoiceCount() do
            this.choices[i] = questionData[i] end

        this:SetAnswerIndex( answerIndex )
    elseif ( CLIENT and #questionData >= 2 and #questionData <= 4 ) then
        this:SetChoiceCount( #questionData )
        this:SetChosenIndex( 0 )
        for i = 1, this:GetChoiceCount() do
            this.choices[i] = questionData[i] end
    elseif ( SERVER ) then
        print( ' [X] Jobtest: Invalid questionData.' )
        return
    end

    return this
end

--[[
Desc: Sends the question data to the server to be saved
]]
function Question:Sync( )
end

--[[
Args: Table questionData, (SERVER only) Number answerIndex
Desc: question class constructor global wrapper
]]
function jobtest:Question( questionData, answerIndex )
    return Question:New( questionData, answerIndex or nil ) end