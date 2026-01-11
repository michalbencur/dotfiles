local function color_scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        return "Catppuccin Mocha"
    else
        return "Catppuccin Mocha"
    end
end

local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

local function cursor_fingerprint(pane)
    local cursor = pane:get_cursor_position()
    return (cursor.x << 16) | cursor.y
end

local function is_nvim(pane)
    local vars = pane:get_user_vars()
    return vars['IS_NVIM'] == 'true'
end

local function move_pane_action(direction)
    local action = wezterm.action.ActivatePaneDirection(direction)
    return wezterm.action_callback(function(win, pane)
        if is_nvim(pane) then
            local pp = cursor_fingerprint(pane)
            win:perform_action(wezterm.action.SendKey { key = direction .. 'Arrow', mods = 'OPT' }, pane)
            wezterm.sleep_ms(120)
            if pp == cursor_fingerprint(pane) then
                win:perform_action(action, pane)
            end
        else
            win:perform_action(action, pane)
        end
    end)
end

-- config.font = wezterm.font("Anonymous Pro")
config.font_size = 13.0
config.color_scheme = color_scheme_for_appearance(wezterm.gui.get_appearance())
config.window_background_opacity = 1.0
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = false

config.leader = { key = "p", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
    {
        key = "n",
        mods = "LEADER",
        action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "n",
        mods = "LEADER|SHIFT",
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "p",
        mods = "LEADER",
        action = wezterm.action.TogglePaneZoomState,
    },

    -- Navigate panes
    {
        key = "RightArrow",
        mods = "CMD",
        action = move_pane_action("Right"),
    },
    {
        key = "LeftArrow",
        mods = "CMD",
        action = move_pane_action("Left"),
    },
    {
        key = "UpArrow",
        mods = "CMD",
        action = move_pane_action("Up"),
    },
    {
        key = "DownArrow",
        mods = "CMD",
        action = move_pane_action("Down"),
    },

    -- Send "CTRL-P" to the terminal when pressing CTRL-P, CTRL-P
    {
        key = "p",
        mods = "LEADER|CTRL",
        action = wezterm.action.SendKey({ key = "p", mods = "CTRL" }),
    },

    -- resize pane
    {
        key = "r",
        mods = "LEADER",
        action = wezterm.action.ActivateKeyTable({
            name = "resize_pane",
            one_shot = false,
        }),
    },
}

config.key_tables = {
    resize_pane = {
        { key = "Escape",     action = "PopKeyTable" },
        { key = "Enter",      action = "PopKeyTable" },
        { key = "h",          action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
        { key = "l",          action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
        { key = "j",          action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
        { key = "k",          action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
        { key = "LeftArrow",  action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
        { key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
        { key = "UpArrow",    action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
        { key = "DownArrow",  action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
    },
}

config.mouse_bindings = {
    {
        event = { Drag = { streak = 1, button = "Left" } },
        mods = "SUPER",
        action = wezterm.action.StartWindowDrag,
    },
}

return config
