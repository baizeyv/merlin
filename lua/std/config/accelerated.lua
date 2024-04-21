local M = {
    mode = 'time_driven',
    enable_deceleration = false,
    acceleration_motions = {},
    acceleration_limit = 150,
    acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
    -- when enable_deceleration = true
    deceleration_table = { { 150, 9999 } }
}

return M
