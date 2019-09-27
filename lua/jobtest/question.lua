local Question = { }

AccessorFunc( Question, 'question_str', 'QString', FORCE_STRING )
AccessorFunc( Question, 'choice_count', 'ChoiceCount', FORCE_NUMBER )
AccessorFunc( Question, 'selected_index', 'Selected', FORCE_NUMBER )
Question.choices = { }

if ( SERVER ) then
    AccessorFunc( Question, 'answer_index', 'AnswerIndex', FORCE_NUMBER ) end

--[[
    Args: String qString Table answerChoices, (SERVER only) Number answerIndex
    Desc: Question class constructor
]]
function Question:New( qString, answerChoices, answerIndex )
    local this = table.Copy( Question )

    if ( qString and isstring( qString ) ) then
        this:SetQString( qString )
    else
        this:SetQString( 'You\'ve become the mayor, should you ... You\'ve become the mayor, should you ... You\'ve become the mayor, should you ... You\'ve become the mayor, should you ... ' )
    end

    if ( answerChoices and istable( answerChoices ) and #answerChoices >= 2 and #answerChoices <= 4 ) then
        this.choices = answerChoices
    else
        this.choices = {
            [1] = 'Raise taxes to 100%.',
            [2] = 'Drift around the city in the mayor\'s limo. Drift around the city in the mayor\'s limo. Drift around the city in the mayor\'s limo. Drift around the city in the mayor\'s limo.',
            [3] = 'Steal the city funds.',
            [4] = 'Go and meet the city staff. Go and meet the city staff.Go and meet the city staff.Go and meet the city staff.Go and meet the city staff.Go and meet the city staff.Go and meet the city staff.Go and meet the city staff.Go and meet the city staff.Go and meet the city staff.Go and meet the city staff.'
        }
    end

    if ( SERVER and answerIndex and isnumber( answerIndex ) ) then
        this:SetAnswerIndex( answerIndex )
    elseif ( SERVER ) then
        this:SetAnswerIndex( 1 )
    end

    this:SetSelected( -1 )

    return this
end

--[[
    Desc: Sends the question data to the server to be saved
]]
function Question:Sync( )
end

--[[ 
    Args: Number i 
    Desc: Gets the question choice at the given index
    Return: String choice
]]
function Question:GetChoice( i )
    return self.choices[i] end

--[[
    Args: String qString, Table answerChoices, (SERVER only) Number answerIndex
    Desc: question class constructor global wrapper
]]
function jobtest:Question( qString, questionData, answerIndex )
    return Question:New( qString, questionData, answerIndex ) end
