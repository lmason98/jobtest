local Question = { }

AccessorFunc( Question, 'question_str', 'QString', FORCE_STRING )
AccessorFunc( Question, 'choice_count', 'ChoiceCount', FORCE_NUMBER )
AccessorFunc( Question, 'chosen_index', 'ChosenIndex', FORCE_NUMBER )
Question.choices = { }

if ( SERVER ) then
    AccessorFunc( Question, 'answer_index', 'AnswerIndex', FORCE_NUMBER ) end

--[[
Args: String qString Table answerChoices, (SERVER only) Number answerIndex
Desc: Question class constructor
]]
function Question:New( qString, answerChoices, answerIndex )
    local this = table.Copy( Question )

    --TODO: Make max choices configurable

    if ( qString and isstring( qString ) ) then
        this:SetQString( qString )
    else
        this:SetQString( 'You stand atop a cliff, do you: ' )
    end

    if ( answerChoices and istable( answerChoices ) and #answerChoices >= 2 and #answerChoices <= 4 ) then
        this.choices = answerChoices
    else
        this.choices = {
            [1] = 'Do a frontflip off',
            [2] = 'Do a backflip off'
        }
    end

    if ( SERVER and answerIndex and isnumber( answerIndex ) ) then
        this:SetAnswerIndex( answerIndex )
    elseif ( SERVER ) then
        this:SetAnswerIndex( 1 )
    end

    return this
end

--[[
Desc: Sends the question data to the server to be saved
]]
function Question:Sync( )
end

--[[
Args: String qString, Table answerChoices, (SERVER only) Number answerIndex
Desc: question class constructor global wrapper
]]
function jobtest:Question( qString, questionData, answerIndex )
    return Question:New( qString, questionData, answerIndex ) end