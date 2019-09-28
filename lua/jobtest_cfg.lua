jobtest.cfg = jobtest.cfg or
{
    -- groups that can create/edit/remove tests and also add/remove saved npcs
    canEditGroups = {
        ['superadmin'] = true
    },

    themes = {
        dark = {
            enabled = true,
            outline = Color( 0, 0, 0, 255 ),
            main = Color( 37, 37, 37, 255 ),
            background = Color( 30, 30, 30, 255 ),
            btn = Color( 25, 25, 25, 255 ),
            focused = Color( 51, 51, 51, 255 ),
            btndown = Color( 65, 65, 65, 255 ),
            text = Color( 173, 173, 173, 255 ),
            textselected = Color( 201, 212, 201, 255 ),
        },
        light = {
            enabled = false,
        }
    },
}
