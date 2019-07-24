local EDITORPANEL = { }
local SELECTIONPANEL = { }
local FRAME = { }
local theme -- initalized on frame init

--[[
Desc: Initializes the text manager editor panel
]]
function EDITORPANEL:Init( )
    local parent = self:GetParent()
    local this = self

    self:DockMargin( 0, 10, 0, 0 )
    self:Dock( FILL )
    self:InvalidateParent( true )
    self:Hide()

    jobtest:VguiButton( 'Back', self, BOTTOM, function( ) self:Hide() parent.selector:Show() end )
end

function EDITORPANEL:Paint( w, h )
    surface.SetDrawColor( theme.background )
    surface.DrawRect( 0, 0, w, h )

    surface.SetDrawColor( theme.outline )
    surface.DrawOutlinedRect( 0, 0, w, h )
end

vgui.Register( 'JobTestManagerEditorPanel', EDITORPANEL, 'DPanel' )

--[[
Desc: Initializes the test manager selection panel
]]
function SELECTIONPANEL:Init( )
    local parent = self:GetParent()
    local this = self

    self:DockMargin( 0, 10, 0, 0 )
    self:Dock( FILL )
    self:InvalidateParent( true )

    jobtest:VguiButton( 'Create New Test', self, TOP, function( ) self:Hide() parent.editor:Show() end )
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
Desc: Initializes the test manager frame
]]
function FRAME:Init( )
    self:SetSize( 500, 400 )
    self:Center()
    self.text = 'Job Test Manager'
    self:SetTitle( '' )
    self:MakePopup()

    theme = jobtest:VguiTheme()

    self.selector = vgui.Create( 'JobTestManagerSelectionPanel', self )
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