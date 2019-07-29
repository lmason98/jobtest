local EDITORPANEL = { }
local TESTCREATEPANEL = { }
local SELECTIONPANEL = { }
local FRAME = { }
local theme -- initalized on frame init

--[[
Args: Table test
Desc: Sets the current test being edited
]]
function EDITORPANEL:SetTest( test )

end

--[[
Desc: Initializes the test editor question form panel 
]]
function EDITORPANEL:Init( )
    local parent = self:GetParent()

    self:DockMargin( 0, 10, 0, 0 )
    self:Dock( FILL )
    self:InvalidateParent( true )
    self:Hide()

    self.testname = 'No Test To Edit'

    jobtest:VguiButton( 'Back', self, BOTTOM, function( ) self:Hide() parent.testcreate:Show()
        local test = jobtest:Test( '', { jobtest:Question( {
            [1] = 'foo',
            [2] = 'bar',
        } ) } )

        print( test )

        -- table.insert( jobtest.tests, jobtest:Test( {
    end )
end

--[[
Args: Number w, Number h
Desc: Draws the question editor panel
]]
function EDITORPANEL:Paint( w, h )
    surface.SetDrawColor( theme.background )
    surface.DrawRect( 0, 0, w, h )

    surface.SetDrawColor( theme.outline )
    surface.DrawOutlinedRect( 0, 0, w, h )

    draw.SimpleText( self.testname, 'jobtest_7b', w / 2, 10, theme.textselected,
        TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
end

vgui.Register( 'JobTestManagerEditorPanel', EDITORPANEL, 'DPanel' )

--[[
Desc: Get's the job the test is intended for
]]
function TESTCREATEPANEL:JobForm( )
    self.job = vgui.Create( 'DComboBox', self )
    self.job:DockMargin( 10, 10, 10, 0 )
    self.job:Dock( TOP )
    self.job:InvalidateParent( true )
    self.job:SetTall( 30 )
    self.job:SetValue( 'Job' )
    self.job:SetFont( 'jobtest_7' )
    self.job:SetTextColor( theme.text )

    local this = self
    local job = self.job

    for k, team in pairs( team.GetAllTeams() ) do
        if ( k > 0 and k < 1000 ) then
            self.job:AddChoice( team.Name ) end
    end

    function self.job:OnSelect( index, value )
        if ( value ~= 'Job' ) then
            this.jobval = value end
    end

    function self.job:Paint( w, h )
        surface.SetDrawColor( theme.main )
        surface.DrawRect( 0, 0, w, h )

        surface.SetDrawColor( theme.outline )
        surface.DrawOutlinedRect( 0, 0, w, h )
    end

    --> https://web.archive.org/web/20190407112054/https://forum.facepunch.com/gmoddev/ntlh/Help-painting-a-ComboBox/1/
    function self.job:DoClick( )
        if ( self:IsMenuOpen() ) then
            self:CloseMenu() return end

        self:OpenMenu()
        
        for k, choice in pairs( job.Menu:GetCanvas():GetChildren() ) do
            function choice:PaintOver( w, h )
                local col = theme.main
                local textCol = theme.text

                if ( self:IsDown() ) then
                    col = theme.btndown
                    textCol = theme.textselected
                elseif ( self:IsHovered() ) then
                    textCol = theme.textselected
                end

                surface.SetDrawColor( col )
                surface.DrawRect( 0, 0, w, h )

                surface.SetDrawColor( theme.outline )
                surface.DrawOutlinedRect( 0, -1, w, h + 1 )

                draw.SimpleText( self:GetValue(), 'jobtest_6', w / 2, ( h / 2 ) - 1 , textCol,
                    TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            end
        end
    end
end

--[[
Desc: Initializes the test manager editor panel
]]
function TESTCREATEPANEL:Init( )
    local parent = self:GetParent()
    local this = self

    self:DockMargin( 0, 10, 0, 0 )
    self:Dock( FILL )
    self:InvalidateParent( true )
    self:Hide()

    --> test job
    self:JobForm()
    --> test name
    jobtest:VguiTextEntry( 'Test Name', self, function( val )
        if ( val ~= '' and val ~= ' ' and val ~= 'Test Name' ) then
            self.nameval = val end
    end )

    jobtest:VguiButton( 'Create', self, TOP, function( )
        local success = parent:NewCreatedTest( self.nameval, self.jobval )
        
        if ( success ) then
            self:Hide()
            parent.editor:Show()
        end
    end )

    jobtest:VguiButton( 'Back', self, BOTTOM, function( )
        self:Hide()
        parent.selector:Show()
    end )
end

--[[
Args: Number w, Number h
Desc: Draws the editor panel
]]
function TESTCREATEPANEL:Paint( w, h )
    surface.SetDrawColor( theme.background )
    surface.DrawRect( 0, 0, w, h )

    surface.SetDrawColor( theme.outline )
    surface.DrawOutlinedRect( 0, 0, w, h )
end

vgui.Register( 'JobTestManagerTestCreatePanel', TESTCREATEPANEL, 'DPanel' )

--[[
Desc: Initializes the test manager selection panel
]]
function SELECTIONPANEL:Init( )
    local parent = self:GetParent()
    local this = self

    self:DockMargin( 0, 10, 0, 0 )
    self:Dock( FILL )
    self:InvalidateParent( true )

    jobtest:VguiButton( 'Create New Test', self, TOP, function( )
        self:Hide()
        parent.testcreate:Show()
    end )
end

--[[
Args: Number w, Number h
Desc: Draws the test manager editor panel
]]
function SELECTIONPANEL:Paint( w, h )
    surface.SetDrawColor( theme.background )
    surface.DrawRect( 0, 0, w, h )

    surface.SetDrawColor( theme.outline )
    surface.DrawOutlinedRect( 0, 0, w, h )

    if ( #jobtest.tests < 1 ) then
        draw.SimpleText( 'No Exisiting tests found.', 'jobtest_7b', w / 2, h / 2, theme.text,
            TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) end
end

vgui.Register( 'JobTestManagerSelectionPanel', SELECTIONPANEL, 'DPanel' )

--[[
Args: String name, String job
Desc: Saves newly created test data
Return: Bool success
]]
function FRAME:NewCreatedTest( name, job )
    print( name, job )
    if ( name and job and isstring( name ) and isstring( job ) ) then
        self.createdtest.name = name
        self.createdtest.job = job
        return true
    end

    LocalPlayer():ChatPrint( 'You must include a name and a job.' )
    return false
end

--[[
Desc: Initializes the test manager frame
]]
function FRAME:Init( )
    self:SetSize( 500, 400 )
    self:Center()
    self.text = 'Job Test Manager'
    self:SetTitle( '' )
    self:MakePopup()

    theme = jobtest:VguiTheme()

    self.createdtest = { }

    self.selector = vgui.Create( 'JobTestManagerSelectionPanel', self )
    self.testcreate = vgui.Create( 'JobTestManagerTestCreatePanel', self )
    self.editor = vgui.Create( 'JobTestManagerEditorPanel', self )
end

--[[
Args: Number w, Number h
Desc: Draws the test manager frame
]]
function FRAME:Paint( w, h )
    surface.SetDrawColor( theme.main )
    surface.DrawRect( 0, 0, w, h )

    surface.SetDrawColor( theme.outline )
    surface.DrawOutlinedRect( 0, 0, w, h )

    draw.SimpleText( self.text, 'jobtest_8b', 10, 10, theme.textselected )
end

vgui.Register( 'JobTestManagerFrame', FRAME, 'DFrame' )

concommand.Add( 'opentestmanager', function()
    vgui.Create( 'JobTestManagerFrame' )
end )