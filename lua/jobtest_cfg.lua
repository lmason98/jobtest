jobtest.cfg = jobtest.cfg or
{
    -- groups that can create/edit/remove tests and also add/remove saved npcs
    canEditGroups = {
        ['superadmin'] = true
    },

    themes = {
        dark = {
            enabled = false,
            outline = Color( 0, 0, 0, 255 ),
            main = Color( 37, 37, 37, 255 ),
            background = Color( 30, 30, 30, 255 ),
            btn = Color( 25, 25, 25, 255 ),
            focused = Color( 51, 51, 51, 255 ),
            btndown = Color( 65, 65, 65, 255 ),
            text = Color( 173, 173, 173, 255 ),
            textSelected = Color( 201, 212, 201, 255 ),
        },
        light = {
            enabled = true,
            outline = Color( 150, 150, 150, 255 ),
            main = Color( 255, 255, 255, 255 ),
            background = Color( 240, 240, 240, 255 ),
            btn = Color( 240, 240, 240, 255 ),
            focused = Color( 195, 195, 195, 255 ),
            btndown = Color( 165, 165, 165, 255 ),
            text = Color( 0, 0, 0, 255 ),
            textSelected = Color( 25, 25, 25, 255 ),
        }
    },
}
