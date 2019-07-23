local Question = { }

AccessorFunc( Question, 'choice_count', 'ChoiceCount', FORCE_NUMBER )
AccessorFunc( Question, 'chosen_index', 'ChosenIndex', FORCE_NUMBER )
Question.choices = { }

if ( SERVER ) then
    AccessorFunc( Question, 'answer_index', 'AnswerIndex', FORCE_NUMBER ) end

--[[
Args: Table questionData
Desc: question class constructor
]]
function Question:New( questionData )
    local this = table.Copy( Question )

    if ( table.Count( questionData ) >= 3 and table.Count( questionData ) <= 5 ) then
        this:SetChoiceCount( table.Count( questionData ) - 1 )
        this:SetChosenIndex( 0 )
        for i = 1, this:GetChoiceCount() do
            this.choices[i] = questionData[i] end

        if ( SERVER ) then
            this:SetAnswerIndex( questionData[this:GetChoiceCount() + 1] ) end
    else
        print( ' [X] Jobtest: Invalid questionData.' )
        return
    end

    return this
end

--[[
Args: Table questionData
Desc: question class constructor global wrapper
]]
function jobtest:Question( questionData )
    return Question:New( questionData ) end