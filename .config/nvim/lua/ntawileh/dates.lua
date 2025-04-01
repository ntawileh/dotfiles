local M = {}

---@class date.Match
---@field matched_time integer
---@field matched_date string
---@field start_col integer
---@field end_col integer

local state = {
    line_content = "",
    line_number = 0,
    matched_time = 0,
}

local bump_options = {
    { name = "today", offset = 0 },
    { name = "tomorrow", offset = 1 },
    { name = "two days", offset = 2 },
    { name = "next week", offset = 7 },
    { name = "next month", offset = 30 },
    { name = "+2 days", offset = 2, relative = true },
    { name = "+7 days", offset = 7, relative = true },
}

local config = {
    date_match = "((%d%d%d%d)-(%d%d)-(%d%d))",
}

---@param base_time integer
---@param offset number
---@return string
local make_date_command = function(base_time, offset)
    local cmd = {
        "date",
        "-v",
        "+" .. offset .. "d",
        "-jf",
        "%F",
    }
    table.insert(cmd, os.date("%Y-%m-%d", base_time))
    table.insert(cmd, "+%F")

    local date_cmd_output = vim.system(cmd, { text = true }):wait()
    if date_cmd_output.code ~= 0 then
        vim.print("Error running date command: " .. date_cmd_output.stderr)
        return ""
    end

    return vim.trim(date_cmd_output.stdout)
end

---@param start_index integer
local bump_and_replace = function(start_index)
    vim.ui.select(bump_options, {
        prompt = "Select a date bump offset",
        format_item = function(item)
            return item.name
        end,
    }, function(offset)
        if offset then
            local updated_date = make_date_command(offset.relative and state.matched_time or os.time(), offset.offset)
            if updated_date ~= "" then
                if start_index == 1 then
                    local line_content = state.line_content:gsub(config.date_match, updated_date, 1)
                    vim.api.nvim_buf_set_lines(0, state.line_number - 1, state.line_number, false, { line_content })
                else
                    local line_content = state.line_content:sub(1, start_index - 1)
                        .. state.line_content:sub(start_index):gsub(config.date_match, updated_date, 1)
                    vim.api.nvim_buf_set_lines(0, state.line_number - 1, state.line_number, false, { line_content })
                end
            end
        end
    end)
end

---comment
---@return date.Match[]
local get_date_matches = function()
    local matches = {}
    ---@diagnostic disable-next-line: no-unknown
    for match, y, m, d in state.line_content:lower():gmatch(config.date_match) do
        local matched_time = os.time({ year = y, month = m, day = d })
        local matched_date = os.date("*t", matched_time)
        local index = state.line_content:find(match, 1, true)
        if type(matched_date) == "string" then
            break
        end
        table.insert(matches, {
            matched_time = matched_time,
            matched_date = matched_date,
            start_col = index,
            end_col = index + string.len(match) - 1,
        })
    end
    return matches
end

function M.bumpDate()
    -- Get the current line number and col
    state.line_number = vim.api.nvim_win_get_cursor(0)[1]
    state.cursor_col = vim.api.nvim_win_get_cursor(0)[2]

    -- Get the line content
    state.line_content = vim.api.nvim_buf_get_lines(0, state.line_number - 1, state.line_number, false)[1]

    local matches = get_date_matches()

    if #matches == 0 then
        vim.print("No date found in the current line")
        return
    elseif #matches == 1 then
        state.matched_time = matches[1].matched_time
        bump_and_replace(1)
        return
    else
        local index = 1
        vim.print(matches)
        state.matched_time = matches[#matches].matched_time
        ---@diagnostic disable-next-line: no-unknown
        for _, match in ipairs(matches) do
            if match.end_col > state.cursor_col then
                state.matched_time = match.matched_time
                index = match.start_col
                break
            end
        end
        bump_and_replace(index)
    end
end

-- M.bumpDate()
-- 2025-02-13 2025-02-14
-- 2025-02-15

return M
