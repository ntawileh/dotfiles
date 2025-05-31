local M = {}

-- Config
local task_tag = "#todo"
local vault_path = vim.fn.expand("~") .. "/Documents/notes"
local ignore_dirs = { "meta", "9-Archive" }

---@class TodoItem
---@field title string
---@field checkbox string
---@field tags string[]
---@field file string
---@field line number
---@field completed boolean
---@field score number
---@field column number
---@field attributes {}
---@field due TodoItemDueDate | nil

---@class TodoItemDueDate
---@field date string
---@field relative_date string
---@field age number
---@field is_overdue boolean
---

-- Builds a ripgrep command as an array suitable for jobstart()
-- search_term (string): text to search for
-- opts (table, optional): {
--   additional_args = table (list of strings),
--   glob = string (file glob),
--   cwd = string (root directory),
--   hidden = bool (include hidden files),
--   ignore_case = bool (add -i),
-- }
local function build_ripgrep_cmd(search_term, opts)
    opts = opts or {}
    local search = search_term or [[^\s*[-+*]\s+\[.?\].*\]] .. task_tag
    local cmd = {
        "rg",
        "-t",
        "md",
        "--no-heading",
        "--color=never",
        "--line-number",
        "--with-filename",
        "--column",
        "--no-messages",
    }

    -- Add ignore case
    if opts.ignore_case then
        table.insert(cmd, "-i")
    end

    -- Add hidden
    if opts.hidden then
        table.insert(cmd, "--hidden")
    end

    -- Add glob
    if opts.glob then
        table.insert(cmd, "--glob")
        table.insert(cmd, opts.glob)
    end

    -- Add additional user flags
    if opts.additional_args then
        for _, arg in ipairs(opts.additional_args) do
            table.insert(cmd, arg)
        end
    end

    -- The search term
    table.insert(cmd, search_term or search or "")

    -- Directory to run the search in
    if opts.cwd then
        table.insert(cmd, opts.cwd)
    end

    return cmd
end

---@param items TodoItem[]
local show_picker = function(items, opts)
    require("snacks.picker").pick({
        matcher = {
            fuzzy = false,
            ignorecase = true,
            filename_bonus = true,
            file_pos = false,
        },

        formatters = {
            text = {
                ft = "markdown",
            },
            file = {
                filename_only = true,
            },
        },
        toggles = {
            tomorrow = "t",
            all = "a",
            completed = "c",
        },
        win = {
            input = {
                keys = {
                    ["c"] = { "toggle_completed", mode = { "n" } },
                    ["a"] = { "toggle_all", mode = { "n" } },
                    ["t"] = { "toggle_tomorrow", mode = { "n" } },
                },
            },
        },
        items = items,
        format = "text",
        title = task_tag .. " Tasks",

        sort = {
            fields = { "score:desc" },
        },
        transform = function(i, ctx)
            if i.due and i.completed ~= true then
                local date_annotate = i.due.age <= 0 and "*" or "*"
                i.text = "- "
                    .. i.checkbox
                    .. " "
                    .. date_annotate
                    .. i.due.relative_date
                    .. date_annotate
                    .. " "
                    .. i.title
            else
                i.text = "- " .. i.checkbox .. " " .. i.title
            end
            i.file = i.file
            i.pos = { tonumber(i.line), tonumber(i.column) - 1 }

            if i.completed and (ctx.picker.opts["completed"] == nil or ctx.picker.opts["completed"] == false) then
                return false
            end

            if ctx.picker.opts["tomorrow"] == true then
                if i.due and i.due.age == 1 then
                    return true
                end
                return false
            end

            if i.due and i.due.age > 0 and (ctx.picker.opts["all"] == nil or ctx.picker.opts["all"] == false) then
                return false
            end
        end,
    })
end

---@param text string
local function replace_urls_in_line(text)
    local url_pattern = "([Hh][Tt][Tt][Pp][Ss]?://[%w%-%._~:/%?#@!$&'%(%)*+,;=]+)" -- http(s)://
    local www_pattern = "([Ww][Ww][Ww]%.[%w%-%._~:/%?#@!$&'%(%)*+,;=]+)" -- www.
    local ftp_pattern = "([Ff][Tt][Pp]://[%w%-%._~:/%?#@!$&'%(%)*+,;=]+)" -- ftp://
    local mailto_pattern = "([Mm][Aa][Ii][Ll][Tt][Oo]:[%w%-%._~:/%?#@!$&'%(%)*+,;=]+)" -- mailto:

    local function repl(url)
        return "[[URL]]"
    end

    text = text:gsub(mailto_pattern, repl)
    text = text:gsub(ftp_pattern, repl)
    text = text:gsub(url_pattern, repl)
    text = text:gsub(www_pattern, repl)
    return text
end

---@param line string
---@return string,string
local function strip_bullet_and_checkbox(line)
    -- pattern breakdown:
    -- ^%s*       : Start with any spaces
    -- [*-]       : A bullet: * or -
    -- %s*        : Any number of spaces
    -- %[[^%]]%]  : [ any character except ] ]
    -- %s*        : Any number of spaces
    -- ()         : Capture position where to start returning the line
    local checkbox, title = line:match("^%s*[*-]%s*(%[[^%]]%])%s*(.*)$")
    return checkbox, title
end

---@param line string
local function checkbox_status(line)
    -- pattern:
    -- ^%s*      : Start with spaces
    -- [*-]      : A bullet: - or *
    -- %s*       : Any spaces
    -- %[([^\]]-)%] : Brackets. Capture anything except closing ], non-greedy
    local inside = line:match("^%s*[*-]%s*%[([^]]-)%]")
    -- return true if inside is not nil and contains at least one non-space character
    return inside ~= nil and inside:match("%S") ~= nil
end

---@param date_str string
---@return number epoch
---@return number days_diff
local function parse_date(date_str)
    -- Parse date string
    local year, month, day = date_str:match("^(%d%d%d%d)%-(%d%d)%-(%d%d)$")
    if not year then
        error("Invalid date format")
    end

    -- Convert string to numbers
    year, month, day = tonumber(year), tonumber(month), tonumber(day)

    -- Table for os.time
    local target = {
        year = year,
        month = month,
        day = day,
        hour = 0,
        min = 0,
        sec = 0,
        isdst = false,
    }

    -- Time for target date at midnight
    local target_epoch = os.time(target)

    -- Table for today's date at midnight
    local now = os.date("*t")
    local today = {
        year = now.year,
        month = now.month,
        day = now.day,
        hour = 0,
        min = 0,
        sec = 0,
        isdst = false,
    }
    local today_epoch = os.time(today)

    -- Compute difference in days
    local days_diff = math.floor((target_epoch - today_epoch) / (60 * 60 * 24))

    return target_epoch, days_diff
end

---@param diff number
---@return string
local function make_relative_date(diff)
    local abs_diff = math.abs(diff)
    local suffix, value, unit

    -- Handle special cases
    if diff == 0 then
        return "today"
    elseif diff == 1 then
        return "tomorrow"
    elseif diff == -1 then
        return "yesterday"
    elseif diff < 0 then
        suffix = " ago"
    else
        suffix = " from now"
    end

    -- Calculate unit based on magnitude
    if abs_diff < 7 then
        value = abs_diff
        unit = "day"
    elseif abs_diff < 30 then
        value = math.floor(abs_diff / 7)
        unit = "week"
    elseif abs_diff < 365 then
        value = math.floor(abs_diff / 30)
        unit = "month"
    else
        value = math.floor(abs_diff / 365)
        unit = "year"
    end

    -- Pluralize unit if needed
    if value > 1 then
        unit = unit .. "s"
    end

    -- Past/future phrasing
    if diff < 0 then
        return value .. " " .. unit .. suffix
    else
        return "in " .. value .. " " .. unit
    end
end

---@param todo TodoItem
local function populate_date_table(todo, due_date)
    if due_date == nil then
        todo.score = -1000
        return
    end
    local _, diff = parse_date(due_date)
    todo.due = {
        date = due_date,
        age = diff,
        is_overdue = diff < 0,
        relative_date = make_relative_date(diff),
    }
    todo.score = todo.score + diff
end

---@param text string
local extract_tags = function(text)
    local tags = {}
    text = text or ""
    for tag in text:gmatch("#(%w+) ") do
        table.insert(tags, tag)
    end
    return tags
end

local function should_ignore_file(file)
    for _, ignore_dir in ipairs(ignore_dirs) do
        local subdir = vault_path .. "/" .. ignore_dir
        if file:find(subdir, 1, true) then
            return true
        end
    end
    return false
end
-- local should_ignore_file = function(file)
--     for _, ignore_dir in ipairs(ignore_dirs) do
--         -- vim.print("should ignore " .. file .. " compared to " .. vault_path .. "/" .. ignore_dir)
--         if file:match(vault_path .. "/" .. ignore_dir) then
--             return true
--         end
--     end
--     return false
-- end

---@param text string
local extract_attributes = function(text)
    local attributes = {}
    text = text or ""
    for key, value in text:gmatch("%[([^%[%]:]+)::([^]]-)%]") do
        attributes[key] = value
    end
    return attributes
end

---@param items string[]
local process_tasks = function(items)
    ---@type TodoItem[]
    local todo_items = {}
    for _, item in ipairs(items) do
        local data = vim.split(item, ":")
        ---@type TodoItem
        local todo_item = {}
        if #data >= 4 then
            todo_item.file = table.remove(data, 1)
            todo_item.line = table.remove(data, 1)
            todo_item.column = table.remove(data, 1)
            todo_item.title = table.concat(data, ":")
            todo_item.score = 0

            todo_item.title = replace_urls_in_line(todo_item.title)
            todo_item.tags = extract_tags(todo_item.title)
            todo_item.completed = checkbox_status(todo_item.title)
            todo_item.attributes = extract_attributes(todo_item.title)

            local checkbox, title = strip_bullet_and_checkbox(todo_item.title)
            todo_item.title = title:gsub(task_tag .. "%s+", ""):gsub("%[([^%[%]:]+)::([^]]-)%]%s*", "")
            todo_item.checkbox = checkbox

            -- vim.notify(vim.inspect(todo_item))
            -- vim.notify(vim.inspect(tags))
            -- vim.notify(vim.inspect(attributes))

            if should_ignore_file(todo_item.file) == false then
                populate_date_table(todo_item, todo_item.attributes["due"])

                table.insert(todo_items, todo_item)
            end
        end
    end
    -- vim.notify(vim.inspect(todo_items))
    --
    table.sort(todo_items, function(a, b)
        return a.score < b.score
    end)
    return todo_items
end

M.show_tasks = function()
    local cmd = build_ripgrep_cmd(nil, { cwd = vault_path, glob = "!/.obsidian/", ignore_case = true })
    vim.system(cmd, { text = true }, function(out)
        vim.schedule(function()
            local todo_items = process_tasks(vim.split(out.stdout, "\n"))
            show_picker(todo_items)
        end)
    end)
end

--
--
--
-- M.show_tasks()
-- "should ignore /
-- /Users/nadimtawileh/Documents/notes/9-Archive/docufi/2023/12/2023-12-05.md compared to
-- /Users/nadimtawileh/Documents/notes/9-Archive"

-- local test_string =
--    "- [x] #todo #email [due::2025-02-12]   [Charlie follow-up - nadim@tawileh.com - tawileh.com Mail](https://mail.google.com/mail/u/0/#inbox/KtbxLxGSvRwwKNkmbcSxsxTNbjrmdNCwQq) "
--     "5-Daily/2025-02-12.md:13:1:- [x] #todo #email [due::2025-02-12]   [Charlie follow-up - nadim@tawileh.com - tawileh.com Mail](https://mail.google.com/mail/u/0/#inbox/KtbxLxGSvRwwKNkmbcSxsxTNbjrmdNCwQq) "
-- process_tasks({ test_string })
--
-- local checkbox, title = strip_bullet_and_checkbox(test_string)
-- vim.print(checkbox)
-- vim.notify(title)

-- local url = "https://fdfd.com and this foo"
-- vim.notify(replace_urls_in_line(url))

return M
