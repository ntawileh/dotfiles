local M = {}

-- Convert RGB to Hex color.
-- @param r Red value
-- @param g Green value
-- @param b Blue value
-- @return HEX color, e.g. '#1E1E1E'
function M.RGB_to_Hex(r, g, b)
    return "#" .. string.format("%02X%02X%02X", r, g, b)
end

-- Convert HUE to RGB
local function Hue_to_RGB(p, q, t)
    if t < 0 then
        t = t + 1
    end
    if t > 1 then
        t = t - 1
    end
    if t < 1 / 6 then
        return p + (q - p) * 6 * t
    end
    if t < 1 / 2 then
        return q
    end
    if t < 2 / 3 then
        return p + (q - p) * (2 / 3 - t) * 6
    end

    return p
end

-- Convert HSL to RGB color.
function M.HSL_to_RGB(h, s, l, a)
    -- H [0,360]
    -- S, L, A [0,1]
    h = h / 360
    s = s / 100
    l = l / 100
    a = a and a / 100 or l
    local r, g, b

    -- achromatic
    if s == 0 then
        r = l
        g = l
        b = l
    else
        local q = l < 0.5 and l * (1 + s) or l + s - l * s
        local p = 2 * l - q
        r = Hue_to_RGB(p, q, h + 1 / 3)
        g = Hue_to_RGB(p, q, h)
        b = Hue_to_RGB(p, q, h - 1 / 3)
    end

    return {
        math.floor(r * 255 + 0.5),
        math.floor(g * 255 + 0.5),
        math.floor(b * 255 + 0.5),
        a,
    }
end

function M.Hex_to_RGB(color)
    color = color:gsub("#", "")

    if color:len() == 3 then
        -- #RGB
        local r = tonumber("0x" .. color:sub(1, 1))
        local g = tonumber("0x" .. color:sub(2, 2))
        local b = tonumber("0x" .. color:sub(3, 3))

        return {
            16 * r + r,
            16 * g + g,
            16 * b + b,
        }
    elseif color:len() == 4 then
        -- #RGBA
        local r = tonumber("0x" .. color:sub(1, 1))
        local g = tonumber("0x" .. color:sub(2, 2))
        local b = tonumber("0x" .. color:sub(3, 3))
        local a = tonumber("0x" .. color:sub(4, 4))

        return {
            16 * r + r,
            16 * g + g,
            16 * b + b,
            utils.round_float((16 * a + a) / 255, 2),
        }
    elseif color:len() == 6 then
        -- #RRGGBB
        return {
            tonumber("0x" .. color:sub(1, 2)),
            tonumber("0x" .. color:sub(3, 4)),
            tonumber("0x" .. color:sub(5, 6)),
        }
    elseif color:len() == 8 then
        -- NOTE: unused at the moment
        -- #RRGGBBAA
        return {
            tonumber("0x" .. color:sub(1, 2)),
            tonumber("0x" .. color:sub(3, 4)),
            tonumber("0x" .. color:sub(5, 6)),
            utils.round_float(tonumber("0x" .. string.sub(color, 7, 8)) / 255, 2),
        }
    end
end

function M.HSL_to_Hex(h, s, l)
    local rgb = M.HSL_to_RGB(h, s, l)
    return M.RGB_to_Hex(rgb[1], rgb[2], rgb[3])
end

function M.round_float(num, decimal_points)
    local decimal = math.pow(10, decimal_points)
    return math.floor(num * decimal + 0.5) / decimal
end

-- Convert RGB to HSL color.
-- @param r Red value
-- @param g Green value
-- @param b Blue value
function M.RGB_to_HSL(r, g, b, a)
    -- R, G, B [0,255]
    -- A [0,1]
    r = r / 255
    g = g / 255
    b = b / 255
    a = a and a or 0

    local c_max = math.max(r, g, b)
    local c_min = math.min(r, g, b)
    local h = 0
    local s = 0
    local l = (c_min + c_max) / 2

    local chroma = c_max - c_min
    if chroma > 0 then
        s = math.min((l <= 0.5 and chroma / (2 * l) or chroma / (2 - (2 * l))), 1)

        if c_max == r then
            h = ((g - b) / chroma + (g < b and 6 or 0))
        elseif c_max == g then
            h = (b - r) / chroma + 2
        elseif c_max == b then
            h = (r - g) / chroma + 4
        end

        h = h * 60
        h = math.floor(h + 0.5)
    end

    return {
        h,
        M.round_float(s * 100, 1),
        M.round_float(l * 100, 1),
        a,
    }
end

function M.cycleColor()
    -- Get the current line number
    local line_number = vim.api.nvim_win_get_cursor(0)[1]

    -- Get the line content
    local line_content = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]

    local rgb_match = "(rgb%(%s*(%d%d[%d]*)%s*,%s*(%d%d[%d]*)%s*,%s*(%d%d[%d]*)%s*%))"
    --(rgb%(%s*([%d]*)%s*,%s*([%d]*)%s*,%s*([%d]*)%s*%))
    local hsl_match = "(hsl%(%s*([%d]*)%s*,%s*([%d]*)%%%s*,%s*([%d]*)%%%s*%))"

    -- RGB -> HSL
    if line_content:match(rgb_match) then
        for _, r, g, b in line_content:lower():gmatch(rgb_match) do
            local h = M.RGB_to_HSL(tonumber(r), tonumber(g), tonumber(b))
            local hsl = string.format("hsl(%d,%d%%%%,%d%%%%)", h[1], h[2], h[3])
            line_content = line_content:gsub(rgb_match, hsl, 1)
        end
        -- replace the text
        vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, false, { line_content })
        return
    end

    -- Hex -> RGB
    if line_content:match("#[0-9a-fA-F]+") then
        for hex in line_content:gmatch("#[0-9a-fA-F]+") do
            local rgb = M.Hex_to_RGB(hex)
            local rgb_str = string.format("rgb(%d,%d,%d)", rgb[1], rgb[2], rgb[3])
            line_content = line_content:gsub("#[0-9a-fA-F]+", rgb_str, 1)
        end
        -- replace the text
        vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, false, { line_content })
        return
    end

    -- HSL -> Hex
    if line_content:match(hsl_match) then
        for _, h, s, l in line_content:lower():gmatch(hsl_match) do
            local hex = M.HSL_to_Hex(tonumber(h), tonumber(s), tonumber(l))
            line_content = line_content:gsub(hsl_match, hex, 1)
        end
        -- replace the text
        vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, false, { line_content })
        return
    end
end

return M
