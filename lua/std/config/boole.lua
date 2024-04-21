local M = {
    mappings = {
        increment = '<C-a>',
        decrement = '<C-x>'
    },
    -- User defined loops
    additions = {
        { 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday' }
    },
    allow_caps_additions = {
        { 'true', 'false' },
        { 'yes', 'no' },
        { 'enable', 'disable' }
        -- enable -> disable
        -- Enable -> Disable
        -- ENABLE -> DISABLE
    }
}

return M
