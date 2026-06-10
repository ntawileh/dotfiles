-- hyper key
local hyper = { "alt", "ctrl", "cmd" }

local switcher_chrome = hs.window.switcher.new({ "Google Chrome" }, {
    -- Show only windows from current screen (optional)
    showCurrentSpace = true,
    showOtherSpaces = false,
})

-- Create a switcher that only looks at all spaces
local switcher = hs.window.switcher.new(hs.window.filter.new():setDefaultFilter({}))

hs.alert.show("Config loaded")
hs.hotkey.bind(hyper, "\\", function()
    hs.reload()
end)

hs.hotkey.bind(hyper, "W", function()
    hs.execute("cd ~/.config/themes/ && ./set-next-wallpaper.sh")
end)

hs.loadSpoon("ShiftIt")
spoon.ShiftIt:bindHotkeys({})

-- centralize at 80% screen size
hs.hotkey.bind(hyper, "'", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local max = win:screen():frame()

    f.x = max.x * 0.8
    f.y = max.y * 0.8
    f.w = max.w * 0.8
    f.h = max.h * 0.8

    win:setFrame(f)
    win:centerOnScreen()
end)

hs.hotkey.bind(hyper, "T", function()
    hs.application.launchOrFocus("Ghostty")
end)

hs.hotkey.bind(hyper, "S", function()
    hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind(hyper, "N", function()
    hs.application.launchOrFocus("Obsidian")
end)

hs.hotkey.bind(hyper, "B", function()
    hs.application.launchOrFocus("Google Chrome")
    switcher_chrome:next()
end)

-- Bind Alt+Tab to cycle to the next/previous window
hs.hotkey.bind("alt", "tab", function()
    switcher:next()
end)

hs.hotkey.bind("alt-shift", "tab", "Prev window", function()
    switcher:previous()
end)
